SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.georgiapacificfunction(int4)...';END$$;
CREATE FUNCTION public.georgiapacificfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;
