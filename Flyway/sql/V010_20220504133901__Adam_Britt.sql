SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."amwintable"';END$$;
DROP TABLE public.amwintable;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."georgiapacifictable"';END$$;
DROP TABLE public.georgiapacifictable;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."fiftytwotable"';END$$;
DROP TABLE public.fiftytwotable;
SET check_function_bodies = true;
