SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."check_password(text, text)"';END$$;
DROP FUNCTION public.check_password(text, text);
SET check_function_bodies = true;
