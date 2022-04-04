SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."increment(int4)"';END$$;
DROP FUNCTION public.increment(int4);
SET check_function_bodies = true;
