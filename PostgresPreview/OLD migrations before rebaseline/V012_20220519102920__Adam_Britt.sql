SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."additonalfunction(int4)"';END$$;
DROP FUNCTION public.additonalfunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV10...';END$$;
CREATE TABLE public."MV10" (
    "Date" _date
);
SET check_function_bodies = true;
