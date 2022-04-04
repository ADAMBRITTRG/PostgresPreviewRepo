SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."buildtest"';END$$;
DROP TABLE public.buildtest;
SET check_function_bodies = true;
