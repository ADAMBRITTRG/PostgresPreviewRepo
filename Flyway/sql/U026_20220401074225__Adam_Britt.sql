SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.amwinfunction(int4)...';END$$;
CREATE FUNCTION public.amwinfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "tester" on "public"."adamtest"...';END$$;
ALTER TABLE public.adamtest DROP COLUMN tester;
SET check_function_bodies = true;
