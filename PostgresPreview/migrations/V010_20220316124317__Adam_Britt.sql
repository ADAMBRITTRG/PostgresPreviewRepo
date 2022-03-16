SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev8...';END$$;
CREATE TABLE public.dev8 (
    title varchar,
    year date
);
SET check_function_bodies = true;
