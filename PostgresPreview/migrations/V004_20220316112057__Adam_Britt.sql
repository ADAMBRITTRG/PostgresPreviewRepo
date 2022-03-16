SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."increment(int4)"';END$$;
DROP FUNCTION public.increment(int4);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.usertest2...';END$$;
CREATE TABLE public.usertest2 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating test1 on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN test1 varchar;
SET check_function_bodies = true;
