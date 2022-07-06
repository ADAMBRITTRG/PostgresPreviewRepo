SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."Dev10"';END$$;
DROP TABLE public."Dev10";
SET check_function_bodies = true;
