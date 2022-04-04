SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."V30"';END$$;
DROP TABLE public."V30";
SET check_function_bodies = true;
