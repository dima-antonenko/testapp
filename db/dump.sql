--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.11
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: administrators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE administrators (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE administrators OWNER TO postgres;

--
-- Name: administrators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE administrators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE administrators_id_seq OWNER TO postgres;

--
-- Name: administrators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE administrators_id_seq OWNED BY administrators.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: cart_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cart_products (
    id bigint NOT NULL,
    product_id integer,
    cart_id integer,
    order_id integer,
    product_price integer,
    product_qty integer DEFAULT 1,
    product_total_price integer
);


ALTER TABLE cart_products OWNER TO postgres;

--
-- Name: cart_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE cart_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cart_products_id_seq OWNER TO postgres;

--
-- Name: cart_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE cart_products_id_seq OWNED BY cart_products.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE carts (
    id bigint NOT NULL,
    customer_id integer
);


ALTER TABLE carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE carts_id_seq OWNED BY carts.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE customers (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE customers_id_seq OWNED BY customers.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE orders (
    id bigint NOT NULL,
    customer_id integer,
    customer_notice text
);


ALTER TABLE orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE product_categories (
    id bigint NOT NULL,
    name character varying,
    product_category_id integer NOT NULL,
    is_root boolean DEFAULT false
);


ALTER TABLE product_categories OWNER TO postgres;

--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_categories_id_seq OWNER TO postgres;

--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_categories_id_seq OWNED BY product_categories.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products (
    id bigint NOT NULL,
    name character varying,
    price integer,
    product_category_id integer
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: administrators id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrators ALTER COLUMN id SET DEFAULT nextval('administrators_id_seq'::regclass);


--
-- Name: cart_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cart_products ALTER COLUMN id SET DEFAULT nextval('cart_products_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carts ALTER COLUMN id SET DEFAULT nextval('carts_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customers ALTER COLUMN id SET DEFAULT nextval('customers_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_categories ALTER COLUMN id SET DEFAULT nextval('product_categories_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Data for Name: administrators; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO administrators VALUES (1, 'admin@mail.ru', '$2a$11$nkR2e20SgNelEJFWp0i/petlrJqsnCkZDy2pGfQaWbkA8wRJmnFGa', NULL, NULL, '2018-02-21 09:12:49.638643', 3, '2018-02-21 09:12:49.661137', '2018-02-20 09:10:42.79468', '127.0.0.1', '127.0.0.1', '2018-02-20 09:08:14.785386', '2018-02-21 09:12:49.663617');


--
-- Name: administrators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('administrators_id_seq', 1, true);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ar_internal_metadata VALUES ('environment', 'development', '2018-02-20 06:54:33.018827', '2018-02-20 06:54:33.018827');


--
-- Data for Name: cart_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO cart_products VALUES (25, 6, 20, NULL, 110, 2, 220);
INSERT INTO cart_products VALUES (8, 1, NULL, 3, 100, 2, 200);
INSERT INTO cart_products VALUES (9, 2, NULL, 3, 100, 1, 100);
INSERT INTO cart_products VALUES (10, 1, NULL, 4, 100, 2, 200);
INSERT INTO cart_products VALUES (11, 2, NULL, 4, 100, 2, 200);
INSERT INTO cart_products VALUES (12, 1, NULL, 5, 100, 1, 100);
INSERT INTO cart_products VALUES (13, 1, NULL, 6, 100, 2, 200);
INSERT INTO cart_products VALUES (14, 2, NULL, 6, 100, 1, 100);
INSERT INTO cart_products VALUES (15, 1, NULL, 7, 100, 1, 100);
INSERT INTO cart_products VALUES (16, 1, NULL, 8, 100, 2, 200);
INSERT INTO cart_products VALUES (19, 3, NULL, 8, 111, 2, 222);
INSERT INTO cart_products VALUES (18, 4, NULL, 8, 111, 3, 333);
INSERT INTO cart_products VALUES (20, 2, NULL, 8, 100, 2, 200);
INSERT INTO cart_products VALUES (21, 1, NULL, 9, 100, 1, 100);
INSERT INTO cart_products VALUES (22, 2, NULL, 9, 100, 1, 100);
INSERT INTO cart_products VALUES (23, 3, NULL, 9, 111, 1, 111);
INSERT INTO cart_products VALUES (24, 1, NULL, 10, 100, 1, 100);


--
-- Name: cart_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('cart_products_id_seq', 25, true);


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO carts VALUES (20, 1);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('carts_id_seq', 20, true);


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customers VALUES (1, 'customer@mail.ru', '$2a$11$2Ln5SZN9GYPIJgUoGa0RiOEP/ptLVQfL8MRgf9llk5J3cD8X00lKi', NULL, NULL, NULL, 2, '2018-02-20 10:13:29.891437', '2018-02-20 09:11:48.081595', '127.0.0.1', '127.0.0.1', '2018-02-20 09:11:48.062198', '2018-02-20 10:13:29.894134');


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('customers_id_seq', 1, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO orders VALUES (4, 1, 'Текст примечания к заказу');
INSERT INTO orders VALUES (5, 1, 'Тестовый заказ');
INSERT INTO orders VALUES (6, 1, 'Еще один тестовый заказ');
INSERT INTO orders VALUES (7, 1, 'Тестовый заказ 3
');
INSERT INTO orders VALUES (3, 1, 'текст примечания к заказу');
INSERT INTO orders VALUES (8, 1, 'test test');
INSERT INTO orders VALUES (9, 1, 'test_test_test');
INSERT INTO orders VALUES (10, 1, 'test');


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('orders_id_seq', 10, true);


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO product_categories VALUES (1, 'Каталог', 0, true);
INSERT INTO product_categories VALUES (3, 'test', 1, false);
INSERT INTO product_categories VALUES (4, 'test-1', 3, false);
INSERT INTO product_categories VALUES (5, 'test-1-1', 4, false);
INSERT INTO product_categories VALUES (6, 'test2', 1, false);
INSERT INTO product_categories VALUES (7, 'test2-1', 6, false);
INSERT INTO product_categories VALUES (8, 'test2-1-1', 7, false);


--
-- Name: product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('product_categories_id_seq', 8, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO products VALUES (1, 'тестовый товар №0', 100, 1);
INSERT INTO products VALUES (2, 'тестовый товар №1', 100, 1);
INSERT INTO products VALUES (3, 'тестовый товар №2', 111, 1);
INSERT INTO products VALUES (4, 'тестовый товар №3', 111, 1);
INSERT INTO products VALUES (5, 'тестовый товар №4', 111, 1);
INSERT INTO products VALUES (6, 'Тестовый товар №5', 110, 8);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 6, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO schema_migrations VALUES ('20180220065116');
INSERT INTO schema_migrations VALUES ('20180220085706');
INSERT INTO schema_migrations VALUES ('20180220090640');
INSERT INTO schema_migrations VALUES ('20180220100304');
INSERT INTO schema_migrations VALUES ('20180220100452');
INSERT INTO schema_migrations VALUES ('20180221071832');
INSERT INTO schema_migrations VALUES ('20180221090635');


--
-- Name: administrators administrators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY administrators
    ADD CONSTRAINT administrators_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cart_products cart_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cart_products
    ADD CONSTRAINT cart_products_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_administrators_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_administrators_on_email ON administrators USING btree (email);


--
-- Name: index_administrators_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_administrators_on_reset_password_token ON administrators USING btree (reset_password_token);


--
-- Name: index_cart_products_on_cart_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_products_on_cart_id ON cart_products USING btree (cart_id);


--
-- Name: index_cart_products_on_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_products_on_order_id ON cart_products USING btree (order_id);


--
-- Name: index_cart_products_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_products_on_product_id ON cart_products USING btree (product_id);


--
-- Name: index_cart_products_on_product_price; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_products_on_product_price ON cart_products USING btree (product_price);


--
-- Name: index_cart_products_on_product_qty; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_products_on_product_qty ON cart_products USING btree (product_qty);


--
-- Name: index_cart_products_on_product_total_price; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_products_on_product_total_price ON cart_products USING btree (product_total_price);


--
-- Name: index_carts_on_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_carts_on_customer_id ON carts USING btree (customer_id);


--
-- Name: index_customers_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_customers_on_email ON customers USING btree (email);


--
-- Name: index_customers_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_customers_on_reset_password_token ON customers USING btree (reset_password_token);


--
-- Name: index_orders_on_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_orders_on_customer_id ON orders USING btree (customer_id);


--
-- Name: index_orders_on_customer_notice; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_orders_on_customer_notice ON orders USING btree (customer_notice);


--
-- Name: index_product_categories_on_is_root; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_product_categories_on_is_root ON product_categories USING btree (is_root);


--
-- Name: index_product_categories_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_product_categories_on_name ON product_categories USING btree (name);


--
-- Name: index_product_categories_on_product_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_product_categories_on_product_category_id ON product_categories USING btree (product_category_id);


--
-- Name: index_products_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_products_on_name ON products USING btree (name);


--
-- Name: index_products_on_price; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_products_on_price ON products USING btree (price);


--
-- Name: index_products_on_product_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_products_on_product_category_id ON products USING btree (product_category_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

