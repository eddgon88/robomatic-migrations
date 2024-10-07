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
-- Name: core; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA core;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: action; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.action (
    id bigint NOT NULL,
    user_from integer NOT NULL,
    user_to integer,
    action_id integer NOT NULL,
    date timestamp(6) without time zone DEFAULT now() NOT NULL,
    folder_id integer,
    test_id integer,
    test_execution_id integer
);


--
-- Name: TABLE action; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.action IS 'Almacena las acciones';


--
-- Name: COLUMN action.user_from; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.user_from IS 'Usuario que realiza la acción';


--
-- Name: COLUMN action.user_to; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.user_to IS 'Usuario que recibe la acción';


--
-- Name: COLUMN action.action_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.action_id IS 'id de la acción';


--
-- Name: COLUMN action.date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.date IS 'fecha de la acción';


--
-- Name: COLUMN action.folder_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.folder_id IS 'id de la carpeta';


--
-- Name: COLUMN action.test_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.test_id IS 'id del test';


--
-- Name: COLUMN action.test_execution_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action.test_execution_id IS 'id de la ejecución';


--
-- Name: action_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.action_id_seq OWNED BY core.action.id;


--
-- Name: action_type; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.action_type (
    id bigint NOT NULL,
    name character varying(300) NOT NULL
);


--
-- Name: TABLE action_type; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.action_type IS 'Almacena los tipos de acciones';


--
-- Name: COLUMN action_type.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action_type.id IS 'Clave de registro unico del tipo de acción';


--
-- Name: COLUMN action_type.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.action_type.name IS 'nombre del tipo de acción';


--
-- Name: action_type_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.action_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: action_type_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.action_type_id_seq OWNED BY core.action_type.id;


--
-- Name: case_execution; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.case_execution (
    id bigint NOT NULL,
    case_execution_id character varying(100) NOT NULL,
    test_execution_id character varying(100) NOT NULL,
    case_results_dir character varying(1000) NOT NULL,
    status character varying(50) NOT NULL
);


--
-- Name: TABLE case_execution; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.case_execution IS 'Almacena los casos de las ejecuciones';


--
-- Name: COLUMN case_execution.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.case_execution.id IS 'Clave de registro unico del caso';


--
-- Name: COLUMN case_execution.case_execution_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.case_execution.case_execution_id IS 'Clave de registro unico del caso';


--
-- Name: COLUMN case_execution.test_execution_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.case_execution.test_execution_id IS 'Clave de registro unico de la ejecución';


--
-- Name: COLUMN case_execution.case_results_dir; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.case_execution.case_results_dir IS 'dirección de los resultados del caso';


--
-- Name: COLUMN case_execution.status; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.case_execution.status IS 'estatus del caso';


--
-- Name: case_execution_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.case_execution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.case_execution_id_seq OWNED BY core.case_execution.id;


--
-- Name: folder; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.folder (
    id bigint NOT NULL,
    name character varying(1000) NOT NULL,
    folder_id integer
);


--
-- Name: TABLE folder; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.folder IS 'Almacena los datos de las carpetas';


--
-- Name: COLUMN folder.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.folder.id IS 'Clave de registro unico de la carpeta';


--
-- Name: COLUMN folder.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.folder.name IS 'nombre de la carpeta';


--
-- Name: folder_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.folder_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: folder_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.folder_id_seq OWNED BY core.folder.id;


--
-- Name: role; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.role (
    id bigint NOT NULL,
    name character varying(300) NOT NULL
);


--
-- Name: TABLE role; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.role IS 'Almacena los tipos de roles';


--
-- Name: COLUMN role.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.role.id IS 'Clave de registro unico del tipo de role';


--
-- Name: COLUMN role.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.role.name IS 'nombre del tipo de role';


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.role_id_seq OWNED BY core.role.id;


--
-- Name: test; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.test (
    id bigint NOT NULL,
    test_id character varying(100) NOT NULL,
    name character varying(500) NOT NULL,
    threads integer DEFAULT 1 NOT NULL,
    script text NOT NULL,
    web boolean DEFAULT false NOT NULL,
    folder_id integer NOT NULL,
    description text,
    before_script text,
    after_script text
);


--
-- Name: TABLE test; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.test IS 'Almacena los test con sus configuraciones';


--
-- Name: COLUMN test.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test.id IS 'Clave de registro unico del test';


--
-- Name: COLUMN test.test_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test.test_id IS 'Clave de registro unico del test';


--
-- Name: COLUMN test.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test.name IS 'nombre del test';


--
-- Name: COLUMN test.threads; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test.threads IS 'hilos de ejecución';


--
-- Name: COLUMN test.script; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test.script IS 'script a ejecutar';


--
-- Name: test_case; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.test_case (
    id bigint NOT NULL,
    test_id integer NOT NULL,
    type_id integer NOT NULL,
    file_dir character varying(1000) NOT NULL
);


