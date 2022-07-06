SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MorePower1"';END$$;
DROP TABLE public."MorePower1";
SET check_function_bodies = true;
