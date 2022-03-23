SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.test3...';END$$;
CREATE TABLE public.test3 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating test3 on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN test3 varchar;
SET check_function_bodies = true;
