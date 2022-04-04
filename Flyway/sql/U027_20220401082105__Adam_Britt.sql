SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."fiftytwotable"';END$$;
DROP TABLE public.fiftytwotable;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."fiftytwofunction(int4)"';END$$;
DROP FUNCTION public.fiftytwofunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "fiftytwocolumn" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN fiftytwocolumn;
SET check_function_bodies = true;
