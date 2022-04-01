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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating phone on "public"."customer"...';END$$;
ALTER TABLE public.customer ADD COLUMN phone varchar;
SET check_function_bodies = true;
