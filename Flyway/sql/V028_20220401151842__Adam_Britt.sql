SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.buildtest...';END$$;
CREATE TABLE public.buildtest (
    title varchar,
    year date
);
SET check_function_bodies = true;
