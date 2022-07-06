SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV4"';END$$;
DROP TABLE public."MV4";
SET check_function_bodies = true;
