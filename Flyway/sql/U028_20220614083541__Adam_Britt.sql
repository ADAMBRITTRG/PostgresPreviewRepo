SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating "public"."schwabfunction(int4)"...';END$$;
CREATE FUNCTION public.schwabfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;
