SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."test3"';END$$;
DROP TABLE public.test3;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "test3" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN test3;
SET check_function_bodies = true;
