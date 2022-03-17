SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.increment(int4)...';END$$;
DROP FUNCTION public.increment(int4);
CREATE FUNCTION public.increment(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;
