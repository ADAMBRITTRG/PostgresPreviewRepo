SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV3...';END$$;
CREATE TABLE public."MV3" (
    
);
SET check_function_bodies = true;
