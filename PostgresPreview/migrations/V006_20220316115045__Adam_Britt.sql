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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev3...';END$$;
CREATE TABLE public.dev3 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev2...';END$$;
CREATE TABLE public.dev2 (
    title varchar,
    year date
);
SET check_function_bodies = true;
