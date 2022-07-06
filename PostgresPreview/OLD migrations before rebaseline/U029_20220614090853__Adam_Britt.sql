SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MorePower"';END$$;
DROP TABLE public."MorePower";
SET check_function_bodies = true;
