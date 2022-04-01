SET check_function_bodies = false;


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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.mpaa_rating...';END$$;
CREATE TYPE public.mpaa_rating AS ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17');


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.year...';END$$;
CREATE DOMAIN public.year AS int4;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.language_language_id_seq...';END$$;
CREATE SEQUENCE public.language_language_id_seq
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory_inventory_id_seq...';END$$;
CREATE SEQUENCE public.inventory_inventory_id_seq
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_payment_id_seq...';END$$;
CREATE SEQUENCE public.payment_payment_id_seq
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.category_category_id_seq...';END$$;
CREATE SEQUENCE public.category_category_id_seq
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.city_city_id_seq...';END$$;
CREATE SEQUENCE public.city_city_id_seq
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff_staff_id_seq...';END$$;
CREATE SEQUENCE public.staff_staff_id_seq
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_film_id_seq...';END$$;
CREATE SEQUENCE public.film_film_id_seq
AS int8
INCREMENT BY 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04...';END$$;
CREATE TABLE public.payment_p2020_04 (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03...';END$$;
CREATE TABLE public.payment_p2020_03 (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02...';END$$;
CREATE TABLE public.payment_p2020_02 (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01...';END$$;
CREATE TABLE public.payment_p2020_01 (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.store...';END$$;
CREATE TABLE public.store (
    store_id int4,
    manager_staff_id int4,
    address_id int4,
    last_update timestamptz
);
ALTER TABLE public.store ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff...';END$$;
CREATE TABLE public.staff (
    staff_id int4,
    first_name text,
    last_name text,
    address_id int4,
    email text,
    store_id int4,
    active bool,
    username text,
    password text,
    last_update timestamptz,
    picture bytea
);
ALTER TABLE public.staff ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff.staff_store_id_fkey...';END$$;
ALTER TABLE public.staff ADD CONSTRAINT staff_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04.payment_p2020_04_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_04 ADD CONSTRAINT payment_p2020_04_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03.payment_p2020_03_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_03 ADD CONSTRAINT payment_p2020_03_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02.payment_p2020_02_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_02 ADD CONSTRAINT payment_p2020_02_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01.payment_p2020_01_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_01 ADD CONSTRAINT payment_p2020_01_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05...';END$$;
CREATE TABLE public.payment_p2020_05 (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05.payment_p2020_05_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_05 ADD CONSTRAINT payment_p2020_05_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental...';END$$;
CREATE TABLE public.rental (
    rental_id int4,
    rental_date timestamptz,
    inventory_id int4,
    customer_id int4,
    return_date timestamptz,
    staff_id int4,
    last_update timestamptz
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06...';END$$;
CREATE TABLE public.payment_p2020_06 (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06.payment_p2020_06_staff_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_06 ADD CONSTRAINT payment_p2020_06_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06.payment_p2020_06_rental_id_fkey...';END$$;
ALTER TABLE public.payment_p2020_06 ADD CONSTRAINT payment_p2020_06_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental (rental_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.language...';END$$;
CREATE TABLE public.language (
    language_id int4,
    name bpchar,
    last_update timestamptz
);
ALTER TABLE public.language ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory...';END$$;
CREATE TABLE public.inventory (
    inventory_id int4,
    film_id int4,
    store_id int4,
    last_update timestamptz
);
ALTER TABLE public.inventory ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rental.rental_inventory_id_fkey...';END$$;
ALTER TABLE public.rental ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory (inventory_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory.inventory_store_id_fkey...';END$$;
ALTER TABLE public.inventory ADD CONSTRAINT inventory_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_category...';END$$;
CREATE TABLE public.film_category (
    film_id int4,
    category_id int4,
    last_update timestamptz
);
ALTER TABLE public.film_category ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film...';END$$;
CREATE TABLE public.film (
    film_id int4,
    title text,
    description text,
    release_year "public"."year",
    language_id int4,
    original_language_id int4,
    rental_duration int2,
    rental_rate numeric,
    length int2,
    replacement_cost numeric,
    rating "public"."mpaa_rating",
    last_update timestamptz,
    special_features _text,
    fulltext tsvector
);
ALTER TABLE public.film ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.inventory.inventory_film_id_fkey...';END$$;
ALTER TABLE public.inventory ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_category.film_category_film_id_fkey...';END$$;
ALTER TABLE public.film_category ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film.film_original_language_id_fkey...';END$$;
ALTER TABLE public.film ADD CONSTRAINT film_original_language_id_fkey FOREIGN KEY (original_language_id) REFERENCES public.language (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film.film_language_id_fkey...';END$$;
ALTER TABLE public.film ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.language (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer...';END$$;
CREATE TABLE public.customer (
    customer_id int4,
    store_id int4,
    first_name text,
    last_name text,
    email text,
    address_id int4,
    activebool bool,
    create_date date,
    last_update timestamptz,
    active int4
);
ALTER TABLE public.customer ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.rewards_report(int4, numeric)...';END$$;
CREATE FUNCTION public.rewards_report(IN min_monthly_purchases int4, IN min_dollar_amount_purchased numeric)
RETURNS "public"."customer"
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.country...';END$$;
CREATE TABLE public.country (
    country_id int4,
    country text,
    last_update timestamptz
);
ALTER TABLE public.country ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.category...';END$$;
CREATE TABLE public.category (
    category_id int4,
    name text,
    last_update timestamptz
);
ALTER TABLE public.category ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_category.film_category_category_id_fkey...';END$$;
ALTER TABLE public.film_category ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category (category_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actor...';END$$;
CREATE TABLE public.actor (
    actor_id int4,
    first_name text,
    last_name text,
    last_update timestamptz
);
ALTER TABLE public.actor ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.city...';END$$;
CREATE TABLE public.city (
    city_id int4,
    city text,
    country_id int4,
    last_update timestamptz
);
ALTER TABLE public.city ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.city.city_country_id_fkey...';END$$;
ALTER TABLE public.city ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country (country_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.address...';END$$;
CREATE TABLE public.address (
    address_id int4,
    address text,
    address2 text,
    district text,
    city_id int4,
    postal_code text,
    phone text,
    last_update timestamptz
);
ALTER TABLE public.address ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.store.store_address_id_fkey...';END$$;
ALTER TABLE public.store ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff.staff_address_id_fkey...';END$$;
ALTER TABLE public.staff ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer.customer_address_id_fkey...';END$$;
ALTER TABLE public.customer ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.address.address_city_id_fkey...';END$$;
ALTER TABLE public.address ADD CONSTRAINT address_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city (city_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_actor...';END$$;
CREATE TABLE public.film_actor (
    actor_id int4,
    film_id int4,
    last_update timestamptz
);
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_actor.film_actor_film_id_fkey...';END$$;
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_actor.film_actor_actor_id_fkey...';END$$;
ALTER TABLE public.film_actor ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actor (actor_id);
SET check_function_bodies = true;
