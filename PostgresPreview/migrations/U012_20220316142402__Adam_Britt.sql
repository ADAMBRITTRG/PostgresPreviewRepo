SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."increment(int4)"';END$$;
DROP FUNCTION public.increment(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."books"';END$$;
DROP TABLE public.books;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "url" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN url;
SET check_function_bodies = true;
