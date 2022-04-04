SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev9"';END$$;
DROP TABLE public.dev9;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "dev1" on "public"."language"...';END$$;
ALTER TABLE public.language DROP COLUMN dev1;
SET check_function_bodies = true;
