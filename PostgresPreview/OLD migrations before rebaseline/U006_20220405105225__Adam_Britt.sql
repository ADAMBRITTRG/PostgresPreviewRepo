SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV6"';END$$;
DROP TABLE public."MV6";
SET check_function_bodies = true;
