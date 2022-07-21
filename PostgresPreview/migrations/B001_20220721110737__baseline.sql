SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_in_stock(int4, int4)...';END$$;
CREATE FUNCTION public.film_in_stock(IN p_film_id int4, IN p_store_id int4, OUT p_film_count int4)
RETURNS int4
LANGUAGE sql
AS $_$
     SELECT inventory_id
     FROM inventory
     WHERE film_id = $1
     AND store_id = $2
     AND inventory_in_stock(inventory_id);
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public._group_concat(text, text)...';END$$;
CREATE FUNCTION public._group_concat(IN  text, IN  text)
RETURNS text
LANGUAGE sql
AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.group_concat(text)...';END$$;
CREATE AGGREGATE public.group_concat(text) (
    SFUNC = public._group_concat,
    STYPE = text
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory_in_stock(int4)...';END$$;
CREATE FUNCTION public.inventory_in_stock(IN p_inventory_id int4)
RETURNS bool
LANGUAGE plpgsql
AS $_$
DECLARE
    v_rentals INTEGER;
    v_out     INTEGER;
BEGIN
    -- AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    -- FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT count(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END $_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory_held_by_customer(int4)...';END$$;
CREATE FUNCTION public.inventory_held_by_customer(IN p_inventory_id int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
DECLARE
    v_customer_id INTEGER;
BEGIN

  SELECT customer_id INTO v_customer_id
  FROM rental
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END $_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.get_customer_balance(int4, timestamptz)...';END$$;
CREATE FUNCTION public.get_customer_balance(IN p_customer_id int4, IN p_effective_date timestamptz)
RETURNS numeric
LANGUAGE plpgsql
AS $_$
       --#OK, WE NEED TO CALCULATE THE CURRENT BALANCE GIVEN A CUSTOMER_ID AND A DATE
       --#THAT WE WANT THE BALANCE TO BE EFFECTIVE FOR. THE BALANCE IS:
       --#   1) RENTAL FEES FOR ALL PREVIOUS RENTALS
       --#   2) ONE DOLLAR FOR EVERY DAY THE PREVIOUS RENTALS ARE OVERDUE
       --#   3) IF A FILM IS MORE THAN RENTAL_DURATION * 2 OVERDUE, CHARGE THE REPLACEMENT_COST
       --#   4) SUBTRACT ALL PAYMENTS MADE BEFORE THE DATE SPECIFIED
DECLARE
    v_rentfees DECIMAL(5,2); --#FEES PAID TO RENT THE VIDEOS INITIALLY
    v_overfees INTEGER;      --#LATE FEES FOR PRIOR RENTALS
    v_payments DECIMAL(5,2); --#SUM OF PAYMENTS MADE PREVIOUSLY
BEGIN
    SELECT COALESCE(SUM(film.rental_rate),0) INTO v_rentfees
    FROM film, inventory, rental
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

    SELECT COALESCE(SUM(IF((rental.return_date - rental.rental_date) > (film.rental_duration * '1 day'::interval),
        ((rental.return_date - rental.rental_date) - (film.rental_duration * '1 day'::interval)),0)),0) INTO v_overfees
    FROM rental, inventory, film
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

    SELECT COALESCE(SUM(payment.amount),0) INTO v_payments
    FROM payment
    WHERE payment.payment_date <= p_effective_date
    AND payment.customer_id = p_customer_id;

    RETURN v_rentfees + v_overfees - v_payments;
END
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.last_updated()...';END$$;
CREATE FUNCTION public.last_updated()
RETURNS trigger
LANGUAGE plpgsql
AS $_$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.last_day(timestamptz)...';END$$;
CREATE FUNCTION public.last_day(IN  timestamptz)
RETURNS date
LANGUAGE sql
AS $_$
  SELECT CASE
    WHEN EXTRACT(MONTH FROM $1) = 12 THEN
      (((EXTRACT(YEAR FROM $1) + 1) operator(pg_catalog.||) '-01-01')::date - INTERVAL '1 day')::date
    ELSE
      ((EXTRACT(YEAR FROM $1) operator(pg_catalog.||) '-' operator(pg_catalog.||) (EXTRACT(MONTH FROM $1) + 1) operator(pg_catalog.||) '-01')::date - INTERVAL '1 day')::date
    END
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.add(int4, int4)...';END$$;
CREATE FUNCTION public.add(IN  int4, IN  int4)
RETURNS int4
LANGUAGE sql
AS $_$select $1 + $2;$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_not_in_stock(int4, int4)...';END$$;
CREATE FUNCTION public.film_not_in_stock(IN p_film_id int4, IN p_store_id int4, OUT p_film_count int4)
RETURNS int4
LANGUAGE sql
AS $_$
    SELECT inventory_id
    FROM inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT inventory_in_stock(inventory_id);
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_payment_id_seq...';END$$;
CREATE SEQUENCE public.payment_payment_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory_inventory_id_seq...';END$$;
CREATE SEQUENCE public.inventory_inventory_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental_rental_id_seq...';END$$;
CREATE SEQUENCE public.rental_rental_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.address_address_id_seq...';END$$;
CREATE SEQUENCE public.address_address_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.country_country_id_seq...';END$$;
CREATE SEQUENCE public.country_country_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actor_actor_id_seq...';END$$;
CREATE SEQUENCE public.actor_actor_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff_staff_id_seq...';END$$;
CREATE SEQUENCE public.staff_staff_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.store_store_id_seq...';END$$;
CREATE SEQUENCE public.store_store_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.language_language_id_seq...';END$$;
CREATE SEQUENCE public.language_language_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.category_category_id_seq...';END$$;
CREATE SEQUENCE public.category_category_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.city_city_id_seq...';END$$;
CREATE SEQUENCE public.city_city_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_film_id_seq...';END$$;
CREATE SEQUENCE public.film_film_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer_customer_id_seq...';END$$;
CREATE SEQUENCE public.customer_customer_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.subscriptions_id_seq...';END$$;
CREATE SEQUENCE public.subscriptions_id_seq
AS int4
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.artists...';END$$;
CREATE TABLE public.artists (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.products...';END$$;
CREATE TABLE public.products (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.books...';END$$;
CREATE TABLE public.books (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.store...';END$$;
CREATE TABLE public.store (
    store_id int4 NOT NULL DEFAULT nextval('public.store_store_id_seq'::regclass),
    manager_staff_id int4 NOT NULL,
    address_id int4 NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.store ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_unq_manager_staff_id...';END$$;
CREATE UNIQUE INDEX idx_unq_manager_staff_id ON public.store USING btree (manager_staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff...';END$$;
CREATE TABLE public.staff (
    staff_id int4 NOT NULL DEFAULT nextval('public.staff_staff_id_seq'::regclass),
    first_name text NOT NULL,
    last_name text NOT NULL,
    address_id int4 NOT NULL,
    email text,
    store_id int4 NOT NULL,
    active bool NOT NULL DEFAULT true,
    username text NOT NULL,
    password text,
    last_update timestamptz NOT NULL DEFAULT now(),
    picture bytea
);
ALTER TABLE public.staff ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff.staff_store_id_fkey...';END$$;
ALTER TABLE public.staff ADD CONSTRAINT staff_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04...';END$$;
CREATE TABLE public.payment_p2020_04 (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04.payment_p2020_04_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_04 ADD CONSTRAINT payment_p2020_04_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_04_customer_id_idx ON public.payment_p2020_04 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_04_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_04_staff_id ON public.payment_p2020_04 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_04_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_04_customer_id ON public.payment_p2020_04 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03...';END$$;
CREATE TABLE public.payment_p2020_03 (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03.payment_p2020_03_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_03 ADD CONSTRAINT payment_p2020_03_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_03_customer_id_idx ON public.payment_p2020_03 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_03_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_03_staff_id ON public.payment_p2020_03 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_03_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_03_customer_id ON public.payment_p2020_03 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02...';END$$;
CREATE TABLE public.payment_p2020_02 (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02.payment_p2020_02_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_02 ADD CONSTRAINT payment_p2020_02_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_02_customer_id_idx ON public.payment_p2020_02 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_02_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_02_staff_id ON public.payment_p2020_02 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_02_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_02_customer_id ON public.payment_p2020_02 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01...';END$$;
CREATE TABLE public.payment_p2020_01 (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01.payment_p2020_01_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_01 ADD CONSTRAINT payment_p2020_01_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_01_customer_id_idx ON public.payment_p2020_01 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_01_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_01_staff_id ON public.payment_p2020_01 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_01_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_01_customer_id ON public.payment_p2020_01 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.films...';END$$;
CREATE TABLE public.films (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05...';END$$;
CREATE TABLE public.payment_p2020_05 (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05.payment_p2020_05_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_05 ADD CONSTRAINT payment_p2020_05_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_05_customer_id_idx ON public.payment_p2020_05 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_05_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_05_staff_id ON public.payment_p2020_05 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_05_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_05_customer_id ON public.payment_p2020_05 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental...';END$$;
CREATE TABLE public.rental (
    rental_id int4 NOT NULL DEFAULT nextval('public.rental_rental_id_seq'::regclass),
    rental_date timestamptz NOT NULL,
    inventory_id int4 NOT NULL,
    customer_id int4 NOT NULL,
    return_date timestamptz,
    staff_id int4 NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.rental ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental.rental_staff_id_fkey...';END$$;
ALTER TABLE public.rental ADD CONSTRAINT rental_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05.payment_p2020_05_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_05 ADD CONSTRAINT payment_p2020_05_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04.payment_p2020_04_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_04 ADD CONSTRAINT payment_p2020_04_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03.payment_p2020_03_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_03 ADD CONSTRAINT payment_p2020_03_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02.payment_p2020_02_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_02 ADD CONSTRAINT payment_p2020_02_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01.payment_p2020_01_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_01 ADD CONSTRAINT payment_p2020_01_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_unq_rental_rental_date_inventory_id_customer_id...';END$$;
CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON public.rental USING btree (rental_date, inventory_id, customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_inventory_id...';END$$;
CREATE INDEX idx_fk_inventory_id ON public.rental USING btree (inventory_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06...';END$$;
CREATE TABLE public.payment_p2020_06 (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06.payment_p2020_06_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_06 ADD CONSTRAINT payment_p2020_06_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06.payment_p2020_06_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_06 ADD CONSTRAINT payment_p2020_06_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_06_customer_id_idx ON public.payment_p2020_06 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_06_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_06_staff_id ON public.payment_p2020_06 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_06_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_06_customer_id ON public.payment_p2020_06 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.adamtest...';END$$;
CREATE TABLE public.adamtest (
    title varchar,
    year date,
    tester varchar
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.checking...';END$$;
CREATE TABLE public.checking (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.subscriptions...';END$$;
CREATE TABLE public.subscriptions (
    id int4 NOT NULL DEFAULT nextval('public.subscriptions_id_seq'::regclass),
    subscription_name varchar
);
ALTER TABLE public.subscriptions ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.subscriptions_id_seq...';END$$;
ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.movies...';END$$;
CREATE TABLE public.movies (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory...';END$$;
CREATE TABLE public.inventory (
    inventory_id int4 NOT NULL DEFAULT nextval('public.inventory_inventory_id_seq'::regclass),
    film_id int4 NOT NULL,
    store_id int4 NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.inventory ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental.rental_inventory_id_fkey...';END$$;
ALTER TABLE public.rental ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory (inventory_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory.inventory_store_id_fkey...';END$$;
ALTER TABLE public.inventory ADD CONSTRAINT inventory_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_store_id_film_id...';END$$;
CREATE INDEX idx_store_id_film_id ON public.inventory USING btree (store_id, film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.language...';END$$;
CREATE TABLE public.language (
    language_id int4 NOT NULL DEFAULT nextval('public.language_language_id_seq'::regclass),
    name bpchar NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now(),
    dev1 varchar
);
ALTER TABLE public.language ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_category...';END$$;
CREATE TABLE public.film_category (
    film_id int4 NOT NULL,
    category_id int4 NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.film_category ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.category...';END$$;
CREATE TABLE public.category (
    category_id int4 NOT NULL DEFAULT nextval('public.category_category_id_seq'::regclass),
    name text NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.category ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_category.film_category_category_id_fkey...';END$$;
ALTER TABLE public.film_category ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category (category_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer...';END$$;
CREATE TABLE public.customer (
    customer_id int4 NOT NULL DEFAULT nextval('public.customer_customer_id_seq'::regclass),
    store_id int4 NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text,
    address_id int4 NOT NULL,
    activebool bool NOT NULL DEFAULT true,
    create_date date NOT NULL DEFAULT CURRENT_DATE,
    last_update timestamptz DEFAULT now(),
    active int4,
    phone varchar,
    website varchar,
    fax varchar,
    test1 varchar,
    checking varchar,
    dev5 varchar,
    url varchar,
    address varchar,
    alternive_name varchar,
    test3 varchar,
    georgiapacificcolumn varchar,
    amwincolumn varchar,
    fiftytwocolumn varchar,
    uniquereference varchar,
    description varchar,
    astcolumn varchar,
    schwabcolumn varchar
);
ALTER TABLE public.customer ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rewards_report(int4, numeric)...';END$$;
CREATE FUNCTION public.rewards_report(IN min_monthly_purchases int4, IN min_dollar_amount_purchased numeric)
RETURNS public.customer
LANGUAGE plpgsql
AS $_$
DECLARE
    last_month_start DATE;
    last_month_end DATE;
rr RECORD;
tmpSQL TEXT;
BEGIN

    /* Some sanity checks... */
    IF min_monthly_purchases = 0 THEN
        RAISE EXCEPTION 'Minimum monthly purchases parameter must be > 0';
    END IF;
    IF min_dollar_amount_purchased = 0.00 THEN
        RAISE EXCEPTION 'Minimum monthly dollar amount purchased parameter must be > $0.00';
    END IF;

    last_month_start := CURRENT_DATE - '3 month'::interval;
    last_month_start := to_date((extract(YEAR FROM last_month_start) || '-' || extract(MONTH FROM last_month_start) || '-01'),'YYYY-MM-DD');
    last_month_end := LAST_DAY(last_month_start);

    /*
    Create a temporary storage area for Customer IDs.
    */
    CREATE TEMPORARY TABLE tmpCustomer (customer_id INTEGER NOT NULL PRIMARY KEY);

    /*
    Find all customers meeting the monthly purchase requirements
    */

    tmpSQL := 'INSERT INTO tmpCustomer (customer_id)
        SELECT p.customer_id
        FROM payment AS p
        WHERE DATE(p.payment_date) BETWEEN '||quote_literal(last_month_start) ||' AND '|| quote_literal(last_month_end) || '
        GROUP BY customer_id
        HAVING SUM(p.amount) > '|| min_dollar_amount_purchased || '
        AND COUNT(customer_id) > ' ||min_monthly_purchases ;

    EXECUTE tmpSQL;

    /*
    Output ALL customer information of matching rewardees.
    Customize output as needed.
    */
    FOR rr IN EXECUTE 'SELECT c.* FROM tmpCustomer AS t INNER JOIN customer AS c ON t.customer_id = c.customer_id' LOOP
        RETURN NEXT rr;
    END LOOP;

    /* Clean up */
    tmpSQL := 'DROP TABLE tmpCustomer';
    EXECUTE tmpSQL;

RETURN;
END
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental.rental_customer_id_fkey...';END$$;
ALTER TABLE public.rental ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06.payment_p2020_06_customer_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_06 ADD CONSTRAINT payment_p2020_06_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05.payment_p2020_05_customer_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_05 ADD CONSTRAINT payment_p2020_05_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04.payment_p2020_04_customer_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_04 ADD CONSTRAINT payment_p2020_04_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03.payment_p2020_03_customer_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_03 ADD CONSTRAINT payment_p2020_03_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02.payment_p2020_02_customer_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_02 ADD CONSTRAINT payment_p2020_02_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01.payment_p2020_01_customer_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_01 ADD CONSTRAINT payment_p2020_01_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer.customer_store_id_fkey...';END$$;
ALTER TABLE public.customer ADD CONSTRAINT customer_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_last_name...';END$$;
CREATE INDEX idx_last_name ON public.customer USING btree (last_name);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_store_id...';END$$;
CREATE INDEX idx_fk_store_id ON public.customer USING btree (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_address_id...';END$$;
CREATE INDEX idx_fk_address_id ON public.customer USING btree (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.country...';END$$;
CREATE TABLE public.country (
    country_id int4 NOT NULL DEFAULT nextval('public.country_country_id_seq'::regclass),
    country text NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.country ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.address...';END$$;
CREATE TABLE public.address (
    address_id int4 NOT NULL DEFAULT nextval('public.address_address_id_seq'::regclass),
    address text NOT NULL,
    address2 text,
    district text NOT NULL,
    city_id int4 NOT NULL,
    postal_code text,
    phone text NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.address ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.store.store_address_id_fkey...';END$$;
ALTER TABLE public.store ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff.staff_address_id_fkey...';END$$;
ALTER TABLE public.staff ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer.customer_address_id_fkey...';END$$;
ALTER TABLE public.customer ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_city_id...';END$$;
CREATE INDEX idx_fk_city_id ON public.address USING btree (city_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.city...';END$$;
CREATE TABLE public.city (
    city_id int4 NOT NULL DEFAULT nextval('public.city_city_id_seq'::regclass),
    city text NOT NULL,
    country_id int4 NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.city ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff_list...';END$$;
CREATE VIEW public.staff_list (id, name, address, "zip code", phone, city, country, sid) AS SELECT s.staff_id AS id,
    ((s.first_name || ' '::text) || s.last_name) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
   FROM (((public.staff s
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer_list...';END$$;
CREATE VIEW public.customer_list (id, name, address, "zip code", phone, city, country, notes, sid) AS SELECT cu.customer_id AS id,
    ((cu.first_name || ' '::text) || cu.last_name) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((public.customer cu
     JOIN public.address a ON ((cu.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.city.city_country_id_fkey...';END$$;
ALTER TABLE public.city ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country (country_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.address.address_city_id_fkey...';END$$;
ALTER TABLE public.address ADD CONSTRAINT address_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city (city_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_country_id...';END$$;
CREATE INDEX idx_fk_country_id ON public.city USING btree (country_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_actor...';END$$;
CREATE TABLE public.film_actor (
    actor_id int4 NOT NULL,
    film_id int4 NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_film_id...';END$$;
CREATE INDEX idx_fk_film_id ON public.film_actor USING btree (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actor...';END$$;
CREATE TABLE public.actor (
    actor_id int4 NOT NULL DEFAULT nextval('public.actor_actor_id_seq'::regclass),
    first_name text NOT NULL,
    last_name text NOT NULL,
    last_update timestamptz NOT NULL DEFAULT now()
);
ALTER TABLE public.actor ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_actor.film_actor_actor_id_fkey...';END$$;
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actor (actor_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_actor_last_name...';END$$;
CREATE INDEX idx_actor_last_name ON public.actor USING btree (last_name);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actors...';END$$;
CREATE TABLE public.actors (
    name varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.sales...';END$$;
CREATE TABLE public.sales (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev14...';END$$;
CREATE TABLE public."Dev14" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev12...';END$$;
CREATE TABLE public."Dev12" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev13...';END$$;
CREATE TABLE public."Dev13" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment...';END$$;
CREATE TABLE public.payment (
    payment_id int4 NOT NULL DEFAULT nextval('public.payment_payment_id_seq'::regclass),
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NOT NULL,
    amount numeric NOT NULL,
    payment_date timestamptz NOT NULL
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.sales_by_store...';END$$;
CREATE VIEW public.sales_by_store (store, manager, total_sales) AS SELECT ((c.city || ','::text) || cy.country) AS store,
    ((m.first_name || ' '::text) || m.last_name) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.store s ON ((i.store_id = s.store_id)))
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city c ON ((a.city_id = c.city_id)))
     JOIN public.country cy ON ((c.country_id = cy.country_id)))
     JOIN public.staff m ON ((s.manager_staff_id = m.staff_id)))
  GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country, c.city;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MorePower...';END$$;
CREATE TABLE public."MorePower" (
    "Test" date,
    "Description" text
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MorePower1...';END$$;
CREATE TABLE public."MorePower1" (
    "Description" text
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.TempTable1...';END$$;
CREATE TABLE public."TempTable1" (
    "CreatedDate" date,
    "Description" text
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev15...';END$$;
CREATE TABLE public."Dev15" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.mpaa_rating...';END$$;
CREATE TYPE public.mpaa_rating AS ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17');


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.year...';END$$;
CREATE DOMAIN public.year AS int4;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film...';END$$;
CREATE TABLE public.film (
    film_id int4 NOT NULL DEFAULT nextval('public.film_film_id_seq'::regclass),
    title text NOT NULL,
    description text,
    release_year public.year,
    language_id int4 NOT NULL,
    original_language_id int4,
    rental_duration int2 NOT NULL DEFAULT 3,
    rental_rate numeric NOT NULL DEFAULT 4.99,
    length int2,
    replacement_cost numeric NOT NULL DEFAULT 19.99,
    rating public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
    last_update timestamptz NOT NULL DEFAULT now(),
    special_features _text,
    fulltext tsvector NOT NULL
);
ALTER TABLE public.film ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.sales_by_film_category...';END$$;
CREATE VIEW public.sales_by_film_category (category, total_sales) AS SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.film f ON ((i.film_id = f.film_id)))
     JOIN public.film_category fc ON ((f.film_id = fc.film_id)))
     JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.nicer_but_slower_film_list...';END$$;
CREATE VIEW public.nicer_but_slower_film_list (fid, title, description, category, price, length, rating, actors) AS SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat((((upper("substring"(actor.first_name, 1, 1)) || lower("substring"(actor.first_name, 2))) || upper("substring"(actor.last_name, 1, 1))) || lower("substring"(actor.last_name, 2)))) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_list...';END$$;
CREATE VIEW public.film_list (fid, title, description, category, price, length, rating, actors) AS SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat(((actor.first_name || ' '::text) || actor.last_name)) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actor_info...';END$$;
CREATE VIEW public.actor_info (actor_id, first_name, last_name, film_info) AS SELECT a.actor_id,
    a.first_name,
    a.last_name,
    public.group_concat(DISTINCT ((c.name || ': '::text) || ( SELECT public.group_concat(f.title) AS group_concat
           FROM ((public.film f
             JOIN public.film_category fc_1 ON ((f.film_id = fc_1.film_id)))
             JOIN public.film_actor fa_1 ON ((f.film_id = fa_1.film_id)))
          WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
          GROUP BY fa_1.actor_id))) AS film_info
   FROM (((public.actor a
     LEFT JOIN public.film_actor fa ON ((a.actor_id = fa.actor_id)))
     LEFT JOIN public.film_category fc ON ((fa.film_id = fc.film_id)))
     LEFT JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY a.actor_id, a.first_name, a.last_name;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory.inventory_film_id_fkey...';END$$;
ALTER TABLE public.inventory ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_category.film_category_film_id_fkey...';END$$;
ALTER TABLE public.film_category ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_actor.film_actor_film_id_fkey...';END$$;
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film.film_original_language_id_fkey...';END$$;
ALTER TABLE public.film ADD CONSTRAINT film_original_language_id_fkey FOREIGN KEY (original_language_id) REFERENCES public.language (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film.film_language_id_fkey...';END$$;
ALTER TABLE public.film ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.language (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_title...';END$$;
CREATE INDEX idx_title ON public.film USING btree (title);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_original_language_id...';END$$;
CREATE INDEX idx_fk_original_language_id ON public.film USING btree (original_language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_language_id...';END$$;
CREATE INDEX idx_fk_language_id ON public.film USING btree (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_fulltext_idx...';END$$;
CREATE INDEX film_fulltext_idx ON public.film USING gist (fulltext);
SET check_function_bodies = true;
