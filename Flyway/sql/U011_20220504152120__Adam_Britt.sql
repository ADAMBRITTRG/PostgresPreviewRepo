SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."sales"';END$$;
DROP TABLE public.sales;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."additonalfunction(int4)"';END$$;
DROP FUNCTION public.additonalfunction(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "description" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN description;
SET check_function_bodies = true;
