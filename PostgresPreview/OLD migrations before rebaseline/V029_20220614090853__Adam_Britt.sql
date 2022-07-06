SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating "public"."MorePower"...';END$$;
CREATE TABLE public."MorePower" (
    "Test" date,
    "Description" text
);
SET check_function_bodies = true;
