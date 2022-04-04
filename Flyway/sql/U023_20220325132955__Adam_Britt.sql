SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."georgiapacifictable"';END$$;
DROP TABLE public.georgiapacifictable;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."georgiapacificfunction(int4)"';END$$;
DROP FUNCTION public.georgiapacificfunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "georgiapacificcolumn" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN georgiapacificcolumn;
SET check_function_bodies = true;
