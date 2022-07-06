SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."ASTTable"';END$$;
DROP TABLE public."ASTTable";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev3"';END$$;
DROP TABLE public.dev3;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev4"';END$$;
DROP TABLE public.dev4;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev5"';END$$;
DROP TABLE public.dev5;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev6"';END$$;
DROP TABLE public.dev6;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."DEV11aGitLab"';END$$;
DROP TABLE public."DEV11aGitLab";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."STCPay"';END$$;
DROP TABLE public."STCPay";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV8"';END$$;
DROP TABLE public."MV8";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV7"';END$$;
DROP TABLE public."MV7";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev7"';END$$;
DROP TABLE public.dev7;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."Dev10"';END$$;
DROP TABLE public."Dev10";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV6"';END$$;
DROP TABLE public."MV6";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev8"';END$$;
DROP TABLE public.dev8;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev9"';END$$;
DROP TABLE public.dev9;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."test3"';END$$;
DROP TABLE public.test3;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV10"';END$$;
DROP TABLE public."MV10";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV5"';END$$;
DROP TABLE public."MV5";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."buildtest"';END$$;
DROP TABLE public.buildtest;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."buildtest2"';END$$;
DROP TABLE public.buildtest2;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV4"';END$$;
DROP TABLE public."MV4";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."usertest2"';END$$;
DROP TABLE public.usertest2;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."dev2"';END$$;
DROP TABLE public.dev2;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."ScwabTable"';END$$;
DROP TABLE public."ScwabTable";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV9"';END$$;
DROP TABLE public."MV9";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."MV3"';END$$;
DROP TABLE public."MV3";


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
SET check_function_bodies = true;
