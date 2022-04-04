SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.products...';END$$;
CREATE TABLE public.products (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating address on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN address varchar;
SET check_function_bodies = true;
