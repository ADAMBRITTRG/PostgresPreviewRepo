SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "Test"."TestTableInTestSchema"';END$$;
DROP TABLE "Test"."TestTableInTestSchema";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "Test"';END$$;
DROP SCHEMA "Test";
SET check_function_bodies = true;