SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.subscriptions_id_seq...';END$$;
ALTER SEQUENCE public.subscriptions_id_seq OWNED BY NONE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.TempTable1';END$$;
DROP TABLE public."TempTable1";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.subscriptions';END$$;
DROP TABLE public.subscriptions;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.subscriptions_id_seq';END$$;
DROP SEQUENCE public.subscriptions_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.store.store_address_id_fkey';END$$;
ALTER TABLE public.store DROP CONSTRAINT store_address_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.store.last_updated';END$$;
DROP TRIGGER last_updated ON public.store;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff_list';END$$;
DROP VIEW public.staff_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff.staff_store_id_fkey';END$$;
ALTER TABLE public.staff DROP CONSTRAINT staff_store_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff.staff_address_id_fkey';END$$;
ALTER TABLE public.staff DROP CONSTRAINT staff_address_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff.last_updated';END$$;
DROP TRIGGER last_updated ON public.staff;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.sales_by_store';END$$;
DROP VIEW public.sales_by_store;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.sales_by_film_category';END$$;
DROP VIEW public.sales_by_film_category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.sales';END$$;
DROP TABLE public.sales;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rewards_report(int4, numeric)';END$$;
DROP FUNCTION public.rewards_report(int4, numeric);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental.rental_staff_id_fkey';END$$;
ALTER TABLE public.rental DROP CONSTRAINT rental_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental.rental_inventory_id_fkey';END$$;
ALTER TABLE public.rental DROP CONSTRAINT rental_inventory_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental.rental_customer_id_fkey';END$$;
ALTER TABLE public.rental DROP CONSTRAINT rental_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental.last_updated';END$$;
DROP TRIGGER last_updated ON public.rental;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.products';END$$;
DROP TABLE public.products;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_06_customer_id_idx';END$$;
DROP INDEX public.payment_p2020_06_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_06.payment_p2020_06_staff_id_fkey';END$$;
ALTER TABLE public.payment_p2020_06 DROP CONSTRAINT payment_p2020_06_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_06.payment_p2020_06_rental_id_fkey';END$$;
ALTER TABLE public.payment_p2020_06 DROP CONSTRAINT payment_p2020_06_rental_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_06.payment_p2020_06_customer_id_fkey';END$$;
ALTER TABLE public.payment_p2020_06 DROP CONSTRAINT payment_p2020_06_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_05_customer_id_idx';END$$;
DROP INDEX public.payment_p2020_05_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_05.payment_p2020_05_staff_id_fkey';END$$;
ALTER TABLE public.payment_p2020_05 DROP CONSTRAINT payment_p2020_05_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_05.payment_p2020_05_rental_id_fkey';END$$;
ALTER TABLE public.payment_p2020_05 DROP CONSTRAINT payment_p2020_05_rental_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_05.payment_p2020_05_customer_id_fkey';END$$;
ALTER TABLE public.payment_p2020_05 DROP CONSTRAINT payment_p2020_05_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_04_customer_id_idx';END$$;
DROP INDEX public.payment_p2020_04_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_04.payment_p2020_04_staff_id_fkey';END$$;
ALTER TABLE public.payment_p2020_04 DROP CONSTRAINT payment_p2020_04_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_04.payment_p2020_04_rental_id_fkey';END$$;
ALTER TABLE public.payment_p2020_04 DROP CONSTRAINT payment_p2020_04_rental_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_04.payment_p2020_04_customer_id_fkey';END$$;
ALTER TABLE public.payment_p2020_04 DROP CONSTRAINT payment_p2020_04_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_03_customer_id_idx';END$$;
DROP INDEX public.payment_p2020_03_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_03.payment_p2020_03_staff_id_fkey';END$$;
ALTER TABLE public.payment_p2020_03 DROP CONSTRAINT payment_p2020_03_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_03.payment_p2020_03_rental_id_fkey';END$$;
ALTER TABLE public.payment_p2020_03 DROP CONSTRAINT payment_p2020_03_rental_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_03.payment_p2020_03_customer_id_fkey';END$$;
ALTER TABLE public.payment_p2020_03 DROP CONSTRAINT payment_p2020_03_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_02_customer_id_idx';END$$;
DROP INDEX public.payment_p2020_02_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_02.payment_p2020_02_staff_id_fkey';END$$;
ALTER TABLE public.payment_p2020_02 DROP CONSTRAINT payment_p2020_02_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_02.payment_p2020_02_rental_id_fkey';END$$;
ALTER TABLE public.payment_p2020_02 DROP CONSTRAINT payment_p2020_02_rental_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_02.payment_p2020_02_customer_id_fkey';END$$;
ALTER TABLE public.payment_p2020_02 DROP CONSTRAINT payment_p2020_02_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_01_customer_id_idx';END$$;
DROP INDEX public.payment_p2020_01_customer_id_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_01.payment_p2020_01_staff_id_fkey';END$$;
ALTER TABLE public.payment_p2020_01 DROP CONSTRAINT payment_p2020_01_staff_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff';END$$;
DROP TABLE public.staff;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.staff_staff_id_seq';END$$;
DROP SEQUENCE public.staff_staff_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_01.payment_p2020_01_rental_id_fkey';END$$;
ALTER TABLE public.payment_p2020_01 DROP CONSTRAINT payment_p2020_01_rental_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_01.payment_p2020_01_customer_id_fkey';END$$;
ALTER TABLE public.payment_p2020_01 DROP CONSTRAINT payment_p2020_01_customer_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment';END$$;
DROP TABLE public.payment;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.nicer_but_slower_film_list';END$$;
DROP VIEW public.nicer_but_slower_film_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.movies';END$$;
DROP TABLE public.movies;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.MorePower1';END$$;
DROP TABLE public."MorePower1";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.MorePower';END$$;
DROP TABLE public."MorePower";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.last_day(timestamptz)';END$$;
DROP FUNCTION public.last_day(timestamptz);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.language.last_updated';END$$;
DROP TRIGGER last_updated ON public.language;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory_in_stock(int4)';END$$;
DROP FUNCTION public.inventory_in_stock(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory_held_by_customer(int4)';END$$;
DROP FUNCTION public.inventory_held_by_customer(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory.last_updated';END$$;
DROP TRIGGER last_updated ON public.inventory;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory.inventory_store_id_fkey';END$$;
ALTER TABLE public.inventory DROP CONSTRAINT inventory_store_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory.inventory_film_id_fkey';END$$;
ALTER TABLE public.inventory DROP CONSTRAINT inventory_film_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_unq_rental_rental_date_inventory_id_customer_id';END$$;
DROP INDEX public.idx_unq_rental_rental_date_inventory_id_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_unq_manager_staff_id';END$$;
DROP INDEX public.idx_unq_manager_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_title';END$$;
DROP INDEX public.idx_title;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_store_id_film_id';END$$;
DROP INDEX public.idx_store_id_film_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory';END$$;
DROP TABLE public.inventory;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.inventory_inventory_id_seq';END$$;
DROP SEQUENCE public.inventory_inventory_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_last_name';END$$;
DROP INDEX public.idx_last_name;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_store_id';END$$;
DROP INDEX public.idx_fk_store_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_06_staff_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_06_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_06_customer_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_06_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_06';END$$;
DROP TABLE public.payment_p2020_06;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_05_staff_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_05_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_05_customer_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_05_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_05';END$$;
DROP TABLE public.payment_p2020_05;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_04_staff_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_04_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_04_customer_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_04_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_04';END$$;
DROP TABLE public.payment_p2020_04;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_03_staff_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_03_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_03_customer_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_03_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_03';END$$;
DROP TABLE public.payment_p2020_03;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_02_staff_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_02_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_02_customer_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_02_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_02';END$$;
DROP TABLE public.payment_p2020_02;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_01_staff_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_01_staff_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_payment_p2020_01_customer_id';END$$;
DROP INDEX public.idx_fk_payment_p2020_01_customer_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_p2020_01';END$$;
DROP TABLE public.payment_p2020_01;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.payment_payment_id_seq';END$$;
DROP SEQUENCE public.payment_payment_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_original_language_id';END$$;
DROP INDEX public.idx_fk_original_language_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_language_id';END$$;
DROP INDEX public.idx_fk_language_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_inventory_id';END$$;
DROP INDEX public.idx_fk_inventory_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental';END$$;
DROP TABLE public.rental;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.rental_rental_id_seq';END$$;
DROP SEQUENCE public.rental_rental_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_film_id';END$$;
DROP INDEX public.idx_fk_film_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_country_id';END$$;
DROP INDEX public.idx_fk_country_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_city_id';END$$;
DROP INDEX public.idx_fk_city_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_fk_address_id';END$$;
DROP INDEX public.idx_fk_address_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.idx_actor_last_name';END$$;
DROP INDEX public.idx_actor_last_name;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.get_customer_balance(int4, timestamptz)';END$$;
DROP FUNCTION public.get_customer_balance(int4, timestamptz);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_not_in_stock(int4, int4)';END$$;
DROP FUNCTION public.film_not_in_stock(int4, int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_list';END$$;
DROP VIEW public.film_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_in_stock(int4, int4)';END$$;
DROP FUNCTION public.film_in_stock(int4, int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_fulltext_idx';END$$;
DROP INDEX public.film_fulltext_idx;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_category.last_updated';END$$;
DROP TRIGGER last_updated ON public.film_category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_category.film_category_film_id_fkey';END$$;
ALTER TABLE public.film_category DROP CONSTRAINT film_category_film_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_category.film_category_category_id_fkey';END$$;
ALTER TABLE public.film_category DROP CONSTRAINT film_category_category_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_actor.last_updated';END$$;
DROP TRIGGER last_updated ON public.film_actor;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_actor.film_actor_film_id_fkey';END$$;
ALTER TABLE public.film_actor DROP CONSTRAINT film_actor_film_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_actor.film_actor_actor_id_fkey';END$$;
ALTER TABLE public.film_actor DROP CONSTRAINT film_actor_actor_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.films';END$$;
DROP TABLE public.films;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film.last_updated';END$$;
DROP TRIGGER last_updated ON public.film;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film.film_original_language_id_fkey';END$$;
ALTER TABLE public.film DROP CONSTRAINT film_original_language_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film.film_language_id_fkey';END$$;
ALTER TABLE public.film DROP CONSTRAINT film_language_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.language';END$$;
DROP TABLE public.language;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.language_language_id_seq';END$$;
DROP SEQUENCE public.language_language_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film.film_fulltext_trigger';END$$;
DROP TRIGGER film_fulltext_trigger ON public.film;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev16';END$$;
DROP TABLE public."Dev16";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev15';END$$;
DROP TABLE public."Dev15";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev14';END$$;
DROP TABLE public."Dev14";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev13';END$$;
DROP TABLE public."Dev13";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev12';END$$;
DROP TABLE public."Dev12";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer_list';END$$;
DROP VIEW public.customer_list;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer.last_updated';END$$;
DROP TRIGGER last_updated ON public.customer;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer.customer_store_id_fkey';END$$;
ALTER TABLE public.customer DROP CONSTRAINT customer_store_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.store';END$$;
DROP TABLE public.store;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.store_store_id_seq';END$$;
DROP SEQUENCE public.store_store_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer.customer_address_id_fkey';END$$;
ALTER TABLE public.customer DROP CONSTRAINT customer_address_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer';END$$;
DROP TABLE public.customer;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.customer_customer_id_seq';END$$;
DROP SEQUENCE public.customer_customer_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.country.last_updated';END$$;
DROP TRIGGER last_updated ON public.country;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.city.last_updated';END$$;
DROP TRIGGER last_updated ON public.city;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.city.city_country_id_fkey';END$$;
ALTER TABLE public.city DROP CONSTRAINT city_country_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.country';END$$;
DROP TABLE public.country;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.country_country_id_seq';END$$;
DROP SEQUENCE public.country_country_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.checking';END$$;
DROP TABLE public.checking;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.category.last_updated';END$$;
DROP TRIGGER last_updated ON public.category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.books';END$$;
DROP TABLE public.books;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.artists';END$$;
DROP TABLE public.artists;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.address.last_updated';END$$;
DROP TRIGGER last_updated ON public.address;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.address.address_city_id_fkey';END$$;
ALTER TABLE public.address DROP CONSTRAINT address_city_id_fkey;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.city';END$$;
DROP TABLE public.city;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.city_city_id_seq';END$$;
DROP SEQUENCE public.city_city_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.address';END$$;
DROP TABLE public.address;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.address_address_id_seq';END$$;
DROP SEQUENCE public.address_address_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.add(int4, int4)';END$$;
DROP FUNCTION public.add(int4, int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.adamtest';END$$;
DROP TABLE public.adamtest;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.actor_info';END$$;
DROP VIEW public.actor_info;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.group_concat(text)';END$$;
DROP AGGREGATE public.group_concat(text);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public._group_concat(text, text)';END$$;
DROP FUNCTION public._group_concat(text, text);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_category';END$$;
DROP TABLE public.film_category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_actor';END$$;
DROP TABLE public.film_actor;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film';END$$;
DROP TABLE public.film;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.mpaa_rating';END$$;
DROP TYPE public.mpaa_rating;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.year';END$$;
DROP DOMAIN public.year;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.film_film_id_seq';END$$;
DROP SEQUENCE public.film_film_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.category';END$$;
DROP TABLE public.category;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.category_category_id_seq';END$$;
DROP SEQUENCE public.category_category_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.actors';END$$;
DROP TABLE public.actors;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.actor.last_updated';END$$;
DROP TRIGGER last_updated ON public.actor;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.last_updated()';END$$;
DROP FUNCTION public.last_updated();


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.actor';END$$;
DROP TABLE public.actor;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.actor_actor_id_seq';END$$;
DROP SEQUENCE public.actor_actor_id_seq;
SET check_function_bodies = true;
