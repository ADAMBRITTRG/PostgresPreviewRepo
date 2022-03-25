SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.georgiapacifictable...';END$$;
CREATE TABLE public.georgiapacifictable (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.georgiapacificfunction(int4)...';END$$;
CREATE FUNCTION public.georgiapacificfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating georgiapacificcolumn on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN georgiapacificcolumn varchar;
SET check_function_bodies = true;
