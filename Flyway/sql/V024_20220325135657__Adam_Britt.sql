SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."georgiapacificfunction(int4)"';END$$;
DROP FUNCTION public.georgiapacificfunction(int4);
SET check_function_bodies = true;
