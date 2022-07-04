SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."Dev12"';END$$;
DROP TABLE public."Dev12";
SET check_function_bodies = true;
