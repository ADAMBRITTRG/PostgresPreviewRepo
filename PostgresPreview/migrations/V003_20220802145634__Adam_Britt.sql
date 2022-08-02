SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.New_Table...';END$$;
CREATE TABLE public."New_Table" (
    "Date Column" date,
    "Description" text,
    "New Column" bit
);
SET check_function_bodies = true;
