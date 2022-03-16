SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.increment(int4)...';END$$;
CREATE FUNCTION public.increment(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating checking on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN checking varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.checking...';END$$;
CREATE TABLE public.checking (
    title varchar,
    year date
);
SET check_function_bodies = true;
