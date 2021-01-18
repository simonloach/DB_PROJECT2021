--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: refreshstock(); Type: FUNCTION; Schema: public; Owner: g12
--

CREATE FUNCTION public.refreshstock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	BEGIN
		UPDATE product
		SET no_instock = COALESCE(no_instock, 0) - NEW.product_quantity
		WHERE product.pid = NEW.pid;
		return NEW;

		END;
		$$;


ALTER FUNCTION public.refreshstock() OWNER TO g12;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO g12;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO g12;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO g12;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO g12;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO g12;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO g12;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO g12;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO g12;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO g12;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO g12;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO g12;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO g12;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: cart_id; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.cart_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.cart_id OWNER TO g12;

--
-- Name: cart; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.cart (
    cart_id integer DEFAULT nextval('public.cart_id'::regclass) NOT NULL,
    client_id integer,
    pid integer,
    quantity integer NOT NULL
);


ALTER TABLE public.cart OWNER TO g12;

--
-- Name: cid; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.cid
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.cid OWNER TO g12;

--
-- Name: categorie; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.categorie (
    cid integer DEFAULT nextval('public.cid'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    parent_cid integer
);


ALTER TABLE public.categorie OWNER TO g12;

--
-- Name: client_id; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.client_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.client_id OWNER TO g12;

--
-- Name: client; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.client (
    client_id integer DEFAULT nextval('public.client_id'::regclass) NOT NULL,
    login character varying(100) NOT NULL,
    "SHA_pass" character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    surname character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    region character varying(100),
    zip_code character varying(10) NOT NULL,
    street character varying(100) NOT NULL,
    building_no integer NOT NULL,
    apart_no integer,
    phone integer NOT NULL,
    email character varying(100) NOT NULL
);


ALTER TABLE public.client OWNER TO g12;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO g12;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO g12;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO g12;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO g12;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO g12;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO g12;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: g12
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO g12;

--
-- Name: manufacturer_id; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.manufacturer_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.manufacturer_id OWNER TO g12;

--
-- Name: manufacturer; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.manufacturer (
    manufacturer_id integer DEFAULT nextval('public.manufacturer_id'::regclass) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.manufacturer OWNER TO g12;

--
-- Name: manufacturers_categorie_id; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.manufacturers_categorie_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.manufacturers_categorie_id OWNER TO g12;

--
-- Name: manufacturers_categorie; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.manufacturers_categorie (
    manufacturers_categorie_id integer DEFAULT nextval('public.manufacturers_categorie_id'::regclass) NOT NULL,
    manufacturer_id integer,
    cid integer
);


ALTER TABLE public.manufacturers_categorie OWNER TO g12;

--
-- Name: oid; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.oid
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.oid OWNER TO g12;

--
-- Name: order; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public."order" (
    oid integer DEFAULT nextval('public.oid'::regclass) NOT NULL,
    client_id integer NOT NULL,
    order_placed_date timestamp without time zone NOT NULL,
    order_taken_date timestamp without time zone,
    shipping_date timestamp without time zone,
    order_fulfilment_date timestamp without time zone,
    order_taken boolean,
    order_fulfilled boolean
);


ALTER TABLE public."order" OWNER TO g12;

--
-- Name: ordered_product_id; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.ordered_product_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.ordered_product_id OWNER TO g12;

--
-- Name: ordered_product; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.ordered_product (
    ordered_product_id integer DEFAULT nextval('public.ordered_product_id'::regclass) NOT NULL,
    oid integer,
    pid integer,
    product_quantity integer NOT NULL,
    product_price numeric(50,2) NOT NULL
);


ALTER TABLE public.ordered_product OWNER TO g12;

--
-- Name: pid; Type: SEQUENCE; Schema: public; Owner: g12
--

CREATE SEQUENCE public.pid
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.pid OWNER TO g12;

--
-- Name: product; Type: TABLE; Schema: public; Owner: g12
--

CREATE TABLE public.product (
    pid integer DEFAULT nextval('public.pid'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    image_source character varying(100),
    manufacturers_categorie_id integer,
    price_gross numeric(50,2) NOT NULL,
    vat_tax numeric(50,2),
    no_instock integer,
    on_sale boolean DEFAULT false,
    sale_price_gross numeric(50,2)
);


ALTER TABLE public.product OWNER TO g12;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add categorie	1	add_categorie
2	Can change categorie	1	change_categorie
3	Can delete categorie	1	delete_categorie
4	Can view categorie	1	view_categorie
5	Can add client	2	add_client
6	Can change client	2	change_client
7	Can delete client	2	delete_client
8	Can view client	2	view_client
9	Can add manufacturer	3	add_manufacturer
10	Can change manufacturer	3	change_manufacturer
11	Can delete manufacturer	3	delete_manufacturer
12	Can view manufacturer	3	view_manufacturer
13	Can add manufacturers categorie	4	add_manufacturerscategorie
14	Can change manufacturers categorie	4	change_manufacturerscategorie
15	Can delete manufacturers categorie	4	delete_manufacturerscategorie
16	Can view manufacturers categorie	4	view_manufacturerscategorie
17	Can add order	5	add_order
18	Can change order	5	change_order
19	Can delete order	5	delete_order
20	Can view order	5	view_order
21	Can add ordered product	6	add_orderedproduct
22	Can change ordered product	6	change_orderedproduct
23	Can delete ordered product	6	delete_orderedproduct
24	Can view ordered product	6	view_orderedproduct
25	Can add product	7	add_product
26	Can change product	7	change_product
27	Can delete product	7	delete_product
28	Can view product	7	view_product
29	Can add cart	8	add_cart
30	Can change cart	8	change_cart
31	Can delete cart	8	delete_cart
32	Can view cart	8	view_cart
33	Can add log entry	9	add_logentry
34	Can change log entry	9	change_logentry
35	Can delete log entry	9	delete_logentry
36	Can view log entry	9	view_logentry
37	Can add permission	10	add_permission
38	Can change permission	10	change_permission
39	Can delete permission	10	delete_permission
40	Can view permission	10	view_permission
41	Can add group	11	add_group
42	Can change group	11	change_group
43	Can delete group	11	delete_group
44	Can view group	11	view_group
45	Can add user	12	add_user
46	Can change user	12	change_user
47	Can delete user	12	delete_user
48	Can view user	12	view_user
49	Can add content type	13	add_contenttype
50	Can change content type	13	change_contenttype
51	Can delete content type	13	delete_contenttype
52	Can view content type	13	view_contenttype
53	Can add session	14	add_session
54	Can change session	14	change_session
55	Can delete session	14	delete_session
56	Can view session	14	view_session
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$216000$wuFbqSvYPW8R$jwFKPzzzCAEQPJt3yESEKsZGWiVFqF6w1qzeEEyAUQA=	2021-01-15 13:26:33.955632+01	t	g12				t	t	2021-01-15 13:26:27.757854+01
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.cart (cart_id, client_id, pid, quantity) FROM stdin;
\.


--
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.categorie (cid, name, parent_cid) FROM stdin;
3	Kable	1
2	Akcesoria	\N
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.client (client_id, login, "SHA_pass", name, surname, city, region, zip_code, street, building_no, apart_no, phone, email) FROM stdin;
2	client	client	bob	ross	New York	\N	33-395	biczyce dolne	12	\N	999999999	999@tennumertoklopoty.pl
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2021-01-15 13:30:00.95929+01	2	Categorie object (2)	1	[{"added": {}}]	1	1
2	2021-01-15 13:30:09.152464+01	3	Categorie object (3)	1	[{"added": {}}]	1	1
3	2021-01-15 13:30:17.170947+01	2	Categorie object (2)	2	[]	1	1
4	2021-01-15 13:30:27.847037+01	2	Manufacturer object (2)	1	[{"added": {}}]	3	1
5	2021-01-15 13:30:35.049752+01	2	ManufacturersCategorie object (2)	1	[{"added": {}}]	4	1
6	2021-01-15 13:33:06.69717+01	3	Product object (3)	1	[{"added": {}}]	7	1
7	2021-01-15 13:33:45.620922+01	2	Client object (2)	1	[{"added": {}}]	2	1
8	2021-01-15 13:34:39.252607+01	2	Order object (2)	1	[{"added": {}}]	5	1
9	2021-01-15 13:36:35.773414+01	1	OrderedProduct object (1)	1	[{"added": {}}]	6	1
10	2021-01-15 13:36:46.118884+01	1	OrderedProduct object (1)	2	[]	6	1
11	2021-01-15 16:15:45.806327+01	3	Product object (3)	2	[{"changed": {"fields": ["Image source"]}}]	7	1
12	2021-01-18 14:44:12.576207+01	1	OrderedProduct object (1)	3		6	1
13	2021-01-18 14:45:09.72203+01	2	OrderedProduct object (2)	1	[{"added": {}}]	6	1
14	2021-01-18 14:53:48.758953+01	2	OrderedProduct object (2)	3		6	1
15	2021-01-18 14:54:49.842841+01	3	OrderedProduct object (3)	1	[{"added": {}}]	6	1
16	2021-01-18 15:07:30.58442+01	3	OrderedProduct object (3)	3		6	1
17	2021-01-18 15:07:43.825151+01	4	OrderedProduct object (4)	1	[{"added": {}}]	6	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	sklep	categorie
2	sklep	client
3	sklep	manufacturer
4	sklep	manufacturerscategorie
5	sklep	order
6	sklep	orderedproduct
7	sklep	product
8	sklep	cart
9	admin	logentry
10	auth	permission
11	auth	group
12	auth	user
13	contenttypes	contenttype
14	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-01-13 18:51:12.476346+01
2	auth	0001_initial	2021-01-13 18:51:12.578151+01
3	admin	0001_initial	2021-01-13 18:51:12.655583+01
4	admin	0002_logentry_remove_auto_add	2021-01-13 18:51:12.680117+01
5	admin	0003_logentry_add_action_flag_choices	2021-01-13 18:51:12.695557+01
6	contenttypes	0002_remove_content_type_name	2021-01-13 18:51:12.732229+01
7	auth	0002_alter_permission_name_max_length	2021-01-13 18:51:12.748736+01
8	auth	0003_alter_user_email_max_length	2021-01-13 18:51:12.760229+01
9	auth	0004_alter_user_username_opts	2021-01-13 18:51:12.77028+01
10	auth	0005_alter_user_last_login_null	2021-01-13 18:51:12.781239+01
11	auth	0006_require_contenttypes_0002	2021-01-13 18:51:12.784089+01
12	auth	0007_alter_validators_add_error_messages	2021-01-13 18:51:12.796197+01
13	auth	0008_alter_user_username_max_length	2021-01-13 18:51:12.823941+01
14	auth	0009_alter_user_last_name_max_length	2021-01-13 18:51:12.847694+01
15	auth	0010_alter_group_name_max_length	2021-01-13 18:51:12.867667+01
16	auth	0011_update_proxy_permissions	2021-01-13 18:51:12.881554+01
17	auth	0012_alter_user_first_name_max_length	2021-01-13 18:51:12.892862+01
18	sessions	0001_initial	2021-01-13 18:51:12.904081+01
19	sklep	0001_initial	2021-01-13 18:51:12.951964+01
20	sklep	0002_auto_20210109_1344	2021-01-13 18:51:12.964637+01
21	sklep	0003_authgroup_authgrouppermissions_authpermission_authuser_authusergroups_authuseruserpermissions_catego	2021-01-13 18:51:13.002846+01
22	sklep	0004_auto_20210109_1308	2021-01-13 18:51:13.023889+01
23	sklep	0005_authgroup_authgrouppermissions_authpermission_authuser_authusergroups_authuseruserpermissions_catego	2021-01-13 18:51:13.073524+01
24	sklep	0006_cart	2021-01-13 18:51:13.081496+01
25	sklep	0007_auto_20210113_1750	2021-01-13 18:51:13.09636+01
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
vpxn3xyhyp2tljog0967vehjbo637kmt	.eJxVjEEOwiAQRe_C2hAoM4Iu3fcMZGBGqRpISrsy3l2bdKHb_977LxVpXUpcu8xxYnVWVh1-t0T5IXUDfKd6azq3usxT0puid9r12Fiel939OyjUy7cGsByySSdkC8ZBwqM1wxCQPHm8khODkMAH71I2kj0QIxGKBAveZvX-AL7uN1s:1l0OBV:HCYMmZXjlMQlYfVPVfQUfO2rTIeojSIIuq75ebkZX8U	2021-01-29 13:26:33.960484+01
\.


--
-- Data for Name: manufacturer; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.manufacturer (manufacturer_id, name) FROM stdin;
2	Xiaomi
\.


--
-- Data for Name: manufacturers_categorie; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.manufacturers_categorie (manufacturers_categorie_id, manufacturer_id, cid) FROM stdin;
2	2	3
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public."order" (oid, client_id, order_placed_date, order_taken_date, shipping_date, order_fulfilment_date, order_taken, order_fulfilled) FROM stdin;
2	2	2021-01-15 12:34:26	2021-01-15 12:34:30	2021-01-15 12:34:32	2021-01-15 12:34:33	t	t
\.


--
-- Data for Name: ordered_product; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.ordered_product (ordered_product_id, oid, pid, product_quantity, product_price) FROM stdin;
4	2	3	50	5010.00
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: g12
--

COPY public.product (pid, name, description, image_source, manufacturers_categorie_id, price_gross, vat_tax, no_instock, on_sale, sale_price_gross) FROM stdin;
3	Kabel Ethernet	kabel eth desc	kabeleth1.jpg,kabeleth2.jpg	2	100.20	8.00	50	f	\N
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: cart_id; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.cart_id', 1, false);


--
-- Name: cid; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.cid', 3, true);


--
-- Name: client_id; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.client_id', 2, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 17, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: manufacturer_id; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.manufacturer_id', 2, true);


--
-- Name: manufacturers_categorie_id; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.manufacturers_categorie_id', 2, true);


--
-- Name: oid; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.oid', 2, true);


--
-- Name: ordered_product_id; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.ordered_product_id', 4, true);


--
-- Name: pid; Type: SEQUENCE SET; Schema: public; Owner: g12
--

SELECT pg_catalog.setval('public.pid', 3, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: cart cart_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pk PRIMARY KEY (cart_id);


--
-- Name: categorie categories_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categories_pk PRIMARY KEY (cid);


--
-- Name: client clients_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT clients_pk PRIMARY KEY (client_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: manufacturers_categorie manufacturers_categories_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.manufacturers_categorie
    ADD CONSTRAINT manufacturers_categories_pk PRIMARY KEY (manufacturers_categorie_id);


--
-- Name: manufacturer manufacturers_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.manufacturer
    ADD CONSTRAINT manufacturers_pk PRIMARY KEY (manufacturer_id);


--
-- Name: ordered_product ordered_products_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.ordered_product
    ADD CONSTRAINT ordered_products_pk PRIMARY KEY (ordered_product_id);


--
-- Name: order orders_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT orders_pk PRIMARY KEY (oid);


--
-- Name: product products_pk; Type: CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT products_pk PRIMARY KEY (pid);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: g12
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: ordered_product trigger; Type: TRIGGER; Schema: public; Owner: g12
--

CREATE TRIGGER trigger AFTER INSERT ON public.ordered_product FOR EACH ROW EXECUTE FUNCTION public.refreshstock();


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: manufacturers_categorie cid; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.manufacturers_categorie
    ADD CONSTRAINT cid FOREIGN KEY (cid) REFERENCES public.categorie(cid) MATCH FULL;


--
-- Name: cart client_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES public.client(client_id) MATCH FULL;


--
-- Name: order client_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT client_id FOREIGN KEY (client_id) REFERENCES public.client(client_id) MATCH FULL;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product manu_cat; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT manu_cat FOREIGN KEY (manufacturers_categorie_id) REFERENCES public.manufacturers_categorie(manufacturers_categorie_id) MATCH FULL;


--
-- Name: manufacturers_categorie manu_id; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.manufacturers_categorie
    ADD CONSTRAINT manu_id FOREIGN KEY (manufacturer_id) REFERENCES public.manufacturer(manufacturer_id) MATCH FULL;


--
-- Name: ordered_product oid; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.ordered_product
    ADD CONSTRAINT oid FOREIGN KEY (oid) REFERENCES public."order"(oid) MATCH FULL;


--
-- Name: cart pid; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT pid FOREIGN KEY (pid) REFERENCES public.product(pid) MATCH FULL;


--
-- Name: ordered_product pid; Type: FK CONSTRAINT; Schema: public; Owner: g12
--

ALTER TABLE ONLY public.ordered_product
    ADD CONSTRAINT pid FOREIGN KEY (pid) REFERENCES public.product(pid) MATCH FULL;


--
-- PostgreSQL database dump complete
--

