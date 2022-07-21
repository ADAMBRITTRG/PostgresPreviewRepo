SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.store.last_updated';END$$;
DROP TRIGGER last_updated ON public.store;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff.last_updated';END$$;
DROP TRIGGER last_updated ON public.staff;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental.last_updated';END$$;
DROP TRIGGER last_updated ON public.rental;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.language.last_updated';END$$;
DROP TRIGGER last_updated ON public.language;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory.last_updated';END$$;
DROP TRIGGER last_updated ON public.inventory;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_category.last_updated';END$$;
DROP TRIGGER last_updated ON public.film_category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_actor.last_updated';END$$;
DROP TRIGGER last_updated ON public.film_actor;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film.last_updated';END$$;
DROP TRIGGER last_updated ON public.film;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film.film_fulltext_trigger';END$$;
DROP TRIGGER film_fulltext_trigger ON public.film;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev16';END$$;
DROP TABLE public."Dev16";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer.last_updated';END$$;
DROP TRIGGER last_updated ON public.customer;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.country.last_updated';END$$;
DROP TRIGGER last_updated ON public.country;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.city.last_updated';END$$;
DROP TRIGGER last_updated ON public.city;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.category.last_updated';END$$;
DROP TRIGGER last_updated ON public.category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.address.last_updated';END$$;
DROP TRIGGER last_updated ON public.address;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.actor.last_updated';END$$;
DROP TRIGGER last_updated ON public.actor;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.rewards_report(int4, numeric)...';END$$;
CREATE OR REPLACE FUNCTION public.rewards_report(IN min_monthly_purchases int4, IN min_dollar_amount_purchased numeric)
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.film_not_in_stock(int4, int4)...';END$$;
CREATE OR REPLACE FUNCTION public.film_not_in_stock(IN p_film_id int4, IN p_store_id int4, OUT p_film_count int4)
RETURNS int4
LANGUAGE sql
AS $_$
    SELECT inventory_id
    FROM inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT inventory_in_stock(inventory_id);
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.last_day(timestamptz)...';END$$;
CREATE OR REPLACE FUNCTION public.last_day(IN  timestamptz)
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.last_updated()...';END$$;
CREATE OR REPLACE FUNCTION public.last_updated()
RETURNS trigger
LANGUAGE plpgsql
AS $_$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.get_customer_balance(int4, timestamptz)...';END$$;
CREATE OR REPLACE FUNCTION public.get_customer_balance(IN p_customer_id int4, IN p_effective_date timestamptz)
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.inventory_held_by_customer(int4)...';END$$;
CREATE OR REPLACE FUNCTION public.inventory_held_by_customer(IN p_inventory_id int4)
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.inventory_in_stock(int4)...';END$$;
CREATE OR REPLACE FUNCTION public.inventory_in_stock(IN p_inventory_id int4)
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


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public._group_concat(text, text)...';END$$;
CREATE OR REPLACE FUNCTION public._group_concat(IN  text, IN  text)
RETURNS text
LANGUAGE sql
AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.film_in_stock(int4, int4)...';END$$;
CREATE OR REPLACE FUNCTION public.film_in_stock(IN p_film_id int4, IN p_store_id int4, OUT p_film_count int4)
RETURNS int4
LANGUAGE sql
AS $_$
     SELECT inventory_id
     FROM inventory
     WHERE film_id = $1
     AND store_id = $2
     AND inventory_in_stock(inventory_id);
$_$;
SET check_function_bodies = true;
