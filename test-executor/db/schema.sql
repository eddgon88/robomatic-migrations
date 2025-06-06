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
-- Name: test_executor; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA test_executor;


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
-- Name: apscheduler_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.apscheduler_jobs (
    id character varying(191) NOT NULL,
    next_run_time double precision,
    job_state bytea NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: case_evidence; Type: TABLE; Schema: test_executor; Owner: -
--

CREATE TABLE test_executor.case_evidence (
    id bigint NOT NULL,
    evidence_id character varying(100) NOT NULL,
    evidence_text text,
    creation_date timestamp(6) without time zone
);


--
-- Name: TABLE case_evidence; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON TABLE test_executor.case_evidence IS 'Almacena los datos de los registros de evidencias';


--
-- Name: COLUMN case_evidence.id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.case_evidence.id IS 'Clave de registro unico del registro';


--
-- Name: COLUMN case_evidence.evidence_id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.case_evidence.evidence_id IS 'Clave de registro unico del archivo';


--
-- Name: COLUMN case_evidence.evidence_text; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.case_evidence.evidence_text IS 'texto del registro';


--
-- Name: case_evidence_id_seq; Type: SEQUENCE; Schema: test_executor; Owner: -
--

CREATE SEQUENCE test_executor.case_evidence_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: case_evidence_id_seq; Type: SEQUENCE OWNED BY; Schema: test_executor; Owner: -
--

ALTER SEQUENCE test_executor.case_evidence_id_seq OWNED BY test_executor.case_evidence.id;


--
-- Name: evidence_file; Type: TABLE; Schema: test_executor; Owner: -
--

CREATE TABLE test_executor.evidence_file (
    id bigint NOT NULL,
    evidence_id character varying(100) NOT NULL,
    file_name character varying(100) NOT NULL,
    evidence_uri character varying(300) NOT NULL,
    type_id integer NOT NULL,
    test_execution_id character varying(100) NOT NULL,
    case_execution_id character varying(100)
);


--
-- Name: TABLE evidence_file; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON TABLE test_executor.evidence_file IS 'Almacena los datos del archivo de evidencias';


--
-- Name: COLUMN evidence_file.id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_file.id IS 'Clave de registro unico del archivo';


--
-- Name: COLUMN evidence_file.evidence_id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_file.evidence_id IS 'Clave de registro unico del archivo';


--
-- Name: COLUMN evidence_file.file_name; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_file.file_name IS 'nombre del archivo';


--
-- Name: COLUMN evidence_file.evidence_uri; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_file.evidence_uri IS 'directorio del archivo';


--
-- Name: COLUMN evidence_file.test_execution_id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_file.test_execution_id IS 'Clave de registro de la ejecución';


--
-- Name: evidence_file_id_seq; Type: SEQUENCE; Schema: test_executor; Owner: -
--

CREATE SEQUENCE test_executor.evidence_file_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evidence_file_id_seq; Type: SEQUENCE OWNED BY; Schema: test_executor; Owner: -
--

ALTER SEQUENCE test_executor.evidence_file_id_seq OWNED BY test_executor.evidence_file.id;


--
-- Name: evidence_type; Type: TABLE; Schema: test_executor; Owner: -
--

CREATE TABLE test_executor.evidence_type (
    id integer NOT NULL,
    name character varying(50)
);


--
-- Name: COLUMN evidence_type.id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_type.id IS 'Id tipo de evidencia';


--
-- Name: COLUMN evidence_type.name; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.evidence_type.name IS 'Nombre tipo de evidencia';


--
-- Name: evidence_type_id_seq; Type: SEQUENCE; Schema: test_executor; Owner: -
--

CREATE SEQUENCE test_executor.evidence_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: evidence_type_id_seq; Type: SEQUENCE OWNED BY; Schema: test_executor; Owner: -
--

ALTER SEQUENCE test_executor.evidence_type_id_seq OWNED BY test_executor.evidence_type.id;


--
-- Name: stop_execution; Type: TABLE; Schema: test_executor; Owner: -
--

CREATE TABLE test_executor.stop_execution (
    id integer NOT NULL,
    execution_id character varying(50)
);


--
-- Name: COLUMN stop_execution.id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.stop_execution.id IS 'Id de detención';


--
-- Name: COLUMN stop_execution.execution_id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.stop_execution.execution_id IS 'id de ejecución';


--
-- Name: stop_execution_id_seq; Type: SEQUENCE; Schema: test_executor; Owner: -
--

CREATE SEQUENCE test_executor.stop_execution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stop_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: test_executor; Owner: -
--

ALTER SEQUENCE test_executor.stop_execution_id_seq OWNED BY test_executor.stop_execution.id;


--
-- Name: test_port; Type: TABLE; Schema: test_executor; Owner: -
--

CREATE TABLE test_executor.test_port (
    id integer NOT NULL,
    execution_id character varying(50),
    selenium_port character varying(50),
    vnc_port character varying(50)
);


--
-- Name: COLUMN test_port.id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.test_port.id IS 'Id de detención';


--
-- Name: COLUMN test_port.execution_id; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.test_port.execution_id IS 'id de ejecución';


--
-- Name: COLUMN test_port.selenium_port; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.test_port.selenium_port IS 'puerto liberado para el selenium hub';


--
-- Name: COLUMN test_port.vnc_port; Type: COMMENT; Schema: test_executor; Owner: -
--

COMMENT ON COLUMN test_executor.test_port.vnc_port IS 'puerto liberado para el nvc server';


--
-- Name: test_port_id_seq; Type: SEQUENCE; Schema: test_executor; Owner: -
--

CREATE SEQUENCE test_executor.test_port_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_port_id_seq; Type: SEQUENCE OWNED BY; Schema: test_executor; Owner: -
--

ALTER SEQUENCE test_executor.test_port_id_seq OWNED BY test_executor.test_port.id;


--
-- Name: case_evidence id; Type: DEFAULT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.case_evidence ALTER COLUMN id SET DEFAULT nextval('test_executor.case_evidence_id_seq'::regclass);


--
-- Name: evidence_file id; Type: DEFAULT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.evidence_file ALTER COLUMN id SET DEFAULT nextval('test_executor.evidence_file_id_seq'::regclass);


--
-- Name: evidence_type id; Type: DEFAULT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.evidence_type ALTER COLUMN id SET DEFAULT nextval('test_executor.evidence_type_id_seq'::regclass);


--
-- Name: stop_execution id; Type: DEFAULT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.stop_execution ALTER COLUMN id SET DEFAULT nextval('test_executor.stop_execution_id_seq'::regclass);


--
-- Name: test_port id; Type: DEFAULT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.test_port ALTER COLUMN id SET DEFAULT nextval('test_executor.test_port_id_seq'::regclass);


--
-- Name: apscheduler_jobs apscheduler_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.apscheduler_jobs
    ADD CONSTRAINT apscheduler_jobs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: case_evidence case_evidence_pkey; Type: CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.case_evidence
    ADD CONSTRAINT case_evidence_pkey PRIMARY KEY (id);


--
-- Name: evidence_file evidence_file_evidence_id_key; Type: CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.evidence_file
    ADD CONSTRAINT evidence_file_evidence_id_key UNIQUE (evidence_id);


--
-- Name: evidence_file evidence_file_pkey; Type: CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.evidence_file
    ADD CONSTRAINT evidence_file_pkey PRIMARY KEY (id);


--
-- Name: evidence_type evidence_type_pkey; Type: CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.evidence_type
    ADD CONSTRAINT evidence_type_pkey PRIMARY KEY (id);


--
-- Name: stop_execution stop_execution_pkey; Type: CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.stop_execution
    ADD CONSTRAINT stop_execution_pkey PRIMARY KEY (id);


--
-- Name: test_port test_port_pkey; Type: CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.test_port
    ADD CONSTRAINT test_port_pkey PRIMARY KEY (id);


--
-- Name: ix_apscheduler_jobs_next_run_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_apscheduler_jobs_next_run_time ON public.apscheduler_jobs USING btree (next_run_time);


--
-- Name: evidence_id; Type: INDEX; Schema: test_executor; Owner: -
--

CREATE INDEX evidence_id ON test_executor.case_evidence USING btree (evidence_id);


--
-- Name: evidence_id_idx; Type: INDEX; Schema: test_executor; Owner: -
--

CREATE UNIQUE INDEX evidence_id_idx ON test_executor.evidence_file USING btree (evidence_id);


--
-- Name: file_name; Type: INDEX; Schema: test_executor; Owner: -
--

CREATE INDEX file_name ON test_executor.evidence_file USING btree (file_name);


--
-- Name: test_execution_id; Type: INDEX; Schema: test_executor; Owner: -
--

CREATE INDEX test_execution_id ON test_executor.evidence_file USING btree (test_execution_id);


--
-- Name: evidence_file evidence_type_fkey; Type: FK CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.evidence_file
    ADD CONSTRAINT evidence_type_fkey FOREIGN KEY (type_id) REFERENCES test_executor.evidence_type(id) ON UPDATE CASCADE;


--
-- Name: case_evidence fk_evidence_id; Type: FK CONSTRAINT; Schema: test_executor; Owner: -
--

ALTER TABLE ONLY test_executor.case_evidence
    ADD CONSTRAINT fk_evidence_id FOREIGN KEY (evidence_id) REFERENCES test_executor.evidence_file(evidence_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20220217152909'),
    ('20220220004013'),
    ('20220220005347'),
    ('20220220010931'),
    ('20220224155811'),
    ('20220224160116'),
    ('20220224160559'),
    ('20230117215737'),
    ('20240508012208');
