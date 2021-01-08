-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3-beta1
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: online_shop | type: DATABASE --
-- DROP DATABASE IF EXISTS online_shop;
CREATE DATABASE online_shop;
-- ddl-end --


-- object: public.client | type: TABLE --
-- DROP TABLE IF EXISTS public.client CASCADE;
CREATE TABLE public.client (
	client_id int4 NOT NULL,
	login varchar NOT NULL,
	"SHA_pass" varchar NOT NULL,
	name varchar NOT NULL,
	surname varchar NOT NULL,
	city varchar NOT NULL,
	region varchar,
	zip_code varchar NOT NULL,
	street varchar NOT NULL,
	building_no int4 NOT NULL,
	apart_no int4,
	phone int4 NOT NULL,
	email varchar NOT NULL,
	CONSTRAINT clients_pk PRIMARY KEY (client_id)

);
-- ddl-end --
ALTER TABLE public.client OWNER TO postgres;
-- ddl-end --

-- object: public."order" | type: TABLE --
-- DROP TABLE IF EXISTS public."order" CASCADE;
CREATE TABLE public."order" (
	oid int4 NOT NULL,
	client_id int4 NOT NULL,
	order_placed_date timestamp NOT NULL,
	order_taken_date timestamp,
	shipping_date timestamp,
	order_fulfilment_date timestamp,
	order_taken boolean,
	order_fulfilled boolean,
	CONSTRAINT orders_pk PRIMARY KEY (oid)

);
-- ddl-end --
ALTER TABLE public."order" OWNER TO postgres;
-- ddl-end --

-- object: public.manufacturer | type: TABLE --
-- DROP TABLE IF EXISTS public.manufacturer CASCADE;
CREATE TABLE public.manufacturer (
	manufacturer_id int4 NOT NULL,
	name varchar NOT NULL,
	CONSTRAINT manufacturers_pk PRIMARY KEY (manufacturer_id)

);
-- ddl-end --
ALTER TABLE public.manufacturer OWNER TO postgres;
-- ddl-end --

-- object: public.categorie | type: TABLE --
-- DROP TABLE IF EXISTS public.categorie CASCADE;
CREATE TABLE public.categorie (
	cid int4 NOT NULL,
	name varchar NOT NULL,
	parent_cid int4,
	CONSTRAINT categories_pk PRIMARY KEY (cid)

);
-- ddl-end --
ALTER TABLE public.categorie OWNER TO postgres;
-- ddl-end --

-- object: public.manufacturers_categorie | type: TABLE --
-- DROP TABLE IF EXISTS public.manufacturers_categorie CASCADE;
CREATE TABLE public.manufacturers_categorie (
	manufacturers_categories int4 NOT NULL,
	manufacturer_id int4,
	cid int4,
	CONSTRAINT manufacturers_categories_pk PRIMARY KEY (manufacturers_categories)

);
-- ddl-end --
ALTER TABLE public.manufacturers_categorie OWNER TO postgres;
-- ddl-end --

-- object: public.product | type: TABLE --
-- DROP TABLE IF EXISTS public.product CASCADE;
CREATE TABLE public.product (
	pid int4 NOT NULL,
	name varchar NOT NULL,
	description text,
	image_source varchar,
	manufacturers_categories int4,
	price_gross decimal NOT NULL,
	vat_tax decimal,
	no_instock int4,
	CONSTRAINT products_pk PRIMARY KEY (pid)

);
-- ddl-end --
ALTER TABLE public.product OWNER TO postgres;
-- ddl-end --

-- object: public.ordered_product | type: TABLE --
-- DROP TABLE IF EXISTS public.ordered_product CASCADE;
CREATE TABLE public.ordered_product (
	ordered_product_id int4 NOT NULL,
	oid int4,
	pid int4,
	product_quantity int4 NOT NULL,
	product_price decimal NOT NULL,
	CONSTRAINT ordered_products_pk PRIMARY KEY (ordered_product_id)

);
-- ddl-end --
ALTER TABLE public.ordered_product OWNER TO postgres;
-- ddl-end --

-- object: client_id | type: CONSTRAINT --
-- ALTER TABLE public."order" DROP CONSTRAINT IF EXISTS client_id CASCADE;
ALTER TABLE public."order" ADD CONSTRAINT client_id FOREIGN KEY (client_id)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: manu_id | type: CONSTRAINT --
-- ALTER TABLE public.manufacturers_categorie DROP CONSTRAINT IF EXISTS manu_id CASCADE;
ALTER TABLE public.manufacturers_categorie ADD CONSTRAINT manu_id FOREIGN KEY (manufacturer_id)
REFERENCES public.manufacturer (manufacturer_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: cid | type: CONSTRAINT --
-- ALTER TABLE public.manufacturers_categorie DROP CONSTRAINT IF EXISTS cid CASCADE;
ALTER TABLE public.manufacturers_categorie ADD CONSTRAINT cid FOREIGN KEY (cid)
REFERENCES public.categorie (cid) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: manu_cat | type: CONSTRAINT --
-- ALTER TABLE public.product DROP CONSTRAINT IF EXISTS manu_cat CASCADE;
ALTER TABLE public.product ADD CONSTRAINT manu_cat FOREIGN KEY (manufacturers_categories)
REFERENCES public.manufacturers_categorie (manufacturers_categories) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: oid | type: CONSTRAINT --
-- ALTER TABLE public.ordered_product DROP CONSTRAINT IF EXISTS oid CASCADE;
ALTER TABLE public.ordered_product ADD CONSTRAINT oid FOREIGN KEY (oid)
REFERENCES public."order" (oid) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pid | type: CONSTRAINT --
-- ALTER TABLE public.ordered_product DROP CONSTRAINT IF EXISTS pid CASCADE;
ALTER TABLE public.ordered_product ADD CONSTRAINT pid FOREIGN KEY (pid)
REFERENCES public.product (pid) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


