SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV10"';END$$;
DROP TABLE public."MV10";


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.additonalfunction(int4)...';END$$;
CREATE FUNCTION public.additonalfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;
