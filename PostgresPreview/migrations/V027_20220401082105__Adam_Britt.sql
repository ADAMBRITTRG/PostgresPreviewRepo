SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.fiftytwotable...';END$$;
CREATE TABLE public.fiftytwotable (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.fiftytwofunction(int4)...';END$$;
CREATE FUNCTION public.fiftytwofunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating fiftytwocolumn on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN fiftytwocolumn varchar;
SET check_function_bodies = true;
