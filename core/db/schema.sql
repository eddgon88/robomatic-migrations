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


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


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
-- Name: annotation_tag_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.annotation_tag_entity (
    id character varying(16) NOT NULL,
    name character varying(24) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: auth_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_identity (
    "userId" uuid,
    "providerId" character varying(64) NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: auth_provider_sync_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_provider_sync_history (
    id integer NOT NULL,
    "providerType" character varying(32) NOT NULL,
    "runMode" text NOT NULL,
    status text NOT NULL,
    "startedAt" timestamp(3) with time zone DEFAULT now() NOT NULL,
    "endedAt" timestamp(3) with time zone DEFAULT now() NOT NULL,
    scanned integer NOT NULL,
    created integer NOT NULL,
    updated integer NOT NULL,
    disabled integer NOT NULL,
    error text
);


--
-- Name: auth_provider_sync_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.auth_provider_sync_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auth_provider_sync_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.auth_provider_sync_history_id_seq OWNED BY public.auth_provider_sync_history.id;


--
-- Name: credentials_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credentials_entity (
    name character varying(128) NOT NULL,
    data text NOT NULL,
    type character varying(128) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    id character varying(36) NOT NULL,
    "isManaged" boolean DEFAULT false NOT NULL
);


--
-- Name: event_destinations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_destinations (
    id uuid NOT NULL,
    destination jsonb NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: execution_annotation_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.execution_annotation_tags (
    "annotationId" integer NOT NULL,
    "tagId" character varying(24) NOT NULL
);


--
-- Name: execution_annotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.execution_annotations (
    id integer NOT NULL,
    "executionId" integer NOT NULL,
    vote character varying(6),
    note text,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: execution_annotations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.execution_annotations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: execution_annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.execution_annotations_id_seq OWNED BY public.execution_annotations.id;


--
-- Name: execution_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.execution_data (
    "executionId" integer NOT NULL,
    "workflowData" json NOT NULL,
    data text NOT NULL
);


--
-- Name: execution_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.execution_entity (
    id integer NOT NULL,
    finished boolean NOT NULL,
    mode character varying NOT NULL,
    "retryOf" character varying,
    "retrySuccessId" character varying,
    "startedAt" timestamp(3) with time zone,
    "stoppedAt" timestamp(3) with time zone,
    "waitTill" timestamp(3) with time zone,
    status character varying NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "deletedAt" timestamp(3) with time zone,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: execution_entity_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.execution_entity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: execution_entity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.execution_entity_id_seq OWNED BY public.execution_entity.id;


--
-- Name: execution_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.execution_metadata (
    id integer NOT NULL,
    "executionId" integer NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


--
-- Name: execution_metadata_temp_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.execution_metadata_temp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: execution_metadata_temp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.execution_metadata_temp_id_seq OWNED BY public.execution_metadata.id;


--
-- Name: folder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.folder (
    id character varying(36) NOT NULL,
    name character varying(128) NOT NULL,
    "parentFolderId" character varying(36),
    "projectId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: folder_tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.folder_tag (
    "folderId" character varying(36) NOT NULL,
    "tagId" character varying(36) NOT NULL
);


--
-- Name: installed_nodes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.installed_nodes (
    name character varying(200) NOT NULL,
    type character varying(200) NOT NULL,
    "latestVersion" integer DEFAULT 1 NOT NULL,
    package character varying(241) NOT NULL
);


--
-- Name: installed_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.installed_packages (
    "packageName" character varying(214) NOT NULL,
    "installedVersion" character varying(50) NOT NULL,
    "authorName" character varying(70),
    "authorEmail" character varying(70),
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: invalid_auth_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invalid_auth_token (
    token character varying(512) NOT NULL,
    "expiresAt" timestamp(3) with time zone NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: processed_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.processed_data (
    "workflowId" character varying(36) NOT NULL,
    context character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    value text NOT NULL
);


--
-- Name: project; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    icon json
);


--
-- Name: project_relation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_relation (
    "projectId" character varying(36) NOT NULL,
    "userId" uuid NOT NULL,
    role character varying NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    scope character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    "loadOnStartup" boolean DEFAULT false NOT NULL
);


--
-- Name: shared_credentials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shared_credentials (
    "credentialsId" character varying(36) NOT NULL,
    "projectId" character varying(36) NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: shared_workflow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shared_workflow (
    "workflowId" character varying(36) NOT NULL,
    "projectId" character varying(36) NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: tag_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tag_entity (
    name character varying(24) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    id character varying(36) NOT NULL
);


--
-- Name: test_case_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_case_execution (
    id character varying(36) NOT NULL,
    "testRunId" character varying(36) NOT NULL,
    "pastExecutionId" integer,
    "executionId" integer,
    "evaluationExecutionId" integer,
    status character varying NOT NULL,
    "runAt" timestamp(3) with time zone,
    "completedAt" timestamp(3) with time zone,
    "errorCode" character varying,
    "errorDetails" json,
    metrics json,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: test_definition; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_definition (
    name character varying(255) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    "evaluationWorkflowId" character varying(36),
    "annotationTagId" character varying(16),
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    description text,
    id character varying(36) NOT NULL,
    "mockedNodes" json DEFAULT '[]'::json NOT NULL
);


--
-- Name: test_metric; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_metric (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    "testDefinitionId" character varying(36) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: test_run; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_run (
    id character varying(36) NOT NULL,
    "testDefinitionId" character varying(36) NOT NULL,
    status character varying NOT NULL,
    "runAt" timestamp(3) with time zone,
    "completedAt" timestamp(3) with time zone,
    metrics json,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "totalCases" integer,
    "passedCases" integer,
    "failedCases" integer,
    "errorCode" character varying(255),
    "errorDetails" text,
    CONSTRAINT test_run_check CHECK (
CASE
    WHEN ((status)::text = 'new'::text) THEN ("totalCases" IS NULL)
    WHEN ((status)::text = ANY ((ARRAY['cancelled'::character varying, 'error'::character varying])::text[])) THEN (("totalCases" IS NULL) OR ("totalCases" >= 0))
    ELSE ("totalCases" >= 0)
END),
    CONSTRAINT test_run_check1 CHECK (
CASE
    WHEN ((status)::text = 'new'::text) THEN ("passedCases" IS NULL)
    WHEN ((status)::text = ANY ((ARRAY['cancelled'::character varying, 'error'::character varying])::text[])) THEN (("passedCases" IS NULL) OR ("passedCases" >= 0))
    ELSE ("passedCases" >= 0)
END),
    CONSTRAINT test_run_check2 CHECK (
CASE
    WHEN ((status)::text = 'new'::text) THEN ("failedCases" IS NULL)
    WHEN ((status)::text = ANY ((ARRAY['cancelled'::character varying, 'error'::character varying])::text[])) THEN (("failedCases" IS NULL) OR ("failedCases" >= 0))
    ELSE ("failedCases" >= 0)
END)
);


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id uuid DEFAULT uuid_in(("overlay"("overlay"(md5((((random())::text || ':'::text) || (clock_timestamp())::text)), '4'::text, 13), to_hex((floor(((random() * (((11 - 8) + 1))::double precision) + (8)::double precision)))::integer), 17))::cstring) NOT NULL,
    email character varying(255),
    "firstName" character varying(32),
    "lastName" character varying(32),
    password character varying(255),
    "personalizationAnswers" json,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    settings json,
    disabled boolean DEFAULT false NOT NULL,
    "mfaEnabled" boolean DEFAULT false NOT NULL,
    "mfaSecret" text,
    "mfaRecoveryCodes" text,
    role text NOT NULL
);


--
-- Name: user_api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_api_keys (
    id character varying(36) NOT NULL,
    "userId" uuid NOT NULL,
    label character varying(100) NOT NULL,
    "apiKey" character varying NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL
);


--
-- Name: variables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variables (
    key character varying(50) NOT NULL,
    type character varying(50) DEFAULT 'string'::character varying NOT NULL,
    value character varying(255),
    id character varying(36) NOT NULL
);


--
-- Name: webhook_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.webhook_entity (
    "webhookPath" character varying NOT NULL,
    method character varying NOT NULL,
    node character varying NOT NULL,
    "webhookId" character varying,
    "pathLength" integer,
    "workflowId" character varying(36) NOT NULL
);


--
-- Name: workflow_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_entity (
    name character varying(128) NOT NULL,
    active boolean NOT NULL,
    nodes json NOT NULL,
    connections json NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    settings json,
    "staticData" json,
    "pinData" json,
    "versionId" character(36),
    "triggerCount" integer DEFAULT 0 NOT NULL,
    id character varying(36) NOT NULL,
    meta json,
    "parentFolderId" character varying(36) DEFAULT NULL::character varying
);


--
-- Name: workflow_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_history (
    "versionId" character varying(36) NOT NULL,
    "workflowId" character varying(36) NOT NULL,
    authors character varying(255) NOT NULL,
    "createdAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    "updatedAt" timestamp(3) with time zone DEFAULT ('now'::text)::timestamp(3) with time zone NOT NULL,
    nodes json NOT NULL,
    connections json NOT NULL
);


--
-- Name: workflow_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflow_statistics (
    count integer DEFAULT 0,
    "latestEvent" timestamp(3) with time zone,
    name character varying(128) NOT NULL,
    "workflowId" character varying(36) NOT NULL
);


--
-- Name: workflows_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workflows_tags (
    "workflowId" character varying(36) NOT NULL,
    "tagId" character varying(36) NOT NULL
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
-- Name: auth_provider_sync_history id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_provider_sync_history ALTER COLUMN id SET DEFAULT nextval('public.auth_provider_sync_history_id_seq'::regclass);


--
-- Name: execution_annotations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_annotations ALTER COLUMN id SET DEFAULT nextval('public.execution_annotations_id_seq'::regclass);


--
-- Name: execution_entity id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_entity ALTER COLUMN id SET DEFAULT nextval('public.execution_entity_id_seq'::regclass);


--
-- Name: execution_metadata id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_metadata ALTER COLUMN id SET DEFAULT nextval('public.execution_metadata_temp_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


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
-- Name: test_run PK_011c050f566e9db509a0fadb9b9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_run
    ADD CONSTRAINT "PK_011c050f566e9db509a0fadb9b9" PRIMARY KEY (id);


--
-- Name: installed_packages PK_08cc9197c39b028c1e9beca225940576fd1a5804; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.installed_packages
    ADD CONSTRAINT "PK_08cc9197c39b028c1e9beca225940576fd1a5804" PRIMARY KEY ("packageName");


--
-- Name: execution_metadata PK_17a0b6284f8d626aae88e1c16e4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_metadata
    ADD CONSTRAINT "PK_17a0b6284f8d626aae88e1c16e4" PRIMARY KEY (id);


--
-- Name: project_relation PK_1caaa312a5d7184a003be0f0cb6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_relation
    ADD CONSTRAINT "PK_1caaa312a5d7184a003be0f0cb6" PRIMARY KEY ("projectId", "userId");


--
-- Name: folder_tag PK_27e4e00852f6b06a925a4d83a3e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folder_tag
    ADD CONSTRAINT "PK_27e4e00852f6b06a925a4d83a3e" PRIMARY KEY ("folderId", "tagId");


--
-- Name: test_metric PK_3e98b8e20acc19c5030a8644142; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_metric
    ADD CONSTRAINT "PK_3e98b8e20acc19c5030a8644142" PRIMARY KEY (id);


--
-- Name: project PK_4d68b1358bb5b766d3e78f32f57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT "PK_4d68b1358bb5b766d3e78f32f57" PRIMARY KEY (id);


--
-- Name: invalid_auth_token PK_5779069b7235b256d91f7af1a15; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invalid_auth_token
    ADD CONSTRAINT "PK_5779069b7235b256d91f7af1a15" PRIMARY KEY (token);


--
-- Name: shared_workflow PK_5ba87620386b847201c9531c58f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT "PK_5ba87620386b847201c9531c58f" PRIMARY KEY ("workflowId", "projectId");


--
-- Name: folder PK_6278a41a706740c94c02e288df8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folder
    ADD CONSTRAINT "PK_6278a41a706740c94c02e288df8" PRIMARY KEY (id);


--
-- Name: annotation_tag_entity PK_69dfa041592c30bbc0d4b84aa00; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.annotation_tag_entity
    ADD CONSTRAINT "PK_69dfa041592c30bbc0d4b84aa00" PRIMARY KEY (id);


--
-- Name: execution_annotations PK_7afcf93ffa20c4252869a7c6a23; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_annotations
    ADD CONSTRAINT "PK_7afcf93ffa20c4252869a7c6a23" PRIMARY KEY (id);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: installed_nodes PK_8ebd28194e4f792f96b5933423fc439df97d9689; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.installed_nodes
    ADD CONSTRAINT "PK_8ebd28194e4f792f96b5933423fc439df97d9689" PRIMARY KEY (name);


--
-- Name: shared_credentials PK_8ef3a59796a228913f251779cff; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT "PK_8ef3a59796a228913f251779cff" PRIMARY KEY ("credentialsId", "projectId");


--
-- Name: test_case_execution PK_90c121f77a78a6580e94b794bce; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_case_execution
    ADD CONSTRAINT "PK_90c121f77a78a6580e94b794bce" PRIMARY KEY (id);


--
-- Name: user_api_keys PK_978fa5caa3468f463dac9d92e69; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_keys
    ADD CONSTRAINT "PK_978fa5caa3468f463dac9d92e69" PRIMARY KEY (id);


--
-- Name: execution_annotation_tags PK_979ec03d31294cca484be65d11f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_annotation_tags
    ADD CONSTRAINT "PK_979ec03d31294cca484be65d11f" PRIMARY KEY ("annotationId", "tagId");


--
-- Name: webhook_entity PK_b21ace2e13596ccd87dc9bf4ea6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_entity
    ADD CONSTRAINT "PK_b21ace2e13596ccd87dc9bf4ea6" PRIMARY KEY ("webhookPath", method);


--
-- Name: workflow_history PK_b6572dd6173e4cd06fe79937b58; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_history
    ADD CONSTRAINT "PK_b6572dd6173e4cd06fe79937b58" PRIMARY KEY ("versionId");


--
-- Name: processed_data PK_ca04b9d8dc72de268fe07a65773; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.processed_data
    ADD CONSTRAINT "PK_ca04b9d8dc72de268fe07a65773" PRIMARY KEY ("workflowId", context);


--
-- Name: settings PK_dc0fe14e6d9943f268e7b119f69ab8bd; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT "PK_dc0fe14e6d9943f268e7b119f69ab8bd" PRIMARY KEY (key);


--
-- Name: role PK_e853ce24e8200abe5721d2c6ac552b73; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT "PK_e853ce24e8200abe5721d2c6ac552b73" PRIMARY KEY (id);


--
-- Name: user PK_ea8f538c94b6e352418254ed6474a81f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "PK_ea8f538c94b6e352418254ed6474a81f" PRIMARY KEY (id);


--
-- Name: role UQ_5b49d0f504f7ef31045a1fb2eb8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT "UQ_5b49d0f504f7ef31045a1fb2eb8" UNIQUE (scope, name);


--
-- Name: user UQ_e12875dfb3b1d92d7d7c5377e2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT "UQ_e12875dfb3b1d92d7d7c5377e2" UNIQUE (email);


--
-- Name: auth_identity auth_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_identity
    ADD CONSTRAINT auth_identity_pkey PRIMARY KEY ("providerId", "providerType");


--
-- Name: auth_provider_sync_history auth_provider_sync_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_provider_sync_history
    ADD CONSTRAINT auth_provider_sync_history_pkey PRIMARY KEY (id);


--
-- Name: credentials_entity credentials_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credentials_entity
    ADD CONSTRAINT credentials_entity_pkey PRIMARY KEY (id);


--
-- Name: event_destinations event_destinations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_destinations
    ADD CONSTRAINT event_destinations_pkey PRIMARY KEY (id);


--
-- Name: execution_data execution_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_data
    ADD CONSTRAINT execution_data_pkey PRIMARY KEY ("executionId");


--
-- Name: execution_entity pk_e3e63bbf986767844bbe1166d4e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_entity
    ADD CONSTRAINT pk_e3e63bbf986767844bbe1166d4e PRIMARY KEY (id);


--
-- Name: workflow_statistics pk_workflow_statistics; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_statistics
    ADD CONSTRAINT pk_workflow_statistics PRIMARY KEY ("workflowId", name);


--
-- Name: workflows_tags pk_workflows_tags; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows_tags
    ADD CONSTRAINT pk_workflows_tags PRIMARY KEY ("workflowId", "tagId");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tag_entity tag_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag_entity
    ADD CONSTRAINT tag_entity_pkey PRIMARY KEY (id);


--
-- Name: test_definition test_definition_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_definition
    ADD CONSTRAINT test_definition_pkey PRIMARY KEY (id);


--
-- Name: variables variables_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variables
    ADD CONSTRAINT variables_key_key UNIQUE (key);


--
-- Name: variables variables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variables
    ADD CONSTRAINT variables_pkey PRIMARY KEY (id);


--
-- Name: workflow_entity workflow_entity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_entity
    ADD CONSTRAINT workflow_entity_pkey PRIMARY KEY (id);


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
-- Name: IDX_14f68deffaf858465715995508; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_14f68deffaf858465715995508" ON public.folder USING btree ("projectId", id);


--
-- Name: IDX_1e31657f5fe46816c34be7c1b4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_1e31657f5fe46816c34be7c1b4" ON public.workflow_history USING btree ("workflowId");


--
-- Name: IDX_1ef35bac35d20bdae979d917a3; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_1ef35bac35d20bdae979d917a3" ON public.user_api_keys USING btree ("apiKey");


--
-- Name: IDX_3a4e9cf37111ac3270e2469b47; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_3a4e9cf37111ac3270e2469b47" ON public.test_metric USING btree ("testDefinitionId");


--
-- Name: IDX_3a81713a76f2295b12b46cdfca; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_3a81713a76f2295b12b46cdfca" ON public.test_run USING btree ("testDefinitionId");


--
-- Name: IDX_5f0643f6717905a05164090dde; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_5f0643f6717905a05164090dde" ON public.project_relation USING btree ("userId");


--
-- Name: IDX_61448d56d61802b5dfde5cdb00; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_61448d56d61802b5dfde5cdb00" ON public.project_relation USING btree ("projectId");


--
-- Name: IDX_63d7bbae72c767cf162d459fcc; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_63d7bbae72c767cf162d459fcc" ON public.user_api_keys USING btree ("userId", label);


--
-- Name: IDX_8e4b4774db42f1e6dda3452b2a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_8e4b4774db42f1e6dda3452b2a" ON public.test_case_execution USING btree ("testRunId");


--
-- Name: IDX_97f863fa83c4786f1956508496; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_97f863fa83c4786f1956508496" ON public.execution_annotations USING btree ("executionId");


--
-- Name: IDX_9ec1ce6fbf82305f489adb971d; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_9ec1ce6fbf82305f489adb971d" ON public.test_definition USING btree ("evaluationWorkflowId");


--
-- Name: IDX_a3697779b366e131b2bbdae297; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_a3697779b366e131b2bbdae297" ON public.execution_annotation_tags USING btree ("tagId");


--
-- Name: IDX_ae51b54c4bb430cf92f48b623f; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_ae51b54c4bb430cf92f48b623f" ON public.annotation_tag_entity USING btree (name);


--
-- Name: IDX_b0dd0087fe3da02b0ffa4b9c5b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_b0dd0087fe3da02b0ffa4b9c5b" ON public.test_definition USING btree ("workflowId");


--
-- Name: IDX_c1519757391996eb06064f0e7c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_c1519757391996eb06064f0e7c" ON public.execution_annotation_tags USING btree ("annotationId");


--
-- Name: IDX_cec8eea3bf49551482ccb4933e; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IDX_cec8eea3bf49551482ccb4933e" ON public.execution_metadata USING btree ("executionId", key);


--
-- Name: IDX_execution_entity_deletedAt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_execution_entity_deletedAt" ON public.execution_entity USING btree ("deletedAt");


--
-- Name: IDX_workflow_entity_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IDX_workflow_entity_name" ON public.workflow_entity USING btree (name);


--
-- Name: idx_07fde106c0b471d8cc80a64fc8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_07fde106c0b471d8cc80a64fc8 ON public.credentials_entity USING btree (type);


--
-- Name: idx_16f4436789e804e3e1c9eeb240; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_16f4436789e804e3e1c9eeb240 ON public.webhook_entity USING btree ("webhookId", method, "pathLength");


--
-- Name: idx_812eb05f7451ca757fb98444ce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_812eb05f7451ca757fb98444ce ON public.tag_entity USING btree (name);


--
-- Name: idx_execution_entity_stopped_at_status_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_execution_entity_stopped_at_status_deleted_at ON public.execution_entity USING btree ("stoppedAt", status, "deletedAt") WHERE (("stoppedAt" IS NOT NULL) AND ("deletedAt" IS NULL));


--
-- Name: idx_execution_entity_wait_till_status_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_execution_entity_wait_till_status_deleted_at ON public.execution_entity USING btree ("waitTill", status, "deletedAt") WHERE (("waitTill" IS NOT NULL) AND ("deletedAt" IS NULL));


--
-- Name: idx_execution_entity_workflow_id_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_execution_entity_workflow_id_started_at ON public.execution_entity USING btree ("workflowId", "startedAt") WHERE (("startedAt" IS NOT NULL) AND ("deletedAt" IS NULL));


--
-- Name: idx_workflows_tags_workflow_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workflows_tags_workflow_id ON public.workflows_tags USING btree ("workflowId");


--
-- Name: pk_credentials_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pk_credentials_entity_id ON public.credentials_entity USING btree (id);


--
-- Name: pk_tag_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pk_tag_entity_id ON public.tag_entity USING btree (id);


--
-- Name: pk_test_definition_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pk_test_definition_id ON public.test_definition USING btree (id);


--
-- Name: pk_variables_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pk_variables_id ON public.variables USING btree (id);


--
-- Name: pk_workflow_entity_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX pk_workflow_entity_id ON public.workflow_entity USING btree (id);


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
-- Name: processed_data FK_06a69a7032c97a763c2c7599464; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.processed_data
    ADD CONSTRAINT "FK_06a69a7032c97a763c2c7599464" FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: workflow_history FK_1e31657f5fe46816c34be7c1b4b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_history
    ADD CONSTRAINT "FK_1e31657f5fe46816c34be7c1b4b" FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: test_case_execution FK_258d954733841d51edd826a562b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_case_execution
    ADD CONSTRAINT "FK_258d954733841d51edd826a562b" FOREIGN KEY ("pastExecutionId") REFERENCES public.execution_entity(id) ON DELETE SET NULL;


--
-- Name: execution_metadata FK_31d0b4c93fb85ced26f6005cda3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_metadata
    ADD CONSTRAINT "FK_31d0b4c93fb85ced26f6005cda3" FOREIGN KEY ("executionId") REFERENCES public.execution_entity(id) ON DELETE CASCADE;


--
-- Name: test_metric FK_3a4e9cf37111ac3270e2469b475; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_metric
    ADD CONSTRAINT "FK_3a4e9cf37111ac3270e2469b475" FOREIGN KEY ("testDefinitionId") REFERENCES public.test_definition(id) ON DELETE CASCADE;


--
-- Name: test_run FK_3a81713a76f2295b12b46cdfcab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_run
    ADD CONSTRAINT "FK_3a81713a76f2295b12b46cdfcab" FOREIGN KEY ("testDefinitionId") REFERENCES public.test_definition(id) ON DELETE CASCADE;


--
-- Name: shared_credentials FK_416f66fc846c7c442970c094ccf; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT "FK_416f66fc846c7c442970c094ccf" FOREIGN KEY ("credentialsId") REFERENCES public.credentials_entity(id) ON DELETE CASCADE;


--
-- Name: project_relation FK_5f0643f6717905a05164090dde7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_relation
    ADD CONSTRAINT "FK_5f0643f6717905a05164090dde7" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: project_relation FK_61448d56d61802b5dfde5cdb002; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_relation
    ADD CONSTRAINT "FK_61448d56d61802b5dfde5cdb002" FOREIGN KEY ("projectId") REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: installed_nodes FK_73f857fc5dce682cef8a99c11dbddbc969618951; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.installed_nodes
    ADD CONSTRAINT "FK_73f857fc5dce682cef8a99c11dbddbc969618951" FOREIGN KEY (package) REFERENCES public.installed_packages("packageName") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: folder FK_804ea52f6729e3940498bd54d78; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folder
    ADD CONSTRAINT "FK_804ea52f6729e3940498bd54d78" FOREIGN KEY ("parentFolderId") REFERENCES public.folder(id) ON DELETE CASCADE;


--
-- Name: shared_credentials FK_812c2852270da1247756e77f5a4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_credentials
    ADD CONSTRAINT "FK_812c2852270da1247756e77f5a4" FOREIGN KEY ("projectId") REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: test_case_execution FK_8e4b4774db42f1e6dda3452b2af; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_case_execution
    ADD CONSTRAINT "FK_8e4b4774db42f1e6dda3452b2af" FOREIGN KEY ("testRunId") REFERENCES public.test_run(id) ON DELETE CASCADE;


--
-- Name: folder_tag FK_94a60854e06f2897b2e0d39edba; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folder_tag
    ADD CONSTRAINT "FK_94a60854e06f2897b2e0d39edba" FOREIGN KEY ("folderId") REFERENCES public.folder(id) ON DELETE CASCADE;


--
-- Name: execution_annotations FK_97f863fa83c4786f19565084960; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_annotations
    ADD CONSTRAINT "FK_97f863fa83c4786f19565084960" FOREIGN KEY ("executionId") REFERENCES public.execution_entity(id) ON DELETE CASCADE;


--
-- Name: test_definition FK_9ec1ce6fbf82305f489adb971d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_definition
    ADD CONSTRAINT "FK_9ec1ce6fbf82305f489adb971d3" FOREIGN KEY ("evaluationWorkflowId") REFERENCES public.workflow_entity(id) ON DELETE SET NULL;


--
-- Name: execution_annotation_tags FK_a3697779b366e131b2bbdae2976; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_annotation_tags
    ADD CONSTRAINT "FK_a3697779b366e131b2bbdae2976" FOREIGN KEY ("tagId") REFERENCES public.annotation_tag_entity(id) ON DELETE CASCADE;


--
-- Name: shared_workflow FK_a45ea5f27bcfdc21af9b4188560; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT "FK_a45ea5f27bcfdc21af9b4188560" FOREIGN KEY ("projectId") REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: folder FK_a8260b0b36939c6247f385b8221; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folder
    ADD CONSTRAINT "FK_a8260b0b36939c6247f385b8221" FOREIGN KEY ("projectId") REFERENCES public.project(id) ON DELETE CASCADE;


--
-- Name: test_definition FK_b0dd0087fe3da02b0ffa4b9c5bb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_definition
    ADD CONSTRAINT "FK_b0dd0087fe3da02b0ffa4b9c5bb" FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: execution_annotation_tags FK_c1519757391996eb06064f0e7c8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_annotation_tags
    ADD CONSTRAINT "FK_c1519757391996eb06064f0e7c8" FOREIGN KEY ("annotationId") REFERENCES public.execution_annotations(id) ON DELETE CASCADE;


--
-- Name: test_definition FK_d5d7ea64662dbc62f5e266fbeb0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_definition
    ADD CONSTRAINT "FK_d5d7ea64662dbc62f5e266fbeb0" FOREIGN KEY ("annotationTagId") REFERENCES public.annotation_tag_entity(id) ON DELETE SET NULL;


--
-- Name: shared_workflow FK_daa206a04983d47d0a9c34649ce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shared_workflow
    ADD CONSTRAINT "FK_daa206a04983d47d0a9c34649ce" FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: folder_tag FK_dc88164176283de80af47621746; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.folder_tag
    ADD CONSTRAINT "FK_dc88164176283de80af47621746" FOREIGN KEY ("tagId") REFERENCES public.tag_entity(id) ON DELETE CASCADE;


--
-- Name: test_case_execution FK_dfbe194e3ebdfe49a87bc4692ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_case_execution
    ADD CONSTRAINT "FK_dfbe194e3ebdfe49a87bc4692ca" FOREIGN KEY ("evaluationExecutionId") REFERENCES public.execution_entity(id) ON DELETE SET NULL;


--
-- Name: user_api_keys FK_e131705cbbc8fb589889b02d457; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_keys
    ADD CONSTRAINT "FK_e131705cbbc8fb589889b02d457" FOREIGN KEY ("userId") REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: test_case_execution FK_e48965fac35d0f5b9e7f51d8c44; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_case_execution
    ADD CONSTRAINT "FK_e48965fac35d0f5b9e7f51d8c44" FOREIGN KEY ("executionId") REFERENCES public.execution_entity(id) ON DELETE SET NULL;


--
-- Name: auth_identity auth_identity_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_identity
    ADD CONSTRAINT "auth_identity_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."user"(id);


--
-- Name: execution_data execution_data_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_data
    ADD CONSTRAINT execution_data_fk FOREIGN KEY ("executionId") REFERENCES public.execution_entity(id) ON DELETE CASCADE;


--
-- Name: execution_entity fk_execution_entity_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_entity
    ADD CONSTRAINT fk_execution_entity_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: webhook_entity fk_webhook_entity_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.webhook_entity
    ADD CONSTRAINT fk_webhook_entity_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: workflow_statistics fk_workflow_statistics_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_statistics
    ADD CONSTRAINT fk_workflow_statistics_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: workflows_tags fk_workflows_tags_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows_tags
    ADD CONSTRAINT fk_workflows_tags_tag_id FOREIGN KEY ("tagId") REFERENCES public.tag_entity(id) ON DELETE CASCADE;


--
-- Name: workflows_tags fk_workflows_tags_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflows_tags
    ADD CONSTRAINT fk_workflows_tags_workflow_id FOREIGN KEY ("workflowId") REFERENCES public.workflow_entity(id) ON DELETE CASCADE;


--
-- Name: workflow_entity workflow_entity_parentFolderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workflow_entity
    ADD CONSTRAINT "workflow_entity_parentFolderId_fkey" FOREIGN KEY ("parentFolderId") REFERENCES public.folder(id) ON DELETE SET NULL;


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
