SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "Test"."TestTableInTestSchema"';END$$;
DROP TABLE "Test"."TestTableInTestSchema";


DO language plpgsql $$BEGIN RAISE NOTICE 'Dropping "Test"';END$$;
DROP SCHEMA "Test";


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering id...';END$$;
ALTER TABLE public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.store ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.store ALTER COLUMN address_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering manager_staff_id...';END$$;
ALTER TABLE public.store ALTER COLUMN manager_staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.store ALTER COLUMN store_id SET DEFAULT nextval('public.store_store_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.staff ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering username...';END$$;
ALTER TABLE public.staff ALTER COLUMN username SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering active...';END$$;
ALTER TABLE public.staff ALTER COLUMN active SET NOT NULL, ALTER COLUMN active SET DEFAULT true;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.staff ALTER COLUMN store_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.staff ALTER COLUMN address_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_name...';END$$;
ALTER TABLE public.staff ALTER COLUMN last_name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering first_name...';END$$;
ALTER TABLE public.staff ALTER COLUMN first_name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.staff ALTER COLUMN staff_id SET DEFAULT nextval('public.staff_staff_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.rental ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering inventory_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN inventory_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_date...';END$$;
ALTER TABLE public.rental ALTER COLUMN rental_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.rental ALTER COLUMN rental_id SET DEFAULT nextval('public.rental_rental_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_06 ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_05 ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_04 ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_03 ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_02 ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment_p2020_01 ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_date...';END$$;
ALTER TABLE public.payment ALTER COLUMN payment_date SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering amount...';END$$;
ALTER TABLE public.payment ALTER COLUMN amount SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN rental_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering staff_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN staff_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN customer_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering payment_id...';END$$;
ALTER TABLE public.payment ALTER COLUMN payment_id SET NOT NULL, ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.language ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering name...';END$$;
ALTER TABLE public.language ALTER COLUMN name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering language_id...';END$$;
ALTER TABLE public.language ALTER COLUMN language_id SET DEFAULT nextval('public.language_language_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.inventory ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.inventory ALTER COLUMN store_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering film_id...';END$$;
ALTER TABLE public.inventory ALTER COLUMN film_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering inventory_id...';END$$;
ALTER TABLE public.inventory ALTER COLUMN inventory_id SET DEFAULT nextval('public.inventory_inventory_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.film_category ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.film_actor ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering fulltext...';END$$;
ALTER TABLE public.film ALTER COLUMN fulltext SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.film ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rating...';END$$;
ALTER TABLE public.film ALTER COLUMN rating SET DEFAULT 'G'::public.mpaa_rating;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering replacement_cost...';END$$;
ALTER TABLE public.film ALTER COLUMN replacement_cost SET NOT NULL, ALTER COLUMN replacement_cost SET DEFAULT 19.99;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_rate...';END$$;
ALTER TABLE public.film ALTER COLUMN rental_rate SET NOT NULL, ALTER COLUMN rental_rate SET DEFAULT 4.99;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering rental_duration...';END$$;
ALTER TABLE public.film ALTER COLUMN rental_duration SET NOT NULL, ALTER COLUMN rental_duration SET DEFAULT 3;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering language_id...';END$$;
ALTER TABLE public.film ALTER COLUMN language_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering title...';END$$;
ALTER TABLE public.film ALTER COLUMN title SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering film_id...';END$$;
ALTER TABLE public.film ALTER COLUMN film_id SET DEFAULT nextval('public.film_film_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.customer ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering create_date...';END$$;
ALTER TABLE public.customer ALTER COLUMN create_date SET NOT NULL, ALTER COLUMN create_date SET DEFAULT CURRENT_DATE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering activebool...';END$$;
ALTER TABLE public.customer ALTER COLUMN activebool SET NOT NULL, ALTER COLUMN activebool SET DEFAULT true;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.customer ALTER COLUMN address_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_name...';END$$;
ALTER TABLE public.customer ALTER COLUMN last_name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering first_name...';END$$;
ALTER TABLE public.customer ALTER COLUMN first_name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering store_id...';END$$;
ALTER TABLE public.customer ALTER COLUMN store_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering customer_id...';END$$;
ALTER TABLE public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.country ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering country...';END$$;
ALTER TABLE public.country ALTER COLUMN country SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering country_id...';END$$;
ALTER TABLE public.country ALTER COLUMN country_id SET DEFAULT nextval('public.country_country_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.city ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering country_id...';END$$;
ALTER TABLE public.city ALTER COLUMN country_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering city...';END$$;
ALTER TABLE public.city ALTER COLUMN city SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering city_id...';END$$;
ALTER TABLE public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.category ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering name...';END$$;
ALTER TABLE public.category ALTER COLUMN name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering category_id...';END$$;
ALTER TABLE public.category ALTER COLUMN category_id SET DEFAULT nextval('public.category_category_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.address ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering phone...';END$$;
ALTER TABLE public.address ALTER COLUMN phone SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering city_id...';END$$;
ALTER TABLE public.address ALTER COLUMN city_id SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering district...';END$$;
ALTER TABLE public.address ALTER COLUMN district SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address...';END$$;
ALTER TABLE public.address ALTER COLUMN address SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering address_id...';END$$;
ALTER TABLE public.address ALTER COLUMN address_id SET DEFAULT nextval('public.address_address_id_seq'::regclass);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_update...';END$$;
ALTER TABLE public.actor ALTER COLUMN last_update SET NOT NULL, ALTER COLUMN last_update SET DEFAULT now();


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering last_name...';END$$;
ALTER TABLE public.actor ALTER COLUMN last_name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering first_name...';END$$;
ALTER TABLE public.actor ALTER COLUMN first_name SET NOT NULL;


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering actor_id...';END$$;
ALTER TABLE public.actor ALTER COLUMN actor_id SET DEFAULT nextval('public.actor_actor_id_seq'::regclass);
SET check_function_bodies = true;
