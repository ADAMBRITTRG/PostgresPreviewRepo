SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."subscriptions_id_seq"';END$$;
DROP SEQUENCE public.subscriptions_id_seq;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."subscriptions"';END$$;
DROP TABLE public.subscriptions;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "public"."movies"';END$$;
DROP TABLE public.movies;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "phone" on "public"."customer"...';END$$;
ALTER TABLE public.customer DROP COLUMN phone;
SET check_function_bodies = true;