--
-- Name: TABLE test_case; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.test_case IS 'Almacena los casos de prueba';


--
-- Name: COLUMN test_case.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_case.id IS 'Clave de registro unico del caso de prueba';


--
-- Name: COLUMN test_case.test_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_case.test_id IS 'id del test al que se le asigna el caso de prueba';


--
-- Name: COLUMN test_case.type_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_case.type_id IS 'id del tipo de caso de prueba';


--
-- Name: COLUMN test_case.file_dir; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_case.file_dir IS 'dirección del caso de prueba';


--
-- Name: test_case_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.test_case_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_case_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.test_case_id_seq OWNED BY core.test_case.id;


--
-- Name: test_case_type; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.test_case_type (
    id bigint NOT NULL,
    name character varying(1000) NOT NULL
);


--
-- Name: TABLE test_case_type; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.test_case_type IS 'Almacena los tipos de casos de prueba';


--
-- Name: COLUMN test_case_type.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_case_type.id IS 'Clave de registro unico del tipo de caso de prueba';


--
-- Name: COLUMN test_case_type.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_case_type.name IS 'nombre del tipo de caso de prueba';


--
-- Name: test_case_type_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.test_case_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_case_type_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.test_case_type_id_seq OWNED BY core.test_case_type.id;


--
-- Name: test_execution; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.test_execution (
    id bigint NOT NULL,
    test_execution_id character varying(100) NOT NULL,
    test_id integer NOT NULL,
    test_results_dir character varying(1000) NOT NULL,
    status integer NOT NULL
);


--
-- Name: TABLE test_execution; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.test_execution IS 'Almacena las ejecuciones de los test';


--
-- Name: COLUMN test_execution.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution.id IS 'Clave de registro unico de la ejecución';


--
-- Name: COLUMN test_execution.test_execution_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution.test_execution_id IS 'Clave de registro unico de la ejecución';


--
-- Name: COLUMN test_execution.test_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution.test_id IS 'Clave de registro unico del test ejecutado';


--
-- Name: COLUMN test_execution.test_results_dir; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution.test_results_dir IS 'dirección de los resultados de la ejecución';


--
-- Name: COLUMN test_execution.status; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution.status IS 'estatus de la ejecución';


--
-- Name: test_execution_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.test_execution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.test_execution_id_seq OWNED BY core.test_execution.id;


--
-- Name: test_execution_status; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.test_execution_status (
    id bigint NOT NULL,
    name character varying(300) NOT NULL
);


--
-- Name: TABLE test_execution_status; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.test_execution_status IS 'Almacena los tipos de status de ejecución';


--
-- Name: COLUMN test_execution_status.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution_status.id IS 'Clave de registro unico del tipo de status';


--
-- Name: COLUMN test_execution_status.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.test_execution_status.name IS 'nombre del tipo de status';


--
-- Name: test_execution_status_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.test_execution_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_execution_status_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.test_execution_status_id_seq OWNED BY core.test_execution_status.id;


--
-- Name: test_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.test_id_seq OWNED BY core.test.id;


--
-- Name: token; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.token (
    id bigint NOT NULL,
    token character varying(100) NOT NULL,
    status integer NOT NULL,
    user_id integer NOT NULL,
    creation_date timestamp(6) without time zone DEFAULT now() NOT NULL,
    expiration_date timestamp(6) without time zone DEFAULT now() NOT NULL
);


--
-- Name: TABLE token; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.token IS 'Almacena las acciones';


--
-- Name: COLUMN token.token; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token.token IS 'token de seguridad';


--
-- Name: COLUMN token.status; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token.status IS 'estado del token';


--
-- Name: COLUMN token.user_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token.user_id IS 'id del usuario propietario del token';


--
-- Name: COLUMN token.creation_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token.creation_date IS 'fecha de creación del token';


--
-- Name: COLUMN token.expiration_date; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token.expiration_date IS 'fecha de expiración del token';


--
-- Name: token_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.token_id_seq OWNED BY core.token.id;


--
-- Name: token_status; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core.token_status (
    id bigint NOT NULL,
    name character varying(300) NOT NULL
);


--
-- Name: TABLE token_status; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core.token_status IS 'Almacena los tipos de status de token';


--
-- Name: COLUMN token_status.id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token_status.id IS 'Clave de registro unico del tipo de status';


--
-- Name: COLUMN token_status.name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core.token_status.name IS 'nombre del tipo de status';


--
-- Name: token_status_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.token_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: token_status_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.token_status_id_seq OWNED BY core.token_status.id;


--
-- Name: user; Type: TABLE; Schema: core; Owner: -
--

