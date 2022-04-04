SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."amwinfunction(int4)"';END$$;
DROP FUNCTION public.amwinfunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating tester on "public"."adamtest"...';END$$;
ALTER TABLE public.adamtest ADD COLUMN tester varchar;
SET check_function_bodies = true;
