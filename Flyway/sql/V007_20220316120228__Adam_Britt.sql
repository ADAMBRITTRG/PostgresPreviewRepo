SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev4...';END$$;
CREATE TABLE public.dev4 (
    title varchar,
    year date
);
SET check_function_bodies = true;
