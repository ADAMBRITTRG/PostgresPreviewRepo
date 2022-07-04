SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev10...';END$$;
CREATE TABLE public."Dev10" (
    "Date" date
);
SET check_function_bodies = true;
