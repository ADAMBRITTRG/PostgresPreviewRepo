SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV5...';END$$;
CREATE TABLE public."MV5" (
    
);
SET check_function_bodies = true;
