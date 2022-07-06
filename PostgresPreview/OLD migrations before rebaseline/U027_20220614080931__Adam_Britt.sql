SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.actor ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_name...';END$$;
ALTER TABLE public.actor ALTER COLUMN last_name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering first_name...';END$$;
ALTER TABLE public.actor ALTER COLUMN first_name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering actor_id...';END$$;
ALTER TABLE public.actor ALTER COLUMN actor_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.film_actor ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.address ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering phone...';END$$;
ALTER TABLE public.address ALTER COLUMN phone DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering city_id...';END$$;
ALTER TABLE public.address ALTER COLUMN city_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering district...';END$$;
ALTER TABLE public.address ALTER COLUMN district DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address...';END$$;
ALTER TABLE public.address ALTER COLUMN address DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.address ALTER COLUMN address_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.city ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering country_id...';END$$;
ALTER TABLE public.city ALTER COLUMN country_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering city...';END$$;
ALTER TABLE public.city ALTER COLUMN city DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering city_id...';END$$;
ALTER TABLE public.city ALTER COLUMN city_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.country ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering country...';END$$;
ALTER TABLE public.country ALTER COLUMN country DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering country_id...';END$$;
ALTER TABLE public.country ALTER COLUMN country_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.category ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering name...';END$$;
ALTER TABLE public.category ALTER COLUMN name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering category_id...';END$$;
ALTER TABLE public.category ALTER COLUMN category_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating "Test"."TestTableInTestSchema"...';END$$;
CREATE TABLE "Test"."TestTableInTestSchema" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.customer ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering create_date...';END$$;
ALTER TABLE public.customer ALTER COLUMN create_date DROP NOT NULL, ALTER COLUMN create_date DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering activebool...';END$$;
ALTER TABLE public.customer ALTER COLUMN activebool DROP NOT NULL, ALTER COLUMN activebool DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.customer ALTER COLUMN address_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_name...';END$$;
ALTER TABLE public.customer ALTER COLUMN last_name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering first_name...';END$$;
ALTER TABLE public.customer ALTER COLUMN first_name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.customer ALTER COLUMN store_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.customer ALTER COLUMN customer_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.language ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering name...';END$$;
ALTER TABLE public.language ALTER COLUMN name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering language_id...';END$$;
ALTER TABLE public.language ALTER COLUMN language_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.film_category ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering fulltext...';END$$;
ALTER TABLE public.film ALTER COLUMN fulltext DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.film ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rating...';END$$;
ALTER TABLE public.film ALTER COLUMN rating DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering replacement_cost...';END$$;
ALTER TABLE public.film ALTER COLUMN replacement_cost DROP NOT NULL, ALTER COLUMN replacement_cost DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_rate...';END$$;
ALTER TABLE public.film ALTER COLUMN rental_rate DROP NOT NULL, ALTER COLUMN rental_rate DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_duration...';END$$;
ALTER TABLE public.film ALTER COLUMN rental_duration DROP NOT NULL, ALTER COLUMN rental_duration DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering language_id...';END$$;
ALTER TABLE public.film ALTER COLUMN language_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering title...';END$$;
ALTER TABLE public.film ALTER COLUMN title DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering film_id...';END$$;
ALTER TABLE public.film ALTER COLUMN film_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.inventory ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.inventory ALTER COLUMN store_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering film_id...';END$$;
ALTER TABLE public.inventory ALTER COLUMN film_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering inventory_id...';END$$;
ALTER TABLE public.inventory ALTER COLUMN inventory_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering id...';END$$;
ALTER TABLE public.subscriptions ALTER COLUMN id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.rental ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering inventory_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN inventory_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_date...';END$$;
ALTER TABLE public.rental ALTER COLUMN rental_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN rental_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN payment_date DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN amount DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN rental_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN customer_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN payment_id DROP NOT NULL, ALTER COLUMN payment_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.staff ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering username...';END$$;
ALTER TABLE public.staff ALTER COLUMN username DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering active...';END$$;
ALTER TABLE public.staff ALTER COLUMN active DROP NOT NULL, ALTER COLUMN active DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.staff ALTER COLUMN store_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.staff ALTER COLUMN address_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_name...';END$$;
ALTER TABLE public.staff ALTER COLUMN last_name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering first_name...';END$$;
ALTER TABLE public.staff ALTER COLUMN first_name DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.staff ALTER COLUMN staff_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.store ALTER COLUMN last_update DROP NOT NULL, ALTER COLUMN last_update DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.store ALTER COLUMN address_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering manager_staff_id...';END$$;
ALTER TABLE public.store ALTER COLUMN manager_staff_id DROP NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.store ALTER COLUMN store_id DROP DEFAULT;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating "Test"...';END$$;
CREATE SCHEMA "Test";
SET check_function_bodies = true;
