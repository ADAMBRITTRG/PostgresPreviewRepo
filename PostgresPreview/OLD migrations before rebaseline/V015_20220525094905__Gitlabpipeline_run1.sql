SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.DEV11aGitLab...';END$$;
CREATE TABLE public."DEV11aGitLab" (
    "Date" date
);
SET check_function_bodies = true;