CREATE TABLE core."user" (
    id bigint NOT NULL,
    full_name character varying(1000) NOT NULL,
    role_id integer NOT NULL,
    phone character varying(100),
    email character varying(1000) NOT NULL,
    pass character varying(16) NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


--
-- Name: TABLE "user"; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON TABLE core."user" IS 'Almacena los datos de los usuarios';


--
-- Name: COLUMN "user".id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core."user".id IS 'Clave de registro unico del usuario';


--
-- Name: COLUMN "user".full_name; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core."user".full_name IS 'nombre del usuario';


--
-- Name: COLUMN "user".role_id; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core."user".role_id IS 'rol del usuario';


--
-- Name: COLUMN "user".phone; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core."user".phone IS 'numero de telefono del usuario';


--
-- Name: COLUMN "user".email; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core."user".email IS 'email del usuario';


--
-- Name: COLUMN "user".pass; Type: COMMENT; Schema: core; Owner: -
--

COMMENT ON COLUMN core."user".pass IS 'contraseña del usuario';


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: core; Owner: -
--

CREATE SEQUENCE core.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: core; Owner: -
--

ALTER SEQUENCE core.user_id_seq OWNED BY core."user".id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: action id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action ALTER COLUMN id SET DEFAULT nextval('core.action_id_seq'::regclass);


--
-- Name: action_type id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action_type ALTER COLUMN id SET DEFAULT nextval('core.action_type_id_seq'::regclass);


--
-- Name: case_execution id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.case_execution ALTER COLUMN id SET DEFAULT nextval('core.case_execution_id_seq'::regclass);


--
-- Name: folder id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.folder ALTER COLUMN id SET DEFAULT nextval('core.folder_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role ALTER COLUMN id SET DEFAULT nextval('core.role_id_seq'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test ALTER COLUMN id SET DEFAULT nextval('core.test_id_seq'::regclass);


--
-- Name: test_case id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case ALTER COLUMN id SET DEFAULT nextval('core.test_case_id_seq'::regclass);


--
-- Name: test_case_type id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case_type ALTER COLUMN id SET DEFAULT nextval('core.test_case_type_id_seq'::regclass);


--
-- Name: test_execution id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution ALTER COLUMN id SET DEFAULT nextval('core.test_execution_id_seq'::regclass);


--
-- Name: test_execution_status id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution_status ALTER COLUMN id SET DEFAULT nextval('core.test_execution_status_id_seq'::regclass);


--
-- Name: token id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.token ALTER COLUMN id SET DEFAULT nextval('core.token_id_seq'::regclass);


--
-- Name: token_status id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.token_status ALTER COLUMN id SET DEFAULT nextval('core.token_status_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."user" ALTER COLUMN id SET DEFAULT nextval('core.user_id_seq'::regclass);


--
-- Name: action action_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT action_pkey PRIMARY KEY (id);


--
-- Name: action_type action_type_name_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action_type
    ADD CONSTRAINT action_type_name_key UNIQUE (name);


--
-- Name: action_type action_type_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action_type
    ADD CONSTRAINT action_type_pkey PRIMARY KEY (id);


--
-- Name: case_execution case_execution_case_execution_id_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.case_execution
    ADD CONSTRAINT case_execution_case_execution_id_key UNIQUE (case_execution_id);


--
-- Name: case_execution case_execution_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.case_execution
    ADD CONSTRAINT case_execution_pkey PRIMARY KEY (id);


--
-- Name: folder folder_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT folder_pkey PRIMARY KEY (id);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: test_case test_case_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case
    ADD CONSTRAINT test_case_pkey PRIMARY KEY (id);


--
-- Name: test_case_type test_case_type_name_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case_type
    ADD CONSTRAINT test_case_type_name_key UNIQUE (name);


--
-- Name: test_case_type test_case_type_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case_type
    ADD CONSTRAINT test_case_type_pkey PRIMARY KEY (id);


--
-- Name: test_execution test_execution_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution
    ADD CONSTRAINT test_execution_pkey PRIMARY KEY (id);


--
-- Name: test_execution_status test_execution_status_name_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution_status
    ADD CONSTRAINT test_execution_status_name_key UNIQUE (name);


--
-- Name: test_execution_status test_execution_status_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution_status
    ADD CONSTRAINT test_execution_status_pkey PRIMARY KEY (id);


--
-- Name: test_execution test_execution_test_execution_id_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution
    ADD CONSTRAINT test_execution_test_execution_id_key UNIQUE (test_execution_id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: test test_test_id_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test
    ADD CONSTRAINT test_test_id_key UNIQUE (test_id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: token_status token_status_name_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.token_status
    ADD CONSTRAINT token_status_name_key UNIQUE (name);


--
-- Name: token_status token_status_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.token_status
    ADD CONSTRAINT token_status_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: action_type_name; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX action_type_name ON core.action_type USING btree (name);


--
-- Name: case_execution_id_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX case_execution_id_idx ON core.case_execution USING btree (case_execution_id);


--
-- Name: email_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX email_idx ON core."user" USING btree (email);


--
-- Name: folder_id; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX folder_id ON core.test USING btree (folder_id);


--
-- Name: folder_id_action; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX folder_id_action ON core.action USING btree (folder_id);


--
-- Name: role_name; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX role_name ON core.role USING btree (name);


--
-- Name: test_case_type_name; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX test_case_type_name ON core.test_case_type USING btree (name);


--
-- Name: test_execution_id; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX test_execution_id ON core.case_execution USING btree (test_execution_id);


--
-- Name: test_execution_id_action; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX test_execution_id_action ON core.action USING btree (test_execution_id);


--
-- Name: test_execution_id_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX test_execution_id_idx ON core.test_execution USING btree (test_execution_id);


--
-- Name: test_execution_status_name; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX test_execution_status_name ON core.test_execution_status USING btree (name);


--
-- Name: test_id; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX test_id ON core.test_execution USING btree (test_id);


--
-- Name: test_id_action; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX test_id_action ON core.action USING btree (test_id);


--
-- Name: test_id_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX test_id_idx ON core.test USING btree (test_id);


--
-- Name: token_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX token_idx ON core.token USING btree (token);


--
-- Name: token_status_name; Type: INDEX; Schema: core; Owner: -
--

CREATE UNIQUE INDEX token_status_name ON core.token_status USING btree (name);


--
-- Name: token_user_idx; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX token_user_idx ON core.token USING btree (user_id);


--
-- Name: user_from_action; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX user_from_action ON core.action USING btree (user_from);


--
-- Name: user_to_action; Type: INDEX; Schema: core; Owner: -
--

CREATE INDEX user_to_action ON core.action USING btree (user_to);


--
-- Name: action fk_action_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT fk_action_id FOREIGN KEY (action_id) REFERENCES core.action_type(id) ON UPDATE CASCADE;


--
-- Name: test fk_folder_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test
    ADD CONSTRAINT fk_folder_id FOREIGN KEY (folder_id) REFERENCES core.folder(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: action fk_folder_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT fk_folder_id FOREIGN KEY (folder_id) REFERENCES core.folder(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: folder fk_folder_idx; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.folder
    ADD CONSTRAINT fk_folder_idx FOREIGN KEY (folder_id) REFERENCES core.folder(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user fk_role_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core."user"
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES core.role(id) ON UPDATE CASCADE;


--
-- Name: case_execution fk_test_execution_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.case_execution
    ADD CONSTRAINT fk_test_execution_id FOREIGN KEY (test_execution_id) REFERENCES core.test_execution(test_execution_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: action fk_test_execution_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT fk_test_execution_id FOREIGN KEY (test_execution_id) REFERENCES core.test_execution(id) ON UPDATE CASCADE;


--
-- Name: test_execution fk_test_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution
    ADD CONSTRAINT fk_test_id FOREIGN KEY (test_id) REFERENCES core.test(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: test_case fk_test_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case
    ADD CONSTRAINT fk_test_id FOREIGN KEY (test_id) REFERENCES core.test(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: action fk_test_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT fk_test_id FOREIGN KEY (test_id) REFERENCES core.test(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: test_execution fk_test_status; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_execution
    ADD CONSTRAINT fk_test_status FOREIGN KEY (status) REFERENCES core.test_execution_status(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: token fk_token_status; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.token
    ADD CONSTRAINT fk_token_status FOREIGN KEY (status) REFERENCES core.token_status(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: test_case fk_type_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.test_case
    ADD CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES core.test_case_type(id) ON UPDATE CASCADE;


--
-- Name: action fk_user_from_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT fk_user_from_id FOREIGN KEY (user_from) REFERENCES core."user"(id) ON UPDATE CASCADE;


--
-- Name: action fk_user_to_id; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY core.action
    ADD CONSTRAINT fk_user_to_id FOREIGN KEY (user_to) REFERENCES core."user"(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20220512015123'),
    ('20220512015130'),
    ('20220512015159'),
    ('20220512015160'),
    ('20220512015165'),
    ('20220512015166'),
    ('20220518002822'),
    ('20220518002823'),
    ('20220519022631'),
    ('20220519034640'),
    ('20220519034921'),
    ('20220519035608'),
    ('20220521015941'),
    ('20220521020418'),
    ('20220521021726'),
    ('20220521022205'),
    ('20220521022934'),
    ('20220521025122'),
    ('20220521025404'),
    ('20220521025737'),
    ('20220521031302'),
    ('20220521031739'),
    ('20220521032309'),
    ('20220521152222'),
    ('20220521153614'),
    ('20220521154640'),
    ('20220709043106'),
    ('20231002175823'),
    ('20231107011504');
