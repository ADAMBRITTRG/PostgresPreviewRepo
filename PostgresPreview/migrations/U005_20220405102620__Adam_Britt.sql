SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV5"';END$$;
DROP TABLE public."MV5";
SET check_function_bodies = true;
