SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev13...';END$$;
CREATE TABLE public."Dev13" (
    "Date" date
);
SET check_function_bodies = true;
