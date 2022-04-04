SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."amwintable"';END$$;
DROP TABLE public.amwintable;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."amwinfunction(int4)"';END$$;
DROP FUNCTION public.amwinfunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "amwincolumn" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN amwincolumn;
SET check_function_bodies = true;
