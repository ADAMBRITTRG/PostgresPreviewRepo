SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.subscriptions...';END$$;
CREATE TABLE public.subscriptions (
    id int4,
    subscription_name varchar
);
ALTER TABLE public.subscriptions ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.subscriptions_id_seq...';END$$;
CREATE SEQUENCE public.subscriptions_id_seq
AS int4
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE
OWNED BY public.subscriptions.id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.movies...';END$$;
CREATE TABLE public.movies (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.increment(int4)...';END$$;
CREATE FUNCTION public.increment(IN i int4)
RETURNS int4
LANGUAGE plpgsql
AS $_$
        BEGIN
                RETURN i + 1;
        END;
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.films...';END$$;
CREATE TABLE public.films (
    title varchar,
    year date
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating fax on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN fax varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating website on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN website varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating phone on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN phone varchar;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.add(int4, int4)...';END$$;
CREATE FUNCTION public.add(IN  int4, IN  int4)
RETURNS int4
LANGUAGE sql
AS $_$select $1 + $2;$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.adamtest...';END$$;
CREATE TABLE public.adamtest (
    title varchar,
    year date
);
SET check_function_bodies = true;
