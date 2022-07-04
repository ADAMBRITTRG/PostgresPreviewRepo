SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating "public"."MorePower1"...';END$$;
CREATE TABLE public."MorePower1" (
    "Description" text
);
SET check_function_bodies = true;
