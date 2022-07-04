SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.schwabfunction(int4)...';END$$;
DROP FUNCTION public.schwabfunction(int4);
CREATE FUNCTION public.schwabfunction(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.ASTTable...';END$$;
CREATE TABLE public."ASTTable" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev3...';END$$;
CREATE TABLE public.dev3 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev4...';END$$;
CREATE TABLE public.dev4 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev5...';END$$;
CREATE TABLE public.dev5 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev6...';END$$;
CREATE TABLE public.dev6 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.DEV11aGitLab...';END$$;
CREATE TABLE public."DEV11aGitLab" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.STCPay...';END$$;
CREATE TABLE public."STCPay" (
    "Date" date,
    "Description" text
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV8...';END$$;
CREATE TABLE public."MV8" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV7...';END$$;
CREATE TABLE public."MV7" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev7...';END$$;
CREATE TABLE public.dev7 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.Dev10...';END$$;
CREATE TABLE public."Dev10" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV6...';END$$;
CREATE TABLE public."MV6" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev8...';END$$;
CREATE TABLE public.dev8 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev9...';END$$;
CREATE TABLE public.dev9 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.test3...';END$$;
CREATE TABLE public.test3 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV10...';END$$;
CREATE TABLE public."MV10" (
    "Date" _date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV5...';END$$;
CREATE TABLE public."MV5" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.buildtest...';END$$;
CREATE TABLE public.buildtest (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.buildtest2...';END$$;
CREATE TABLE public.buildtest2 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV4...';END$$;
CREATE TABLE public."MV4" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.usertest2...';END$$;
CREATE TABLE public.usertest2 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.dev2...';END$$;
CREATE TABLE public.dev2 (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.ScwabTable...';END$$;
CREATE TABLE public."ScwabTable" (
    "Date" date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV9...';END$$;
CREATE TABLE public."MV9" (
    
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.MV3...';END$$;
CREATE TABLE public."MV3" (
    
);
SET check_function_bodies = true;
