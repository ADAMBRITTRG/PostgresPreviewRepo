SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating amwincolumn on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN amwincolumn varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.amwintable...';END$$;
CREATE TABLE public.amwintable (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.amwinfunction(int4)...';END$$;
CREATE FUNCTION public.amwinfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;
