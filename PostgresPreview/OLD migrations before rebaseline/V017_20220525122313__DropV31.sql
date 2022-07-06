SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."v31"';END$$;
DROP TABLE public.v31;
SET check_function_bodies = true;
