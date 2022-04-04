SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.check_password(text, text)...';END$$;
CREATE FUNCTION public.check_password(IN uname text, IN pass text)
RETURNS bool
LANGUAGE plpgsql
AS $_$
DECLARE passed BOOLEAN;
BEGIN
        SELECT  (pwd = $2) INTO passed
        FROM    pwds
        WHERE   username = $1;

        RETURN passed;
END;
$_$;
SET check_function_bodies = true;
