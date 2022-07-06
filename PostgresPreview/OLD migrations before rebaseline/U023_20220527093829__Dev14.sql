SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."Dev14"';END$$;
DROP TABLE public."Dev14";
SET check_function_bodies = true;
