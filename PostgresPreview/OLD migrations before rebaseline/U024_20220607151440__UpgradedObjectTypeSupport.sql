SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."staff_list"';END$$;
DROP VIEW public.staff_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."sales_by_store"';END$$;
DROP VIEW public.sales_by_store;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."sales_by_film_category"';END$$;
DROP VIEW public.sales_by_film_category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment_p2020_06_customer_id_idx"';END$$;
DROP INDEX public.payment_p2020_06_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment_p2020_05_customer_id_idx"';END$$;
DROP INDEX public.payment_p2020_05_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment_p2020_04_customer_id_idx"';END$$;
DROP INDEX public.payment_p2020_04_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment_p2020_03_customer_id_idx"';END$$;
DROP INDEX public.payment_p2020_03_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment_p2020_02_customer_id_idx"';END$$;
DROP INDEX public.payment_p2020_02_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment_p2020_01_customer_id_idx"';END$$;
DROP INDEX public.payment_p2020_01_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."payment"';END$$;
DROP TABLE public.payment;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."nicer_but_slower_film_list"';END$$;
DROP VIEW public.nicer_but_slower_film_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_unq_rental_rental_date_inventory_id_customer_id"';END$$;
DROP INDEX public.idx_unq_rental_rental_date_inventory_id_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_unq_manager_staff_id"';END$$;
DROP INDEX public.idx_unq_manager_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_title"';END$$;
DROP INDEX public.idx_title;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_store_id_film_id"';END$$;
DROP INDEX public.idx_store_id_film_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_last_name"';END$$;
DROP INDEX public.idx_last_name;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_store_id"';END$$;
DROP INDEX public.idx_fk_store_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_06_staff_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_06_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_06_customer_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_06_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_05_staff_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_05_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_05_customer_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_05_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_04_staff_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_04_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_04_customer_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_04_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_03_staff_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_03_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_03_customer_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_03_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_02_staff_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_02_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_02_customer_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_02_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_01_staff_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_01_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_payment_p2020_01_customer_id"';END$$;
DROP INDEX public.idx_fk_payment_p2020_01_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_original_language_id"';END$$;
DROP INDEX public.idx_fk_original_language_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_language_id"';END$$;
DROP INDEX public.idx_fk_language_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_inventory_id"';END$$;
DROP INDEX public.idx_fk_inventory_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_film_id"';END$$;
DROP INDEX public.idx_fk_film_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_country_id"';END$$;
DROP INDEX public.idx_fk_country_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_city_id"';END$$;
DROP INDEX public.idx_fk_city_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_fk_address_id"';END$$;
DROP INDEX public.idx_fk_address_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."idx_actor_last_name"';END$$;
DROP INDEX public.idx_actor_last_name;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."film_list"';END$$;
DROP VIEW public.film_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."film_fulltext_idx"';END$$;
DROP INDEX public.film_fulltext_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."customer_list"';END$$;
DROP VIEW public.customer_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."actor_info"';END$$;
DROP VIEW public.actor_info;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."group_concat(text)"';END$$;
DROP AGGREGATE public.group_concat(text);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.schwabfunction(int4)...';END$$;
DROP FUNCTION public.schwabfunction(int4);
CREATE FUNCTION public.schwabfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;