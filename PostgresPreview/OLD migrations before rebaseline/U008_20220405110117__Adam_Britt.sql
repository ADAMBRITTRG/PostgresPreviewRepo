SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV8"';END$$;
DROP TABLE public."MV8";
SET check_function_bodies = true;
