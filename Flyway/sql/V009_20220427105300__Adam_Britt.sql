SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV9...';END$$;
CREATE TABLE public."MV9" (
    
);

DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actors...';END$$;
CREATE TABLE public.actors (
    name varchar,
    year date
);
SET check_function_bodies = true;
