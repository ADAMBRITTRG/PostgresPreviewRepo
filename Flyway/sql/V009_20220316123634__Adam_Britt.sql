SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev7...';END$$;
CREATE TABLE public.dev7 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev6...';END$$;
CREATE TABLE public.dev6 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev5...';END$$;
CREATE TABLE public.dev5 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating dev5 on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN dev5 varchar;
SET check_function_bodies = true;
