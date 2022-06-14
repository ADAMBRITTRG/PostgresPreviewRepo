SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating "public"."TempTable1"...';END$$;
CREATE TABLE public."TempTable1" (
    "CreatedDate" date,
    "Description" text
);
SET check_function_bodies = true;
