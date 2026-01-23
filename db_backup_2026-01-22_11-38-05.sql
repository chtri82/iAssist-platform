--
-- PostgreSQL database dump
--

\restrict p3PpXFg0RsoA0LcxcXgdPT1Tfnmhka1Sxsh7SHPzTuFbKcrcXdxIdFMGmuJMdTw

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 16.11 (Debian 16.11-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ab_permission; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_permission (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.ab_permission OWNER TO admin;

--
-- Name: ab_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_permission_id_seq OWNER TO admin;

--
-- Name: ab_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_permission_id_seq OWNED BY public.ab_permission.id;


--
-- Name: ab_permission_view; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_permission_view (
    id integer NOT NULL,
    permission_id integer,
    view_menu_id integer
);


ALTER TABLE public.ab_permission_view OWNER TO admin;

--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_permission_view_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_permission_view_id_seq OWNER TO admin;

--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_permission_view_id_seq OWNED BY public.ab_permission_view.id;


--
-- Name: ab_permission_view_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_permission_view_role (
    id integer NOT NULL,
    permission_view_id integer,
    role_id integer
);


ALTER TABLE public.ab_permission_view_role OWNER TO admin;

--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_permission_view_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_permission_view_role_id_seq OWNER TO admin;

--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_permission_view_role_id_seq OWNED BY public.ab_permission_view_role.id;


--
-- Name: ab_register_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_register_user (
    id integer NOT NULL,
    first_name character varying(256) NOT NULL,
    last_name character varying(256) NOT NULL,
    username character varying(512) NOT NULL,
    password character varying(256),
    email character varying(512) NOT NULL,
    registration_date timestamp without time zone,
    registration_hash character varying(256)
);


ALTER TABLE public.ab_register_user OWNER TO admin;

--
-- Name: ab_register_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_register_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_register_user_id_seq OWNER TO admin;

--
-- Name: ab_register_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_register_user_id_seq OWNED BY public.ab_register_user.id;


--
-- Name: ab_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_role (
    id integer NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.ab_role OWNER TO admin;

--
-- Name: ab_role_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_role_id_seq OWNER TO admin;

--
-- Name: ab_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_role_id_seq OWNED BY public.ab_role.id;


--
-- Name: ab_user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_user (
    id integer NOT NULL,
    first_name character varying(256) NOT NULL,
    last_name character varying(256) NOT NULL,
    username character varying(512) NOT NULL,
    password character varying(256),
    active boolean,
    email character varying(512) NOT NULL,
    last_login timestamp without time zone,
    login_count integer,
    fail_login_count integer,
    created_on timestamp without time zone,
    changed_on timestamp without time zone,
    created_by_fk integer,
    changed_by_fk integer
);


ALTER TABLE public.ab_user OWNER TO admin;

--
-- Name: ab_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_user_id_seq OWNER TO admin;

--
-- Name: ab_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_user_id_seq OWNED BY public.ab_user.id;


--
-- Name: ab_user_role; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_user_role (
    id integer NOT NULL,
    user_id integer,
    role_id integer
);


ALTER TABLE public.ab_user_role OWNER TO admin;

--
-- Name: ab_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_user_role_id_seq OWNER TO admin;

--
-- Name: ab_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_user_role_id_seq OWNED BY public.ab_user_role.id;


--
-- Name: ab_view_menu; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.ab_view_menu (
    id integer NOT NULL,
    name character varying(250) NOT NULL
);


ALTER TABLE public.ab_view_menu OWNER TO admin;

--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.ab_view_menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ab_view_menu_id_seq OWNER TO admin;

--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.ab_view_menu_id_seq OWNED BY public.ab_view_menu.id;


--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO admin;

--
-- Name: callback_request; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.callback_request (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    priority_weight integer NOT NULL,
    callback_data json NOT NULL,
    callback_type character varying(20) NOT NULL,
    processor_subdir character varying(2000)
);


ALTER TABLE public.callback_request OWNER TO admin;

--
-- Name: callback_request_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.callback_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.callback_request_id_seq OWNER TO admin;

--
-- Name: callback_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.callback_request_id_seq OWNED BY public.callback_request.id;


--
-- Name: connection; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.connection (
    id integer NOT NULL,
    conn_id character varying(250) NOT NULL,
    conn_type character varying(500) NOT NULL,
    description text,
    host character varying(500),
    schema character varying(500),
    login text,
    password text,
    port integer,
    is_encrypted boolean,
    is_extra_encrypted boolean,
    extra text
);


ALTER TABLE public.connection OWNER TO admin;

--
-- Name: connection_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.connection_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.connection_id_seq OWNER TO admin;

--
-- Name: connection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.connection_id_seq OWNED BY public.connection.id;


--
-- Name: dag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag (
    dag_id character varying(250) NOT NULL,
    root_dag_id character varying(250),
    is_paused boolean,
    is_subdag boolean,
    is_active boolean,
    last_parsed_time timestamp with time zone,
    last_pickled timestamp with time zone,
    last_expired timestamp with time zone,
    scheduler_lock boolean,
    pickle_id integer,
    fileloc character varying(2000),
    processor_subdir character varying(2000),
    owners character varying(2000),
    description text,
    default_view character varying(25),
    schedule_interval text,
    timetable_description character varying(1000),
    max_active_tasks integer NOT NULL,
    max_active_runs integer,
    has_task_concurrency_limits boolean NOT NULL,
    has_import_errors boolean DEFAULT false,
    next_dagrun timestamp with time zone,
    next_dagrun_data_interval_start timestamp with time zone,
    next_dagrun_data_interval_end timestamp with time zone,
    next_dagrun_create_after timestamp with time zone
);


ALTER TABLE public.dag OWNER TO admin;

--
-- Name: dag_code; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_code (
    fileloc_hash bigint NOT NULL,
    fileloc character varying(2000) NOT NULL,
    last_updated timestamp with time zone NOT NULL,
    source_code text NOT NULL
);


ALTER TABLE public.dag_code OWNER TO admin;

--
-- Name: dag_owner_attributes; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_owner_attributes (
    dag_id character varying(250) NOT NULL,
    owner character varying(500) NOT NULL,
    link character varying(500) NOT NULL
);


ALTER TABLE public.dag_owner_attributes OWNER TO admin;

--
-- Name: dag_pickle; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_pickle (
    id integer NOT NULL,
    pickle bytea,
    created_dttm timestamp with time zone,
    pickle_hash bigint
);


ALTER TABLE public.dag_pickle OWNER TO admin;

--
-- Name: dag_pickle_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dag_pickle_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dag_pickle_id_seq OWNER TO admin;

--
-- Name: dag_pickle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.dag_pickle_id_seq OWNED BY public.dag_pickle.id;


--
-- Name: dag_run; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_run (
    id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    queued_at timestamp with time zone,
    execution_date timestamp with time zone NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    state character varying(50),
    run_id character varying(250) NOT NULL,
    creating_job_id integer,
    external_trigger boolean,
    run_type character varying(50) NOT NULL,
    conf bytea,
    data_interval_start timestamp with time zone,
    data_interval_end timestamp with time zone,
    last_scheduling_decision timestamp with time zone,
    dag_hash character varying(32),
    log_template_id integer,
    updated_at timestamp with time zone,
    clear_number integer NOT NULL
);


ALTER TABLE public.dag_run OWNER TO admin;

--
-- Name: dag_run_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dag_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dag_run_id_seq OWNER TO admin;

--
-- Name: dag_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.dag_run_id_seq OWNED BY public.dag_run.id;


--
-- Name: dag_run_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_run_note (
    user_id integer,
    dag_run_id integer NOT NULL,
    content character varying(1000),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_run_note OWNER TO admin;

--
-- Name: dag_schedule_dataset_reference; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_schedule_dataset_reference (
    dataset_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_schedule_dataset_reference OWNER TO admin;

--
-- Name: dag_tag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_tag (
    name character varying(100) NOT NULL,
    dag_id character varying(250) NOT NULL
);


ALTER TABLE public.dag_tag OWNER TO admin;

--
-- Name: dag_warning; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dag_warning (
    dag_id character varying(250) NOT NULL,
    warning_type character varying(50) NOT NULL,
    message text NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.dag_warning OWNER TO admin;

--
-- Name: dagrun_dataset_event; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dagrun_dataset_event (
    dag_run_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.dagrun_dataset_event OWNER TO admin;

--
-- Name: dataset; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dataset (
    id integer NOT NULL,
    uri character varying(3000) NOT NULL,
    extra json NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    is_orphaned boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dataset OWNER TO admin;

--
-- Name: dataset_dag_run_queue; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dataset_dag_run_queue (
    dataset_id integer NOT NULL,
    target_dag_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.dataset_dag_run_queue OWNER TO admin;

--
-- Name: dataset_event; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.dataset_event (
    id integer NOT NULL,
    dataset_id integer NOT NULL,
    extra json NOT NULL,
    source_task_id character varying(250),
    source_dag_id character varying(250),
    source_run_id character varying(250),
    source_map_index integer DEFAULT '-1'::integer,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.dataset_event OWNER TO admin;

--
-- Name: dataset_event_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dataset_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dataset_event_id_seq OWNER TO admin;

--
-- Name: dataset_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.dataset_event_id_seq OWNED BY public.dataset_event.id;


--
-- Name: dataset_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.dataset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dataset_id_seq OWNER TO admin;

--
-- Name: dataset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.dataset_id_seq OWNED BY public.dataset.id;


--
-- Name: import_error; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.import_error (
    id integer NOT NULL,
    "timestamp" timestamp with time zone,
    filename character varying(1024),
    stacktrace text,
    processor_subdir character varying(2000)
);


ALTER TABLE public.import_error OWNER TO admin;

--
-- Name: import_error_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.import_error_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.import_error_id_seq OWNER TO admin;

--
-- Name: import_error_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.import_error_id_seq OWNED BY public.import_error.id;


--
-- Name: job; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.job (
    id integer NOT NULL,
    dag_id character varying(250),
    state character varying(20),
    job_type character varying(30),
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    latest_heartbeat timestamp with time zone,
    executor_class character varying(500),
    hostname character varying(500),
    unixname character varying(1000)
);


ALTER TABLE public.job OWNER TO admin;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_id_seq OWNER TO admin;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.job_id_seq OWNED BY public.job.id;


--
-- Name: log; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.log (
    id integer NOT NULL,
    dttm timestamp with time zone,
    dag_id character varying(250),
    task_id character varying(250),
    map_index integer,
    event character varying(30),
    execution_date timestamp with time zone,
    owner character varying(500),
    owner_display_name character varying(500),
    extra text
);


ALTER TABLE public.log OWNER TO admin;

--
-- Name: log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_id_seq OWNER TO admin;

--
-- Name: log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.log_id_seq OWNED BY public.log.id;


--
-- Name: log_template; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.log_template (
    id integer NOT NULL,
    filename text NOT NULL,
    elasticsearch_id text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.log_template OWNER TO admin;

--
-- Name: log_template_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.log_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.log_template_id_seq OWNER TO admin;

--
-- Name: log_template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.log_template_id_seq OWNED BY public.log_template.id;


--
-- Name: rendered_task_instance_fields; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.rendered_task_instance_fields (
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    rendered_fields json NOT NULL,
    k8s_pod_yaml json
);


ALTER TABLE public.rendered_task_instance_fields OWNER TO admin;

--
-- Name: serialized_dag; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.serialized_dag (
    dag_id character varying(250) NOT NULL,
    fileloc character varying(2000) NOT NULL,
    fileloc_hash bigint NOT NULL,
    data json,
    data_compressed bytea,
    last_updated timestamp with time zone NOT NULL,
    dag_hash character varying(32) NOT NULL,
    processor_subdir character varying(2000)
);


ALTER TABLE public.serialized_dag OWNER TO admin;

--
-- Name: session; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.session (
    id integer NOT NULL,
    session_id character varying(255),
    data bytea,
    expiry timestamp without time zone
);


ALTER TABLE public.session OWNER TO admin;

--
-- Name: session_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.session_id_seq OWNER TO admin;

--
-- Name: session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.session_id_seq OWNED BY public.session.id;


--
-- Name: sla_miss; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sla_miss (
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    execution_date timestamp with time zone NOT NULL,
    email_sent boolean,
    "timestamp" timestamp with time zone,
    description text,
    notification_sent boolean
);


ALTER TABLE public.sla_miss OWNER TO admin;

--
-- Name: slot_pool; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.slot_pool (
    id integer NOT NULL,
    pool character varying(256),
    slots integer,
    description text,
    include_deferred boolean NOT NULL
);


ALTER TABLE public.slot_pool OWNER TO admin;

--
-- Name: slot_pool_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.slot_pool_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.slot_pool_id_seq OWNER TO admin;

--
-- Name: slot_pool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.slot_pool_id_seq OWNED BY public.slot_pool.id;


--
-- Name: task_fail; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.task_fail (
    id integer NOT NULL,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    duration integer
);


ALTER TABLE public.task_fail OWNER TO admin;

--
-- Name: task_fail_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.task_fail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_fail_id_seq OWNER TO admin;

--
-- Name: task_fail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.task_fail_id_seq OWNED BY public.task_fail.id;


--
-- Name: task_instance; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.task_instance (
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    start_date timestamp with time zone,
    end_date timestamp with time zone,
    duration double precision,
    state character varying(20),
    try_number integer,
    max_tries integer DEFAULT '-1'::integer,
    hostname character varying(1000),
    unixname character varying(1000),
    job_id integer,
    pool character varying(256) NOT NULL,
    pool_slots integer NOT NULL,
    queue character varying(256),
    priority_weight integer,
    operator character varying(1000),
    custom_operator_name character varying(1000),
    queued_dttm timestamp with time zone,
    queued_by_job_id integer,
    pid integer,
    executor_config bytea,
    updated_at timestamp with time zone,
    external_executor_id character varying(250),
    trigger_id integer,
    trigger_timeout timestamp without time zone,
    next_method character varying(1000),
    next_kwargs json
);


ALTER TABLE public.task_instance OWNER TO admin;

--
-- Name: task_instance_note; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.task_instance_note (
    user_id integer,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer NOT NULL,
    content character varying(1000),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_instance_note OWNER TO admin;

--
-- Name: task_map; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.task_map (
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer NOT NULL,
    length integer NOT NULL,
    keys json,
    CONSTRAINT ck_task_map_task_map_length_not_negative CHECK ((length >= 0))
);


ALTER TABLE public.task_map OWNER TO admin;

--
-- Name: task_outlet_dataset_reference; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.task_outlet_dataset_reference (
    dataset_id integer NOT NULL,
    dag_id character varying(250) NOT NULL,
    task_id character varying(250) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.task_outlet_dataset_reference OWNER TO admin;

--
-- Name: task_reschedule; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.task_reschedule (
    id integer NOT NULL,
    task_id character varying(250) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    try_number integer NOT NULL,
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    duration integer NOT NULL,
    reschedule_date timestamp with time zone NOT NULL
);


ALTER TABLE public.task_reschedule OWNER TO admin;

--
-- Name: task_reschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.task_reschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_reschedule_id_seq OWNER TO admin;

--
-- Name: task_reschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.task_reschedule_id_seq OWNED BY public.task_reschedule.id;


--
-- Name: trigger; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.trigger (
    id integer NOT NULL,
    classpath character varying(1000) NOT NULL,
    kwargs json NOT NULL,
    created_date timestamp with time zone NOT NULL,
    triggerer_id integer
);


ALTER TABLE public.trigger OWNER TO admin;

--
-- Name: trigger_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.trigger_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trigger_id_seq OWNER TO admin;

--
-- Name: trigger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.trigger_id_seq OWNED BY public.trigger.id;


--
-- Name: user_transactions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_transactions (
    id integer NOT NULL,
    user_id integer,
    category character varying(100),
    amount numeric(10,2),
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_transactions OWNER TO admin;

--
-- Name: user_transactions_cleaned; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_transactions_cleaned (
    id bigint,
    user_id bigint,
    category text,
    amount double precision,
    "timestamp" timestamp without time zone,
    amount_usd double precision
);


ALTER TABLE public.user_transactions_cleaned OWNER TO admin;

--
-- Name: user_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_transactions_id_seq OWNER TO admin;

--
-- Name: user_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_transactions_id_seq OWNED BY public.user_transactions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100),
    email character varying(150),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: variable; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.variable (
    id integer NOT NULL,
    key character varying(250),
    val text,
    description text,
    is_encrypted boolean
);


ALTER TABLE public.variable OWNER TO admin;

--
-- Name: variable_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.variable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.variable_id_seq OWNER TO admin;

--
-- Name: variable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.variable_id_seq OWNED BY public.variable.id;


--
-- Name: xcom; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.xcom (
    dag_run_id integer NOT NULL,
    task_id character varying(250) NOT NULL,
    map_index integer DEFAULT '-1'::integer NOT NULL,
    key character varying(512) NOT NULL,
    dag_id character varying(250) NOT NULL,
    run_id character varying(250) NOT NULL,
    value bytea,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.xcom OWNER TO admin;

--
-- Name: ab_permission id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission ALTER COLUMN id SET DEFAULT nextval('public.ab_permission_id_seq'::regclass);


--
-- Name: ab_permission_view id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view ALTER COLUMN id SET DEFAULT nextval('public.ab_permission_view_id_seq'::regclass);


--
-- Name: ab_permission_view_role id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view_role ALTER COLUMN id SET DEFAULT nextval('public.ab_permission_view_role_id_seq'::regclass);


--
-- Name: ab_register_user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_register_user ALTER COLUMN id SET DEFAULT nextval('public.ab_register_user_id_seq'::regclass);


--
-- Name: ab_role id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_role ALTER COLUMN id SET DEFAULT nextval('public.ab_role_id_seq'::regclass);


--
-- Name: ab_user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user ALTER COLUMN id SET DEFAULT nextval('public.ab_user_id_seq'::regclass);


--
-- Name: ab_user_role id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user_role ALTER COLUMN id SET DEFAULT nextval('public.ab_user_role_id_seq'::regclass);


--
-- Name: ab_view_menu id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_view_menu ALTER COLUMN id SET DEFAULT nextval('public.ab_view_menu_id_seq'::regclass);


--
-- Name: callback_request id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.callback_request ALTER COLUMN id SET DEFAULT nextval('public.callback_request_id_seq'::regclass);


--
-- Name: connection id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.connection ALTER COLUMN id SET DEFAULT nextval('public.connection_id_seq'::regclass);


--
-- Name: dag_pickle id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_pickle ALTER COLUMN id SET DEFAULT nextval('public.dag_pickle_id_seq'::regclass);


--
-- Name: dag_run id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run ALTER COLUMN id SET DEFAULT nextval('public.dag_run_id_seq'::regclass);


--
-- Name: dataset id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset ALTER COLUMN id SET DEFAULT nextval('public.dataset_id_seq'::regclass);


--
-- Name: dataset_event id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset_event ALTER COLUMN id SET DEFAULT nextval('public.dataset_event_id_seq'::regclass);


--
-- Name: import_error id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.import_error ALTER COLUMN id SET DEFAULT nextval('public.import_error_id_seq'::regclass);


--
-- Name: job id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.job ALTER COLUMN id SET DEFAULT nextval('public.job_id_seq'::regclass);


--
-- Name: log id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.log ALTER COLUMN id SET DEFAULT nextval('public.log_id_seq'::regclass);


--
-- Name: log_template id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.log_template ALTER COLUMN id SET DEFAULT nextval('public.log_template_id_seq'::regclass);


--
-- Name: session id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.session ALTER COLUMN id SET DEFAULT nextval('public.session_id_seq'::regclass);


--
-- Name: slot_pool id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.slot_pool ALTER COLUMN id SET DEFAULT nextval('public.slot_pool_id_seq'::regclass);


--
-- Name: task_fail id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_fail ALTER COLUMN id SET DEFAULT nextval('public.task_fail_id_seq'::regclass);


--
-- Name: task_reschedule id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_reschedule ALTER COLUMN id SET DEFAULT nextval('public.task_reschedule_id_seq'::regclass);


--
-- Name: trigger id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trigger ALTER COLUMN id SET DEFAULT nextval('public.trigger_id_seq'::regclass);


--
-- Name: user_transactions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_transactions ALTER COLUMN id SET DEFAULT nextval('public.user_transactions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: variable id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variable ALTER COLUMN id SET DEFAULT nextval('public.variable_id_seq'::regclass);


--
-- Data for Name: ab_permission; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_permission (id, name) FROM stdin;
1	can_read
2	can_delete
3	can_edit
\.


--
-- Data for Name: ab_permission_view; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_permission_view (id, permission_id, view_menu_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	3	2
5	1	2
6	2	2
\.


--
-- Data for Name: ab_permission_view_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_permission_view_role (id, permission_view_id, role_id) FROM stdin;
\.


--
-- Data for Name: ab_register_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_register_user (id, first_name, last_name, username, password, email, registration_date, registration_hash) FROM stdin;
\.


--
-- Data for Name: ab_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_role (id, name) FROM stdin;
\.


--
-- Data for Name: ab_user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_user (id, first_name, last_name, username, password, active, email, last_login, login_count, fail_login_count, created_on, changed_on, created_by_fk, changed_by_fk) FROM stdin;
\.


--
-- Data for Name: ab_user_role; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_user_role (id, user_id, role_id) FROM stdin;
\.


--
-- Data for Name: ab_view_menu; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.ab_view_menu (id, name) FROM stdin;
1	DAG:iassist_self_train
2	DAG:self_train_dag
\.


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.alembic_version (version_num) FROM stdin;
10b52ebd31f7
\.


--
-- Data for Name: callback_request; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.callback_request (id, created_at, priority_weight, callback_data, callback_type, processor_subdir) FROM stdin;
\.


--
-- Data for Name: connection; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.connection (id, conn_id, conn_type, description, host, schema, login, password, port, is_encrypted, is_extra_encrypted, extra) FROM stdin;
1	airflow_db	mysql	\N	mysql	airflow	root	\N	\N	f	f	\N
2	aws_default	aws	\N	\N	\N	\N	\N	\N	f	f	\N
\.


--
-- Data for Name: dag; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag (dag_id, root_dag_id, is_paused, is_subdag, is_active, last_parsed_time, last_pickled, last_expired, scheduler_lock, pickle_id, fileloc, processor_subdir, owners, description, default_view, schedule_interval, timetable_description, max_active_tasks, max_active_runs, has_task_concurrency_limits, has_import_errors, next_dagrun, next_dagrun_data_interval_start, next_dagrun_data_interval_end, next_dagrun_create_after) FROM stdin;
iassist_self_train	\N	f	f	t	2026-01-21 17:57:01.787405+00	\N	\N	\N	\N	/opt/airflow/dags/self_train_dag.py	\N	iAssist	🤖 iAssist self-training orchestration DAG	grid	{"type": "timedelta", "attrs": {"days": 0, "seconds": 21600, "microseconds": 0}}		16	16	f	f	2026-01-21 06:00:00+00	2026-01-21 06:00:00+00	2026-01-21 12:00:00+00	2026-01-21 12:00:00+00
\.


--
-- Data for Name: dag_code; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_code (fileloc_hash, fileloc, last_updated, source_code) FROM stdin;
62009709588464514	/opt/airflow/dags/self_train_dag.py	2026-01-21 17:57:01.792613+00	from datetime import datetime, timedelta\nfrom airflow import DAG\nfrom airflow.operators.python import PythonOperator\nimport requests\nimport os\n\n# -- DAG Metadata --\ndefault_args = {\n    'owner': 'iAssist',\n    'retries': 3,\n    'retry_delay': timedelta(minutes=5),\n}\n\ndef fetch_data_from_web():\n    """🕸️ Pulls approved datasets (e.g. finance, health, market)"""\n    print("🌐 Fetching approved open datasets...")\n    # Example placeholder — in production use your approved APIs list\n    datasets = [\n        "https://datahub.io/core/finance-vix/r/vix-daily.csv",\n        "https://datahub.io/core/co2-fossil-global/r/global.csv"\n    ]\n    for url in datasets:\n        print(f"✅ Retrieved: {url}")\n    return "Fetched all datasets."\n\ndef run_databricks_training():\n    """🔥 Triggers Databricks job for model fine-tuning"""\n    print("🚀 Launching Databricks job...")\n    databricks_url = os.getenv("DATABRICKS_URL", "")\n    databricks_token = os.getenv("DATABRICKS_TOKEN", "")\n    job_id = os.getenv("DATABRICKS_JOBID", "")\n\n    if not databricks_url or not databricks_token or not job_id:\n        raise ValueError("Missing Databricks credentials or Job ID")\n\n    headers = {"Authorization": f"Bearer {databricks_token}"}\n    response = requests.post(f"{databricks_url}/api/2.1/jobs/run-now", headers=headers, json={"job_id": job_id})\n    \n    print("🧠 Training triggered, response:", response.text)\n    return "Training triggered."\n\ndef log_training_result():\n    """🧾 Log output to database or Airflow log"""\n    print("📋 Training completed, results logged to DB (placeholder).")\n\n# -- DAG Definition --\nwith DAG(\n    'iassist_self_train',\n    default_args=default_args,\n    description='🤖 iAssist self-training orchestration DAG',\n    schedule_interval=timedelta(hours=6),\n    start_date=datetime(2026, 1, 21),\n    catchup=False,\n) as dag:\n\n    task_fetch = PythonOperator(\n        task_id='fetch_datasets',\n        python_callable=fetch_data_from_web\n    )\n\n    task_train = PythonOperator(\n        task_id='run_databricks_training',\n        python_callable=run_databricks_training\n    )\n\n    task_log = PythonOperator(\n        task_id='log_training_result',\n        python_callable=log_training_result\n    )\n\n    task_fetch >> task_train >> task_log\n\n\n
\.


--
-- Data for Name: dag_owner_attributes; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_owner_attributes (dag_id, owner, link) FROM stdin;
\.


--
-- Data for Name: dag_pickle; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_pickle (id, pickle, created_dttm, pickle_hash) FROM stdin;
\.


--
-- Data for Name: dag_run; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_run (id, dag_id, queued_at, execution_date, start_date, end_date, state, run_id, creating_job_id, external_trigger, run_type, conf, data_interval_start, data_interval_end, last_scheduling_decision, dag_hash, log_template_id, updated_at, clear_number) FROM stdin;
\.


--
-- Data for Name: dag_run_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_run_note (user_id, dag_run_id, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_schedule_dataset_reference; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_schedule_dataset_reference (dataset_id, dag_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dag_tag; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_tag (name, dag_id) FROM stdin;
\.


--
-- Data for Name: dag_warning; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dag_warning (dag_id, warning_type, message, "timestamp") FROM stdin;
\.


--
-- Data for Name: dagrun_dataset_event; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dagrun_dataset_event (dag_run_id, event_id) FROM stdin;
\.


--
-- Data for Name: dataset; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dataset (id, uri, extra, created_at, updated_at, is_orphaned) FROM stdin;
\.


--
-- Data for Name: dataset_dag_run_queue; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dataset_dag_run_queue (dataset_id, target_dag_id, created_at) FROM stdin;
\.


--
-- Data for Name: dataset_event; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.dataset_event (id, dataset_id, extra, source_task_id, source_dag_id, source_run_id, source_map_index, "timestamp") FROM stdin;
\.


--
-- Data for Name: import_error; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.import_error (id, "timestamp", filename, stacktrace, processor_subdir) FROM stdin;
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.job (id, dag_id, state, job_type, start_date, end_date, latest_heartbeat, executor_class, hostname, unixname) FROM stdin;
\.


--
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.log (id, dttm, dag_id, task_id, map_index, event, execution_date, owner, owner_display_name, extra) FROM stdin;
1	2026-01-21 17:56:58.774253+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
2	2026-01-21 17:57:05.199995+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
3	2026-01-21 17:57:11.231641+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
4	2026-01-21 17:57:18.452533+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
5	2026-01-21 17:57:25.719146+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
6	2026-01-21 17:57:34.443437+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
7	2026-01-21 17:57:47.774169+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
8	2026-01-21 17:58:06.628923+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
9	2026-01-21 17:58:37.804766+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
10	2026-01-21 17:59:34.36409+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
11	2026-01-21 18:00:39.709905+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
12	2026-01-21 18:01:44.976053+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
13	2026-01-21 18:02:50.584786+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
14	2026-01-21 18:03:55.663404+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
15	2026-01-21 18:05:00.801212+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
16	2026-01-21 18:06:06.056461+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
17	2026-01-21 18:07:11.264692+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
18	2026-01-21 18:08:16.445597+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
19	2026-01-21 18:09:21.498931+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
20	2026-01-21 18:10:26.685103+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
21	2026-01-21 18:11:31.754536+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
22	2026-01-21 18:12:36.84297+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
23	2026-01-21 18:13:42.063336+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
24	2026-01-21 18:14:47.073585+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
25	2026-01-21 18:15:52.151221+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
26	2026-01-21 18:16:57.178241+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
27	2026-01-21 18:18:02.200977+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
28	2026-01-21 18:19:07.463297+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
29	2026-01-21 18:20:12.453022+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
30	2026-01-21 18:21:17.500381+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
31	2026-01-21 18:22:22.496076+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
32	2026-01-21 18:23:27.442774+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
33	2026-01-21 18:24:32.389314+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
34	2026-01-21 18:25:37.426122+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
35	2026-01-21 21:21:46.059822+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
36	2026-01-21 21:22:52.065286+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
37	2026-01-21 21:23:57.409068+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
38	2026-01-21 21:25:03.003402+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
39	2026-01-21 21:26:08.700922+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
40	2026-01-21 21:27:14.514431+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
41	2026-01-21 21:28:20.213339+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
42	2026-01-21 21:29:25.595755+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
43	2026-01-21 21:30:31.137863+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
44	2026-01-21 21:31:36.431803+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
45	2026-01-21 21:32:41.856053+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
46	2026-01-21 21:33:47.148295+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
47	2026-01-21 21:34:52.522101+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
48	2026-01-21 21:35:57.86158+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
49	2026-01-21 21:37:03.256681+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
50	2026-01-21 21:38:08.785388+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
51	2026-01-21 21:39:14.181358+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
52	2026-01-21 21:40:19.435508+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
53	2026-01-21 21:41:24.676428+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
54	2026-01-21 21:42:29.879508+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
55	2026-01-21 21:43:35.086004+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
56	2026-01-21 21:44:40.625461+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
57	2026-01-21 21:45:45.931106+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
58	2026-01-21 21:46:51.096156+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
59	2026-01-21 21:47:56.453326+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
60	2026-01-21 21:49:01.786727+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
61	2026-01-21 21:50:07.081839+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
62	2026-01-21 21:51:12.848813+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
63	2026-01-21 21:52:18.769069+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
64	2026-01-21 21:53:25.482278+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
65	2026-01-21 21:54:31.618412+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
66	2026-01-21 21:55:38.189817+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
67	2026-01-21 21:56:45.447182+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
68	2026-01-21 21:57:53.683338+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
69	2026-01-21 21:58:58.941827+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
70	2026-01-21 22:00:04.545551+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
71	2026-01-21 22:01:09.619334+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
72	2026-01-21 22:02:14.797912+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
73	2026-01-21 22:03:20.188463+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
74	2026-01-21 22:04:25.380637+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
75	2026-01-21 22:05:30.818745+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
76	2026-01-21 22:06:35.991051+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
77	2026-01-21 22:07:41.69886+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
78	2026-01-21 22:08:47.414632+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
79	2026-01-21 22:09:52.631118+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
80	2026-01-21 22:10:57.977943+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
81	2026-01-21 22:12:03.3096+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
82	2026-01-21 22:13:08.476907+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
83	2026-01-21 22:14:13.626704+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
84	2026-01-21 22:15:18.820391+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
85	2026-01-21 22:16:24.429167+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
86	2026-01-21 22:17:29.464069+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
87	2026-01-21 22:18:34.912621+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
88	2026-01-21 22:19:41.217315+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
89	2026-01-21 22:20:46.657645+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
90	2026-01-21 22:21:52.555613+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
91	2026-01-21 22:22:58.437918+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
92	2026-01-21 22:24:03.774801+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
93	2026-01-21 22:25:08.933142+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
94	2026-01-21 22:26:14.297637+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
95	2026-01-21 22:27:19.572225+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
96	2026-01-21 22:28:25.015643+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
97	2026-01-21 22:29:30.389164+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
98	2026-01-21 22:30:35.958007+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
99	2026-01-21 22:31:41.212686+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
100	2026-01-21 22:32:46.783858+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
101	2026-01-21 22:33:52.143861+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
102	2026-01-21 22:34:57.354577+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
103	2026-01-21 22:36:02.526618+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
104	2026-01-21 22:37:07.679594+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
105	2026-01-21 22:38:12.763185+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
106	2026-01-21 22:39:18.162203+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
107	2026-01-21 22:40:23.686956+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
108	2026-01-21 22:41:29.172958+00	\N	\N	\N	cli_check	\N	airflow	\N	{"host_name": "0c5511724510", "full_command": "['/home/airflow/.local/bin/airflow', 'db', 'check']"}
\.


--
-- Data for Name: log_template; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.log_template (id, filename, elasticsearch_id, created_at) FROM stdin;
\.


--
-- Data for Name: rendered_task_instance_fields; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.rendered_task_instance_fields (dag_id, task_id, run_id, map_index, rendered_fields, k8s_pod_yaml) FROM stdin;
\.


--
-- Data for Name: serialized_dag; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.serialized_dag (dag_id, fileloc, fileloc_hash, data, data_compressed, last_updated, dag_hash, processor_subdir) FROM stdin;
self_train_dag	/opt/airflow/dags/self_train_dag.py	62009709588464514	{"__version": 1, "dag": {"edge_info": {}, "fileloc": "/opt/airflow/dags/self_train_dag.py", "catchup": false, "start_date": 1768953600.0, "dataset_triggers": [], "_dag_id": "self_train_dag", "timetable": {"__type": "airflow.timetables.interval.CronDataIntervalTimetable", "__var": {"expression": "0 0 * * *", "timezone": "UTC"}}, "tags": ["self-train", "iAssist", "hybrid"], "timezone": "UTC", "default_args": {"__var": {"owner": "airflow", "depends_on_past": false, "email_on_failure": false, "email_on_retry": false, "retries": 1, "retry_delay": {"__var": 300.0, "__type": "timedelta"}}, "__type": "dict"}, "_description": "Self-training orchestration between AI Core and Databricks", "_task_group": {"_group_id": null, "prefix_group_id": true, "tooltip": "", "ui_color": "CornflowerBlue", "ui_fgcolor": "#000", "children": {"extract_training_tasks": ["operator", "extract_training_tasks"], "local_pretrain": ["operator", "local_pretrain"], "trigger_databricks_training": ["operator", "trigger_databricks_training"], "finalize_training": ["operator", "finalize_training"]}, "upstream_group_ids": [], "downstream_group_ids": [], "upstream_task_ids": [], "downstream_task_ids": []}, "_processor_dags_folder": "/opt/airflow/dags", "tasks": [{"owner": "airflow", "downstream_task_ids": ["local_pretrain"], "ui_color": "#ffefeb", "retry_delay": 300.0, "pool": "default_pool", "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "email_on_retry": false, "email_on_failure": false, "ui_fgcolor": "#000", "template_ext": [], "retries": 1, "on_failure_fail_dagrun": false, "is_setup": false, "task_id": "extract_training_tasks", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "_log_config_logger_name": "airflow.task.operators", "is_teardown": false, "_task_type": "PythonOperator", "_task_module": "airflow.operators.python", "_is_empty": false, "op_args": [], "op_kwargs": {}}, {"owner": "airflow", "downstream_task_ids": ["trigger_databricks_training"], "ui_color": "#ffefeb", "retry_delay": 300.0, "pool": "default_pool", "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "email_on_retry": false, "email_on_failure": false, "ui_fgcolor": "#000", "template_ext": [], "retries": 1, "on_failure_fail_dagrun": false, "is_setup": false, "task_id": "local_pretrain", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "_log_config_logger_name": "airflow.task.operators", "is_teardown": false, "_task_type": "PythonOperator", "_task_module": "airflow.operators.python", "_is_empty": false, "op_args": [], "op_kwargs": {}}, {"owner": "airflow", "downstream_task_ids": ["finalize_training"], "ui_color": "#ffefeb", "retry_delay": 300.0, "pool": "default_pool", "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "email_on_retry": false, "email_on_failure": false, "ui_fgcolor": "#000", "template_ext": [], "retries": 1, "on_failure_fail_dagrun": false, "is_setup": false, "task_id": "trigger_databricks_training", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "_log_config_logger_name": "airflow.task.operators", "is_teardown": false, "_task_type": "PythonOperator", "_task_module": "airflow.operators.python", "_is_empty": false, "op_args": [], "op_kwargs": {}}, {"owner": "airflow", "downstream_task_ids": [], "ui_color": "#ffefeb", "retry_delay": 300.0, "pool": "default_pool", "template_fields_renderers": {"templates_dict": "json", "op_args": "py", "op_kwargs": "py"}, "email_on_retry": false, "email_on_failure": false, "ui_fgcolor": "#000", "template_ext": [], "retries": 1, "on_failure_fail_dagrun": false, "is_setup": false, "task_id": "finalize_training", "template_fields": ["templates_dict", "op_args", "op_kwargs"], "_log_config_logger_name": "airflow.task.operators", "is_teardown": false, "_task_type": "PythonOperator", "_task_module": "airflow.operators.python", "_is_empty": false, "op_args": [], "op_kwargs": {}}], "dag_dependencies": [], "params": {}}}	\N	2026-01-21 22:40:26.488677+00	3d73a50149d77b185b011bad243d9cdd	\N
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.session (id, session_id, data, expiry) FROM stdin;
\.


--
-- Data for Name: sla_miss; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sla_miss (task_id, dag_id, execution_date, email_sent, "timestamp", description, notification_sent) FROM stdin;
\.


--
-- Data for Name: slot_pool; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.slot_pool (id, pool, slots, description, include_deferred) FROM stdin;
1	default_pool	128	Default pool	f
\.


--
-- Data for Name: task_fail; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.task_fail (id, task_id, dag_id, run_id, map_index, start_date, end_date, duration) FROM stdin;
\.


--
-- Data for Name: task_instance; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.task_instance (task_id, dag_id, run_id, map_index, start_date, end_date, duration, state, try_number, max_tries, hostname, unixname, job_id, pool, pool_slots, queue, priority_weight, operator, custom_operator_name, queued_dttm, queued_by_job_id, pid, executor_config, updated_at, external_executor_id, trigger_id, trigger_timeout, next_method, next_kwargs) FROM stdin;
\.


--
-- Data for Name: task_instance_note; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.task_instance_note (user_id, task_id, dag_id, run_id, map_index, content, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_map; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.task_map (dag_id, task_id, run_id, map_index, length, keys) FROM stdin;
\.


--
-- Data for Name: task_outlet_dataset_reference; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.task_outlet_dataset_reference (dataset_id, dag_id, task_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_reschedule; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.task_reschedule (id, task_id, dag_id, run_id, map_index, try_number, start_date, end_date, duration, reschedule_date) FROM stdin;
\.


--
-- Data for Name: trigger; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.trigger (id, classpath, kwargs, created_date, triggerer_id) FROM stdin;
\.


--
-- Data for Name: user_transactions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_transactions (id, user_id, category, amount, "timestamp") FROM stdin;
1	1	groceries	82.50	2026-01-21 16:28:42.137253
2	1	utilities	120.00	2026-01-21 16:28:42.137253
3	2	entertainment	60.00	2026-01-21 16:28:42.137253
4	2	fuel	45.75	2026-01-21 16:28:42.137253
\.


--
-- Data for Name: user_transactions_cleaned; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_transactions_cleaned (id, user_id, category, amount, "timestamp", amount_usd) FROM stdin;
1	1	Groceries	82.5	2026-01-21 16:28:42.137253	82.5
2	1	Utilities	120	2026-01-21 16:28:42.137253	120
3	2	Entertainment	60	2026-01-21 16:28:42.137253	60
4	2	Fuel	45.75	2026-01-21 16:28:42.137253	45.75
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, name, email, created_at) FROM stdin;
1	Test User	test@iassist.ai	2026-01-17 22:37:59.256801
\.


--
-- Data for Name: variable; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.variable (id, key, val, description, is_encrypted) FROM stdin;
\.


--
-- Data for Name: xcom; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.xcom (dag_run_id, task_id, map_index, key, dag_id, run_id, value, "timestamp") FROM stdin;
\.


--
-- Name: ab_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_permission_id_seq', 3, true);


--
-- Name: ab_permission_view_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_permission_view_id_seq', 6, true);


--
-- Name: ab_permission_view_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_permission_view_role_id_seq', 1, false);


--
-- Name: ab_register_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_register_user_id_seq', 1, false);


--
-- Name: ab_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_role_id_seq', 1, false);


--
-- Name: ab_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_user_id_seq', 1, false);


--
-- Name: ab_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_user_role_id_seq', 1, false);


--
-- Name: ab_view_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.ab_view_menu_id_seq', 2, true);


--
-- Name: callback_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.callback_request_id_seq', 1, false);


--
-- Name: connection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.connection_id_seq', 2, true);


--
-- Name: dag_pickle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dag_pickle_id_seq', 1, false);


--
-- Name: dag_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dag_run_id_seq', 1, false);


--
-- Name: dataset_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dataset_event_id_seq', 1, false);


--
-- Name: dataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.dataset_id_seq', 1, false);


--
-- Name: import_error_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.import_error_id_seq', 1, false);


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.job_id_seq', 1, false);


--
-- Name: log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.log_id_seq', 108, true);


--
-- Name: log_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.log_template_id_seq', 1, false);


--
-- Name: session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.session_id_seq', 1, false);


--
-- Name: slot_pool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.slot_pool_id_seq', 1, true);


--
-- Name: task_fail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.task_fail_id_seq', 1, false);


--
-- Name: task_reschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.task_reschedule_id_seq', 1, false);


--
-- Name: trigger_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.trigger_id_seq', 1, false);


--
-- Name: user_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_transactions_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: variable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.variable_id_seq', 1, false);


--
-- Name: ab_permission ab_permission_name_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission
    ADD CONSTRAINT ab_permission_name_uq UNIQUE (name);


--
-- Name: ab_permission ab_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission
    ADD CONSTRAINT ab_permission_pkey PRIMARY KEY (id);


--
-- Name: ab_permission_view ab_permission_view_permission_id_view_menu_id_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_permission_id_view_menu_id_uq UNIQUE (permission_id, view_menu_id);


--
-- Name: ab_permission_view ab_permission_view_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_pkey PRIMARY KEY (id);


--
-- Name: ab_permission_view_role ab_permission_view_role_permission_view_id_role_id_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_permission_view_id_role_id_uq UNIQUE (permission_view_id, role_id);


--
-- Name: ab_permission_view_role ab_permission_view_role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_pkey PRIMARY KEY (id);


--
-- Name: ab_register_user ab_register_user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_register_user
    ADD CONSTRAINT ab_register_user_pkey PRIMARY KEY (id);


--
-- Name: ab_register_user ab_register_user_username_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_register_user
    ADD CONSTRAINT ab_register_user_username_uq UNIQUE (username);


--
-- Name: ab_role ab_role_name_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_role
    ADD CONSTRAINT ab_role_name_uq UNIQUE (name);


--
-- Name: ab_role ab_role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_role
    ADD CONSTRAINT ab_role_pkey PRIMARY KEY (id);


--
-- Name: ab_user ab_user_email_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_email_uq UNIQUE (email);


--
-- Name: ab_user ab_user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_pkey PRIMARY KEY (id);


--
-- Name: ab_user_role ab_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_pkey PRIMARY KEY (id);


--
-- Name: ab_user_role ab_user_role_user_id_role_id_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_user_id_role_id_uq UNIQUE (user_id, role_id);


--
-- Name: ab_user ab_user_username_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_username_uq UNIQUE (username);


--
-- Name: ab_view_menu ab_view_menu_name_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_view_menu
    ADD CONSTRAINT ab_view_menu_name_uq UNIQUE (name);


--
-- Name: ab_view_menu ab_view_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_view_menu
    ADD CONSTRAINT ab_view_menu_pkey PRIMARY KEY (id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: callback_request callback_request_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.callback_request
    ADD CONSTRAINT callback_request_pkey PRIMARY KEY (id);


--
-- Name: connection connection_conn_id_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_conn_id_uq UNIQUE (conn_id);


--
-- Name: connection connection_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.connection
    ADD CONSTRAINT connection_pkey PRIMARY KEY (id);


--
-- Name: dag_code dag_code_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_code
    ADD CONSTRAINT dag_code_pkey PRIMARY KEY (fileloc_hash);


--
-- Name: dag_owner_attributes dag_owner_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_owner_attributes
    ADD CONSTRAINT dag_owner_attributes_pkey PRIMARY KEY (dag_id, owner);


--
-- Name: dag_pickle dag_pickle_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_pickle
    ADD CONSTRAINT dag_pickle_pkey PRIMARY KEY (id);


--
-- Name: dag dag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag
    ADD CONSTRAINT dag_pkey PRIMARY KEY (dag_id);


--
-- Name: dag_run dag_run_dag_id_execution_date_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_dag_id_execution_date_key UNIQUE (dag_id, execution_date);


--
-- Name: dag_run dag_run_dag_id_run_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_dag_id_run_id_key UNIQUE (dag_id, run_id);


--
-- Name: dag_run_note dag_run_note_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_pkey PRIMARY KEY (dag_run_id);


--
-- Name: dag_run dag_run_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT dag_run_pkey PRIMARY KEY (id);


--
-- Name: dag_tag dag_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_tag
    ADD CONSTRAINT dag_tag_pkey PRIMARY KEY (name, dag_id);


--
-- Name: dag_warning dag_warning_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_warning
    ADD CONSTRAINT dag_warning_pkey PRIMARY KEY (dag_id, warning_type);


--
-- Name: dagrun_dataset_event dagrun_dataset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dagrun_dataset_event
    ADD CONSTRAINT dagrun_dataset_event_pkey PRIMARY KEY (dag_run_id, event_id);


--
-- Name: dataset_event dataset_event_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset_event
    ADD CONSTRAINT dataset_event_pkey PRIMARY KEY (id);


--
-- Name: dataset dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT dataset_pkey PRIMARY KEY (id);


--
-- Name: dataset_dag_run_queue datasetdagrunqueue_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset_dag_run_queue
    ADD CONSTRAINT datasetdagrunqueue_pkey PRIMARY KEY (dataset_id, target_dag_id);


--
-- Name: dag_schedule_dataset_reference dsdr_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_schedule_dataset_reference
    ADD CONSTRAINT dsdr_pkey PRIMARY KEY (dataset_id, dag_id);


--
-- Name: import_error import_error_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.import_error
    ADD CONSTRAINT import_error_pkey PRIMARY KEY (id);


--
-- Name: job job_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: log_template log_template_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.log_template
    ADD CONSTRAINT log_template_pkey PRIMARY KEY (id);


--
-- Name: rendered_task_instance_fields rendered_task_instance_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.rendered_task_instance_fields
    ADD CONSTRAINT rendered_task_instance_fields_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: serialized_dag serialized_dag_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.serialized_dag
    ADD CONSTRAINT serialized_dag_pkey PRIMARY KEY (dag_id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: session session_session_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_session_id_key UNIQUE (session_id);


--
-- Name: sla_miss sla_miss_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sla_miss
    ADD CONSTRAINT sla_miss_pkey PRIMARY KEY (task_id, dag_id, execution_date);


--
-- Name: slot_pool slot_pool_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.slot_pool
    ADD CONSTRAINT slot_pool_pkey PRIMARY KEY (id);


--
-- Name: slot_pool slot_pool_pool_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.slot_pool
    ADD CONSTRAINT slot_pool_pool_uq UNIQUE (pool);


--
-- Name: task_fail task_fail_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_fail
    ADD CONSTRAINT task_fail_pkey PRIMARY KEY (id);


--
-- Name: task_instance_note task_instance_note_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_pkey PRIMARY KEY (task_id, dag_id, run_id, map_index);


--
-- Name: task_instance task_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: task_map task_map_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_map
    ADD CONSTRAINT task_map_pkey PRIMARY KEY (dag_id, task_id, run_id, map_index);


--
-- Name: task_reschedule task_reschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_pkey PRIMARY KEY (id);


--
-- Name: task_outlet_dataset_reference todr_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_outlet_dataset_reference
    ADD CONSTRAINT todr_pkey PRIMARY KEY (dataset_id, dag_id, task_id);


--
-- Name: trigger trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.trigger
    ADD CONSTRAINT trigger_pkey PRIMARY KEY (id);


--
-- Name: user_transactions user_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_transactions
    ADD CONSTRAINT user_transactions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: variable variable_key_uq; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_key_uq UNIQUE (key);


--
-- Name: variable variable_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.variable
    ADD CONSTRAINT variable_pkey PRIMARY KEY (id);


--
-- Name: xcom xcom_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.xcom
    ADD CONSTRAINT xcom_pkey PRIMARY KEY (dag_run_id, task_id, map_index, key);


--
-- Name: dag_id_state; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX dag_id_state ON public.dag_run USING btree (dag_id, state);


--
-- Name: idx_ab_register_user_username; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX idx_ab_register_user_username ON public.ab_register_user USING btree (lower((username)::text));


--
-- Name: idx_ab_user_username; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX idx_ab_user_username ON public.ab_user USING btree (lower((username)::text));


--
-- Name: idx_dag_run_dag_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_dag_run_dag_id ON public.dag_run USING btree (dag_id);


--
-- Name: idx_dag_run_queued_dags; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_dag_run_queued_dags ON public.dag_run USING btree (state, dag_id) WHERE ((state)::text = 'queued'::text);


--
-- Name: idx_dag_run_running_dags; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_dag_run_running_dags ON public.dag_run USING btree (state, dag_id) WHERE ((state)::text = 'running'::text);


--
-- Name: idx_dagrun_dataset_events_dag_run_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_dagrun_dataset_events_dag_run_id ON public.dagrun_dataset_event USING btree (dag_run_id);


--
-- Name: idx_dagrun_dataset_events_event_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_dagrun_dataset_events_event_id ON public.dagrun_dataset_event USING btree (event_id);


--
-- Name: idx_dataset_id_timestamp; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_dataset_id_timestamp ON public.dataset_event USING btree (dataset_id, "timestamp");


--
-- Name: idx_fileloc_hash; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_fileloc_hash ON public.serialized_dag USING btree (fileloc_hash);


--
-- Name: idx_job_dag_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_job_dag_id ON public.job USING btree (dag_id);


--
-- Name: idx_job_state_heartbeat; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_job_state_heartbeat ON public.job USING btree (state, latest_heartbeat);


--
-- Name: idx_last_scheduling_decision; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_last_scheduling_decision ON public.dag_run USING btree (last_scheduling_decision);


--
-- Name: idx_log_dag; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_log_dag ON public.log USING btree (dag_id);


--
-- Name: idx_log_dttm; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_log_dttm ON public.log USING btree (dttm);


--
-- Name: idx_log_event; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_log_event ON public.log USING btree (event);


--
-- Name: idx_next_dagrun_create_after; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_next_dagrun_create_after ON public.dag USING btree (next_dagrun_create_after);


--
-- Name: idx_root_dag_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_root_dag_id ON public.dag USING btree (root_dag_id);


--
-- Name: idx_task_fail_task_instance; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_task_fail_task_instance ON public.task_fail USING btree (dag_id, task_id, run_id, map_index);


--
-- Name: idx_task_reschedule_dag_run; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_task_reschedule_dag_run ON public.task_reschedule USING btree (dag_id, run_id);


--
-- Name: idx_task_reschedule_dag_task_run; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_task_reschedule_dag_task_run ON public.task_reschedule USING btree (dag_id, task_id, run_id, map_index);


--
-- Name: idx_uri_unique; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX idx_uri_unique ON public.dataset USING btree (uri);


--
-- Name: idx_xcom_key; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_xcom_key ON public.xcom USING btree (key);


--
-- Name: idx_xcom_task_instance; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX idx_xcom_task_instance ON public.xcom USING btree (dag_id, task_id, run_id, map_index);


--
-- Name: job_type_heart; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX job_type_heart ON public.job USING btree (job_type, latest_heartbeat);


--
-- Name: sm_dag; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX sm_dag ON public.sla_miss USING btree (dag_id);


--
-- Name: ti_dag_run; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_dag_run ON public.task_instance USING btree (dag_id, run_id);


--
-- Name: ti_dag_state; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_dag_state ON public.task_instance USING btree (dag_id, state);


--
-- Name: ti_job_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_job_id ON public.task_instance USING btree (job_id);


--
-- Name: ti_pool; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_pool ON public.task_instance USING btree (pool, state, priority_weight);


--
-- Name: ti_state; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_state ON public.task_instance USING btree (state);


--
-- Name: ti_state_incl_start_date; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_state_incl_start_date ON public.task_instance USING btree (dag_id, task_id, state) INCLUDE (start_date);


--
-- Name: ti_state_lkp; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_state_lkp ON public.task_instance USING btree (dag_id, task_id, run_id, state);


--
-- Name: ti_trigger_id; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ti_trigger_id ON public.task_instance USING btree (trigger_id);


--
-- Name: ab_permission_view ab_permission_view_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.ab_permission(id);


--
-- Name: ab_permission_view_role ab_permission_view_role_permission_view_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_permission_view_id_fkey FOREIGN KEY (permission_view_id) REFERENCES public.ab_permission_view(id);


--
-- Name: ab_permission_view_role ab_permission_view_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view_role
    ADD CONSTRAINT ab_permission_view_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id);


--
-- Name: ab_permission_view ab_permission_view_view_menu_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_permission_view
    ADD CONSTRAINT ab_permission_view_view_menu_id_fkey FOREIGN KEY (view_menu_id) REFERENCES public.ab_view_menu(id);


--
-- Name: ab_user ab_user_changed_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_changed_by_fk_fkey FOREIGN KEY (changed_by_fk) REFERENCES public.ab_user(id);


--
-- Name: ab_user ab_user_created_by_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user
    ADD CONSTRAINT ab_user_created_by_fk_fkey FOREIGN KEY (created_by_fk) REFERENCES public.ab_user(id);


--
-- Name: ab_user_role ab_user_role_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.ab_role(id);


--
-- Name: ab_user_role ab_user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.ab_user_role
    ADD CONSTRAINT ab_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: dag_owner_attributes dag.dag_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_owner_attributes
    ADD CONSTRAINT "dag.dag_id" FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_run_note dag_run_note_dr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_dr_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dag_run_note dag_run_note_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run_note
    ADD CONSTRAINT dag_run_note_user_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: dag_tag dag_tag_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_tag
    ADD CONSTRAINT dag_tag_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dagrun_dataset_event dagrun_dataset_event_dag_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dagrun_dataset_event
    ADD CONSTRAINT dagrun_dataset_event_dag_run_id_fkey FOREIGN KEY (dag_run_id) REFERENCES public.dag_run(id) ON DELETE CASCADE;


--
-- Name: dagrun_dataset_event dagrun_dataset_event_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dagrun_dataset_event
    ADD CONSTRAINT dagrun_dataset_event_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.dataset_event(id) ON DELETE CASCADE;


--
-- Name: dag_warning dcw_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_warning
    ADD CONSTRAINT dcw_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dataset_dag_run_queue ddrq_dag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset_dag_run_queue
    ADD CONSTRAINT ddrq_dag_fkey FOREIGN KEY (target_dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dataset_dag_run_queue ddrq_dataset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dataset_dag_run_queue
    ADD CONSTRAINT ddrq_dataset_fkey FOREIGN KEY (dataset_id) REFERENCES public.dataset(id) ON DELETE CASCADE;


--
-- Name: dag_schedule_dataset_reference dsdr_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_schedule_dataset_reference
    ADD CONSTRAINT dsdr_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: dag_schedule_dataset_reference dsdr_dataset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_schedule_dataset_reference
    ADD CONSTRAINT dsdr_dataset_fkey FOREIGN KEY (dataset_id) REFERENCES public.dataset(id) ON DELETE CASCADE;


--
-- Name: rendered_task_instance_fields rtif_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.rendered_task_instance_fields
    ADD CONSTRAINT rtif_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- Name: task_fail task_fail_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_fail
    ADD CONSTRAINT task_fail_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- Name: task_instance task_instance_dag_run_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_dag_run_fkey FOREIGN KEY (dag_id, run_id) REFERENCES public.dag_run(dag_id, run_id) ON DELETE CASCADE;


--
-- Name: dag_run task_instance_log_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.dag_run
    ADD CONSTRAINT task_instance_log_template_id_fkey FOREIGN KEY (log_template_id) REFERENCES public.log_template(id);


--
-- Name: task_instance_note task_instance_note_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- Name: task_instance_note task_instance_note_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_instance_note
    ADD CONSTRAINT task_instance_note_user_fkey FOREIGN KEY (user_id) REFERENCES public.ab_user(id);


--
-- Name: task_instance task_instance_trigger_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_instance
    ADD CONSTRAINT task_instance_trigger_id_fkey FOREIGN KEY (trigger_id) REFERENCES public.trigger(id) ON DELETE CASCADE;


--
-- Name: task_map task_map_task_instance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_map
    ADD CONSTRAINT task_map_task_instance_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: task_reschedule task_reschedule_dr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_dr_fkey FOREIGN KEY (dag_id, run_id) REFERENCES public.dag_run(dag_id, run_id) ON DELETE CASCADE;


--
-- Name: task_reschedule task_reschedule_ti_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_reschedule
    ADD CONSTRAINT task_reschedule_ti_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- Name: task_outlet_dataset_reference todr_dag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_outlet_dataset_reference
    ADD CONSTRAINT todr_dag_id_fkey FOREIGN KEY (dag_id) REFERENCES public.dag(dag_id) ON DELETE CASCADE;


--
-- Name: task_outlet_dataset_reference todr_dataset_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.task_outlet_dataset_reference
    ADD CONSTRAINT todr_dataset_fkey FOREIGN KEY (dataset_id) REFERENCES public.dataset(id) ON DELETE CASCADE;


--
-- Name: xcom xcom_task_instance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.xcom
    ADD CONSTRAINT xcom_task_instance_fkey FOREIGN KEY (dag_id, task_id, run_id, map_index) REFERENCES public.task_instance(dag_id, task_id, run_id, map_index) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict p3PpXFg0RsoA0LcxcXgdPT1Tfnmhka1Sxsh7SHPzTuFbKcrcXdxIdFMGmuJMdTw

