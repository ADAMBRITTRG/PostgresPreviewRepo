SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV9"';END$$;
DROP TABLE public."MV9";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."actors"';END$$;
DROP TABLE public.actors;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.V30...';END$$;
CREATE TABLE public."V30" (
    
);
SET check_function_bodies = true;
