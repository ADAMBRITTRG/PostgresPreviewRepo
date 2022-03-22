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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating alternive_name on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN alternive_name varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.artists...';END$$;
CREATE TABLE public.artists (
    title varchar,
    year date
);
SET check_function_bodies = true;
