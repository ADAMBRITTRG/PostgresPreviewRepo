SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.STCPay...';END$$;
CREATE TABLE public."STCPay" (
    "Date" date,
    "Description" text
);
SET check_function_bodies = true;
