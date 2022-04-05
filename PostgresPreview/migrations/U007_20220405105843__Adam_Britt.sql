SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV7"';END$$;
DROP TABLE public."MV7";
SET check_function_bodies = true;
