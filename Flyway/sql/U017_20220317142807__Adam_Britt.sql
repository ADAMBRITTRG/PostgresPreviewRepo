SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."increment(int4)"';END$$;
DROP FUNCTION public.increment(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."artists"';END$$;
DROP TABLE public.artists;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "alternive_name" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN alternive_name;
SET check_function_bodies = true;
