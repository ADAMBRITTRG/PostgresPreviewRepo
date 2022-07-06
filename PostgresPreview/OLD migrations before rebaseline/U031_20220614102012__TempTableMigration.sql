SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."TempTable1"';END$$;
DROP TABLE public."TempTable1";
SET check_function_bodies = true;
