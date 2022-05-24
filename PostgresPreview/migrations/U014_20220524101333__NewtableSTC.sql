SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."STCPay"';END$$;
DROP TABLE public."STCPay";
SET check_function_bodies = true;
