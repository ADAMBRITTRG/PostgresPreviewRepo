SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."DEV11aGitLab"';END$$;
DROP TABLE public."DEV11aGitLab";
SET check_function_bodies = true;
