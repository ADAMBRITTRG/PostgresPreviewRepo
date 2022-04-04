SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."buildtest2"';END$$;
DROP TABLE public.buildtest2;
SET check_function_bodies = true;
