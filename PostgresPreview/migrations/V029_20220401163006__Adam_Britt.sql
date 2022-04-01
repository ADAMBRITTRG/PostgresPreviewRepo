SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.buildtest2...';END$$;
CREATE TABLE public.buildtest2 (
    title varchar,
    year date
);
SET check_function_bodies = true;
