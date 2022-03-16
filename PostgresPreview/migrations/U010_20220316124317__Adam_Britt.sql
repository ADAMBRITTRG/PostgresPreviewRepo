SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev8"';END$$;
DROP TABLE public.dev8;
SET check_function_bodies = true;
