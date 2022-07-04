SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev12...';END$$;
CREATE TABLE public."Dev12" (
    "Date" date
);
SET check_function_bodies = true;
