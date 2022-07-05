SET check_function_bodies = false;

DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.georgiapacifictable...';END$$;
CREATE TABLE public.georgiapacifictable (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.fiftytwotable...';END$$;
CREATE TABLE public.fiftytwotable (
    title varchar,
    year date
);
SET check_function_bodies = true;
