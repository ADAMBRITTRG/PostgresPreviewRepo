SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating dev1 on "public"."language"...';END$$;
ALTER TABLE public.language ADD COLUMN dev1 varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev9...';END$$;
CREATE TABLE public.dev9 (
    title varchar,
    year date
);
SET check_function_bodies = true;
