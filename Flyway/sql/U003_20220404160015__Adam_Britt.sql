SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV3"';END$$;
DROP TABLE public."MV3";
SET check_function_bodies = true;
