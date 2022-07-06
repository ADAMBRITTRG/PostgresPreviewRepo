SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev15';END$$;
DROP TABLE public."Dev15";
SET check_function_bodies = true;
