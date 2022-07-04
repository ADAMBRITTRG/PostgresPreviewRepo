SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."Dev13"';END$$;
DROP TABLE public."Dev13";
SET check_function_bodies = true;
