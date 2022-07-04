SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating astcolumn on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN astcolumn varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.ASTTable...';END$$;
CREATE TABLE public."ASTTable" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.astfunction(int4)...';END$$;
CREATE FUNCTION public.astfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;
SET check_function_bodies = true;
