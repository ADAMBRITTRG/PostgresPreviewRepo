SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."ASTTable"';END$$;
DROP TABLE public."ASTTable";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."astfunction(int4)"';END$$;
DROP FUNCTION public.astfunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "astcolumn" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN astcolumn;
SET check_function_bodies = true;
