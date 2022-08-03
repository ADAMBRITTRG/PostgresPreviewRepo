SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping public.Dev17';END$$;
DROP TABLE public."Dev17";
SET check_function_bodies = true;
