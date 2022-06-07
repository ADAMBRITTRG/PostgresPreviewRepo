SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.staff_list...';END$$;
CREATE VIEW public.staff_list (id, name, address, "zip code", phone, city, country, sid) AS SELECT s.staff_id AS id,
    ((s.first_name || ' '::text) || s.last_name) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
   FROM (((public.staff s
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));;


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


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_06_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_06_customer_id_idx ON public.payment_p2020_06 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_05_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_05_customer_id_idx ON public.payment_p2020_05 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_04_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_04_customer_id_idx ON public.payment_p2020_04 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_03_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_03_customer_id_idx ON public.payment_p2020_03 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_02_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_02_customer_id_idx ON public.payment_p2020_02 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment_p2020_01_customer_id_idx...';END$$;
CREATE INDEX payment_p2020_01_customer_id_idx ON public.payment_p2020_01 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.payment...';END$$;
CREATE TABLE public.payment (
    payment_id int4,
    customer_id int4,
    staff_id int4,
    rental_id int4,
    amount numeric,
    payment_date timestamptz
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.sales_by_store...';END$$;
CREATE VIEW public.sales_by_store (store, manager, total_sales) AS SELECT ((c.city || ','::text) || cy.country) AS store,
    ((m.first_name || ' '::text) || m.last_name) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.store s ON ((i.store_id = s.store_id)))
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city c ON ((a.city_id = c.city_id)))
     JOIN public.country cy ON ((c.country_id = cy.country_id)))
     JOIN public.staff m ON ((s.manager_staff_id = m.staff_id)))
  GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country, c.city;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.sales_by_film_category...';END$$;
CREATE VIEW public.sales_by_film_category (category, total_sales) AS SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.film f ON ((i.film_id = f.film_id)))
     JOIN public.film_category fc ON ((f.film_id = fc.film_id)))
     JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_unq_rental_rental_date_inventory_id_customer_id...';END$$;
CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON public.rental USING btree (rental_date, inventory_id, customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_unq_manager_staff_id...';END$$;
CREATE UNIQUE INDEX idx_unq_manager_staff_id ON public.store USING btree (manager_staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_title...';END$$;
CREATE INDEX idx_title ON public.film USING btree (title);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_store_id_film_id...';END$$;
CREATE INDEX idx_store_id_film_id ON public.inventory USING btree (store_id, film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_last_name...';END$$;
CREATE INDEX idx_last_name ON public.customer USING btree (last_name);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_store_id...';END$$;
CREATE INDEX idx_fk_store_id ON public.customer USING btree (store_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_06_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_06_staff_id ON public.payment_p2020_06 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_06_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_06_customer_id ON public.payment_p2020_06 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_05_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_05_staff_id ON public.payment_p2020_05 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_05_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_05_customer_id ON public.payment_p2020_05 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_04_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_04_staff_id ON public.payment_p2020_04 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_04_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_04_customer_id ON public.payment_p2020_04 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_03_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_03_staff_id ON public.payment_p2020_03 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_03_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_03_customer_id ON public.payment_p2020_03 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_02_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_02_staff_id ON public.payment_p2020_02 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_02_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_02_customer_id ON public.payment_p2020_02 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_01_staff_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_01_staff_id ON public.payment_p2020_01 USING btree (staff_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_payment_p2020_01_customer_id...';END$$;
CREATE INDEX idx_fk_payment_p2020_01_customer_id ON public.payment_p2020_01 USING btree (customer_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_original_language_id...';END$$;
CREATE INDEX idx_fk_original_language_id ON public.film USING btree (original_language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_language_id...';END$$;
CREATE INDEX idx_fk_language_id ON public.film USING btree (language_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_inventory_id...';END$$;
CREATE INDEX idx_fk_inventory_id ON public.rental USING btree (inventory_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_film_id...';END$$;
CREATE INDEX idx_fk_film_id ON public.film_actor USING btree (film_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_country_id...';END$$;
CREATE INDEX idx_fk_country_id ON public.city USING btree (country_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_city_id...';END$$;
CREATE INDEX idx_fk_city_id ON public.address USING btree (city_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_fk_address_id...';END$$;
CREATE INDEX idx_fk_address_id ON public.customer USING btree (address_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.idx_actor_last_name...';END$$;
CREATE INDEX idx_actor_last_name ON public.actor USING btree (last_name);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.group_concat(text)...';END$$;
CREATE AGGREGATE public.group_concat(text) (
    SFUNC = public._group_concat,
    STYPE = text
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.nicer_but_slower_film_list...';END$$;
CREATE VIEW public.nicer_but_slower_film_list (fid, title, description, category, price, length, rating, actors) AS SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat((((upper("substring"(actor.first_name, 1, 1)) || lower("substring"(actor.first_name, 2))) || upper("substring"(actor.last_name, 1, 1))) || lower("substring"(actor.last_name, 2)))) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_list...';END$$;
CREATE VIEW public.film_list (fid, title, description, category, price, length, rating, actors) AS SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat(((actor.first_name || ' '::text) || actor.last_name)) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.film_fulltext_idx...';END$$;
CREATE INDEX film_fulltext_idx ON public.film USING gist (fulltext);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.customer_list...';END$$;
CREATE VIEW public.customer_list (id, name, address, "zip code", phone, city, country, notes, sid) AS SELECT cu.customer_id AS id,
    ((cu.first_name || ' '::text) || cu.last_name) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((public.customer cu
     JOIN public.address a ON ((cu.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.actor_info...';END$$;
CREATE VIEW public.actor_info (actor_id, first_name, last_name, film_info) AS SELECT a.actor_id,
    a.first_name,
    a.last_name,
    public.group_concat(DISTINCT ((c.name || ': '::text) || ( SELECT public.group_concat(f.title) AS group_concat
           FROM ((public.film f
             JOIN public.film_category fc_1 ON ((f.film_id = fc_1.film_id)))
             JOIN public.film_actor fa_1 ON ((f.film_id = fa_1.film_id)))
          WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
          GROUP BY fa_1.actor_id))) AS film_info
   FROM (((public.actor a
     LEFT JOIN public.film_actor fa ON ((a.actor_id = fa.actor_id)))
     LEFT JOIN public.film_category fc ON ((fa.film_id = fc.film_id)))
     LEFT JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY a.actor_id, a.first_name, a.last_name;;
SET check_function_bodies = true;