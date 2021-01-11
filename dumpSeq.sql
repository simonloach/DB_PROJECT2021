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
	client_id int4 NOT NULL DEFAULT nextval('public.client_id'::regclass),
	login varchar(100) NOT NULL,
	"SHA_pass" varchar(100) NOT NULL,
	name varchar(100) NOT NULL,
	surname varchar(100) NOT NULL,
	city varchar(100) NOT NULL,
	region varchar(100),
	zip_code varchar(10) NOT NULL,
	street varchar(100) NOT NULL,
	building_no int4 NOT NULL,
	apart_no int4,
	phone int4 NOT NULL,
	email varchar(100) NOT NULL,
	CONSTRAINT clients_pk PRIMARY KEY (client_id)

);
-- ddl-end --
ALTER TABLE public.client OWNER TO postgres;
-- ddl-end --

-- object: public."order" | type: TABLE --
-- DROP TABLE IF EXISTS public."order" CASCADE;
CREATE TABLE public."order" (
	oid int4 NOT NULL DEFAULT nextval('public.oid'::regclass),
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
	manufacturer_id int4 NOT NULL DEFAULT nextval('public.manufacturer_id'::regclass),
	name varchar(100) NOT NULL,
	CONSTRAINT manufacturers_pk PRIMARY KEY (manufacturer_id)

);
-- ddl-end --
ALTER TABLE public.manufacturer OWNER TO postgres;
-- ddl-end --

-- object: public.categorie | type: TABLE --
-- DROP TABLE IF EXISTS public.categorie CASCADE;
CREATE TABLE public.categorie (
	cid int4 NOT NULL DEFAULT nextval('public.cid'::regclass),
	name varchar(100) NOT NULL,
	parent_cid int4,
	CONSTRAINT categories_pk PRIMARY KEY (cid)

);
-- ddl-end --
ALTER TABLE public.categorie OWNER TO postgres;
-- ddl-end --

-- object: public.manufacturers_categorie | type: TABLE --
-- DROP TABLE IF EXISTS public.manufacturers_categorie CASCADE;
CREATE TABLE public.manufacturers_categorie (
	manufacturers_categorie_id int4 NOT NULL DEFAULT nextval('public.manufacturers_categorie_id'::regclass),
	manufacturer_id int4,
	cid int4,
	CONSTRAINT manufacturers_categories_pk PRIMARY KEY (manufacturers_categorie_id)

);
-- ddl-end --
ALTER TABLE public.manufacturers_categorie OWNER TO postgres;
-- ddl-end --

-- object: public.product | type: TABLE --
-- DROP TABLE IF EXISTS public.product CASCADE;
CREATE TABLE public.product (
	pid int4 NOT NULL DEFAULT nextval('public.pid'::regclass),
	name varchar(100) NOT NULL,
	description text,
	image_source varchar(100),
	manufacturers_categorie_id int4,
	price_gross decimal(2,2) NOT NULL,
	vat_tax decimal(2,2),
	no_instock int4,
	on_sale boolean DEFAULT false,
	sale_price_gross decimal(2,2),
	CONSTRAINT products_pk PRIMARY KEY (pid)

);
-- ddl-end --
ALTER TABLE public.product OWNER TO postgres;
-- ddl-end --

-- object: public.ordered_product | type: TABLE --
-- DROP TABLE IF EXISTS public.ordered_product CASCADE;
CREATE TABLE public.ordered_product (
	ordered_product_id int4 NOT NULL DEFAULT nextval('public.ordered_product_id'::regclass),
	oid int4,
	pid int4,
	product_quantity int4 NOT NULL,
	product_price decimal(2,2) NOT NULL,
	CONSTRAINT ordered_products_pk PRIMARY KEY (ordered_product_id)

);
-- ddl-end --
ALTER TABLE public.ordered_product OWNER TO postgres;
-- ddl-end --

-- object: public.cart | type: TABLE --
-- DROP TABLE IF EXISTS public.cart CASCADE;
CREATE TABLE public.cart (
	cart_id int4 NOT NULL DEFAULT nextval('public.cart_id'::regclass),
	client_id int4,
	pid int4,
	quantity int4 NOT NULL,
	CONSTRAINT cart_pk PRIMARY KEY (cart_id)

);
-- ddl-end --
ALTER TABLE public.cart OWNER TO postgres;
-- ddl-end --

-- object: public.manufacturer_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.manufacturer_id CASCADE;
CREATE SEQUENCE public.manufacturer_id
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.manufacturer_id OWNER TO postgres;
-- ddl-end --

-- object: public.cid | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.cid CASCADE;
CREATE SEQUENCE public.cid
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.cid OWNER TO postgres;
-- ddl-end --

-- object: public.pid | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.pid CASCADE;
CREATE SEQUENCE public.pid
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.pid OWNER TO postgres;
-- ddl-end --

-- object: public.client_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.client_id CASCADE;
CREATE SEQUENCE public.client_id
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.client_id OWNER TO postgres;
-- ddl-end --

-- object: public.cart_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.cart_id CASCADE;
CREATE SEQUENCE public.cart_id
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.cart_id OWNER TO postgres;
-- ddl-end --

-- object: public.oid | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.oid CASCADE;
CREATE SEQUENCE public.oid
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.oid OWNER TO postgres;
-- ddl-end --

-- object: public.ordered_product_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ordered_product_id CASCADE;
CREATE SEQUENCE public.ordered_product_id
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.ordered_product_id OWNER TO postgres;
-- ddl-end --

-- object: public.manufacturers_categorie_id | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.manufacturers_categorie_id CASCADE;
CREATE SEQUENCE public.manufacturers_categorie_id
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;

-- ddl-end --
ALTER SEQUENCE public.manufacturers_categorie_id OWNER TO postgres;
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
ALTER TABLE public.product ADD CONSTRAINT manu_cat FOREIGN KEY (manufacturers_categorie_id)
REFERENCES public.manufacturers_categorie (manufacturers_categorie_id) MATCH FULL
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

-- object: client_id | type: CONSTRAINT --
-- ALTER TABLE public.cart DROP CONSTRAINT IF EXISTS client_id CASCADE;
ALTER TABLE public.cart ADD CONSTRAINT client_id FOREIGN KEY (client_id)
REFERENCES public.client (client_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: pid | type: CONSTRAINT --
-- ALTER TABLE public.cart DROP CONSTRAINT IF EXISTS pid CASCADE;
ALTER TABLE public.cart ADD CONSTRAINT pid FOREIGN KEY (pid)
REFERENCES public.product (pid) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


