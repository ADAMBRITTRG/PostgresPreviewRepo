SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.ScwabTable...';END$$;
CREATE TABLE public."ScwabTable" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.schwabfunction(int4)...';END$$;
CREATE FUNCTION public.schwabfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating schwabcolumn on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN schwabcolumn varchar;
SET check_function_bodies = true;