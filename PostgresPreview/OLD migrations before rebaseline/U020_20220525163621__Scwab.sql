SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."ScwabTable"';END$$;
DROP TABLE public."ScwabTable";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."schwabfunction(int4)"';END$$;
DROP FUNCTION public.schwabfunction(int4);

SET check_function_bodies = true;
