SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."astfunction(int4)"';END$$;
DROP FUNCTION public.astfunction(int4);
SET check_function_bodies = true;
