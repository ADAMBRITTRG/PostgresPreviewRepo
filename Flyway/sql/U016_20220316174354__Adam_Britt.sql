SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."products"';END$$;
DROP TABLE public.products;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "address" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN address;
SET check_function_bodies = true;
