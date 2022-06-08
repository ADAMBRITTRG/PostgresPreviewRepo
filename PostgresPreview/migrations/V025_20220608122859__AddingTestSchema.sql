SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating Test.TestTableInTestSchema...';END$$;
CREATE TABLE "Test"."TestTableInTestSchema" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating Test...';END$$;
CREATE SCHEMA "Test";
SET check_function_bodies = true;