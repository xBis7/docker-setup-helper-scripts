--
-- PostgreSQL database dump
--

-- Dumped from database version 12.16 (Debian 12.16-1.pgdg120+1)
-- Dumped by pg_dump version 12.16 (Debian 12.16-1.pgdg120+1)

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
-- Name: getmodulesidbyname(character varying); Type: FUNCTION; Schema: public; Owner: rangeradmin
--

CREATE FUNCTION public.getmodulesidbyname(input_val character varying) RETURNS bigint
    LANGUAGE sql
    AS $_$ SELECT x_modules_master.id FROM x_modules_master
WHERE x_modules_master.module = $1; $_$;


ALTER FUNCTION public.getmodulesidbyname(input_val character varying) OWNER TO rangeradmin;

--
-- Name: getxportaluidbyloginid(character varying); Type: FUNCTION; Schema: public; Owner: rangeradmin
--

CREATE FUNCTION public.getxportaluidbyloginid(input_val character varying) RETURNS bigint
    LANGUAGE sql
    AS $_$ SELECT x_portal_user.id FROM x_portal_user
WHERE x_portal_user.login_id = $1; $_$;


ALTER FUNCTION public.getxportaluidbyloginid(input_val character varying) OWNER TO rangeradmin;

--
-- Name: x_trx_log_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_trx_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_trx_log_seq OWNER TO rangeradmin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: x_trx_log; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_trx_log (
    id bigint DEFAULT nextval('public.x_trx_log_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    class_type integer DEFAULT 0 NOT NULL,
    object_id bigint,
    parent_object_id bigint,
    parent_object_class_type integer DEFAULT 0 NOT NULL,
    parent_object_name character varying(1024) DEFAULT NULL::character varying,
    object_name character varying(1024) DEFAULT NULL::character varying,
    attr_name character varying(255) DEFAULT NULL::character varying,
    prev_val text,
    new_val text,
    trx_id character varying(1024) DEFAULT NULL::character varying,
    action character varying(255) DEFAULT NULL::character varying,
    sess_id character varying(512) DEFAULT NULL::character varying,
    req_id character varying(30) DEFAULT NULL::character varying,
    sess_type character varying(30) DEFAULT NULL::character varying
);


ALTER TABLE public.x_trx_log OWNER TO rangeradmin;

--
-- Name: vx_trx_log; Type: VIEW; Schema: public; Owner: rangeradmin
--

CREATE VIEW public.vx_trx_log AS
 SELECT x_trx_log.id,
    x_trx_log.create_time,
    x_trx_log.update_time,
    x_trx_log.added_by_id,
    x_trx_log.upd_by_id,
    x_trx_log.class_type,
    x_trx_log.object_id,
    x_trx_log.parent_object_id,
    x_trx_log.parent_object_class_type,
    x_trx_log.attr_name,
    x_trx_log.parent_object_name,
    x_trx_log.object_name,
    x_trx_log.prev_val,
    x_trx_log.new_val,
    x_trx_log.trx_id,
    x_trx_log.action,
    x_trx_log.sess_id,
    x_trx_log.req_id,
    x_trx_log.sess_type
   FROM public.x_trx_log
  WHERE (x_trx_log.id IN ( SELECT min(x_trx_log_1.id) AS min
           FROM public.x_trx_log x_trx_log_1
          GROUP BY x_trx_log_1.trx_id));


ALTER TABLE public.vx_trx_log OWNER TO rangeradmin;

--
-- Name: x_access_type_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_access_type_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_access_type_def_seq OWNER TO rangeradmin;

--
-- Name: x_access_type_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_access_type_def (
    id bigint DEFAULT nextval('public.x_access_type_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    label character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0,
    datamask_options character varying(1024) DEFAULT NULL::character varying,
    rowfilter_options character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_access_type_def OWNER TO rangeradmin;

--
-- Name: x_access_type_def_grants_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_access_type_def_grants_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_access_type_def_grants_seq OWNER TO rangeradmin;

--
-- Name: x_access_type_def_grants; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_access_type_def_grants (
    id bigint DEFAULT nextval('public.x_access_type_def_grants_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    atd_id bigint NOT NULL,
    implied_grant character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_access_type_def_grants OWNER TO rangeradmin;

--
-- Name: x_asset_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_asset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_asset_seq OWNER TO rangeradmin;

--
-- Name: x_asset; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_asset (
    id bigint DEFAULT nextval('public.x_asset_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    asset_name character varying(1024) NOT NULL,
    descr character varying(4000) DEFAULT NULL::character varying,
    act_status integer DEFAULT 0 NOT NULL,
    asset_type integer DEFAULT 0 NOT NULL,
    config text,
    sup_native boolean DEFAULT false NOT NULL
);


ALTER TABLE public.x_asset OWNER TO rangeradmin;

--
-- Name: x_audit_map_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_audit_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_audit_map_seq OWNER TO rangeradmin;

--
-- Name: x_audit_map; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_audit_map (
    id bigint DEFAULT nextval('public.x_audit_map_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    res_id bigint,
    group_id bigint,
    user_id bigint,
    audit_type bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.x_audit_map OWNER TO rangeradmin;

--
-- Name: x_auth_sess_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_auth_sess_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_auth_sess_seq OWNER TO rangeradmin;

--
-- Name: x_auth_sess; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_auth_sess (
    id bigint DEFAULT nextval('public.x_auth_sess_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    login_id character varying(767) NOT NULL,
    user_id bigint,
    ext_sess_id character varying(512) DEFAULT NULL::character varying,
    auth_time timestamp without time zone NOT NULL,
    auth_status integer DEFAULT 0 NOT NULL,
    auth_type integer DEFAULT 0 NOT NULL,
    auth_provider integer DEFAULT 0 NOT NULL,
    device_type integer DEFAULT 0 NOT NULL,
    req_ip character varying(48) NOT NULL,
    req_ua character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_auth_sess OWNER TO rangeradmin;

--
-- Name: x_context_enricher_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_context_enricher_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_context_enricher_def_seq OWNER TO rangeradmin;

--
-- Name: x_context_enricher_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_context_enricher_def (
    id bigint DEFAULT nextval('public.x_context_enricher_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    enricher character varying(1024) DEFAULT NULL::character varying,
    enricher_options character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_context_enricher_def OWNER TO rangeradmin;

--
-- Name: x_cred_store_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_cred_store_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_cred_store_seq OWNER TO rangeradmin;

--
-- Name: x_cred_store; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_cred_store (
    id bigint DEFAULT nextval('public.x_cred_store_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    store_name character varying(1024) NOT NULL,
    descr character varying(4000) NOT NULL
);


ALTER TABLE public.x_cred_store OWNER TO rangeradmin;

--
-- Name: x_data_hist_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_data_hist_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_data_hist_seq OWNER TO rangeradmin;

--
-- Name: x_data_hist; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_data_hist (
    id bigint DEFAULT nextval('public.x_data_hist_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    obj_guid character varying(1024) NOT NULL,
    obj_class_type integer NOT NULL,
    obj_id bigint NOT NULL,
    obj_name character varying(1024) NOT NULL,
    version bigint,
    action character varying(512) NOT NULL,
    from_time timestamp without time zone NOT NULL,
    to_time timestamp without time zone,
    content text NOT NULL
);


ALTER TABLE public.x_data_hist OWNER TO rangeradmin;

--
-- Name: x_datamask_type_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_datamask_type_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_datamask_type_def_seq OWNER TO rangeradmin;

--
-- Name: x_datamask_type_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_datamask_type_def (
    id bigint DEFAULT nextval('public.x_datamask_type_def_seq'::regclass) NOT NULL,
    guid character varying(64) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) NOT NULL,
    label character varying(1024) NOT NULL,
    description character varying(1024) DEFAULT NULL::character varying,
    transformer character varying(1024) DEFAULT NULL::character varying,
    datamask_options character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    rb_key_description character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_datamask_type_def OWNER TO rangeradmin;

--
-- Name: x_db_base_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_db_base_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_db_base_seq OWNER TO rangeradmin;

--
-- Name: x_db_base; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_db_base (
    id bigint DEFAULT nextval('public.x_db_base_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint
);


ALTER TABLE public.x_db_base OWNER TO rangeradmin;

--
-- Name: x_db_version_h; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_db_version_h (
    id integer NOT NULL,
    version character varying(64) NOT NULL,
    inst_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    inst_by character varying(256) NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by character varying(256) NOT NULL,
    active character varying(1) DEFAULT 'Y'::character varying,
    CONSTRAINT x_db_version_h_active_check CHECK (((active)::text = ANY ((ARRAY['Y'::character varying, 'N'::character varying])::text[])))
);


ALTER TABLE public.x_db_version_h OWNER TO rangeradmin;

--
-- Name: x_db_version_h_id_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_db_version_h_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_db_version_h_id_seq OWNER TO rangeradmin;

--
-- Name: x_db_version_h_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rangeradmin
--

ALTER SEQUENCE public.x_db_version_h_id_seq OWNED BY public.x_db_version_h.id;


--
-- Name: x_enum_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_enum_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_enum_def_seq OWNER TO rangeradmin;

--
-- Name: x_enum_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_enum_def (
    id bigint DEFAULT nextval('public.x_enum_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    default_index bigint
);


ALTER TABLE public.x_enum_def OWNER TO rangeradmin;

--
-- Name: x_enum_element_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_enum_element_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_enum_element_def_seq OWNER TO rangeradmin;

--
-- Name: x_enum_element_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_enum_element_def (
    id bigint DEFAULT nextval('public.x_enum_element_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    enum_def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    label character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_enum_element_def OWNER TO rangeradmin;

--
-- Name: x_group_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_group_seq OWNER TO rangeradmin;

--
-- Name: x_group; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_group (
    id bigint DEFAULT nextval('public.x_group_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    group_name character varying(1024) NOT NULL,
    descr text,
    status integer DEFAULT 0 NOT NULL,
    group_type integer DEFAULT 0 NOT NULL,
    cred_store_id bigint,
    group_src integer DEFAULT 0 NOT NULL,
    is_visible integer DEFAULT 1 NOT NULL,
    other_attributes text,
    sync_source text
);


ALTER TABLE public.x_group OWNER TO rangeradmin;

--
-- Name: x_group_groups_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_group_groups_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_group_groups_seq OWNER TO rangeradmin;

--
-- Name: x_group_groups; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_group_groups (
    id bigint DEFAULT nextval('public.x_group_groups_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    group_name character varying(1024) NOT NULL,
    p_group_id bigint,
    group_id bigint
);


ALTER TABLE public.x_group_groups OWNER TO rangeradmin;

--
-- Name: x_group_module_perm_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_group_module_perm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_group_module_perm_seq OWNER TO rangeradmin;

--
-- Name: x_group_module_perm; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_group_module_perm (
    id bigint DEFAULT nextval('public.x_group_module_perm_seq'::regclass) NOT NULL,
    group_id bigint,
    module_id bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    is_allowed integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.x_group_module_perm OWNER TO rangeradmin;

--
-- Name: x_group_users_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_group_users_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_group_users_seq OWNER TO rangeradmin;

--
-- Name: x_group_users; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_group_users (
    id bigint DEFAULT nextval('public.x_group_users_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    group_name character varying(767) NOT NULL,
    p_group_id bigint,
    user_id bigint
);


ALTER TABLE public.x_group_users OWNER TO rangeradmin;

--
-- Name: x_modules_master_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_modules_master_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_modules_master_seq OWNER TO rangeradmin;

--
-- Name: x_modules_master; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_modules_master (
    id bigint DEFAULT nextval('public.x_modules_master_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    module character varying(1024) NOT NULL,
    url character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_modules_master OWNER TO rangeradmin;

--
-- Name: x_perm_map_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_perm_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_perm_map_seq OWNER TO rangeradmin;

--
-- Name: x_perm_map; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_perm_map (
    id bigint DEFAULT nextval('public.x_perm_map_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    perm_group character varying(1024) DEFAULT NULL::character varying,
    res_id bigint,
    group_id bigint,
    user_id bigint,
    perm_for integer DEFAULT 0 NOT NULL,
    perm_type integer DEFAULT 0 NOT NULL,
    is_recursive integer DEFAULT 0 NOT NULL,
    is_wild_card boolean DEFAULT true NOT NULL,
    grant_revoke boolean DEFAULT true NOT NULL,
    ip_address text
);


ALTER TABLE public.x_perm_map OWNER TO rangeradmin;

--
-- Name: x_plugin_info_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_plugin_info_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_plugin_info_seq OWNER TO rangeradmin;

--
-- Name: x_plugin_info; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_plugin_info (
    id bigint DEFAULT nextval('public.x_plugin_info_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    service_name character varying(255) NOT NULL,
    app_type character varying(128) NOT NULL,
    host_name character varying(255) NOT NULL,
    ip_address character varying(64) NOT NULL,
    info character varying(1024) NOT NULL
);


ALTER TABLE public.x_plugin_info OWNER TO rangeradmin;

--
-- Name: x_policy_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_seq OWNER TO rangeradmin;

--
-- Name: x_policy; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy (
    id bigint DEFAULT nextval('public.x_policy_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    service bigint NOT NULL,
    name character varying(512) NOT NULL,
    policy_type integer DEFAULT 0,
    description character varying(1024) DEFAULT NULL::character varying,
    resource_signature character varying(128) DEFAULT NULL::character varying,
    is_enabled boolean DEFAULT false NOT NULL,
    is_audit_enabled boolean DEFAULT false NOT NULL,
    policy_options character varying(4000) DEFAULT NULL::character varying,
    policy_priority integer DEFAULT 0 NOT NULL,
    policy_text text,
    zone_id bigint DEFAULT '1'::bigint NOT NULL
);


ALTER TABLE public.x_policy OWNER TO rangeradmin;

--
-- Name: x_policy_change_log_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_change_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_change_log_seq OWNER TO rangeradmin;

--
-- Name: x_policy_change_log; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_change_log (
    id bigint DEFAULT nextval('public.x_policy_change_log_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    service_id bigint NOT NULL,
    change_type integer NOT NULL,
    policy_version bigint DEFAULT '0'::bigint NOT NULL,
    service_type character varying(256) DEFAULT NULL::character varying,
    policy_type integer,
    zone_name character varying(256) DEFAULT NULL::character varying,
    policy_id bigint,
    policy_guid character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_change_log OWNER TO rangeradmin;

--
-- Name: x_policy_condition_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_condition_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_condition_def_seq OWNER TO rangeradmin;

--
-- Name: x_policy_condition_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_condition_def (
    id bigint DEFAULT nextval('public.x_policy_condition_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    evaluator character varying(1024) DEFAULT NULL::character varying,
    evaluator_options character varying(1024) DEFAULT NULL::character varying,
    validation_reg_ex character varying(1024) DEFAULT NULL::character varying,
    validation_message character varying(1024) DEFAULT NULL::character varying,
    ui_hint character varying(1024) DEFAULT NULL::character varying,
    label character varying(1024) DEFAULT NULL::character varying,
    description character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    rb_key_description character varying(1024) DEFAULT NULL::character varying,
    rb_key_validation_message character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_policy_condition_def OWNER TO rangeradmin;

--
-- Name: x_policy_export_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_export_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_export_seq OWNER TO rangeradmin;

--
-- Name: x_policy_export_audit; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_export_audit (
    id bigint DEFAULT nextval('public.x_policy_export_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    client_ip character varying(255) NOT NULL,
    agent_id character varying(255) DEFAULT NULL::character varying,
    req_epoch bigint NOT NULL,
    last_updated timestamp without time zone,
    repository_name character varying(1024) DEFAULT NULL::character varying,
    exported_json text,
    http_ret_code integer DEFAULT 0 NOT NULL,
    cluster_name character varying(255) DEFAULT NULL::character varying,
    zone_name character varying(255) DEFAULT NULL::character varying,
    policy_version bigint
);


ALTER TABLE public.x_policy_export_audit OWNER TO rangeradmin;

--
-- Name: x_policy_item_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item (
    id bigint DEFAULT nextval('public.x_policy_item_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    delegate_admin boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 0,
    item_type integer DEFAULT 0 NOT NULL,
    is_enabled boolean DEFAULT true NOT NULL,
    comments character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_item OWNER TO rangeradmin;

--
-- Name: x_policy_item_access_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_access_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_access_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item_access; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item_access (
    id bigint DEFAULT nextval('public.x_policy_item_access_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_item_id bigint NOT NULL,
    type bigint NOT NULL,
    is_allowed boolean DEFAULT false NOT NULL,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_policy_item_access OWNER TO rangeradmin;

--
-- Name: x_policy_item_condition_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_condition_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_condition_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item_condition; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item_condition (
    id bigint DEFAULT nextval('public.x_policy_item_condition_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_item_id bigint NOT NULL,
    type bigint NOT NULL,
    value character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_policy_item_condition OWNER TO rangeradmin;

--
-- Name: x_policy_item_datamask_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_datamask_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_datamask_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item_datamask; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item_datamask (
    id bigint DEFAULT nextval('public.x_policy_item_datamask_seq'::regclass) NOT NULL,
    guid character varying(64) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_item_id bigint NOT NULL,
    type bigint NOT NULL,
    condition_expr character varying(1024) DEFAULT NULL::character varying,
    value_expr character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_item_datamask OWNER TO rangeradmin;

--
-- Name: x_policy_item_group_perm_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_group_perm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_group_perm_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item_group_perm; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item_group_perm (
    id bigint DEFAULT nextval('public.x_policy_item_group_perm_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_item_id bigint NOT NULL,
    group_id bigint,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_policy_item_group_perm OWNER TO rangeradmin;

--
-- Name: x_policy_item_rowfilter_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_rowfilter_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_rowfilter_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item_rowfilter; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item_rowfilter (
    id bigint DEFAULT nextval('public.x_policy_item_rowfilter_seq'::regclass) NOT NULL,
    guid character varying(64) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_item_id bigint NOT NULL,
    filter_expr character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_item_rowfilter OWNER TO rangeradmin;

--
-- Name: x_policy_item_user_perm_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_item_user_perm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_item_user_perm_seq OWNER TO rangeradmin;

--
-- Name: x_policy_item_user_perm; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_item_user_perm (
    id bigint DEFAULT nextval('public.x_policy_item_user_perm_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_item_id bigint NOT NULL,
    user_id bigint,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_policy_item_user_perm OWNER TO rangeradmin;

--
-- Name: x_policy_label_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_label_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_label_seq OWNER TO rangeradmin;

--
-- Name: x_policy_label; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_label (
    id bigint DEFAULT nextval('public.x_policy_label_seq'::regclass) NOT NULL,
    guid character varying(64) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    label_name character varying(512) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_label OWNER TO rangeradmin;

--
-- Name: x_policy_label_map_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_label_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_label_map_seq OWNER TO rangeradmin;

--
-- Name: x_policy_label_map; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_label_map (
    id bigint DEFAULT nextval('public.x_policy_label_map_seq'::regclass) NOT NULL,
    guid character varying(64) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint,
    policy_label_id bigint
);


ALTER TABLE public.x_policy_label_map OWNER TO rangeradmin;

--
-- Name: x_policy_ref_access_type_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_access_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_access_type_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_access_type; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_access_type (
    id bigint DEFAULT nextval('public.x_policy_ref_access_type_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    access_def_id bigint NOT NULL,
    access_type_name character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_access_type OWNER TO rangeradmin;

--
-- Name: x_policy_ref_condition_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_condition_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_condition_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_condition; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_condition (
    id bigint DEFAULT nextval('public.x_policy_ref_condition_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    condition_def_id bigint NOT NULL,
    condition_name character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_condition OWNER TO rangeradmin;

--
-- Name: x_policy_ref_datamask_type_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_datamask_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_datamask_type_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_datamask_type; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_datamask_type (
    id bigint DEFAULT nextval('public.x_policy_ref_datamask_type_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    datamask_def_id bigint NOT NULL,
    datamask_type_name character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_datamask_type OWNER TO rangeradmin;

--
-- Name: x_policy_ref_group_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_group_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_group; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_group (
    id bigint DEFAULT nextval('public.x_policy_ref_group_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    group_id bigint NOT NULL,
    group_name character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_group OWNER TO rangeradmin;

--
-- Name: x_policy_ref_resource_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_resource_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_resource; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_resource (
    id bigint DEFAULT nextval('public.x_policy_ref_resource_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    resource_def_id bigint NOT NULL,
    resource_name character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_resource OWNER TO rangeradmin;

--
-- Name: x_policy_ref_role_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_role_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_role; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_role (
    id bigint DEFAULT nextval('public.x_policy_ref_role_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    role_id bigint NOT NULL,
    role_name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_role OWNER TO rangeradmin;

--
-- Name: x_policy_ref_user_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_ref_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_ref_user_seq OWNER TO rangeradmin;

--
-- Name: x_policy_ref_user; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_ref_user (
    id bigint DEFAULT nextval('public.x_policy_ref_user_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    user_id bigint NOT NULL,
    user_name character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_policy_ref_user OWNER TO rangeradmin;

--
-- Name: x_policy_resource_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_resource_seq OWNER TO rangeradmin;

--
-- Name: x_policy_resource; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_resource (
    id bigint DEFAULT nextval('public.x_policy_resource_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    policy_id bigint NOT NULL,
    res_def_id bigint NOT NULL,
    is_excludes boolean DEFAULT false NOT NULL,
    is_recursive boolean DEFAULT false NOT NULL
);


ALTER TABLE public.x_policy_resource OWNER TO rangeradmin;

--
-- Name: x_policy_resource_map_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_policy_resource_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_policy_resource_map_seq OWNER TO rangeradmin;

--
-- Name: x_policy_resource_map; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_policy_resource_map (
    id bigint DEFAULT nextval('public.x_policy_resource_map_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    resource_id bigint NOT NULL,
    value character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_policy_resource_map OWNER TO rangeradmin;

--
-- Name: x_portal_user_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_portal_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_portal_user_seq OWNER TO rangeradmin;

--
-- Name: x_portal_user; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_portal_user (
    id bigint DEFAULT nextval('public.x_portal_user_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    first_name character varying(256) DEFAULT NULL::character varying,
    last_name character varying(256) DEFAULT NULL::character varying,
    pub_scr_name character varying(2048) DEFAULT NULL::character varying,
    login_id character varying(767) DEFAULT NULL::character varying,
    password character varying(512) NOT NULL,
    email character varying(512) DEFAULT NULL::character varying,
    status integer DEFAULT 0 NOT NULL,
    user_src integer DEFAULT 0 NOT NULL,
    notes text,
    other_attributes text,
    sync_source text,
    old_passwords text,
    password_updated_time timestamp without time zone
);


ALTER TABLE public.x_portal_user OWNER TO rangeradmin;

--
-- Name: x_portal_user_role_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_portal_user_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_portal_user_role_seq OWNER TO rangeradmin;

--
-- Name: x_portal_user_role; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_portal_user_role (
    id bigint DEFAULT nextval('public.x_portal_user_role_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    user_id bigint NOT NULL,
    user_role character varying(128) DEFAULT NULL::character varying,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.x_portal_user_role OWNER TO rangeradmin;

--
-- Name: x_ranger_global_state_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_ranger_global_state_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_ranger_global_state_seq OWNER TO rangeradmin;

--
-- Name: x_ranger_global_state; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_ranger_global_state (
    id bigint DEFAULT nextval('public.x_ranger_global_state_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    state_name character varying(255) NOT NULL,
    app_data character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_ranger_global_state OWNER TO rangeradmin;

--
-- Name: x_resource_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_resource_seq OWNER TO rangeradmin;

--
-- Name: x_resource; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_resource (
    id bigint DEFAULT nextval('public.x_resource_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    res_name character varying(4000) DEFAULT NULL::character varying,
    descr character varying(4000) DEFAULT NULL::character varying,
    res_type integer DEFAULT 0 NOT NULL,
    asset_id bigint NOT NULL,
    parent_id bigint,
    parent_path character varying(4000) DEFAULT NULL::character varying,
    is_encrypt integer DEFAULT 0 NOT NULL,
    is_recursive integer DEFAULT 0 NOT NULL,
    res_group character varying(1024) DEFAULT NULL::character varying,
    res_dbs text,
    res_tables text,
    res_col_fams text,
    res_cols text,
    res_udfs text,
    res_status integer DEFAULT 1 NOT NULL,
    table_type integer DEFAULT 0 NOT NULL,
    col_type integer DEFAULT 0 NOT NULL,
    policy_name character varying(500) DEFAULT NULL::character varying,
    res_topologies text,
    res_services text
);


ALTER TABLE public.x_resource OWNER TO rangeradmin;

--
-- Name: x_resource_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_resource_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_resource_def_seq OWNER TO rangeradmin;

--
-- Name: x_resource_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_resource_def (
    id bigint DEFAULT nextval('public.x_resource_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    type character varying(1024) DEFAULT NULL::character varying,
    res_level bigint,
    parent bigint,
    mandatory boolean DEFAULT false NOT NULL,
    look_up_supported boolean DEFAULT false NOT NULL,
    recursive_supported boolean DEFAULT false NOT NULL,
    excludes_supported boolean DEFAULT false NOT NULL,
    matcher character varying(1024) DEFAULT NULL::character varying,
    matcher_options character varying(1024) DEFAULT NULL::character varying,
    validation_reg_ex character varying(1024) DEFAULT NULL::character varying,
    validation_message character varying(1024) DEFAULT NULL::character varying,
    ui_hint character varying(1024) DEFAULT NULL::character varying,
    label character varying(1024) DEFAULT NULL::character varying,
    description character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    rb_key_description character varying(1024) DEFAULT NULL::character varying,
    rb_key_validation_message character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0,
    datamask_options character varying(1024) DEFAULT NULL::character varying,
    rowfilter_options character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_resource_def OWNER TO rangeradmin;

--
-- Name: x_rms_mapping_provider_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_rms_mapping_provider_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_rms_mapping_provider_seq OWNER TO rangeradmin;

--
-- Name: x_rms_mapping_provider; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_rms_mapping_provider (
    id bigint DEFAULT nextval('public.x_rms_mapping_provider_seq'::regclass) NOT NULL,
    change_timestamp timestamp without time zone,
    name character varying(128) NOT NULL,
    last_known_version bigint NOT NULL
);


ALTER TABLE public.x_rms_mapping_provider OWNER TO rangeradmin;

--
-- Name: x_rms_notification_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_rms_notification_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_rms_notification_seq OWNER TO rangeradmin;

--
-- Name: x_rms_notification; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_rms_notification (
    id bigint DEFAULT nextval('public.x_rms_notification_seq'::regclass) NOT NULL,
    hms_name character varying(128) DEFAULT NULL::character varying,
    notification_id bigint,
    change_timestamp timestamp without time zone,
    change_type character varying(64) DEFAULT NULL::character varying,
    hl_resource_id bigint,
    hl_service_id bigint,
    ll_resource_id bigint,
    ll_service_id bigint
);


ALTER TABLE public.x_rms_notification OWNER TO rangeradmin;

--
-- Name: x_rms_resource_mapping_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_rms_resource_mapping_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_rms_resource_mapping_seq OWNER TO rangeradmin;

--
-- Name: x_rms_resource_mapping; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_rms_resource_mapping (
    id bigint DEFAULT nextval('public.x_rms_resource_mapping_seq'::regclass) NOT NULL,
    change_timestamp timestamp without time zone,
    hl_resource_id bigint NOT NULL,
    ll_resource_id bigint NOT NULL
);


ALTER TABLE public.x_rms_resource_mapping OWNER TO rangeradmin;

--
-- Name: x_rms_service_resource_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_rms_service_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_rms_service_resource_seq OWNER TO rangeradmin;

--
-- Name: x_rms_service_resource; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_rms_service_resource (
    id bigint DEFAULT nextval('public.x_rms_service_resource_seq'::regclass) NOT NULL,
    guid character varying(64) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    service_id bigint NOT NULL,
    resource_signature character varying(128) DEFAULT NULL::character varying,
    is_enabled boolean DEFAULT true NOT NULL,
    service_resource_elements_text text
);


ALTER TABLE public.x_rms_service_resource OWNER TO rangeradmin;

--
-- Name: x_role_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_role_seq OWNER TO rangeradmin;

--
-- Name: x_role; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_role (
    id bigint DEFAULT nextval('public.x_role_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint DEFAULT '0'::bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(1024) DEFAULT NULL::character varying,
    role_options character varying(4000) DEFAULT NULL::character varying,
    role_text text
);


ALTER TABLE public.x_role OWNER TO rangeradmin;

--
-- Name: x_role_ref_group_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_role_ref_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_role_ref_group_seq OWNER TO rangeradmin;

--
-- Name: x_role_ref_group; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_role_ref_group (
    id bigint DEFAULT nextval('public.x_role_ref_group_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    role_id bigint NOT NULL,
    group_id bigint,
    group_name character varying(767) DEFAULT NULL::character varying,
    priv_type integer
);


ALTER TABLE public.x_role_ref_group OWNER TO rangeradmin;

--
-- Name: x_role_ref_role_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_role_ref_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_role_ref_role_seq OWNER TO rangeradmin;

--
-- Name: x_role_ref_role; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_role_ref_role (
    id bigint DEFAULT nextval('public.x_role_ref_role_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    role_ref_id bigint,
    role_id bigint NOT NULL,
    role_name character varying(255) DEFAULT NULL::character varying,
    priv_type integer
);


ALTER TABLE public.x_role_ref_role OWNER TO rangeradmin;

--
-- Name: x_role_ref_user_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_role_ref_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_role_ref_user_seq OWNER TO rangeradmin;

--
-- Name: x_role_ref_user; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_role_ref_user (
    id bigint DEFAULT nextval('public.x_role_ref_user_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    role_id bigint NOT NULL,
    user_id bigint,
    user_name character varying(767) DEFAULT NULL::character varying,
    priv_type integer
);


ALTER TABLE public.x_role_ref_user OWNER TO rangeradmin;

--
-- Name: x_sec_zone_ref_group_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_sec_zone_ref_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_sec_zone_ref_group_seq OWNER TO rangeradmin;

--
-- Name: x_sec_zone_ref_resource_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_sec_zone_ref_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_sec_zone_ref_resource_seq OWNER TO rangeradmin;

--
-- Name: x_sec_zone_ref_role_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_sec_zone_ref_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_sec_zone_ref_role_seq OWNER TO rangeradmin;

--
-- Name: x_sec_zone_ref_service_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_sec_zone_ref_service_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_sec_zone_ref_service_seq OWNER TO rangeradmin;

--
-- Name: x_sec_zone_ref_tag_srvc_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_sec_zone_ref_tag_srvc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_sec_zone_ref_tag_srvc_seq OWNER TO rangeradmin;

--
-- Name: x_sec_zone_ref_user_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_sec_zone_ref_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_sec_zone_ref_user_seq OWNER TO rangeradmin;

--
-- Name: x_security_zone_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_security_zone_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_security_zone_seq OWNER TO rangeradmin;

--
-- Name: x_security_zone; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone (
    id bigint DEFAULT nextval('public.x_security_zone_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    name character varying(255) NOT NULL,
    jsondata text,
    description character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_security_zone OWNER TO rangeradmin;

--
-- Name: x_security_zone_ref_group; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone_ref_group (
    id bigint DEFAULT nextval('public.x_sec_zone_ref_group_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    zone_id bigint,
    group_id bigint,
    group_name character varying(255) DEFAULT NULL::character varying,
    group_type smallint
);


ALTER TABLE public.x_security_zone_ref_group OWNER TO rangeradmin;

--
-- Name: x_security_zone_ref_resource; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone_ref_resource (
    id bigint DEFAULT nextval('public.x_sec_zone_ref_resource_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    zone_id bigint,
    resource_def_id bigint,
    resource_name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_security_zone_ref_resource OWNER TO rangeradmin;

--
-- Name: x_security_zone_ref_role; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone_ref_role (
    id bigint DEFAULT nextval('public.x_sec_zone_ref_role_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    zone_id bigint,
    role_id bigint,
    role_name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_security_zone_ref_role OWNER TO rangeradmin;

--
-- Name: x_security_zone_ref_service; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone_ref_service (
    id bigint DEFAULT nextval('public.x_sec_zone_ref_service_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    zone_id bigint,
    service_id bigint,
    service_name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_security_zone_ref_service OWNER TO rangeradmin;

--
-- Name: x_security_zone_ref_tag_srvc; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone_ref_tag_srvc (
    id bigint DEFAULT nextval('public.x_sec_zone_ref_tag_srvc_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    zone_id bigint,
    tag_srvc_id bigint,
    tag_srvc_name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_security_zone_ref_tag_srvc OWNER TO rangeradmin;

--
-- Name: x_security_zone_ref_user; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_security_zone_ref_user (
    id bigint DEFAULT nextval('public.x_sec_zone_ref_user_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    zone_id bigint,
    user_id bigint,
    user_name character varying(255) DEFAULT NULL::character varying,
    user_type smallint
);


ALTER TABLE public.x_security_zone_ref_user OWNER TO rangeradmin;

--
-- Name: x_service_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_service_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_service_seq OWNER TO rangeradmin;

--
-- Name: x_service; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_service (
    id bigint DEFAULT nextval('public.x_service_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    type bigint,
    name character varying(255) DEFAULT NULL::character varying,
    display_name character varying(255) DEFAULT NULL::character varying,
    policy_version bigint,
    policy_update_time timestamp without time zone,
    description character varying(1024) DEFAULT NULL::character varying,
    is_enabled boolean DEFAULT false NOT NULL,
    tag_service bigint,
    tag_version bigint DEFAULT 0 NOT NULL,
    tag_update_time timestamp without time zone
);


ALTER TABLE public.x_service OWNER TO rangeradmin;

--
-- Name: x_service_config_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_service_config_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_service_config_def_seq OWNER TO rangeradmin;

--
-- Name: x_service_config_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_service_config_def (
    id bigint DEFAULT nextval('public.x_service_config_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    def_id bigint NOT NULL,
    item_id bigint NOT NULL,
    name character varying(1024) DEFAULT NULL::character varying,
    type character varying(1024) DEFAULT NULL::character varying,
    sub_type character varying(1024) DEFAULT NULL::character varying,
    is_mandatory boolean DEFAULT false NOT NULL,
    default_value character varying(1024) DEFAULT NULL::character varying,
    validation_reg_ex character varying(1024) DEFAULT NULL::character varying,
    validation_message character varying(1024) DEFAULT NULL::character varying,
    ui_hint character varying(1024) DEFAULT NULL::character varying,
    label character varying(1024) DEFAULT NULL::character varying,
    description character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    rb_key_description character varying(1024) DEFAULT NULL::character varying,
    rb_key_validation_message character varying(1024) DEFAULT NULL::character varying,
    sort_order integer DEFAULT 0
);


ALTER TABLE public.x_service_config_def OWNER TO rangeradmin;

--
-- Name: x_service_config_map_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_service_config_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_service_config_map_seq OWNER TO rangeradmin;

--
-- Name: x_service_config_map; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_service_config_map (
    id bigint DEFAULT nextval('public.x_service_config_map_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    service bigint NOT NULL,
    config_key character varying(1024) DEFAULT NULL::character varying,
    config_value character varying(4000) DEFAULT NULL::character varying
);


ALTER TABLE public.x_service_config_map OWNER TO rangeradmin;

--
-- Name: x_service_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_service_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_service_def_seq OWNER TO rangeradmin;

--
-- Name: x_service_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_service_def (
    id bigint DEFAULT nextval('public.x_service_def_seq'::regclass) NOT NULL,
    guid character varying(1024) DEFAULT NULL::character varying,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    name character varying(1024) DEFAULT NULL::character varying,
    display_name character varying(1024) DEFAULT NULL::character varying,
    impl_class_name character varying(1024) DEFAULT NULL::character varying,
    label character varying(1024) DEFAULT NULL::character varying,
    description character varying(1024) DEFAULT NULL::character varying,
    rb_key_label character varying(1024) DEFAULT NULL::character varying,
    rb_key_description character varying(1024) DEFAULT NULL::character varying,
    is_enabled boolean DEFAULT true,
    def_options character varying(1024) DEFAULT NULL::character varying
);


ALTER TABLE public.x_service_def OWNER TO rangeradmin;

--
-- Name: x_service_resource_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_service_resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_service_resource_seq OWNER TO rangeradmin;

--
-- Name: x_service_resource; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_service_resource (
    id bigint DEFAULT nextval('public.x_service_resource_seq'::regclass) NOT NULL,
    guid character varying(64) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    service_id bigint NOT NULL,
    resource_signature character varying(128) DEFAULT NULL::character varying,
    is_enabled boolean DEFAULT true NOT NULL,
    service_resource_elements_text text,
    tags_text text
);


ALTER TABLE public.x_service_resource OWNER TO rangeradmin;

--
-- Name: x_service_version_info_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_service_version_info_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_service_version_info_seq OWNER TO rangeradmin;

--
-- Name: x_service_version_info; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_service_version_info (
    id bigint DEFAULT nextval('public.x_service_version_info_seq'::regclass) NOT NULL,
    service_id bigint NOT NULL,
    policy_version bigint DEFAULT '0'::bigint NOT NULL,
    policy_update_time timestamp without time zone,
    tag_version bigint DEFAULT '0'::bigint NOT NULL,
    tag_update_time timestamp without time zone,
    role_version bigint DEFAULT '0'::bigint NOT NULL,
    role_update_time timestamp without time zone,
    version bigint DEFAULT '1'::bigint NOT NULL
);


ALTER TABLE public.x_service_version_info OWNER TO rangeradmin;

--
-- Name: x_tag_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_tag_seq OWNER TO rangeradmin;

--
-- Name: x_tag; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_tag (
    id bigint DEFAULT nextval('public.x_tag_seq'::regclass) NOT NULL,
    guid character varying(64) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    type bigint NOT NULL,
    owned_by smallint DEFAULT 0 NOT NULL,
    policy_options character varying(4000) DEFAULT NULL::character varying,
    tag_attrs_text text
);


ALTER TABLE public.x_tag OWNER TO rangeradmin;

--
-- Name: x_tag_change_log_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_tag_change_log_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_tag_change_log_seq OWNER TO rangeradmin;

--
-- Name: x_tag_change_log; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_tag_change_log (
    id bigint DEFAULT nextval('public.x_tag_change_log_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    service_id bigint NOT NULL,
    change_type integer NOT NULL,
    service_tags_version bigint DEFAULT '0'::bigint NOT NULL,
    service_resource_id bigint,
    tag_id bigint
);


ALTER TABLE public.x_tag_change_log OWNER TO rangeradmin;

--
-- Name: x_tag_def_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_tag_def_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_tag_def_seq OWNER TO rangeradmin;

--
-- Name: x_tag_def; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_tag_def (
    id bigint DEFAULT nextval('public.x_tag_def_seq'::regclass) NOT NULL,
    guid character varying(64) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    version bigint,
    name character varying(255) NOT NULL,
    source character varying(128) DEFAULT NULL::character varying,
    is_enabled boolean DEFAULT false NOT NULL,
    tag_attrs_def_text text
);


ALTER TABLE public.x_tag_def OWNER TO rangeradmin;

--
-- Name: x_tag_resource_map; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_tag_resource_map (
    id bigint NOT NULL,
    guid character varying(64) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    tag_id bigint NOT NULL,
    res_id bigint NOT NULL
);


ALTER TABLE public.x_tag_resource_map OWNER TO rangeradmin;

--
-- Name: x_tag_resource_map_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_tag_resource_map_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_tag_resource_map_seq OWNER TO rangeradmin;

--
-- Name: x_ugsync_audit_info_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_ugsync_audit_info_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_ugsync_audit_info_seq OWNER TO rangeradmin;

--
-- Name: x_ugsync_audit_info; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_ugsync_audit_info (
    id bigint DEFAULT nextval('public.x_ugsync_audit_info_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    event_time timestamp without time zone,
    user_name character varying(255) NOT NULL,
    sync_source character varying(128) NOT NULL,
    no_of_new_users bigint NOT NULL,
    no_of_new_groups bigint NOT NULL,
    no_of_modified_users bigint NOT NULL,
    no_of_modified_groups bigint NOT NULL,
    sync_source_info text NOT NULL,
    session_id character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.x_ugsync_audit_info OWNER TO rangeradmin;

--
-- Name: x_user_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_user_seq OWNER TO rangeradmin;

--
-- Name: x_user; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_user (
    id bigint DEFAULT nextval('public.x_user_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    user_name character varying(767) NOT NULL,
    descr text,
    status integer DEFAULT 0 NOT NULL,
    cred_store_id bigint,
    is_visible integer DEFAULT 1 NOT NULL,
    other_attributes text,
    sync_source text
);


ALTER TABLE public.x_user OWNER TO rangeradmin;

--
-- Name: x_user_module_perm_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.x_user_module_perm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.x_user_module_perm_seq OWNER TO rangeradmin;

--
-- Name: x_user_module_perm; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.x_user_module_perm (
    id bigint DEFAULT nextval('public.x_user_module_perm_seq'::regclass) NOT NULL,
    user_id bigint,
    module_id bigint,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    is_allowed integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.x_user_module_perm OWNER TO rangeradmin;

--
-- Name: xa_access_audit_seq; Type: SEQUENCE; Schema: public; Owner: rangeradmin
--

CREATE SEQUENCE public.xa_access_audit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.xa_access_audit_seq OWNER TO rangeradmin;

--
-- Name: xa_access_audit; Type: TABLE; Schema: public; Owner: rangeradmin
--

CREATE TABLE public.xa_access_audit (
    id bigint DEFAULT nextval('public.xa_access_audit_seq'::regclass) NOT NULL,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    added_by_id bigint,
    upd_by_id bigint,
    audit_type integer DEFAULT 0 NOT NULL,
    access_result integer DEFAULT 0,
    access_type character varying(255) DEFAULT NULL::character varying,
    acl_enforcer character varying(255) DEFAULT NULL::character varying,
    agent_id character varying(255) DEFAULT NULL::character varying,
    client_ip character varying(255) DEFAULT NULL::character varying,
    client_type character varying(255) DEFAULT NULL::character varying,
    policy_id bigint DEFAULT '0'::bigint,
    repo_name character varying(255) DEFAULT NULL::character varying,
    repo_type bigint DEFAULT '0'::bigint,
    result_reason character varying(255) DEFAULT NULL::character varying,
    session_id character varying(255) DEFAULT NULL::character varying,
    event_time timestamp without time zone,
    request_user character varying(255) DEFAULT NULL::character varying,
    action character varying(2000) DEFAULT NULL::character varying,
    request_data character varying(4000) DEFAULT NULL::character varying,
    resource_path character varying(4000) DEFAULT NULL::character varying,
    resource_type character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.xa_access_audit OWNER TO rangeradmin;

--
-- Name: x_db_version_h id; Type: DEFAULT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_db_version_h ALTER COLUMN id SET DEFAULT nextval('public.x_db_version_h_id_seq'::regclass);


--
-- Data for Name: x_access_type_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_access_type_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, label, rb_key_label, sort_order, datamask_options, rowfilter_options) FROM stdin;
1	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.423	\N	\N	1	1	read	Read	\N	0	\N	\N
2	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.425	\N	\N	1	2	write	Write	\N	1	\N	\N
3	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.426	\N	\N	1	3	execute	Execute	\N	2	\N	\N
4	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.516	\N	\N	2	1	read	Read	\N	0	\N	\N
5	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.518	\N	\N	2	2	write	Write	\N	1	\N	\N
6	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.519	\N	\N	2	3	create	Create	\N	2	\N	\N
7	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.52	\N	\N	2	4	admin	Admin	\N	3	\N	\N
8	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.525	\N	\N	2	5	execute	Execute	\N	4	\N	\N
10	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.57	\N	\N	3	2	update	update	\N	1	\N	\N
11	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.571	\N	\N	3	3	create	Create	\N	2	\N	\N
12	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.571	\N	\N	3	4	drop	Drop	\N	3	\N	\N
13	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.572	\N	\N	3	5	alter	Alter	\N	4	\N	\N
14	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.573	\N	\N	3	6	index	Index	\N	5	\N	\N
15	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.574	\N	\N	3	7	lock	Lock	\N	6	\N	\N
16	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.574	\N	\N	3	8	all	All	\N	7	\N	\N
17	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.586	\N	\N	3	9	read	Read	\N	8	\N	\N
18	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.587	\N	\N	3	10	write	Write	\N	9	\N	\N
19	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.587	\N	\N	3	11	repladmin	ReplAdmin	\N	10	\N	\N
20	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.588	\N	\N	3	12	serviceadmin	Service Admin	\N	11	\N	\N
21	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.589	\N	\N	3	13	tempudfadmin	Temporary UDF Admin	\N	12	\N	\N
22	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.589	\N	\N	3	14	refresh	Refresh	\N	13	\N	\N
9	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.605	\N	\N	3	1	select	select	\N	0	{"itemId":1,"name":"select","label":"select"}	{"itemId":1,"name":"select","label":"select"}
23	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.652	\N	\N	7	1	create	Create	\N	0	\N	\N
24	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.653	\N	\N	7	2	delete	Delete	\N	1	\N	\N
25	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.654	\N	\N	7	3	rollover	Rollover	\N	2	\N	\N
26	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.655	\N	\N	7	4	setkeymaterial	Set Key Material	\N	3	\N	\N
27	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.657	\N	\N	7	5	get	Get	\N	4	\N	\N
28	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.66	\N	\N	7	6	getkeys	Get Keys	\N	5	\N	\N
29	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.661	\N	\N	7	7	getmetadata	Get Metadata	\N	6	\N	\N
30	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.662	\N	\N	7	8	generateeek	Generate EEK	\N	7	\N	\N
31	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.663	\N	\N	7	9	decrypteek	Decrypt EEK	\N	8	\N	\N
32	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.684	\N	\N	5	1	allow	Allow	\N	0	\N	\N
33	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.706	\N	\N	6	1	submitTopology	Submit Topology	\N	0	\N	\N
34	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.708	\N	\N	6	2	fileUpload	File Upload	\N	1	\N	\N
35	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.709	\N	\N	6	5	fileDownload	File Download	\N	2	\N	\N
36	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.709	\N	\N	6	6	killTopology	Kill Topology	\N	3	\N	\N
37	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.71	\N	\N	6	7	rebalance	Rebalance	\N	4	\N	\N
38	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.71	\N	\N	6	8	activate	Activate	\N	5	\N	\N
39	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.711	\N	\N	6	9	deactivate	Deactivate	\N	6	\N	\N
40	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.712	\N	\N	6	10	getTopologyConf	Get Topology Conf	\N	7	\N	\N
41	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.712	\N	\N	6	11	getTopology	Get Topology	\N	8	\N	\N
42	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.713	\N	\N	6	12	getUserTopology	Get User Topology	\N	9	\N	\N
43	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.714	\N	\N	6	13	getTopologyInfo	Get Topology Info	\N	10	\N	\N
44	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.715	\N	\N	6	14	uploadNewCredentials	Upload New Credential	\N	11	\N	\N
45	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.746	\N	\N	4	1	submit-app	submit-app	\N	0	\N	\N
46	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.746	\N	\N	4	2	admin-queue	admin-queue	\N	1	\N	\N
47	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.767	\N	\N	9	1	publish	Publish	\N	0	\N	\N
48	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.768	\N	\N	9	2	consume	Consume	\N	1	\N	\N
49	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.769	\N	\N	9	5	configure	Configure	\N	2	\N	\N
50	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.769	\N	\N	9	6	describe	Describe	\N	3	\N	\N
51	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.77	\N	\N	9	7	kafka_admin	Kafka Admin	\N	4	\N	\N
52	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.776	\N	\N	9	8	create	Create	\N	5	\N	\N
53	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.777	\N	\N	9	9	delete	Delete	\N	6	\N	\N
54	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.778	\N	\N	9	10	idempotent_write	Idempotent Write	\N	7	\N	\N
55	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.778	\N	\N	9	11	describe_configs	Describe Configs	\N	8	\N	\N
56	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.779	\N	\N	9	12	alter_configs	Alter Configs	\N	9	\N	\N
57	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.78	\N	\N	9	13	cluster_action	Cluster Action	\N	10	\N	\N
58	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.78	\N	\N	9	14	alter	Alter	\N	11	\N	\N
59	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.801	\N	\N	8	100	query	Query	\N	0	\N	\N
60	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.801	\N	\N	8	200	update	Update	\N	1	\N	\N
61	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.823	\N	\N	202	1	create	Create	\N	0	\N	\N
62	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.823	\N	\N	202	2	read	Read	\N	1	\N	\N
63	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.824	\N	\N	202	3	update	Update	\N	2	\N	\N
64	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.824	\N	\N	202	4	delete	Delete	\N	3	\N	\N
65	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.855	\N	\N	10	100	READ	Read	\N	0	\N	\N
66	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.857	\N	\N	10	200	WRITE	Write	\N	1	\N	\N
67	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.879	\N	\N	13	100	READ	Read	\N	0	\N	\N
68	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.88	\N	\N	13	200	WRITE	Write	\N	1	\N	\N
69	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.881	\N	\N	13	300	DELETE	Delete	\N	2	\N	\N
70	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.92	\N	\N	15	1	type-create	Create Type	\N	0	\N	\N
71	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.921	\N	\N	15	2	type-update	Update Type	\N	1	\N	\N
72	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.923	\N	\N	15	3	type-delete	Delete Type	\N	2	\N	\N
73	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.924	\N	\N	15	4	entity-read	Read Entity	\N	3	\N	\N
74	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.924	\N	\N	15	5	entity-create	Create Entity	\N	4	\N	\N
75	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.925	\N	\N	15	6	entity-update	Update Entity	\N	5	\N	\N
76	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.925	\N	\N	15	7	entity-delete	Delete Entity	\N	6	\N	\N
77	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.926	\N	\N	15	8	entity-add-classification	Add Classification	\N	7	\N	\N
78	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.926	\N	\N	15	9	entity-update-classification	Update Classification	\N	8	\N	\N
79	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.927	\N	\N	15	10	entity-remove-classification	Remove Classification	\N	9	\N	\N
80	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.927	\N	\N	15	11	admin-export	Admin Export	\N	10	\N	\N
81	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.928	\N	\N	15	12	admin-import	Admin Import	\N	11	\N	\N
82	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.928	\N	\N	15	13	add-relationship	Add Relationship	\N	12	\N	\N
83	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.929	\N	\N	15	14	update-relationship	Update Relationship	\N	13	\N	\N
84	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.929	\N	\N	15	15	remove-relationship	Remove Relationship	\N	14	\N	\N
85	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.93	\N	\N	15	16	admin-purge	Admin Purge	\N	15	\N	\N
86	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.93	\N	\N	15	17	entity-add-label	Add Label	\N	16	\N	\N
87	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.931	\N	\N	15	18	entity-remove-label	Remove Label	\N	17	\N	\N
88	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.931	\N	\N	15	19	entity-update-business-metadata	Update Business Metadata	\N	18	\N	\N
89	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.932	\N	\N	15	20	type-read	Read Type	\N	19	\N	\N
90	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.932	\N	\N	15	21	admin-audits	Admin Audits	\N	20	\N	\N
91	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.968	\N	\N	14	1	READ	READ	\N	0	\N	\N
92	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.969	\N	\N	14	2	WRITE	WRITE	\N	1	\N	\N
95	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.027	\N	\N	12	1	QUERY	QUERY	\N	0	\N	\N
96	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.028	\N	\N	12	2	OPERATION	OPERATION	\N	1	\N	\N
97	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.028	\N	\N	12	3	MANAGEMENT	MANAGEMENT	\N	2	\N	\N
98	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.029	\N	\N	12	4	ADMIN	ADMIN	\N	3	\N	\N
103	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.064	\N	\N	16	1	all	all	\N	0	\N	\N
104	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.072	\N	\N	16	2	monitor	monitor	\N	1	\N	\N
105	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.073	\N	\N	16	3	manage	manage	\N	2	\N	\N
106	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.073	\N	\N	16	4	view_index_metadata	view_index_metadata	\N	3	\N	\N
107	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.075	\N	\N	16	5	read	read	\N	4	\N	\N
108	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.075	\N	\N	16	6	read_cross_cluster	read_cross_cluster	\N	5	\N	\N
109	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.077	\N	\N	16	7	index	index	\N	6	\N	\N
110	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.079	\N	\N	16	8	create	create	\N	7	\N	\N
111	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.081	\N	\N	16	9	delete	delete	\N	8	\N	\N
112	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.082	\N	\N	16	10	write	write	\N	9	\N	\N
113	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.083	\N	\N	16	11	delete_index	delete_index	\N	10	\N	\N
114	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.084	\N	\N	16	12	create_index	create_index	\N	11	\N	\N
128	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.148	\N	\N	203	2	insert	Insert	\N	1	\N	\N
129	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.148	\N	\N	203	3	create	Create	\N	2	\N	\N
130	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.149	\N	\N	203	4	drop	Drop	\N	3	\N	\N
131	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.149	\N	\N	203	5	delete	Delete	\N	4	\N	\N
132	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.15	\N	\N	203	6	use	Use	\N	5	\N	\N
133	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.15	\N	\N	203	7	alter	Alter	\N	6	\N	\N
134	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.151	\N	\N	203	8	grant	Grant	\N	7	\N	\N
135	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.151	\N	\N	203	9	revoke	Revoke	\N	8	\N	\N
136	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.152	\N	\N	203	10	show	Show	\N	9	\N	\N
137	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.152	\N	\N	203	11	impersonate	Impersonate	\N	10	\N	\N
138	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.153	\N	\N	203	12	all	All	\N	11	\N	\N
139	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.159	\N	\N	203	13	execute	execute	\N	12	\N	\N
127	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.165	\N	\N	203	1	select	Select	\N	0	{"itemId":1,"name":"select","label":"Select"}	{"itemId":1,"name":"select","label":"Select"}
154	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.264	\N	\N	17	2	insert	Insert	\N	1	\N	\N
155	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.265	\N	\N	17	3	create	Create	\N	2	\N	\N
156	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.265	\N	\N	17	4	drop	Drop	\N	3	\N	\N
157	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.266	\N	\N	17	5	delete	Delete	\N	4	\N	\N
158	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.266	\N	\N	17	6	use	Use	\N	5	\N	\N
159	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.267	\N	\N	17	7	alter	Alter	\N	6	\N	\N
160	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.267	\N	\N	17	8	grant	Grant	\N	7	\N	\N
161	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.268	\N	\N	17	9	revoke	Revoke	\N	8	\N	\N
162	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.268	\N	\N	17	10	show	Show	\N	9	\N	\N
163	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.269	\N	\N	17	11	impersonate	Impersonate	\N	10	\N	\N
164	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.269	\N	\N	17	12	all	All	\N	11	\N	\N
165	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.276	\N	\N	17	13	execute	execute	\N	12	\N	\N
153	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.281	\N	\N	17	1	select	Select	\N	0	{"itemId":1,"name":"select","label":"Select"}	{"itemId":1,"name":"select","label":"Select"}
179	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.397	\N	\N	201	8	all	All	\N	0	\N	\N
180	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.401	\N	\N	201	1	read	Read	\N	1	\N	\N
181	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.402	\N	\N	201	2	write	Write	\N	2	\N	\N
182	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.402	\N	\N	201	3	create	Create	\N	3	\N	\N
183	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.403	\N	\N	201	4	list	List	\N	4	\N	\N
184	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.403	\N	\N	201	5	delete	Delete	\N	5	\N	\N
185	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.404	\N	\N	201	6	read_acl	Read_ACL	\N	6	\N	\N
186	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.405	\N	\N	201	7	write_acl	Write_ACL	\N	7	\N	\N
195	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.527	\N	\N	105	1	select	SELECT	\N	0	\N	\N
196	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.529	\N	\N	105	2	insert	INSERT	\N	1	\N	\N
197	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.53	\N	\N	105	3	update	UPDATE	\N	2	\N	\N
198	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.531	\N	\N	105	4	delete	DELETE	\N	3	\N	\N
199	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.533	\N	\N	105	5	alter	ALTER	\N	4	\N	\N
200	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.535	\N	\N	105	6	create	CREATE	\N	5	\N	\N
201	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.536	\N	\N	105	7	drop	DROP	\N	6	\N	\N
202	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.538	\N	\N	105	8	metadata	METADATA	\N	7	\N	\N
203	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.539	\N	\N	105	9	all	ALL	\N	8	\N	\N
213	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.698	\N	\N	205	1	read	Read	\N	0	{"itemId":1,"name":"read","label":"Read"}	{"itemId":1,"name":"read","label":"Read"}
214	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.699	\N	\N	205	2	write	Write	\N	1	\N	{"itemId":2,"name":"write","label":"Write"}
93	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.378	\N	\N	100	14015	sqoop:READ	READ	\N	0	\N	\N
94	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.381	\N	\N	100	14016	sqoop:WRITE	WRITE	\N	1	\N	\N
99	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.384	\N	\N	100	12013	kylin:QUERY	QUERY	\N	2	\N	\N
100	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.386	\N	\N	100	12014	kylin:OPERATION	OPERATION	\N	3	\N	\N
101	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.389	\N	\N	100	12015	kylin:MANAGEMENT	MANAGEMENT	\N	4	\N	\N
102	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.393	\N	\N	100	12016	kylin:ADMIN	ADMIN	\N	5	\N	\N
115	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.396	\N	\N	100	16017	elasticsearch:all	all	\N	6	\N	\N
116	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.398	\N	\N	100	16018	elasticsearch:monitor	monitor	\N	7	\N	\N
117	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.4	\N	\N	100	16019	elasticsearch:manage	manage	\N	8	\N	\N
118	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.403	\N	\N	100	16020	elasticsearch:view_index_metadata	view_index_metadata	\N	9	\N	\N
119	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.405	\N	\N	100	16021	elasticsearch:read	read	\N	10	\N	\N
120	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.407	\N	\N	100	16022	elasticsearch:read_cross_cluster	read_cross_cluster	\N	11	\N	\N
121	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.409	\N	\N	100	16023	elasticsearch:index	index	\N	12	\N	\N
122	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.412	\N	\N	100	16024	elasticsearch:create	create	\N	13	\N	\N
123	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.415	\N	\N	100	16025	elasticsearch:delete	delete	\N	14	\N	\N
124	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.417	\N	\N	100	16026	elasticsearch:write	write	\N	15	\N	\N
125	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.418	\N	\N	100	16027	elasticsearch:delete_index	delete_index	\N	16	\N	\N
126	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.42	\N	\N	100	16028	elasticsearch:create_index	create_index	\N	17	\N	\N
140	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.423	\N	\N	100	203204	trino:select	Select	\N	18	{"itemId":203204,"name":"trino:select","label":"Select"}	\N
141	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.425	\N	\N	100	203205	trino:insert	Insert	\N	19	\N	\N
142	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.427	\N	\N	100	203206	trino:create	Create	\N	20	\N	\N
143	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.429	\N	\N	100	203207	trino:drop	Drop	\N	21	\N	\N
144	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.431	\N	\N	100	203208	trino:delete	Delete	\N	22	\N	\N
145	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.433	\N	\N	100	203209	trino:use	Use	\N	23	\N	\N
146	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.435	\N	\N	100	203210	trino:alter	Alter	\N	24	\N	\N
147	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.437	\N	\N	100	203211	trino:grant	Grant	\N	25	\N	\N
148	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.439	\N	\N	100	203212	trino:revoke	Revoke	\N	26	\N	\N
149	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.442	\N	\N	100	203213	trino:show	Show	\N	27	\N	\N
150	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.444	\N	\N	100	203214	trino:impersonate	Impersonate	\N	28	\N	\N
151	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.446	\N	\N	100	203215	trino:all	All	\N	29	\N	\N
152	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.448	\N	\N	100	203216	trino:execute	execute	\N	30	\N	\N
166	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.451	\N	\N	100	17018	presto:select	Select	\N	31	{"itemId":17018,"name":"presto:select","label":"Select"}	\N
167	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.453	\N	\N	100	17019	presto:insert	Insert	\N	32	\N	\N
168	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.456	\N	\N	100	17020	presto:create	Create	\N	33	\N	\N
169	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.458	\N	\N	100	17021	presto:drop	Drop	\N	34	\N	\N
170	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.461	\N	\N	100	17022	presto:delete	Delete	\N	35	\N	\N
171	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.463	\N	\N	100	17023	presto:use	Use	\N	36	\N	\N
172	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.465	\N	\N	100	17024	presto:alter	Alter	\N	37	\N	\N
173	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.467	\N	\N	100	17025	presto:grant	Grant	\N	38	\N	\N
174	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.469	\N	\N	100	17026	presto:revoke	Revoke	\N	39	\N	\N
175	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.471	\N	\N	100	17027	presto:show	Show	\N	40	\N	\N
176	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.473	\N	\N	100	17028	presto:impersonate	Impersonate	\N	41	\N	\N
177	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.475	\N	\N	100	17029	presto:all	All	\N	42	\N	\N
178	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.476	\N	\N	100	17030	presto:execute	execute	\N	43	\N	\N
187	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.478	\N	\N	100	201209	ozone:all	All	\N	44	\N	\N
188	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.48	\N	\N	100	201202	ozone:read	Read	\N	45	\N	\N
189	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.482	\N	\N	100	201203	ozone:write	Write	\N	46	\N	\N
190	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.484	\N	\N	100	201204	ozone:create	Create	\N	47	\N	\N
191	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.485	\N	\N	100	201205	ozone:list	List	\N	48	\N	\N
192	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.487	\N	\N	100	201206	ozone:delete	Delete	\N	49	\N	\N
193	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.488	\N	\N	100	201207	ozone:read_acl	Read_ACL	\N	50	\N	\N
194	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.49	\N	\N	100	201208	ozone:write_acl	Write_ACL	\N	51	\N	\N
204	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.492	\N	\N	100	105106	kudu:select	SELECT	\N	52	\N	\N
205	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.493	\N	\N	100	105107	kudu:insert	INSERT	\N	53	\N	\N
206	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.496	\N	\N	100	105108	kudu:update	UPDATE	\N	54	\N	\N
207	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.498	\N	\N	100	105109	kudu:delete	DELETE	\N	55	\N	\N
208	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.501	\N	\N	100	105110	kudu:alter	ALTER	\N	56	\N	\N
209	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.503	\N	\N	100	105111	kudu:create	CREATE	\N	57	\N	\N
210	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.505	\N	\N	100	105112	kudu:drop	DROP	\N	58	\N	\N
211	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.508	\N	\N	100	105113	kudu:metadata	METADATA	\N	59	\N	\N
212	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.511	\N	\N	100	105114	kudu:all	ALL	\N	60	\N	\N
215	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.513	\N	\N	100	205206	nestedstructure:read	Read	\N	61	{"itemId":205206,"name":"nestedstructure:read","label":"Read"}	\N
216	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.516	\N	\N	100	205207	nestedstructure:write	Write	\N	62	\N	\N
217	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.518	\N	\N	100	1002	hdfs:read	Read	\N	63	\N	\N
218	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.52	\N	\N	100	1003	hdfs:write	Write	\N	64	\N	\N
219	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.522	\N	\N	100	1004	hdfs:execute	Execute	\N	65	\N	\N
220	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.524	\N	\N	100	2003	hbase:read	Read	\N	66	\N	\N
221	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.525	\N	\N	100	2004	hbase:write	Write	\N	67	\N	\N
222	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.527	\N	\N	100	2005	hbase:create	Create	\N	68	\N	\N
223	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.529	\N	\N	100	2006	hbase:admin	Admin	\N	69	\N	\N
224	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.531	\N	\N	100	2007	hbase:execute	Execute	\N	70	\N	\N
225	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.533	\N	\N	100	3004	hive:select	select	\N	71	{"itemId":3004,"name":"hive:select","label":"select"}	\N
226	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.536	\N	\N	100	3005	hive:update	update	\N	72	\N	\N
227	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.538	\N	\N	100	3006	hive:create	Create	\N	73	\N	\N
228	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.541	\N	\N	100	3007	hive:drop	Drop	\N	74	\N	\N
229	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.543	\N	\N	100	3008	hive:alter	Alter	\N	75	\N	\N
230	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.546	\N	\N	100	3009	hive:index	Index	\N	76	\N	\N
231	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.548	\N	\N	100	3010	hive:lock	Lock	\N	77	\N	\N
232	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.55	\N	\N	100	3011	hive:all	All	\N	78	\N	\N
233	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.554	\N	\N	100	3012	hive:read	Read	\N	79	\N	\N
234	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.555	\N	\N	100	3013	hive:write	Write	\N	80	\N	\N
235	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.558	\N	\N	100	3014	hive:repladmin	ReplAdmin	\N	81	\N	\N
236	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.563	\N	\N	100	3015	hive:serviceadmin	Service Admin	\N	82	\N	\N
237	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.566	\N	\N	100	3016	hive:tempudfadmin	Temporary UDF Admin	\N	83	\N	\N
238	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.569	\N	\N	100	3017	hive:refresh	Refresh	\N	84	\N	\N
239	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.572	\N	\N	100	7008	kms:create	Create	\N	85	\N	\N
240	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.575	\N	\N	100	7009	kms:delete	Delete	\N	86	\N	\N
241	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.578	\N	\N	100	7010	kms:rollover	Rollover	\N	87	\N	\N
242	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.582	\N	\N	100	7011	kms:setkeymaterial	Set Key Material	\N	88	\N	\N
243	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.585	\N	\N	100	7012	kms:get	Get	\N	89	\N	\N
244	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.588	\N	\N	100	7013	kms:getkeys	Get Keys	\N	90	\N	\N
245	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.591	\N	\N	100	7014	kms:getmetadata	Get Metadata	\N	91	\N	\N
246	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.594	\N	\N	100	7015	kms:generateeek	Generate EEK	\N	92	\N	\N
247	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.596	\N	\N	100	7016	kms:decrypteek	Decrypt EEK	\N	93	\N	\N
248	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.599	\N	\N	100	5006	knox:allow	Allow	\N	94	\N	\N
249	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.601	\N	\N	100	6007	storm:submitTopology	Submit Topology	\N	95	\N	\N
250	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.603	\N	\N	100	6008	storm:fileUpload	File Upload	\N	96	\N	\N
251	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.606	\N	\N	100	6011	storm:fileDownload	File Download	\N	97	\N	\N
252	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.608	\N	\N	100	6012	storm:killTopology	Kill Topology	\N	98	\N	\N
253	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.61	\N	\N	100	6013	storm:rebalance	Rebalance	\N	99	\N	\N
254	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.612	\N	\N	100	6014	storm:activate	Activate	\N	100	\N	\N
255	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.614	\N	\N	100	6015	storm:deactivate	Deactivate	\N	101	\N	\N
256	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.616	\N	\N	100	6016	storm:getTopologyConf	Get Topology Conf	\N	102	\N	\N
257	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.617	\N	\N	100	6017	storm:getTopology	Get Topology	\N	103	\N	\N
258	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.62	\N	\N	100	6018	storm:getUserTopology	Get User Topology	\N	104	\N	\N
259	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.622	\N	\N	100	6019	storm:getTopologyInfo	Get Topology Info	\N	105	\N	\N
260	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.624	\N	\N	100	6020	storm:uploadNewCredentials	Upload New Credential	\N	106	\N	\N
261	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.627	\N	\N	100	4005	yarn:submit-app	submit-app	\N	107	\N	\N
262	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.629	\N	\N	100	4006	yarn:admin-queue	admin-queue	\N	108	\N	\N
263	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.631	\N	\N	100	9010	kafka:publish	Publish	\N	109	\N	\N
264	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.633	\N	\N	100	9011	kafka:consume	Consume	\N	110	\N	\N
265	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.634	\N	\N	100	9014	kafka:configure	Configure	\N	111	\N	\N
266	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.636	\N	\N	100	9015	kafka:describe	Describe	\N	112	\N	\N
267	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.638	\N	\N	100	9016	kafka:kafka_admin	Kafka Admin	\N	113	\N	\N
268	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.641	\N	\N	100	9017	kafka:create	Create	\N	114	\N	\N
269	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.643	\N	\N	100	9018	kafka:delete	Delete	\N	115	\N	\N
270	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.645	\N	\N	100	9019	kafka:idempotent_write	Idempotent Write	\N	116	\N	\N
271	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.647	\N	\N	100	9020	kafka:describe_configs	Describe Configs	\N	117	\N	\N
272	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.649	\N	\N	100	9021	kafka:alter_configs	Alter Configs	\N	118	\N	\N
273	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.651	\N	\N	100	9022	kafka:cluster_action	Cluster Action	\N	119	\N	\N
274	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.653	\N	\N	100	9023	kafka:alter	Alter	\N	120	\N	\N
275	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.656	\N	\N	100	8108	solr:query	Query	\N	121	\N	\N
276	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.658	\N	\N	100	8208	solr:update	Update	\N	122	\N	\N
277	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.661	\N	\N	100	202203	schema-registry:create	Create	\N	123	\N	\N
278	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.664	\N	\N	100	202204	schema-registry:read	Read	\N	124	\N	\N
279	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.666	\N	\N	100	202205	schema-registry:update	Update	\N	125	\N	\N
280	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.669	\N	\N	100	202206	schema-registry:delete	Delete	\N	126	\N	\N
281	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.672	\N	\N	100	10110	nifi:READ	Read	\N	127	\N	\N
282	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.674	\N	\N	100	10210	nifi:WRITE	Write	\N	128	\N	\N
283	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.677	\N	\N	100	13113	nifi-registry:READ	Read	\N	129	\N	\N
284	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.679	\N	\N	100	13213	nifi-registry:WRITE	Write	\N	130	\N	\N
285	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.682	\N	\N	100	13313	nifi-registry:DELETE	Delete	\N	131	\N	\N
286	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.684	\N	\N	100	15016	atlas:type-create	Create Type	\N	132	\N	\N
287	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.686	\N	\N	100	15017	atlas:type-update	Update Type	\N	133	\N	\N
288	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.689	\N	\N	100	15018	atlas:type-delete	Delete Type	\N	134	\N	\N
289	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.692	\N	\N	100	15019	atlas:entity-read	Read Entity	\N	135	\N	\N
290	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.693	\N	\N	100	15020	atlas:entity-create	Create Entity	\N	136	\N	\N
291	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.695	\N	\N	100	15021	atlas:entity-update	Update Entity	\N	137	\N	\N
292	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.697	\N	\N	100	15022	atlas:entity-delete	Delete Entity	\N	138	\N	\N
293	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.698	\N	\N	100	15023	atlas:entity-add-classification	Add Classification	\N	139	\N	\N
294	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.7	\N	\N	100	15024	atlas:entity-update-classification	Update Classification	\N	140	\N	\N
295	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.701	\N	\N	100	15025	atlas:entity-remove-classification	Remove Classification	\N	141	\N	\N
296	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.703	\N	\N	100	15026	atlas:admin-export	Admin Export	\N	142	\N	\N
297	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.705	\N	\N	100	15027	atlas:admin-import	Admin Import	\N	143	\N	\N
298	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.707	\N	\N	100	15028	atlas:add-relationship	Add Relationship	\N	144	\N	\N
299	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.709	\N	\N	100	15029	atlas:update-relationship	Update Relationship	\N	145	\N	\N
300	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.711	\N	\N	100	15030	atlas:remove-relationship	Remove Relationship	\N	146	\N	\N
301	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.713	\N	\N	100	15031	atlas:admin-purge	Admin Purge	\N	147	\N	\N
302	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.714	\N	\N	100	15032	atlas:entity-add-label	Add Label	\N	148	\N	\N
303	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.715	\N	\N	100	15033	atlas:entity-remove-label	Remove Label	\N	149	\N	\N
304	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.717	\N	\N	100	15034	atlas:entity-update-business-metadata	Update Business Metadata	\N	150	\N	\N
305	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.718	\N	\N	100	15035	atlas:type-read	Read Type	\N	151	\N	\N
306	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.72	\N	\N	100	15036	atlas:admin-audits	Admin Audits	\N	152	\N	\N
\.


--
-- Data for Name: x_access_type_def_grants; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_access_type_def_grants (id, guid, create_time, update_time, added_by_id, upd_by_id, atd_id, implied_grant) FROM stdin;
1	\N	2024-02-08 17:01:08.521	2024-02-08 17:01:08.522	\N	\N	7	read
2	\N	2024-02-08 17:01:08.523	2024-02-08 17:01:08.523	\N	\N	7	write
3	\N	2024-02-08 17:01:08.523	2024-02-08 17:01:08.524	\N	\N	7	create
4	\N	2024-02-08 17:01:08.575	2024-02-08 17:01:08.575	\N	\N	16	select
5	\N	2024-02-08 17:01:08.576	2024-02-08 17:01:08.576	\N	\N	16	update
6	\N	2024-02-08 17:01:08.577	2024-02-08 17:01:08.577	\N	\N	16	create
7	\N	2024-02-08 17:01:08.578	2024-02-08 17:01:08.579	\N	\N	16	drop
8	\N	2024-02-08 17:01:08.579	2024-02-08 17:01:08.58	\N	\N	16	alter
9	\N	2024-02-08 17:01:08.581	2024-02-08 17:01:08.581	\N	\N	16	index
10	\N	2024-02-08 17:01:08.582	2024-02-08 17:01:08.582	\N	\N	16	lock
11	\N	2024-02-08 17:01:08.582	2024-02-08 17:01:08.583	\N	\N	16	read
12	\N	2024-02-08 17:01:08.583	2024-02-08 17:01:08.583	\N	\N	16	write
13	\N	2024-02-08 17:01:08.584	2024-02-08 17:01:08.584	\N	\N	16	repladmin
14	\N	2024-02-08 17:01:08.584	2024-02-08 17:01:08.585	\N	\N	16	serviceadmin
15	\N	2024-02-08 17:01:08.585	2024-02-08 17:01:08.585	\N	\N	16	refresh
16	\N	2024-02-08 17:01:08.707	2024-02-08 17:01:08.707	\N	\N	33	fileUpload
17	\N	2024-02-08 17:01:08.707	2024-02-08 17:01:08.707	\N	\N	33	fileDownload
18	\N	2024-02-08 17:01:08.747	2024-02-08 17:01:08.747	\N	\N	46	submit-app
19	\N	2024-02-08 17:01:08.767	2024-02-08 17:01:08.767	\N	\N	47	describe
20	\N	2024-02-08 17:01:08.768	2024-02-08 17:01:08.768	\N	\N	48	describe
21	\N	2024-02-08 17:01:08.769	2024-02-08 17:01:08.769	\N	\N	49	describe
22	\N	2024-02-08 17:01:08.77	2024-02-08 17:01:08.77	\N	\N	51	publish
23	\N	2024-02-08 17:01:08.77	2024-02-08 17:01:08.771	\N	\N	51	consume
24	\N	2024-02-08 17:01:08.771	2024-02-08 17:01:08.771	\N	\N	51	configure
25	\N	2024-02-08 17:01:08.771	2024-02-08 17:01:08.771	\N	\N	51	describe
26	\N	2024-02-08 17:01:08.772	2024-02-08 17:01:08.772	\N	\N	51	create
27	\N	2024-02-08 17:01:08.772	2024-02-08 17:01:08.773	\N	\N	51	delete
28	\N	2024-02-08 17:01:08.773	2024-02-08 17:01:08.773	\N	\N	51	describe_configs
29	\N	2024-02-08 17:01:08.774	2024-02-08 17:01:08.774	\N	\N	51	alter_configs
30	\N	2024-02-08 17:01:08.774	2024-02-08 17:01:08.774	\N	\N	51	alter
31	\N	2024-02-08 17:01:08.775	2024-02-08 17:01:08.775	\N	\N	51	idempotent_write
32	\N	2024-02-08 17:01:08.775	2024-02-08 17:01:08.775	\N	\N	51	cluster_action
33	\N	2024-02-08 17:01:08.777	2024-02-08 17:01:08.777	\N	\N	53	describe
34	\N	2024-02-08 17:01:08.779	2024-02-08 17:01:08.779	\N	\N	56	describe_configs
35	\N	2024-02-08 17:01:08.92	2024-02-08 17:01:08.921	\N	\N	70	type-read
36	\N	2024-02-08 17:01:08.922	2024-02-08 17:01:08.922	\N	\N	71	type-read
37	\N	2024-02-08 17:01:08.923	2024-02-08 17:01:08.923	\N	\N	72	type-read
38	\N	2024-02-08 17:01:09.064	2024-02-08 17:01:09.064	\N	\N	103	monitor
39	\N	2024-02-08 17:01:09.065	2024-02-08 17:01:09.065	\N	\N	103	manage
40	\N	2024-02-08 17:01:09.066	2024-02-08 17:01:09.066	\N	\N	103	view_index_metadata
41	\N	2024-02-08 17:01:09.066	2024-02-08 17:01:09.066	\N	\N	103	read
42	\N	2024-02-08 17:01:09.067	2024-02-08 17:01:09.067	\N	\N	103	read_cross_cluster
43	\N	2024-02-08 17:01:09.067	2024-02-08 17:01:09.068	\N	\N	103	index
44	\N	2024-02-08 17:01:09.068	2024-02-08 17:01:09.068	\N	\N	103	create
45	\N	2024-02-08 17:01:09.069	2024-02-08 17:01:09.069	\N	\N	103	delete
46	\N	2024-02-08 17:01:09.069	2024-02-08 17:01:09.069	\N	\N	103	write
47	\N	2024-02-08 17:01:09.069	2024-02-08 17:01:09.069	\N	\N	103	delete_index
48	\N	2024-02-08 17:01:09.07	2024-02-08 17:01:09.07	\N	\N	103	create_index
49	\N	2024-02-08 17:01:09.07	2024-02-08 17:01:09.07	\N	\N	103	indices_put
50	\N	2024-02-08 17:01:09.071	2024-02-08 17:01:09.071	\N	\N	103	indices_search_shards
51	\N	2024-02-08 17:01:09.071	2024-02-08 17:01:09.071	\N	\N	103	indices_bulk
52	\N	2024-02-08 17:01:09.071	2024-02-08 17:01:09.072	\N	\N	103	indices_index
53	\N	2024-02-08 17:01:09.073	2024-02-08 17:01:09.073	\N	\N	105	monitor
54	\N	2024-02-08 17:01:09.074	2024-02-08 17:01:09.074	\N	\N	106	indices_search_shards
55	\N	2024-02-08 17:01:09.076	2024-02-08 17:01:09.076	\N	\N	108	indices_search_shards
56	\N	2024-02-08 17:01:09.077	2024-02-08 17:01:09.077	\N	\N	109	indices_put
57	\N	2024-02-08 17:01:09.078	2024-02-08 17:01:09.078	\N	\N	109	indices_bulk
58	\N	2024-02-08 17:01:09.078	2024-02-08 17:01:09.078	\N	\N	109	indices_index
59	\N	2024-02-08 17:01:09.079	2024-02-08 17:01:09.079	\N	\N	110	indices_put
60	\N	2024-02-08 17:01:09.08	2024-02-08 17:01:09.08	\N	\N	110	indices_bulk
61	\N	2024-02-08 17:01:09.08	2024-02-08 17:01:09.081	\N	\N	110	indices_index
62	\N	2024-02-08 17:01:09.082	2024-02-08 17:01:09.082	\N	\N	111	indices_bulk
63	\N	2024-02-08 17:01:09.083	2024-02-08 17:01:09.083	\N	\N	112	indices_put
64	\N	2024-02-08 17:01:09.104	2024-02-08 17:01:09.104	\N	\N	115	elasticsearch:monitor
65	\N	2024-02-08 17:01:09.105	2024-02-08 17:01:09.105	\N	\N	115	elasticsearch:manage
66	\N	2024-02-08 17:01:09.105	2024-02-08 17:01:09.105	\N	\N	115	elasticsearch:view_index_metadata
67	\N	2024-02-08 17:01:09.105	2024-02-08 17:01:09.105	\N	\N	115	elasticsearch:read
68	\N	2024-02-08 17:01:09.106	2024-02-08 17:01:09.106	\N	\N	115	elasticsearch:read_cross_cluster
69	\N	2024-02-08 17:01:09.106	2024-02-08 17:01:09.106	\N	\N	115	elasticsearch:index
70	\N	2024-02-08 17:01:09.107	2024-02-08 17:01:09.107	\N	\N	115	elasticsearch:create
71	\N	2024-02-08 17:01:09.107	2024-02-08 17:01:09.107	\N	\N	115	elasticsearch:delete
72	\N	2024-02-08 17:01:09.107	2024-02-08 17:01:09.107	\N	\N	115	elasticsearch:write
73	\N	2024-02-08 17:01:09.108	2024-02-08 17:01:09.108	\N	\N	115	elasticsearch:delete_index
74	\N	2024-02-08 17:01:09.108	2024-02-08 17:01:09.108	\N	\N	115	elasticsearch:create_index
75	\N	2024-02-08 17:01:09.109	2024-02-08 17:01:09.109	\N	\N	115	elasticsearch:indices_put
76	\N	2024-02-08 17:01:09.109	2024-02-08 17:01:09.109	\N	\N	115	elasticsearch:indices_search_shards
77	\N	2024-02-08 17:01:09.109	2024-02-08 17:01:09.109	\N	\N	115	elasticsearch:indices_bulk
78	\N	2024-02-08 17:01:09.11	2024-02-08 17:01:09.11	\N	\N	115	elasticsearch:indices_index
79	\N	2024-02-08 17:01:09.112	2024-02-08 17:01:09.112	\N	\N	117	elasticsearch:monitor
80	\N	2024-02-08 17:01:09.113	2024-02-08 17:01:09.113	\N	\N	118	elasticsearch:indices_search_shards
81	\N	2024-02-08 17:01:09.115	2024-02-08 17:01:09.115	\N	\N	120	elasticsearch:indices_search_shards
82	\N	2024-02-08 17:01:09.116	2024-02-08 17:01:09.116	\N	\N	121	elasticsearch:indices_put
83	\N	2024-02-08 17:01:09.116	2024-02-08 17:01:09.116	\N	\N	121	elasticsearch:indices_bulk
84	\N	2024-02-08 17:01:09.117	2024-02-08 17:01:09.117	\N	\N	121	elasticsearch:indices_index
85	\N	2024-02-08 17:01:09.118	2024-02-08 17:01:09.118	\N	\N	122	elasticsearch:indices_index
86	\N	2024-02-08 17:01:09.118	2024-02-08 17:01:09.118	\N	\N	122	elasticsearch:indices_put
87	\N	2024-02-08 17:01:09.119	2024-02-08 17:01:09.119	\N	\N	122	elasticsearch:indices_bulk
88	\N	2024-02-08 17:01:09.12	2024-02-08 17:01:09.12	\N	\N	123	elasticsearch:indices_bulk
89	\N	2024-02-08 17:01:09.121	2024-02-08 17:01:09.121	\N	\N	124	elasticsearch:indices_put
90	\N	2024-02-08 17:01:09.153	2024-02-08 17:01:09.153	\N	\N	138	select
91	\N	2024-02-08 17:01:09.153	2024-02-08 17:01:09.154	\N	\N	138	insert
92	\N	2024-02-08 17:01:09.154	2024-02-08 17:01:09.154	\N	\N	138	create
93	\N	2024-02-08 17:01:09.154	2024-02-08 17:01:09.155	\N	\N	138	delete
94	\N	2024-02-08 17:01:09.155	2024-02-08 17:01:09.155	\N	\N	138	drop
95	\N	2024-02-08 17:01:09.155	2024-02-08 17:01:09.156	\N	\N	138	use
96	\N	2024-02-08 17:01:09.156	2024-02-08 17:01:09.156	\N	\N	138	alter
97	\N	2024-02-08 17:01:09.157	2024-02-08 17:01:09.157	\N	\N	138	grant
98	\N	2024-02-08 17:01:09.157	2024-02-08 17:01:09.157	\N	\N	138	revoke
99	\N	2024-02-08 17:01:09.158	2024-02-08 17:01:09.158	\N	\N	138	show
100	\N	2024-02-08 17:01:09.158	2024-02-08 17:01:09.158	\N	\N	138	impersonate
101	\N	2024-02-08 17:01:09.159	2024-02-08 17:01:09.159	\N	\N	138	execute
102	\N	2024-02-08 17:01:09.217	2024-02-08 17:01:09.217	\N	\N	151	trino:select
103	\N	2024-02-08 17:01:09.217	2024-02-08 17:01:09.217	\N	\N	151	trino:insert
104	\N	2024-02-08 17:01:09.218	2024-02-08 17:01:09.218	\N	\N	151	trino:create
105	\N	2024-02-08 17:01:09.218	2024-02-08 17:01:09.218	\N	\N	151	trino:delete
106	\N	2024-02-08 17:01:09.219	2024-02-08 17:01:09.219	\N	\N	151	trino:drop
107	\N	2024-02-08 17:01:09.22	2024-02-08 17:01:09.22	\N	\N	151	trino:use
108	\N	2024-02-08 17:01:09.221	2024-02-08 17:01:09.221	\N	\N	151	trino:alter
109	\N	2024-02-08 17:01:09.221	2024-02-08 17:01:09.221	\N	\N	151	trino:grant
110	\N	2024-02-08 17:01:09.222	2024-02-08 17:01:09.222	\N	\N	151	trino:revoke
111	\N	2024-02-08 17:01:09.222	2024-02-08 17:01:09.222	\N	\N	151	trino:show
112	\N	2024-02-08 17:01:09.223	2024-02-08 17:01:09.223	\N	\N	151	trino:impersonate
113	\N	2024-02-08 17:01:09.224	2024-02-08 17:01:09.224	\N	\N	151	trino:execute
114	\N	2024-02-08 17:01:09.27	2024-02-08 17:01:09.27	\N	\N	164	select
115	\N	2024-02-08 17:01:09.27	2024-02-08 17:01:09.27	\N	\N	164	insert
116	\N	2024-02-08 17:01:09.271	2024-02-08 17:01:09.271	\N	\N	164	create
117	\N	2024-02-08 17:01:09.271	2024-02-08 17:01:09.271	\N	\N	164	delete
118	\N	2024-02-08 17:01:09.272	2024-02-08 17:01:09.272	\N	\N	164	drop
119	\N	2024-02-08 17:01:09.272	2024-02-08 17:01:09.272	\N	\N	164	use
120	\N	2024-02-08 17:01:09.273	2024-02-08 17:01:09.273	\N	\N	164	alter
121	\N	2024-02-08 17:01:09.273	2024-02-08 17:01:09.274	\N	\N	164	grant
122	\N	2024-02-08 17:01:09.274	2024-02-08 17:01:09.274	\N	\N	164	revoke
123	\N	2024-02-08 17:01:09.274	2024-02-08 17:01:09.274	\N	\N	164	show
124	\N	2024-02-08 17:01:09.275	2024-02-08 17:01:09.275	\N	\N	164	impersonate
125	\N	2024-02-08 17:01:09.275	2024-02-08 17:01:09.275	\N	\N	164	execute
126	\N	2024-02-08 17:01:09.349	2024-02-08 17:01:09.349	\N	\N	177	presto:select
127	\N	2024-02-08 17:01:09.35	2024-02-08 17:01:09.35	\N	\N	177	presto:insert
128	\N	2024-02-08 17:01:09.35	2024-02-08 17:01:09.351	\N	\N	177	presto:create
129	\N	2024-02-08 17:01:09.351	2024-02-08 17:01:09.351	\N	\N	177	presto:delete
130	\N	2024-02-08 17:01:09.352	2024-02-08 17:01:09.352	\N	\N	177	presto:drop
131	\N	2024-02-08 17:01:09.352	2024-02-08 17:01:09.352	\N	\N	177	presto:use
132	\N	2024-02-08 17:01:09.353	2024-02-08 17:01:09.353	\N	\N	177	presto:alter
133	\N	2024-02-08 17:01:09.353	2024-02-08 17:01:09.353	\N	\N	177	presto:grant
134	\N	2024-02-08 17:01:09.354	2024-02-08 17:01:09.354	\N	\N	177	presto:revoke
135	\N	2024-02-08 17:01:09.354	2024-02-08 17:01:09.354	\N	\N	177	presto:show
136	\N	2024-02-08 17:01:09.355	2024-02-08 17:01:09.355	\N	\N	177	presto:impersonate
137	\N	2024-02-08 17:01:09.358	2024-02-08 17:01:09.358	\N	\N	177	presto:execute
138	\N	2024-02-08 17:01:09.397	2024-02-08 17:01:09.398	\N	\N	179	read
139	\N	2024-02-08 17:01:09.398	2024-02-08 17:01:09.398	\N	\N	179	write
140	\N	2024-02-08 17:01:09.398	2024-02-08 17:01:09.399	\N	\N	179	create
141	\N	2024-02-08 17:01:09.399	2024-02-08 17:01:09.399	\N	\N	179	list
142	\N	2024-02-08 17:01:09.4	2024-02-08 17:01:09.4	\N	\N	179	delete
143	\N	2024-02-08 17:01:09.4	2024-02-08 17:01:09.4	\N	\N	179	read_acl
144	\N	2024-02-08 17:01:09.401	2024-02-08 17:01:09.401	\N	\N	179	write_acl
145	\N	2024-02-08 17:01:09.482	2024-02-08 17:01:09.482	\N	\N	187	ozone:read
146	\N	2024-02-08 17:01:09.482	2024-02-08 17:01:09.482	\N	\N	187	ozone:write
147	\N	2024-02-08 17:01:09.483	2024-02-08 17:01:09.483	\N	\N	187	ozone:create
148	\N	2024-02-08 17:01:09.483	2024-02-08 17:01:09.483	\N	\N	187	ozone:list
149	\N	2024-02-08 17:01:09.484	2024-02-08 17:01:09.484	\N	\N	187	ozone:delete
150	\N	2024-02-08 17:01:09.484	2024-02-08 17:01:09.484	\N	\N	187	ozone:read_acl
151	\N	2024-02-08 17:01:09.485	2024-02-08 17:01:09.485	\N	\N	187	ozone:write_acl
152	\N	2024-02-08 17:01:09.528	2024-02-08 17:01:09.528	\N	\N	195	metadata
153	\N	2024-02-08 17:01:09.529	2024-02-08 17:01:09.529	\N	\N	196	metadata
154	\N	2024-02-08 17:01:09.53	2024-02-08 17:01:09.53	\N	\N	197	metadata
155	\N	2024-02-08 17:01:09.532	2024-02-08 17:01:09.532	\N	\N	198	metadata
156	\N	2024-02-08 17:01:09.534	2024-02-08 17:01:09.534	\N	\N	199	metadata
157	\N	2024-02-08 17:01:09.535	2024-02-08 17:01:09.536	\N	\N	200	metadata
158	\N	2024-02-08 17:01:09.537	2024-02-08 17:01:09.537	\N	\N	201	metadata
159	\N	2024-02-08 17:01:09.539	2024-02-08 17:01:09.54	\N	\N	203	select
160	\N	2024-02-08 17:01:09.54	2024-02-08 17:01:09.54	\N	\N	203	insert
161	\N	2024-02-08 17:01:09.541	2024-02-08 17:01:09.541	\N	\N	203	update
162	\N	2024-02-08 17:01:09.541	2024-02-08 17:01:09.541	\N	\N	203	delete
163	\N	2024-02-08 17:01:09.542	2024-02-08 17:01:09.542	\N	\N	203	alter
164	\N	2024-02-08 17:01:09.543	2024-02-08 17:01:09.543	\N	\N	203	create
165	\N	2024-02-08 17:01:09.543	2024-02-08 17:01:09.543	\N	\N	203	drop
166	\N	2024-02-08 17:01:09.544	2024-02-08 17:01:09.544	\N	\N	203	metadata
167	\N	2024-02-08 17:01:09.641	2024-02-08 17:01:09.642	\N	\N	204	kudu:metadata
168	\N	2024-02-08 17:01:09.643	2024-02-08 17:01:09.643	\N	\N	205	kudu:metadata
169	\N	2024-02-08 17:01:09.645	2024-02-08 17:01:09.645	\N	\N	206	kudu:metadata
170	\N	2024-02-08 17:01:09.647	2024-02-08 17:01:09.647	\N	\N	207	kudu:metadata
171	\N	2024-02-08 17:01:09.649	2024-02-08 17:01:09.65	\N	\N	208	kudu:metadata
172	\N	2024-02-08 17:01:09.651	2024-02-08 17:01:09.651	\N	\N	209	kudu:metadata
173	\N	2024-02-08 17:01:09.653	2024-02-08 17:01:09.653	\N	\N	210	kudu:metadata
174	\N	2024-02-08 17:01:09.655	2024-02-08 17:01:09.656	\N	\N	212	kudu:metadata
175	\N	2024-02-08 17:01:09.656	2024-02-08 17:01:09.656	\N	\N	212	kudu:select
176	\N	2024-02-08 17:01:09.657	2024-02-08 17:01:09.657	\N	\N	212	kudu:insert
177	\N	2024-02-08 17:01:09.657	2024-02-08 17:01:09.657	\N	\N	212	kudu:update
178	\N	2024-02-08 17:01:09.658	2024-02-08 17:01:09.658	\N	\N	212	kudu:delete
179	\N	2024-02-08 17:01:09.658	2024-02-08 17:01:09.658	\N	\N	212	kudu:alter
180	\N	2024-02-08 17:01:09.659	2024-02-08 17:01:09.659	\N	\N	212	kudu:create
181	\N	2024-02-08 17:01:09.659	2024-02-08 17:01:09.659	\N	\N	212	kudu:drop
182	\N	2024-02-08 17:01:10.24	2024-02-08 17:01:10.24	\N	\N	223	hbase:read
183	\N	2024-02-08 17:01:10.241	2024-02-08 17:01:10.241	\N	\N	223	hbase:write
184	\N	2024-02-08 17:01:10.242	2024-02-08 17:01:10.242	\N	\N	223	hbase:create
185	\N	2024-02-08 17:01:10.478	2024-02-08 17:01:10.478	\N	\N	232	hive:select
186	\N	2024-02-08 17:01:10.478	2024-02-08 17:01:10.478	\N	\N	232	hive:update
187	\N	2024-02-08 17:01:10.479	2024-02-08 17:01:10.479	\N	\N	232	hive:create
188	\N	2024-02-08 17:01:10.48	2024-02-08 17:01:10.48	\N	\N	232	hive:drop
189	\N	2024-02-08 17:01:10.48	2024-02-08 17:01:10.48	\N	\N	232	hive:alter
190	\N	2024-02-08 17:01:10.481	2024-02-08 17:01:10.481	\N	\N	232	hive:index
191	\N	2024-02-08 17:01:10.482	2024-02-08 17:01:10.482	\N	\N	232	hive:lock
192	\N	2024-02-08 17:01:10.483	2024-02-08 17:01:10.483	\N	\N	232	hive:read
193	\N	2024-02-08 17:01:10.484	2024-02-08 17:01:10.484	\N	\N	232	hive:write
194	\N	2024-02-08 17:01:10.485	2024-02-08 17:01:10.485	\N	\N	232	hive:repladmin
195	\N	2024-02-08 17:01:10.485	2024-02-08 17:01:10.486	\N	\N	232	hive:serviceadmin
196	\N	2024-02-08 17:01:10.486	2024-02-08 17:01:10.487	\N	\N	232	hive:refresh
197	\N	2024-02-08 17:01:11.108	2024-02-08 17:01:11.108	\N	\N	249	storm:fileUpload
198	\N	2024-02-08 17:01:11.109	2024-02-08 17:01:11.109	\N	\N	249	storm:fileDownload
199	\N	2024-02-08 17:01:11.331	2024-02-08 17:01:11.331	\N	\N	262	yarn:submit-app
200	\N	2024-02-08 17:01:11.591	2024-02-08 17:01:11.591	\N	\N	263	kafka:describe
201	\N	2024-02-08 17:01:11.594	2024-02-08 17:01:11.594	\N	\N	264	kafka:describe
202	\N	2024-02-08 17:01:11.596	2024-02-08 17:01:11.596	\N	\N	265	kafka:describe
203	\N	2024-02-08 17:01:11.599	2024-02-08 17:01:11.6	\N	\N	267	kafka:describe
204	\N	2024-02-08 17:01:11.601	2024-02-08 17:01:11.601	\N	\N	267	kafka:create
205	\N	2024-02-08 17:01:11.602	2024-02-08 17:01:11.602	\N	\N	267	kafka:describe_configs
206	\N	2024-02-08 17:01:11.603	2024-02-08 17:01:11.604	\N	\N	267	kafka:alter_configs
207	\N	2024-02-08 17:01:11.605	2024-02-08 17:01:11.605	\N	\N	267	kafka:alter
208	\N	2024-02-08 17:01:11.606	2024-02-08 17:01:11.606	\N	\N	267	kafka:idempotent_write
209	\N	2024-02-08 17:01:11.607	2024-02-08 17:01:11.607	\N	\N	267	kafka:cluster_action
210	\N	2024-02-08 17:01:11.608	2024-02-08 17:01:11.609	\N	\N	267	kafka:delete
211	\N	2024-02-08 17:01:11.61	2024-02-08 17:01:11.61	\N	\N	267	kafka:publish
212	\N	2024-02-08 17:01:11.611	2024-02-08 17:01:11.611	\N	\N	267	kafka:consume
213	\N	2024-02-08 17:01:11.613	2024-02-08 17:01:11.613	\N	\N	267	kafka:configure
214	\N	2024-02-08 17:01:11.617	2024-02-08 17:01:11.617	\N	\N	269	kafka:describe
215	\N	2024-02-08 17:01:11.623	2024-02-08 17:01:11.623	\N	\N	272	kafka:describe_configs
216	\N	2024-02-08 17:01:13.684	2024-02-08 17:01:13.685	\N	\N	286	atlas:type-read
217	\N	2024-02-08 17:01:13.687	2024-02-08 17:01:13.687	\N	\N	287	atlas:type-read
218	\N	2024-02-08 17:01:13.69	2024-02-08 17:01:13.69	\N	\N	288	atlas:type-read
\.


--
-- Data for Name: x_asset; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_asset (id, create_time, update_time, added_by_id, upd_by_id, asset_name, descr, act_status, asset_type, config, sup_native) FROM stdin;
\.


--
-- Data for Name: x_audit_map; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_audit_map (id, create_time, update_time, added_by_id, upd_by_id, res_id, group_id, user_id, audit_type) FROM stdin;
\.


--
-- Data for Name: x_auth_sess; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_auth_sess (id, create_time, update_time, added_by_id, upd_by_id, login_id, user_id, ext_sess_id, auth_time, auth_status, auth_type, auth_provider, device_type, req_ip, req_ua) FROM stdin;
1	2024-02-08 17:01:36.02	2024-02-08 17:01:36.023	\N	\N	admin	1	2973B0F8B57969194448EC5A6D3C92F1	2024-02-08 17:01:36.02	1	1	0	1	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36
2	2024-02-08 17:01:49.834	2024-02-08 17:01:49.835	\N	\N	admin	1	937828630C0A0CCE992254E45BD5F352	2024-02-08 17:01:49.834	1	1	0	1	172.22.0.3	python-requests/2.31.0
3	2024-02-08 17:50:17.393	2024-02-08 17:50:17.402	\N	\N	admin	\N	F94F4257510DB65B517A5526D08303D7	2024-02-08 17:50:17.393	2	1	0	0	172.22.0.1	\N
4	2024-02-08 17:50:23.844	2024-02-08 17:50:23.845	\N	\N	admin	1	F94F4257510DB65B517A5526D08303D7	2024-02-08 17:50:23.844	1	1	0	1	172.22.0.1	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36
\.


--
-- Data for Name: x_context_enricher_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_context_enricher_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, enricher, enricher_options, sort_order) FROM stdin;
1	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.727	\N	\N	100	1	TagEnricher	org.apache.ranger.plugin.contextenricher.RangerTagEnricher	{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}	0
\.


--
-- Data for Name: x_cred_store; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_cred_store (id, create_time, update_time, added_by_id, upd_by_id, store_name, descr) FROM stdin;
\.


--
-- Data for Name: x_data_hist; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_data_hist (id, create_time, update_time, obj_guid, obj_class_type, obj_id, obj_name, version, action, from_time, to_time, content) FROM stdin;
1	2024-02-08 17:01:08.443	2024-02-08 17:01:08.443	0d047247-bafe-4cf8-8e9b-d5d377284b2d	1033	1	hdfs	1	Create	2024-02-08 17:01:08.443	\N	{"id":1,"guid":"0d047247-bafe-4cf8-8e9b-d5d377284b2d","isEnabled":true,"createTime":1707411668205,"updateTime":1707411668322,"version":1,"name":"hdfs","displayName":"hdfs","implClass":"org.apache.ranger.services.hdfs.RangerServiceHdfs","label":"HDFS Repository","description":"HDFS Repository","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"fs.default.name","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"1.For one Namenode Url, eg.<br>hdfs://&lt;host&gt;:&lt;port&gt;<br>2.For HA Namenode Urls(use , delimiter), eg.<br>hdfs://&lt;host&gt;:&lt;port&gt;,hdfs://&lt;host2&gt;:&lt;port2&gt;<br>\\"}","label":"Namenode URL"},{"itemId":4,"name":"hadoop.security.authorization","type":"bool","subType":"YesTrue:NoFalse","mandatory":true,"defaultValue":"false","label":"Authorization Enabled"},{"itemId":5,"name":"hadoop.security.authentication","type":"enum","subType":"authnType","mandatory":true,"defaultValue":"simple","label":"Authentication Type"},{"itemId":6,"name":"hadoop.security.auth_to_local","type":"string","mandatory":false},{"itemId":7,"name":"dfs.datanode.kerberos.principal","type":"string","mandatory":false},{"itemId":8,"name":"dfs.namenode.kerberos.principal","type":"string","mandatory":false},{"itemId":9,"name":"dfs.secondary.namenode.kerberos.principal","type":"string","mandatory":false},{"itemId":10,"name":"hadoop.rpc.protection","type":"enum","subType":"rpcProtection","mandatory":false,"defaultValue":"authentication","label":"RPC Protection Type"},{"itemId":11,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"},{"itemId":12,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[{'accessResult': 'DENIED', 'isAudited': true}, {'actions':['delete','rename'],'isAudited':true}, {'users':['hdfs'], 'actions': ['listStatus', 'getfileinfo', 'listCachePools', 'listCacheDirectives', 'listCorruptFileBlocks', 'monitorHealth', 'rollEditLog', 'open'], 'isAudited': false}, {'users': ['oozie'],'resources': {'path': {'values': ['/user/oozie/share/lib'],'isRecursive': true}},'isAudited': false},{'users': ['spark'],'resources': {'path': {'values': ['/user/spark/applicationHistory'],'isRecursive': true}},'isAudited': false},{'users': ['hue'],'resources': {'path': {'values': ['/user/hue'],'isRecursive': true}},'isAudited': false},{'users': ['hbase'],'resources': {'path': {'values': ['/hbase'],'isRecursive': true}},'isAudited': false},{'users': ['mapred'],'resources': {'path': {'values': ['/user/history'],'isRecursive': true}},'isAudited': false}, {'actions': ['getfileinfo'], 'isAudited':false} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"path","type":"path","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":true,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerPathResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Resource Path","description":"HDFS file or directory path","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"read","label":"Read"},{"itemId":2,"name":"write","label":"Write"},{"itemId":3,"name":"execute","label":"Execute"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authnType","elements":[{"itemId":1,"name":"simple","label":"Simple"},{"itemId":2,"name":"kerberos","label":"Kerberos"}],"defaultIndex":0},{"itemId":2,"name":"rpcProtection","elements":[{"itemId":1,"name":"authentication","label":"Authentication"},{"itemId":2,"name":"integrity","label":"Integrity"},{"itemId":3,"name":"privacy","label":"Privacy"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
2	2024-02-08 17:01:08.535	2024-02-08 17:01:08.535	d6cea1f0-2509-4791-8fc1-7b092399ba3b	1033	2	hbase	1	Create	2024-02-08 17:01:08.535	\N	{"id":2,"guid":"d6cea1f0-2509-4791-8fc1-7b092399ba3b","isEnabled":true,"createTime":1707411668494,"updateTime":1707411668494,"version":1,"name":"hbase","displayName":"hbase","implClass":"org.apache.ranger.services.hbase.RangerServiceHBase","label":"HBase","description":"HBase","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"hadoop.security.authentication","type":"enum","subType":"authnType","mandatory":true,"defaultValue":"simple"},{"itemId":4,"name":"hbase.master.kerberos.principal","type":"string","mandatory":false},{"itemId":5,"name":"hbase.security.authentication","type":"enum","subType":"authnType","mandatory":true,"defaultValue":"simple"},{"itemId":6,"name":"hbase.zookeeper.property.clientPort","type":"int","mandatory":true,"defaultValue":"2181"},{"itemId":7,"name":"hbase.zookeeper.quorum","type":"string","mandatory":true},{"itemId":8,"name":"zookeeper.znode.parent","type":"string","mandatory":true,"defaultValue":"/hbase"},{"itemId":9,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"},{"itemId":10,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'table':{'values':['*-ROOT-*','*.META.*', '*_acl_*', 'hbase:meta', 'hbase:acl', 'default', 'hbase']}}, 'users':['hbase'], 'isAudited': false }, {'resources':{'table':{'values':['atlas_janus','ATLAS_ENTITY_AUDIT_EVENTS']},'column-family':{'values':['*']},'column':{'values':['*']}},'users':['atlas', 'hbase'],'isAudited':false},{'users':['hbase'], 'actions':['balance'],'isAudited':false}]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"table","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"HBase Table","description":"HBase Table","isValidLeaf":false},{"itemId":2,"name":"column-family","type":"string","level":20,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"HBase Column-family","description":"HBase Column-family","isValidLeaf":false},{"itemId":3,"name":"column","type":"string","level":30,"parent":"column-family","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"HBase Column","description":"HBase Column","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"read","label":"Read"},{"itemId":2,"name":"write","label":"Write"},{"itemId":3,"name":"create","label":"Create"},{"itemId":4,"name":"admin","label":"Admin","impliedGrants":["read","write","create"]},{"itemId":5,"name":"execute","label":"Execute"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authnType","elements":[{"itemId":1,"name":"simple","label":"Simple"},{"itemId":2,"name":"kerberos","label":"Kerberos"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
3	2024-02-08 17:01:08.631	2024-02-08 17:01:08.631	3e1afb5a-184a-4e82-9d9c-87a5cacc243c	1033	3	hive	1	Create	2024-02-08 17:01:08.631	\N	{"id":3,"guid":"3e1afb5a-184a-4e82-9d9c-87a5cacc243c","isEnabled":true,"createTime":1707411668548,"updateTime":1707411668548,"version":1,"name":"hive","displayName":"Hadoop SQL","implClass":"org.apache.ranger.services.hive.RangerServiceHive","label":"Hive Server2","description":"Hive Server2","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"jdbc.driverClassName","type":"string","mandatory":true,"defaultValue":"org.apache.hive.jdbc.HiveDriver"},{"itemId":4,"name":"jdbc.url","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"1.For Remote Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;<br>2.For Embedded Mode (no host or port), eg.<br>jdbc:hive2:///;initFile=&lt;file&gt;<br>3.For HTTP Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;/;<br>transportMode=http;httpPath=&lt;httpPath&gt;<br>4.For SSL Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;/;ssl=true;<br>sslTrustStore=tStore;trustStorePassword=pw<br>5.For ZooKeeper Mode, eg.<br>jdbc:hive2://&lt;host&gt;/;serviceDiscoveryMode=<br>zooKeeper;zooKeeperNamespace=hiveserver2<br>6.For Kerberos Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;/;<br>principal=hive/domain@EXAMPLE.COM<br>\\"}"},{"itemId":5,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"},{"itemId":6,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'actions':['METADATA OPERATION'], 'isAudited': false}, {'users':['hive','hue'],'actions':['SHOW_ROLES'],'isAudited':false} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":7,"name":"global","type":"string","level":10,"mandatory":false,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Global","description":"Global","isValidLeaf":true},{"itemId":1,"name":"database","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Hive Database","description":"Hive Database","isValidLeaf":true},{"itemId":5,"name":"url","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":true,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerURLResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"URL","description":"URL","isValidLeaf":true},{"itemId":6,"name":"hiveservice","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Hive Service","description":"Hive Service","isValidLeaf":true},{"itemId":2,"name":"table","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Hive Table","description":"Hive Table","isValidLeaf":true},{"itemId":3,"name":"udf","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Hive UDF","description":"Hive UDF","isValidLeaf":true},{"itemId":4,"name":"column","type":"string","level":30,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Hive Column","description":"Hive Column","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"select","label":"select"},{"itemId":2,"name":"update","label":"update"},{"itemId":3,"name":"create","label":"Create"},{"itemId":4,"name":"drop","label":"Drop"},{"itemId":5,"name":"alter","label":"Alter"},{"itemId":6,"name":"index","label":"Index"},{"itemId":7,"name":"lock","label":"Lock"},{"itemId":8,"name":"all","label":"All","impliedGrants":["select","update","create","drop","alter","index","lock","read","write","repladmin","serviceadmin","refresh"]},{"itemId":9,"name":"read","label":"Read"},{"itemId":10,"name":"write","label":"Write"},{"itemId":11,"name":"repladmin","label":"ReplAdmin"},{"itemId":12,"name":"serviceadmin","label":"Service Admin"},{"itemId":13,"name":"tempudfadmin","label":"Temporary UDF Admin"},{"itemId":14,"name":"refresh","label":"Refresh"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{"maskTypes":[{"itemId":1,"name":"MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":2,"name":"MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3,"name":"MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":4,"name":"MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":5,"name":"MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":6,"name":"MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":12,"name":"MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":13,"name":"CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":1,"name":"select","label":"select"}],"resources":[{"itemId":1,"name":"database","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Database","description":"Hive Database","isValidLeaf":false},{"itemId":2,"name":"table","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Table","description":"Hive Table","isValidLeaf":false},{"itemId":4,"name":"column","type":"string","level":30,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Column","description":"Hive Column","isValidLeaf":true}]},"rowFilterDef":{"accessTypes":[{"itemId":1,"name":"select","label":"select"}],"resources":[{"itemId":1,"name":"database","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Database","description":"Hive Database","isValidLeaf":false},{"itemId":2,"name":"table","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Table","description":"Hive Table","isValidLeaf":true}]}}
4	2024-02-08 17:01:08.667	2024-02-08 17:01:08.667	50fd3b41-3aa6-49af-814d-32859bcf5f17	1033	7	kms	1	Create	2024-02-08 17:01:08.667	\N	{"id":7,"guid":"50fd3b41-3aa6-49af-814d-32859bcf5f17","isEnabled":true,"createTime":1707411668644,"updateTime":1707411668644,"version":1,"name":"kms","displayName":"kms","implClass":"org.apache.ranger.services.kms.RangerServiceKMS","label":"KMS","description":"KMS","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"encryption","security.allowed.roles":"keyadmin"},"configs":[{"itemId":1,"name":"provider","type":"string","mandatory":true,"label":"KMS URL"},{"itemId":2,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":3,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":4,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['keyadmin'] ,'isAudited':false} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"keyname","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Key Name","description":"Key Name","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"create","label":"Create"},{"itemId":2,"name":"delete","label":"Delete"},{"itemId":3,"name":"rollover","label":"Rollover"},{"itemId":4,"name":"setkeymaterial","label":"Set Key Material"},{"itemId":5,"name":"get","label":"Get"},{"itemId":6,"name":"getkeys","label":"Get Keys"},{"itemId":7,"name":"getmetadata","label":"Get Metadata"},{"itemId":8,"name":"generateeek","label":"Generate EEK"},{"itemId":9,"name":"decrypteek","label":"Decrypt EEK"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
5	2024-02-08 17:01:08.692	2024-02-08 17:01:08.692	84b481b5-f23b-4f71-b8b6-ab33977149ca	1033	5	knox	1	Create	2024-02-08 17:01:08.692	\N	{"id":5,"guid":"84b481b5-f23b-4f71-b8b6-ab33977149ca","isEnabled":true,"createTime":1707411668673,"updateTime":1707411668673,"version":1,"name":"knox","displayName":"knox","implClass":"org.apache.ranger.services.knox.RangerServiceKnox","label":"Knox Gateway","description":"Knox Gateway","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"knox.url","type":"string","mandatory":true},{"itemId":4,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"},{"itemId":5,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['knox'] ,'isAudited':false} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"topology","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Knox Topology","description":"Knox Topology","isValidLeaf":false},{"itemId":2,"name":"service","type":"string","level":20,"parent":"topology","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Knox Service","description":"Knox Service","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"allow","label":"Allow"}],"policyConditions":[{"itemId":1,"name":"ip-range","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher","uiHint":"{ \\"isMultiValue\\":true }","label":"IP Address Range","description":"IP Address Range"},{"itemId":2,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
6	2024-02-08 17:01:08.718	2024-02-08 17:01:08.718	2a60f427-edcf-4e20-834c-a9a267b5b963	1033	6	storm	1	Create	2024-02-08 17:01:08.718	\N	{"id":6,"guid":"2a60f427-edcf-4e20-834c-a9a267b5b963","isEnabled":true,"createTime":1707411668699,"updateTime":1707411668699,"version":1,"name":"storm","displayName":"storm","implClass":"org.apache.ranger.services.storm.RangerServiceStorm","label":"Storm","description":"Storm","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"nimbus.url","type":"string","mandatory":true,"label":"Nimbus URL"},{"itemId":4,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"}],"resources":[{"itemId":1,"name":"topology","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Storm Topology","description":"Storm Topology","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"submitTopology","label":"Submit Topology","impliedGrants":["fileUpload","fileDownload"]},{"itemId":2,"name":"fileUpload","label":"File Upload"},{"itemId":5,"name":"fileDownload","label":"File Download"},{"itemId":6,"name":"killTopology","label":"Kill Topology"},{"itemId":7,"name":"rebalance","label":"Rebalance"},{"itemId":8,"name":"activate","label":"Activate"},{"itemId":9,"name":"deactivate","label":"Deactivate"},{"itemId":10,"name":"getTopologyConf","label":"Get Topology Conf"},{"itemId":11,"name":"getTopology","label":"Get Topology"},{"itemId":12,"name":"getUserTopology","label":"Get User Topology"},{"itemId":13,"name":"getTopologyInfo","label":"Get Topology Info"},{"itemId":14,"name":"uploadNewCredentials","label":"Upload New Credential"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
7	2024-02-08 17:01:08.753	2024-02-08 17:01:08.753	5b710438-edcf-4e20-834c-a9a267b5b963	1033	4	yarn	1	Create	2024-02-08 17:01:08.753	\N	{"id":4,"guid":"5b710438-edcf-4e20-834c-a9a267b5b963","isEnabled":true,"createTime":1707411668738,"updateTime":1707411668738,"version":1,"name":"yarn","displayName":"yarn","implClass":"org.apache.ranger.services.yarn.RangerServiceYarn","label":"YARN","description":"YARN","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"yarn.url","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"1.For one url, eg.<br>'http or https://&lt;ipaddr&gt;:8088'<br>2.For multiple urls (use , or ; delimiter), eg.<br>'http://&lt;ipaddr1&gt;:8088,http://&lt;ipaddr2&gt;:8088'\\"}","label":"YARN REST URL"},{"itemId":4,"name":"hadoop.security.authentication","type":"enum","subType":"authnType","mandatory":false,"defaultValue":"simple","label":"Authentication Type"},{"itemId":5,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"},{"itemId":6,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"queue","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":true,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerPathResourceMatcher","matcherOptions":{"pathSeparatorChar":".","wildCard":"true","ignoreCase":"false"},"label":"Queue","description":"Queue","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"submit-app","label":"submit-app"},{"itemId":2,"name":"admin-queue","label":"admin-queue","impliedGrants":["submit-app"]}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authnType","elements":[{"itemId":1,"name":"simple","label":"Simple"},{"itemId":2,"name":"kerberos","label":"Kerberos"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
8	2024-02-08 17:01:08.786	2024-02-08 17:01:08.786	f0a466d7-fcb8-41ce-a54d-a5488a5dc54a	1033	9	kafka	1	Create	2024-02-08 17:01:08.786	\N	{"id":9,"guid":"f0a466d7-fcb8-41ce-a54d-a5488a5dc54a","isEnabled":true,"createTime":1707411668758,"updateTime":1707411668758,"version":1,"name":"kafka","displayName":"kafka","implClass":"org.apache.ranger.services.kafka.RangerServiceKafka","label":"Kafka","description":"Apache Kafka","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"zookeeper.connect","type":"string","mandatory":true,"defaultValue":"localhost:2181","label":"Zookeeper Connect String"},{"itemId":4,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Ranger Plugin SSL CName"},{"itemId":5,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'topic':{'values':['ATLAS_ENTITIES','ATLAS_HOOK','ATLAS_SPARK_HOOK']}},'users':['atlas'],'actions':['describe','publish','consume'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_HOOK']}},'users':['hive','hbase','impala','nifi'],'actions':['publish','describe'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_ENTITIES']}},'users':['rangertagsync'],'actions':['consume','describe'],'isAudited':false},{'resources':{'consumergroup':{'values':['*']}},'users':['atlas','rangertagsync'],'actions':['consume'],'isAudited':false},{'users':['kafka'],'isAudited':false}]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"topic","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Topic","description":"Topic","accessTypeRestrictions":["describe_configs","alter_configs","publish","create","consume","configure","describe","delete","alter"],"isValidLeaf":true},{"itemId":2,"name":"transactionalid","type":"string","level":1,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Transactional Id","description":"Transactional Id","accessTypeRestrictions":["publish","describe"],"isValidLeaf":true},{"itemId":3,"name":"cluster","type":"string","level":1,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Cluster","description":"Cluster","accessTypeRestrictions":["describe_configs","alter_configs","idempotent_write","create","configure","describe","kafka_admin","cluster_action","alter"],"isValidLeaf":true},{"itemId":4,"name":"delegationtoken","type":"string","level":1,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Delegation Token","description":"Delegation Token","accessTypeRestrictions":["describe"],"isValidLeaf":true},{"itemId":5,"name":"consumergroup","type":"string","level":1,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Consumer Group","description":"Consumer Group","accessTypeRestrictions":["consume","describe","delete"],"isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"publish","label":"Publish","impliedGrants":["describe"]},{"itemId":2,"name":"consume","label":"Consume","impliedGrants":["describe"]},{"itemId":5,"name":"configure","label":"Configure","impliedGrants":["describe"]},{"itemId":6,"name":"describe","label":"Describe"},{"itemId":7,"name":"kafka_admin","label":"Kafka Admin","impliedGrants":["describe","create","describe_configs","alter_configs","alter","idempotent_write","cluster_action","delete","publish","consume","configure"]},{"itemId":8,"name":"create","label":"Create"},{"itemId":9,"name":"delete","label":"Delete","impliedGrants":["describe"]},{"itemId":10,"name":"idempotent_write","label":"Idempotent Write"},{"itemId":11,"name":"describe_configs","label":"Describe Configs"},{"itemId":12,"name":"alter_configs","label":"Alter Configs","impliedGrants":["describe_configs"]},{"itemId":13,"name":"cluster_action","label":"Cluster Action"},{"itemId":14,"name":"alter","label":"Alter"}],"policyConditions":[{"itemId":1,"name":"ip-range","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher","uiHint":"{ \\"isMultiValue\\":true }","label":"IP Address Range","description":"IP Address Range"},{"itemId":2,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
9	2024-02-08 17:01:08.807	2024-02-08 17:01:08.807	b80fbc96-5851-4a74-8b1b-6a95abc8fd53	1033	8	solr	1	Create	2024-02-08 17:01:08.807	\N	{"id":8,"guid":"b80fbc96-5851-4a74-8b1b-6a95abc8fd53","isEnabled":true,"createTime":1707411668792,"updateTime":1707411668792,"version":1,"name":"solr","displayName":"solr","implClass":"org.apache.ranger.services.solr.RangerServiceSolr","label":"SOLR","description":"Solr","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":100,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":200,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":300,"name":"solr.zookeeper.quorum","type":"string","mandatory":false,"label":"Solr Zookeeper Quorum"},{"itemId":400,"name":"solr.url","type":"string","mandatory":true,"label":"Solr URL"},{"itemId":500,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Ranger Plugin SSL CName"},{"itemId":600,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['hive','hdfs','kafka','hbase','solr','rangerraz','knox','atlas','yarn','impala'] ,'isAudited':false} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":100,"name":"collection","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Solr Collection","description":"Solr Collection","isValidLeaf":true},{"itemId":101,"name":"config","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Solr Config","description":"Solr Config","isValidLeaf":true},{"itemId":102,"name":"schema","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Schema of a collection","description":"The schema of a collection","isValidLeaf":true},{"itemId":103,"name":"admin","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Solr Admin","description":"Solr Admin","isValidLeaf":true}],"accessTypes":[{"itemId":100,"name":"query","label":"Query"},{"itemId":200,"name":"update","label":"Update"}],"policyConditions":[{"itemId":100,"name":"ip-range","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher","uiHint":"{ \\"isMultiValue\\":true }","label":"IP Address Range","description":"IP Address Range"},{"itemId":101,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
10	2024-02-08 17:01:08.833	2024-02-08 17:01:08.833	9d71df31-5c2c-462b-b4f5-142d2331e245	1033	202	schema-registry	1	Create	2024-02-08 17:01:08.833	\N	{"id":202,"guid":"9d71df31-5c2c-462b-b4f5-142d2331e245","isEnabled":true,"createTime":1707411668812,"updateTime":1707411668812,"version":1,"name":"schema-registry","displayName":"schema-registry","implClass":"org.apache.ranger.services.schema.registry.RangerServiceSchemaRegistry","label":"Schema Registry","description":"Schema Registry","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"schema.registry.url","type":"string","mandatory":true,"label":"Schema Registry URL"},{"itemId":2,"name":"schema-registry.authentication","type":"enum","subType":"authType","mandatory":true,"defaultValue":"KERBEROS","label":"Authentication Type"},{"itemId":3,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Ranger Plugin SSL CName"},{"itemId":4,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"registry-service","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"validationRegEx":"^\\\\*$","label":"Schema Registry Service","description":"Schema Registry Service","isValidLeaf":true},{"itemId":2,"name":"schema-group","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Schema Group","description":"Schema Group","isValidLeaf":false},{"itemId":6,"name":"serde","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"validationRegEx":"^\\\\*$","label":"Serializer/Deserializer","description":"Serializer/Deserializer","isValidLeaf":true},{"itemId":3,"name":"schema-metadata","type":"string","level":20,"parent":"schema-group","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Schema Name","description":"Schema Name","isValidLeaf":true},{"itemId":4,"name":"schema-branch","type":"string","level":30,"parent":"schema-metadata","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Schema Branch","description":"Schema Branch","isValidLeaf":true},{"itemId":5,"name":"schema-version","type":"string","level":40,"parent":"schema-branch","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"validationRegEx":"^\\\\*$","label":"Schema Version","description":"Schema Version","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"create","label":"Create"},{"itemId":2,"name":"read","label":"Read"},{"itemId":3,"name":"update","label":"Update"},{"itemId":4,"name":"delete","label":"Delete"}],"policyConditions":[{"itemId":1,"name":"ip-range","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher","uiHint":"{ \\"isMultiValue\\":true }","label":"IP Address Range","description":"IP Address Range"},{"itemId":2,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authType","elements":[{"itemId":1,"name":"NONE","label":"None"},{"itemId":2,"name":"KERBEROS","label":"Kerberos"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
11	2024-02-08 17:01:08.865	2024-02-08 17:01:08.865	21890f77-ed89-4bfd-88d7-35614b0c98c4	1033	10	nifi	1	Create	2024-02-08 17:01:08.865	\N	{"id":10,"guid":"21890f77-ed89-4bfd-88d7-35614b0c98c4","isEnabled":true,"createTime":1707411668840,"updateTime":1707411668840,"version":1,"name":"nifi","displayName":"nifi","implClass":"org.apache.ranger.services.nifi.RangerServiceNiFi","label":"NIFI","description":"NiFi","options":{"enableDenyAndExceptionsInPolicies":"false"},"configs":[{"itemId":400,"name":"nifi.url","type":"string","mandatory":true,"defaultValue":"http://localhost:8080/nifi-api/resources","uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"The URL of the NiFi REST API that provides the available resources.\\"}","label":"NiFi URL"},{"itemId":410,"name":"nifi.authentication","type":"enum","subType":"authType","mandatory":true,"defaultValue":"NONE","label":"Authentication Type"},{"itemId":411,"name":"nifi.ssl.use.default.context","type":"bool","subType":"YesTrue:NoFalse","mandatory":true,"defaultValue":"false","uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"If true, then Ranger's keystore and truststore will be used to communicate with NiFi. If false, the keystore and truststore properties must be provided.\\"}","label":"Use Ranger's Default SSL Context"},{"itemId":500,"name":"nifi.ssl.keystore","type":"string","mandatory":false,"label":"Keystore"},{"itemId":510,"name":"nifi.ssl.keystoreType","type":"string","mandatory":false,"label":"Keystore Type"},{"itemId":520,"name":"nifi.ssl.keystorePassword","type":"password","mandatory":false,"label":"Keystore Password"},{"itemId":530,"name":"nifi.ssl.truststore","type":"string","mandatory":false,"label":"Truststore"},{"itemId":540,"name":"nifi.ssl.truststoreType","type":"string","mandatory":false,"label":"Truststore Type"},{"itemId":550,"name":"nifi.ssl.truststorePassword","type":"password","mandatory":false,"label":"Truststore Password"},{"itemId":560,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":100,"name":"nifi-resource","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"NiFi Resource Identifier","description":"NiFi Resource","isValidLeaf":true}],"accessTypes":[{"itemId":100,"name":"READ","label":"Read"},{"itemId":200,"name":"WRITE","label":"Write"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authType","elements":[{"itemId":1,"name":"NONE","label":"None"},{"itemId":2,"name":"SSL","label":"SSL"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
12	2024-02-08 17:01:08.887	2024-02-08 17:01:08.887	c6da6567-f1b3-48bf-a1ca-314aef19d5e5	1033	13	nifi-registry	1	Create	2024-02-08 17:01:08.887	\N	{"id":13,"guid":"c6da6567-f1b3-48bf-a1ca-314aef19d5e5","isEnabled":true,"createTime":1707411668869,"updateTime":1707411668869,"version":1,"name":"nifi-registry","displayName":"nifi-registry","implClass":"org.apache.ranger.services.nifi.registry.RangerServiceNiFiRegistry","label":"NIFI Registry","description":"NiFi Registry","options":{"enableDenyAndExceptionsInPolicies":"false"},"configs":[{"itemId":400,"name":"nifi.registry.url","type":"string","mandatory":true,"defaultValue":"http://localhost:18080/nifi-registry-api/policies/resources","uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"The URL of the NiFi Registry REST API that provides the available resources.\\"}","label":"NiFi Registry URL"},{"itemId":410,"name":"nifi.registry.authentication","type":"enum","subType":"authType","mandatory":true,"defaultValue":"NONE","label":"Authentication Type"},{"itemId":411,"name":"nifi.registry.ssl.use.default.context","type":"bool","subType":"YesTrue:NoFalse","mandatory":true,"defaultValue":"false","uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"If true, then Ranger's keystore and truststore will be used to communicate with NiFi Registry. If false, the keystore and truststore properties must be provided.\\"}","label":"Use Ranger's Default SSL Context"},{"itemId":500,"name":"nifi.registry.ssl.keystore","type":"string","mandatory":false,"label":"Keystore"},{"itemId":510,"name":"nifi.registry.ssl.keystoreType","type":"string","mandatory":false,"label":"Keystore Type"},{"itemId":520,"name":"nifi.registry.ssl.keystorePassword","type":"password","mandatory":false,"label":"Keystore Password"},{"itemId":530,"name":"nifi.registry.ssl.truststore","type":"string","mandatory":false,"label":"Truststore"},{"itemId":540,"name":"nifi.registry.ssl.truststoreType","type":"string","mandatory":false,"label":"Truststore Type"},{"itemId":550,"name":"nifi.registry.ssl.truststorePassword","type":"password","mandatory":false,"label":"Truststore Password"},{"itemId":560,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":100,"name":"nifi-registry-resource","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"NiFi Registry Resource Identifier","description":"NiFi Registry Resource","isValidLeaf":true}],"accessTypes":[{"itemId":100,"name":"READ","label":"Read"},{"itemId":200,"name":"WRITE","label":"Write"},{"itemId":300,"name":"DELETE","label":"Delete"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authType","elements":[{"itemId":1,"name":"NONE","label":"None"},{"itemId":2,"name":"SSL","label":"SSL"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
13	2024-02-08 17:01:08.939	2024-02-08 17:01:08.939	311a79b7-16f5-46f4-9829-a0224b9999c5	1033	15	atlas	1	Create	2024-02-08 17:01:08.939	\N	{"id":15,"guid":"311a79b7-16f5-46f4-9829-a0224b9999c5","isEnabled":true,"createTime":1707411668894,"updateTime":1707411668894,"version":1,"name":"atlas","displayName":"atlas","implClass":"org.apache.ranger.services.atlas.RangerServiceAtlas","label":"Atlas Metadata Server","description":"Atlas Metadata Server","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"atlas.rest.address","type":"string","mandatory":true,"defaultValue":"http://localhost:21000"},{"itemId":4,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"},{"itemId":5,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['atlas'] ,'isAudited':false}, {'accessResult':'ALLOWED', 'isAudited':false, 'actions':['entity-read'], 'accessTypes':['entity-read'], 'users':['nifi']} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":3,"name":"entity-type","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Entity Type","description":"Entity Type","isValidLeaf":false},{"itemId":6,"name":"atlas-service","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Atlas Service","description":"Atlas Service","accessTypeRestrictions":["admin-purge","admin-import","admin-export","admin-audits"],"isValidLeaf":true},{"itemId":7,"name":"relationship-type","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Relationship Type","description":"Relationship Type","isValidLeaf":false},{"itemId":1,"name":"type-category","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Type Catagory","description":"Type Catagory","isValidLeaf":false},{"itemId":4,"name":"entity-classification","type":"string","level":20,"parent":"entity-type","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Entity Classification","description":"Entity Classification","isValidLeaf":false},{"itemId":8,"name":"end-one-entity-type","type":"string","level":20,"parent":"relationship-type","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"End1 Entity Type","description":"End1 Entity Type","isValidLeaf":false},{"itemId":2,"name":"type","type":"string","level":20,"parent":"type-category","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Type Name","description":"Type Name","accessTypeRestrictions":["type-create","type-delete","type-read","type-update"],"isValidLeaf":true},{"itemId":9,"name":"end-one-entity-classification","type":"string","level":30,"parent":"end-one-entity-type","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"End1 Entity Classification","description":"End1 Entity Classification","isValidLeaf":false},{"itemId":5,"name":"entity","type":"string","level":30,"parent":"entity-classification","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Entity ID","description":"Entity ID","accessTypeRestrictions":["entity-read","entity-create","entity-update","entity-delete"],"isValidLeaf":true},{"itemId":16,"name":"classification","type":"string","level":40,"parent":"entity","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Targetted classifications","description":"Targetted classifications","accessTypeRestrictions":["entity-remove-classification","entity-add-classification","entity-update-classification"],"isValidLeaf":true},{"itemId":10,"name":"end-one-entity","type":"string","level":40,"parent":"end-one-entity-classification","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"End1 Entity ID","description":"End1 Entity ID","isValidLeaf":false},{"itemId":14,"name":"entity-label","type":"string","level":40,"parent":"entity","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Label","description":"Label","accessTypeRestrictions":["entity-add-label","entity-remove-label"],"isValidLeaf":true},{"itemId":15,"name":"entity-business-metadata","type":"string","level":40,"parent":"entity","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Business Metadata","description":"Business Metadata","accessTypeRestrictions":["entity-update-business-metadata"],"isValidLeaf":true},{"itemId":11,"name":"end-two-entity-type","type":"string","level":50,"parent":"end-one-entity","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"End2 Entity Type","description":"End2 Entity Type","isValidLeaf":false},{"itemId":12,"name":"end-two-entity-classification","type":"string","level":60,"parent":"end-two-entity-type","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"End2 Entity Classification","description":"End2 Entity Classification","isValidLeaf":false},{"itemId":13,"name":"end-two-entity","type":"string","level":70,"parent":"end-two-entity-classification","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"End2 Entity ID","description":"End2 Entity ID","accessTypeRestrictions":["remove-relationship","update-relationship","add-relationship"],"isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"type-create","label":"Create Type","impliedGrants":["type-read"]},{"itemId":2,"name":"type-update","label":"Update Type","impliedGrants":["type-read"]},{"itemId":3,"name":"type-delete","label":"Delete Type","impliedGrants":["type-read"]},{"itemId":4,"name":"entity-read","label":"Read Entity"},{"itemId":5,"name":"entity-create","label":"Create Entity"},{"itemId":6,"name":"entity-update","label":"Update Entity"},{"itemId":7,"name":"entity-delete","label":"Delete Entity"},{"itemId":8,"name":"entity-add-classification","label":"Add Classification"},{"itemId":9,"name":"entity-update-classification","label":"Update Classification"},{"itemId":10,"name":"entity-remove-classification","label":"Remove Classification"},{"itemId":11,"name":"admin-export","label":"Admin Export"},{"itemId":12,"name":"admin-import","label":"Admin Import"},{"itemId":13,"name":"add-relationship","label":"Add Relationship"},{"itemId":14,"name":"update-relationship","label":"Update Relationship"},{"itemId":15,"name":"remove-relationship","label":"Remove Relationship"},{"itemId":16,"name":"admin-purge","label":"Admin Purge"},{"itemId":17,"name":"entity-add-label","label":"Add Label"},{"itemId":18,"name":"entity-remove-label","label":"Remove Label"},{"itemId":19,"name":"entity-update-business-metadata","label":"Update Business Metadata"},{"itemId":20,"name":"type-read","label":"Read Type"},{"itemId":21,"name":"admin-audits","label":"Admin Audits"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
15	2024-02-08 17:01:08.972	2024-02-08 17:01:08.972	6c63d385-5876-4a4c-ac4a-3b99b50ed600	1033	14	sqoop	1	Create	2024-02-08 17:01:08.972	\N	{"id":14,"guid":"6c63d385-5876-4a4c-ac4a-3b99b50ed600","isEnabled":true,"createTime":1707411668961,"updateTime":1707411668961,"version":1,"name":"sqoop","displayName":"sqoop","implClass":"org.apache.ranger.services.sqoop.RangerServiceSqoop","label":"SQOOP","description":"SQOOP","options":{"enableDenyAndExceptionsInPolicies":"false"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"sqoop.url","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"eg. 'http://&lt;ipaddr&gt;:12000'\\"}","label":"Sqoop URL"},{"itemId":3,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"}],"resources":[{"itemId":1,"name":"connector","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Connector","description":"Sqoop Connector","isValidLeaf":true},{"itemId":2,"name":"link","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Link","description":"Sqoop Link","isValidLeaf":true},{"itemId":3,"name":"job","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Job","description":"Sqoop Job","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"READ","label":"READ"},{"itemId":2,"name":"WRITE","label":"WRITE"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
17	2024-02-08 17:01:09.032	2024-02-08 17:01:09.032	88ab8471-3e27-40c2-8bd8-458b5b1a9b25	1033	12	kylin	1	Create	2024-02-08 17:01:09.032	\N	{"id":12,"guid":"88ab8471-3e27-40c2-8bd8-458b5b1a9b25","isEnabled":true,"createTime":1707411669019,"updateTime":1707411669019,"version":1,"name":"kylin","displayName":"kylin","implClass":"org.apache.ranger.services.kylin.RangerServiceKylin","label":"KYLIN","description":"KYLIN","options":{"enableDenyAndExceptionsInPolicies":"false"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"kylin.url","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"1.For one url, eg.<br>'http://&lt;ipaddr&gt;:7070'<br>2.For multiple urls (use , or ; delimiter), eg.<br>'http://&lt;ipaddr1&gt;:7070,http://&lt;ipaddr2&gt;:7070'\\"}","label":"Kylin URL"},{"itemId":4,"name":"commonNameForCertificate","type":"string","mandatory":false,"label":"Common Name for Certificate"}],"resources":[{"itemId":1,"name":"project","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Kylin Project","description":"Kylin Project","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"QUERY","label":"QUERY"},{"itemId":2,"name":"OPERATION","label":"OPERATION"},{"itemId":3,"name":"MANAGEMENT","label":"MANAGEMENT"},{"itemId":4,"name":"ADMIN","label":"ADMIN"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
19	2024-02-08 17:01:09.089	2024-02-08 17:01:09.089	c0682ba7-7052-4c9c-a30e-84ccd5d98457	1033	16	elasticsearch	1	Create	2024-02-08 17:01:09.089	\N	{"id":16,"guid":"c0682ba7-7052-4c9c-a30e-84ccd5d98457","isEnabled":true,"createTime":1707411669058,"updateTime":1707411669058,"version":1,"name":"elasticsearch","displayName":"elasticsearch","implClass":"org.apache.ranger.services.elasticsearch.RangerServiceElasticsearch","label":"ELASTICSEARCH","description":"ELASTICSEARCH","options":{"enableDenyAndExceptionsInPolicies":"false"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"elasticsearch.url","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"eg. 'http://&lt;ipaddr&gt;:9200'\\"}","label":"Elasticsearch URL"}],"resources":[{"itemId":1,"name":"index","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Index","description":"Elasticsearch Index","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"all","label":"all","impliedGrants":["monitor","manage","view_index_metadata","read","read_cross_cluster","index","create","delete","write","delete_index","create_index","indices_put","indices_search_shards","indices_bulk","indices_index"]},{"itemId":2,"name":"monitor","label":"monitor"},{"itemId":3,"name":"manage","label":"manage","impliedGrants":["monitor"]},{"itemId":4,"name":"view_index_metadata","label":"view_index_metadata","impliedGrants":["indices_search_shards"]},{"itemId":5,"name":"read","label":"read"},{"itemId":6,"name":"read_cross_cluster","label":"read_cross_cluster","impliedGrants":["indices_search_shards"]},{"itemId":7,"name":"index","label":"index","impliedGrants":["indices_put","indices_bulk","indices_index"]},{"itemId":8,"name":"create","label":"create","impliedGrants":["indices_index","indices_put","indices_bulk"]},{"itemId":9,"name":"delete","label":"delete","impliedGrants":["indices_bulk"]},{"itemId":10,"name":"write","label":"write","impliedGrants":["indices_put"]},{"itemId":11,"name":"delete_index","label":"delete_index"},{"itemId":12,"name":"create_index","label":"create_index"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
21	2024-02-08 17:01:09.173	2024-02-08 17:01:09.173	379a9fe5-1b6e-4091-a584-4890e245e6c1	1033	203	trino	1	Create	2024-02-08 17:01:09.173	\N	{"id":203,"guid":"379a9fe5-1b6e-4091-a584-4890e245e6c1","isEnabled":true,"createTime":1707411669134,"updateTime":1707411669134,"version":1,"name":"trino","displayName":"trino","implClass":"org.apache.ranger.services.trino.RangerServiceTrino","label":"Trino","description":"Trino","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":false,"label":"Password"},{"itemId":3,"name":"jdbc.driverClassName","type":"string","mandatory":true,"defaultValue":"io.trino.jdbc.TrinoDriver"},{"itemId":4,"name":"jdbc.url","type":"string","mandatory":true}],"resources":[{"itemId":6,"name":"systemproperty","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"System Property","description":"Trino System Property","accessTypeRestrictions":["alter"],"isValidLeaf":true},{"itemId":8,"name":"function","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Trino Function","description":"Trino Function","accessTypeRestrictions":["grant","execute"],"isValidLeaf":true},{"itemId":5,"name":"trinouser","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Trino User","description":"Trino User","accessTypeRestrictions":["impersonate"],"isValidLeaf":true},{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Trino Catalog","description":"Trino Catalog","isValidLeaf":true},{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Trino Schema","description":"Trino Schema","isValidLeaf":true},{"itemId":7,"name":"sessionproperty","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Catalog Session Property","description":"Trino Catalog Session Property","accessTypeRestrictions":["alter"],"isValidLeaf":true},{"itemId":9,"name":"procedure","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Schema Procedure","description":"Schema Procedure","accessTypeRestrictions":["grant","execute"],"isValidLeaf":true},{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Trino Table","description":"Trino Table","isValidLeaf":true},{"itemId":4,"name":"column","type":"string","level":40,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Trino Column","description":"Trino Column","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"select","label":"Select"},{"itemId":2,"name":"insert","label":"Insert"},{"itemId":3,"name":"create","label":"Create"},{"itemId":4,"name":"drop","label":"Drop"},{"itemId":5,"name":"delete","label":"Delete"},{"itemId":6,"name":"use","label":"Use"},{"itemId":7,"name":"alter","label":"Alter"},{"itemId":8,"name":"grant","label":"Grant"},{"itemId":9,"name":"revoke","label":"Revoke"},{"itemId":10,"name":"show","label":"Show"},{"itemId":11,"name":"impersonate","label":"Impersonate"},{"itemId":12,"name":"all","label":"All","impliedGrants":["select","insert","create","delete","drop","use","alter","grant","revoke","show","impersonate","execute"]},{"itemId":13,"name":"execute","label":"execute"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{"maskTypes":[{"itemId":1,"name":"MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":2,"name":"MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":3,"name":"MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":4,"name":"MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":5,"name":"MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":6,"name":"MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":12,"name":"MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":13,"name":"CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":1,"name":"select","label":"Select"}],"resources":[{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Catalog","description":"Trino Catalog","isValidLeaf":false},{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Schema","description":"Trino Schema","isValidLeaf":false},{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Table","description":"Trino Table","isValidLeaf":false},{"itemId":4,"name":"column","type":"string","level":40,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Column","description":"Trino Column","isValidLeaf":true}]},"rowFilterDef":{"accessTypes":[{"itemId":1,"name":"select","label":"Select"}],"resources":[{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Catalog","description":"Trino Catalog","isValidLeaf":false},{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Schema","description":"Trino Schema","isValidLeaf":false},{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Table","description":"Trino Table","isValidLeaf":true}]}}
23	2024-02-08 17:01:09.29	2024-02-08 17:01:09.29	379a9fe5-1b6e-4091-a584-4890e245e6c1	1033	17	presto	1	Create	2024-02-08 17:01:09.29	\N	{"id":17,"guid":"379a9fe5-1b6e-4091-a584-4890e245e6c1","isEnabled":true,"createTime":1707411669247,"updateTime":1707411669247,"version":1,"name":"presto","displayName":"presto","implClass":"org.apache.ranger.services.presto.RangerServicePresto","label":"Presto","description":"Presto","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":false,"label":"Password"},{"itemId":3,"name":"jdbc.driverClassName","type":"string","mandatory":true,"defaultValue":"io.prestosql.jdbc.PrestoDriver"},{"itemId":4,"name":"jdbc.url","type":"string","mandatory":true}],"resources":[{"itemId":6,"name":"systemproperty","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"System Property","description":"Presto System Property","accessTypeRestrictions":["alter"],"isValidLeaf":true},{"itemId":8,"name":"function","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Presto Function","description":"Presto Function","accessTypeRestrictions":["grant","execute"],"isValidLeaf":true},{"itemId":5,"name":"prestouser","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Presto User","description":"Presto User","accessTypeRestrictions":["impersonate"],"isValidLeaf":true},{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Presto Catalog","description":"Presto Catalog","isValidLeaf":true},{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Presto Schema","description":"Presto Schema","isValidLeaf":true},{"itemId":7,"name":"sessionproperty","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Catalog Session Property","description":"Presto Catalog Session Property","accessTypeRestrictions":["alter"],"isValidLeaf":true},{"itemId":9,"name":"procedure","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Schema Procedure","description":"Schema Procedure","accessTypeRestrictions":["grant","execute"],"isValidLeaf":true},{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Presto Table","description":"Presto Table","isValidLeaf":true},{"itemId":4,"name":"column","type":"string","level":40,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Presto Column","description":"Presto Column","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"select","label":"Select"},{"itemId":2,"name":"insert","label":"Insert"},{"itemId":3,"name":"create","label":"Create"},{"itemId":4,"name":"drop","label":"Drop"},{"itemId":5,"name":"delete","label":"Delete"},{"itemId":6,"name":"use","label":"Use"},{"itemId":7,"name":"alter","label":"Alter"},{"itemId":8,"name":"grant","label":"Grant"},{"itemId":9,"name":"revoke","label":"Revoke"},{"itemId":10,"name":"show","label":"Show"},{"itemId":11,"name":"impersonate","label":"Impersonate"},{"itemId":12,"name":"all","label":"All","impliedGrants":["select","insert","create","delete","drop","use","alter","grant","revoke","show","impersonate","execute"]},{"itemId":13,"name":"execute","label":"execute"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{"maskTypes":[{"itemId":1,"name":"MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":2,"name":"MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":3,"name":"MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":4,"name":"MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":5,"name":"MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":6,"name":"MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":12,"name":"MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":13,"name":"CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":1,"name":"select","label":"Select"}],"resources":[{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Catalog","description":"Presto Catalog","isValidLeaf":false},{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Schema","description":"Presto Schema","isValidLeaf":false},{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Table","description":"Presto Table","isValidLeaf":false},{"itemId":4,"name":"column","type":"string","level":40,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Column","description":"Presto Column","isValidLeaf":true}]},"rowFilterDef":{"accessTypes":[{"itemId":1,"name":"select","label":"Select"}],"resources":[{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Catalog","description":"Presto Catalog","isValidLeaf":false},{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Schema","description":"Presto Schema","isValidLeaf":false},{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Table","description":"Presto Table","isValidLeaf":true}]}}
25	2024-02-08 17:01:09.412	2024-02-08 17:01:09.412	a978ad0a-263e-4b86-957c-9e26ab028ee5	1033	201	ozone	1	Create	2024-02-08 17:01:09.412	\N	{"id":201,"guid":"a978ad0a-263e-4b86-957c-9e26ab028ee5","isEnabled":true,"createTime":1707411669385,"updateTime":1707411669385,"version":1,"name":"ozone","displayName":"ozone","implClass":"org.apache.ranger.services.ozone.RangerServiceOzone","label":"OZONE","description":"Ozone Repository","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"username","type":"string","mandatory":true,"label":"Username"},{"itemId":2,"name":"password","type":"password","mandatory":true,"label":"Password"},{"itemId":3,"name":"ozone.om.http-address","type":"string","mandatory":true,"uiHint":"{\\"TextFieldWithIcon\\":true, \\"info\\": \\"For Ozone Url, eg.<br>&lt;host&gt;:&lt;port&gt;<br>\\"}","label":"Ozone URL"},{"itemId":4,"name":"hadoop.security.authorization","type":"bool","subType":"YesTrue:NoFalse","mandatory":false,"defaultValue":"false","label":"Authorization Enabled"},{"itemId":5,"name":"hadoop.security.authentication","type":"enum","subType":"authnType","mandatory":true,"defaultValue":"simple","label":"Authentication Type"},{"itemId":6,"name":"hadoop.security.auth_to_local","type":"string","mandatory":false},{"itemId":7,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"volume","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"false"},"label":"Ozone Volume","description":"Ozone Volume","isValidLeaf":true},{"itemId":2,"name":"bucket","type":"string","level":20,"parent":"volume","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Ozone Bucket","description":"Ozone Bucket","isValidLeaf":true},{"itemId":3,"name":"key","type":"string","level":30,"parent":"bucket","mandatory":true,"lookupSupported":true,"recursiveSupported":true,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Ozone Key","description":"Ozone Key","isValidLeaf":true}],"accessTypes":[{"itemId":8,"name":"all","label":"All","impliedGrants":["read","write","create","list","delete","read_acl","write_acl"]},{"itemId":1,"name":"read","label":"Read"},{"itemId":2,"name":"write","label":"Write"},{"itemId":3,"name":"create","label":"Create"},{"itemId":4,"name":"list","label":"List"},{"itemId":5,"name":"delete","label":"Delete"},{"itemId":6,"name":"read_acl","label":"Read_ACL"},{"itemId":7,"name":"write_acl","label":"Write_ACL"}],"policyConditions":[{"itemId":1,"name":"ip-range","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher","uiHint":"{ \\"isMultiValue\\":true }","label":"IP Address Range","description":"IP Address Range"},{"itemId":2,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"enums":[{"itemId":1,"name":"authnType","elements":[{"itemId":1,"name":"simple","label":"Simple"},{"itemId":2,"name":"kerberos","label":"Kerberos"}],"defaultIndex":0}],"dataMaskDef":{},"rowFilterDef":{}}
27	2024-02-08 17:01:09.549	2024-02-08 17:01:09.549	3afccea8-2307-4627-90c1-c8db61b25584	1033	105	kudu	1	Create	2024-02-08 17:01:09.549	\N	{"id":105,"guid":"3afccea8-2307-4627-90c1-c8db61b25584","isEnabled":true,"createTime":1707411669518,"updateTime":1707411669518,"version":1,"name":"kudu","displayName":"kudu","implClass":"org.apache.ranger.services.kudu.RangerServiceKudu","label":"Kudu","description":"Kudu","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"database","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Database","description":"Database","isValidLeaf":true},{"itemId":2,"name":"table","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Table","description":"Table","isValidLeaf":true},{"itemId":3,"name":"column","type":"string","level":30,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"Column","description":"Column","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"select","label":"SELECT","impliedGrants":["metadata"]},{"itemId":2,"name":"insert","label":"INSERT","impliedGrants":["metadata"]},{"itemId":3,"name":"update","label":"UPDATE","impliedGrants":["metadata"]},{"itemId":4,"name":"delete","label":"DELETE","impliedGrants":["metadata"]},{"itemId":5,"name":"alter","label":"ALTER","impliedGrants":["metadata"]},{"itemId":6,"name":"create","label":"CREATE","impliedGrants":["metadata"]},{"itemId":7,"name":"drop","label":"DROP","impliedGrants":["metadata"]},{"itemId":8,"name":"metadata","label":"METADATA"},{"itemId":9,"name":"all","label":"ALL","impliedGrants":["metadata","select","insert","update","delete","alter","create","drop"]}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{},"rowFilterDef":{}}
29	2024-02-08 17:01:09.705	2024-02-08 17:01:09.705	3b048585-a04f-4f83-8801-f5cb97d40360	1033	205	nestedstructure	1	Create	2024-02-08 17:01:09.705	\N	{"id":205,"guid":"3b048585-a04f-4f83-8801-f5cb97d40360","isEnabled":true,"createTime":1707411669685,"updateTime":1707411669685,"version":1,"name":"nestedstructure","displayName":"nestedstructure","label":"NestedStructure","description":"Plugin to enforce READ and WRITE access control on nested structures such as JSON response objects from microservice API resource calls","options":{"enableDenyAndExceptionsInPolicies":"true"},"configs":[{"itemId":1,"name":"commonNameForCertificate","type":"string","mandatory":false},{"itemId":2,"name":"policy.download.auth.users","type":"string","mandatory":false}],"resources":[{"itemId":1,"name":"schema","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"NestedStructure Schema","description":"Schema of the nested structure returned from Microservice GET, etc","isValidLeaf":true},{"itemId":2,"name":"field","type":"string","level":20,"parent":"schema","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":true,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"label":"NestedStructure Schema Field","description":"NestedStructure Schema Field","isValidLeaf":true}],"accessTypes":[{"itemId":1,"name":"read","label":"Read"},{"itemId":2,"name":"write","label":"Write"}],"policyConditions":[{"itemId":1,"name":"_expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"dataMaskDef":{"maskTypes":[{"itemId":1,"name":"MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":2,"name":"MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3,"name":"MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":4,"name":"MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":5,"name":"MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":6,"name":"MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":12,"name":"MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":13,"name":"CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":1,"name":"read","label":"Read"}],"resources":[{"itemId":1,"name":"schema","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"NestedStructure Schema","description":"NestedStructure Schema returned from Microservice GET, etc","isValidLeaf":false},{"itemId":2,"name":"field","type":"string","level":20,"parent":"schema","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"NestedStructure Schema Field","description":"NestedStructure Schema Field","isValidLeaf":true}]},"rowFilterDef":{"accessTypes":[{"itemId":1,"name":"read","label":"Read"},{"itemId":2,"name":"write","label":"Write"}],"resources":[{"itemId":1,"name":"schema","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"NestedStructure Schema","description":"NestedStructure Schema returned from Microservice GET, etc","isValidLeaf":true}]}}
22	2024-02-08 17:01:09.239	2024-02-08 17:01:10.094	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	5	Update	2024-02-08 17:01:09.239	2024-02-08 17:01:10.094	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669178,"version":5,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index","elasticsearch:monitor","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_bulk","elasticsearch:indices_put","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:select","trino:insert","trino:create"]},{"itemId":203216,"name":"trino:execute","label":"execute"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
32	2024-02-08 17:01:10.294	2024-02-08 17:01:10.294	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	11	Update	2024-02-08 17:01:10.294	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411670103,"version":11,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_bulk","elasticsearch:indices_index","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:impersonate","trino:select","trino:delete","trino:create","trino:insert","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:execute"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:insert","presto:delete","presto:select","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate","presto:execute","presto:create"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:write_acl","ozone:read","ozone:write","ozone:list","ozone:create","ozone:delete","ozone:read_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:select","kudu:metadata","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create","kudu:drop"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:create","hbase:write","hbase:read"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
16	2024-02-08 17:01:09.01	2024-02-08 17:01:10.294	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	2	Update	2024-02-08 17:01:09.01	2024-02-08 17:01:10.294	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411668976,"version":2,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{},"rowFilterDef":{}}
33	2024-02-08 17:01:10.539	2024-02-08 17:01:10.539	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	12	Update	2024-02-08 17:01:10.539	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411670304,"version":12,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:indices_put","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_search_shards","elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:insert","trino:execute","trino:impersonate","trino:show","trino:revoke","trino:grant","trino:alter","trino:use","trino:drop","trino:delete","trino:create","trino:select"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:select","presto:execute","presto:impersonate","presto:show","presto:revoke","presto:grant","presto:alter","presto:use","presto:drop","presto:delete","presto:create","presto:insert"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:list","ozone:read","ozone:write","ozone:create","ozone:delete","ozone:read_acl","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:metadata","kudu:drop","kudu:create","kudu:alter","kudu:delete","kudu:update","kudu:insert","kudu:select"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:create","hbase:write","hbase:read"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:read","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin","hive:repladmin","hive:write","hive:lock"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
34	2024-02-08 17:01:10.739	2024-02-08 17:01:10.739	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	13	Update	2024-02-08 17:01:10.739	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411670551,"version":13,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_bulk","elasticsearch:indices_index","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:select","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:delete","trino:create","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:revoke","presto:drop","presto:use","presto:alter","presto:grant","presto:delete","presto:show","presto:impersonate","presto:execute","presto:select","presto:insert","presto:create"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:write_acl","ozone:create","ozone:write","ozone:list","ozone:read","ozone:delete","ozone:read_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:create","hbase:read"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:refresh","hive:select","hive:update","hive:create","hive:drop","hive:alter","hive:index","hive:lock","hive:read","hive:write","hive:repladmin","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
18	2024-02-08 17:01:09.054	2024-02-08 17:01:10.739	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	3	Update	2024-02-08 17:01:09.054	2024-02-08 17:01:10.739	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669035,"version":3,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{},"rowFilterDef":{}}
35	2024-02-08 17:01:10.923	2024-02-08 17:01:10.923	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	14	Update	2024-02-08 17:01:10.923	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411670751,"version":14,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_bulk","elasticsearch:indices_index","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:select","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:delete","trino:create","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:revoke","presto:drop","presto:use","presto:alter","presto:grant","presto:delete","presto:show","presto:impersonate","presto:execute","presto:select","presto:insert","presto:create"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:write_acl","ozone:create","ozone:write","ozone:list","ozone:read","ozone:delete","ozone:read_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:create","hbase:read"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:refresh","hive:select","hive:update","hive:create","hive:drop","hive:alter","hive:index","hive:lock","hive:read","hive:write","hive:repladmin","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
36	2024-02-08 17:01:11.152	2024-02-08 17:01:11.152	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	15	Update	2024-02-08 17:01:11.152	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411670933,"version":15,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:show","trino:drop","trino:delete","trino:revoke","trino:create","trino:insert","trino:select","trino:grant","trino:alter","trino:execute","trino:use","trino:impersonate"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:execute","presto:delete","presto:create","presto:insert","presto:select","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:write_acl","ozone:create","ozone:write","ozone:list","ozone:read","ozone:delete","ozone:read_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:insert","kudu:metadata","kudu:select","kudu:update","kudu:delete","kudu:alter","kudu:create","kudu:drop"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:read","hbase:create","hbase:write"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin","hive:repladmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileDownload","storm:fileUpload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
30	2024-02-08 17:01:09.824	2024-02-08 17:01:13.34	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	9	Update	2024-02-08 17:01:09.824	2024-02-08 17:01:13.34	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669711,"version":9,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_index","elasticsearch:indices_bulk"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:select","trino:execute","trino:show","trino:revoke","trino:grant","trino:alter","trino:use","trino:drop","trino:delete","trino:create","trino:insert","trino:impersonate"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:impersonate","presto:execute","presto:create","presto:insert","presto:delete","presto:select","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:list","ozone:delete","ozone:read_acl","ozone:write_acl","ozone:read","ozone:write","ozone:create"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:create","kudu:alter","kudu:update","kudu:insert","kudu:select","kudu:metadata","kudu:delete","kudu:drop"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
20	2024-02-08 17:01:09.129	2024-02-08 17:01:11.152	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	4	Update	2024-02-08 17:01:09.129	2024-02-08 17:01:11.152	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669092,"version":4,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_bulk","elasticsearch:indices_index","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{},"rowFilterDef":{}}
37	2024-02-08 17:01:11.365	2024-02-08 17:01:11.365	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	16	Update	2024-02-08 17:01:11.365	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411671161,"version":16,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:show","trino:revoke","trino:delete","trino:create","trino:insert","trino:grant","trino:select","trino:drop","trino:impersonate","trino:execute","trino:alter","trino:use"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:impersonate","presto:delete","presto:create","presto:insert","presto:select","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:execute"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:write_acl","ozone:create","ozone:write","ozone:list","ozone:read","ozone:delete","ozone:read_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:update","kudu:metadata","kudu:select","kudu:insert","kudu:delete","kudu:alter","kudu:create","kudu:drop"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:read","hbase:create","hbase:write"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin","hive:repladmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
28	2024-02-08 17:01:09.68	2024-02-08 17:01:11.365	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	8	Update	2024-02-08 17:01:09.68	2024-02-08 17:01:11.365	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669561,"version":8,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_index","elasticsearch:indices_bulk"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:select","trino:execute","trino:show","trino:revoke","trino:grant","trino:alter","trino:use","trino:drop","trino:delete","trino:create","trino:insert","trino:impersonate"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:impersonate","presto:execute","presto:create","presto:insert","presto:delete","presto:select","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:list","ozone:delete","ozone:read_acl","ozone:write_acl","ozone:read","ozone:write","ozone:create"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:create","kudu:alter","kudu:update","kudu:insert","kudu:select","kudu:metadata","kudu:delete","kudu:drop"]}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
38	2024-02-08 17:01:11.665	2024-02-08 17:01:11.665	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	17	Update	2024-02-08 17:01:11.665	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411671375,"version":17,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:create","trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:select","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:insert","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate","presto:execute","presto:delete","presto:create","presto:drop","presto:select"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:read_acl","ozone:read","ozone:write","ozone:create","ozone:list","ozone:delete","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:read","hbase:create"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:repladmin","hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]},{"itemId":9010,"name":"kafka:publish","label":"Publish","impliedGrants":["kafka:describe"]},{"itemId":9011,"name":"kafka:consume","label":"Consume","impliedGrants":["kafka:describe"]},{"itemId":9014,"name":"kafka:configure","label":"Configure","impliedGrants":["kafka:describe"]},{"itemId":9015,"name":"kafka:describe","label":"Describe"},{"itemId":9016,"name":"kafka:kafka_admin","label":"Kafka Admin","impliedGrants":["kafka:idempotent_write","kafka:alter","kafka:alter_configs","kafka:describe_configs","kafka:create","kafka:describe","kafka:publish","kafka:delete","kafka:cluster_action","kafka:configure","kafka:consume"]},{"itemId":9017,"name":"kafka:create","label":"Create"},{"itemId":9018,"name":"kafka:delete","label":"Delete","impliedGrants":["kafka:describe"]},{"itemId":9019,"name":"kafka:idempotent_write","label":"Idempotent Write"},{"itemId":9020,"name":"kafka:describe_configs","label":"Describe Configs"},{"itemId":9021,"name":"kafka:alter_configs","label":"Alter Configs","impliedGrants":["kafka:describe_configs"]},{"itemId":9022,"name":"kafka:cluster_action","label":"Cluster Action"},{"itemId":9023,"name":"kafka:alter","label":"Alter"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
24	2024-02-08 17:01:09.379	2024-02-08 17:01:11.665	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	6	Update	2024-02-08 17:01:09.379	2024-02-08 17:01:11.665	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669296,"version":6,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_put","elasticsearch:indices_bulk"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_bulk","elasticsearch:indices_put","elasticsearch:indices_index"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:select","trino:insert","trino:create","trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:execute","presto:select","presto:insert","presto:create","presto:delete","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate"]},{"itemId":17030,"name":"presto:execute","label":"execute"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
39	2024-02-08 17:01:12.08	2024-02-08 17:01:12.08	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	18	Update	2024-02-08 17:01:12.08	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411671682,"version":18,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:create","trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:select","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:insert","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate","presto:execute","presto:delete","presto:create","presto:drop","presto:select"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:read_acl","ozone:read","ozone:write","ozone:create","ozone:list","ozone:delete","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:read","hbase:create"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:repladmin","hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]},{"itemId":9010,"name":"kafka:publish","label":"Publish","impliedGrants":["kafka:describe"]},{"itemId":9011,"name":"kafka:consume","label":"Consume","impliedGrants":["kafka:describe"]},{"itemId":9014,"name":"kafka:configure","label":"Configure","impliedGrants":["kafka:describe"]},{"itemId":9015,"name":"kafka:describe","label":"Describe"},{"itemId":9016,"name":"kafka:kafka_admin","label":"Kafka Admin","impliedGrants":["kafka:idempotent_write","kafka:alter","kafka:alter_configs","kafka:describe_configs","kafka:create","kafka:describe","kafka:publish","kafka:delete","kafka:cluster_action","kafka:configure","kafka:consume"]},{"itemId":9017,"name":"kafka:create","label":"Create"},{"itemId":9018,"name":"kafka:delete","label":"Delete","impliedGrants":["kafka:describe"]},{"itemId":9019,"name":"kafka:idempotent_write","label":"Idempotent Write"},{"itemId":9020,"name":"kafka:describe_configs","label":"Describe Configs"},{"itemId":9021,"name":"kafka:alter_configs","label":"Alter Configs","impliedGrants":["kafka:describe_configs"]},{"itemId":9022,"name":"kafka:cluster_action","label":"Cluster Action"},{"itemId":9023,"name":"kafka:alter","label":"Alter"},{"itemId":8108,"name":"solr:query","label":"Query"},{"itemId":8208,"name":"solr:update","label":"Update"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
26	2024-02-08 17:01:09.511	2024-02-08 17:01:12.08	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	7	Update	2024-02-08 17:01:09.511	2024-02-08 17:01:12.08	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669418,"version":7,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_search_shards","elasticsearch:indices_put","elasticsearch:create_index","elasticsearch:delete_index","elasticsearch:write","elasticsearch:delete","elasticsearch:create","elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_put","elasticsearch:indices_bulk"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:alter","trino:use","trino:drop","trino:delete","trino:create","trino:insert","trino:select"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:grant","presto:insert","presto:create","presto:delete","presto:drop","presto:use","presto:alter","presto:select","presto:revoke","presto:show","presto:impersonate","presto:execute"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:read","ozone:write_acl","ozone:read_acl","ozone:delete","ozone:list","ozone:create","ozone:write"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
40	2024-02-08 17:01:12.478	2024-02-08 17:01:12.478	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	19	Update	2024-02-08 17:01:12.478	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411672094,"version":19,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:create","trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:select","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:insert","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate","presto:execute","presto:delete","presto:create","presto:drop","presto:select"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:read_acl","ozone:read","ozone:write","ozone:create","ozone:list","ozone:delete","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:read","hbase:create"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:repladmin","hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]},{"itemId":9010,"name":"kafka:publish","label":"Publish","impliedGrants":["kafka:describe"]},{"itemId":9011,"name":"kafka:consume","label":"Consume","impliedGrants":["kafka:describe"]},{"itemId":9014,"name":"kafka:configure","label":"Configure","impliedGrants":["kafka:describe"]},{"itemId":9015,"name":"kafka:describe","label":"Describe"},{"itemId":9016,"name":"kafka:kafka_admin","label":"Kafka Admin","impliedGrants":["kafka:idempotent_write","kafka:alter","kafka:alter_configs","kafka:describe_configs","kafka:create","kafka:describe","kafka:publish","kafka:delete","kafka:cluster_action","kafka:configure","kafka:consume"]},{"itemId":9017,"name":"kafka:create","label":"Create"},{"itemId":9018,"name":"kafka:delete","label":"Delete","impliedGrants":["kafka:describe"]},{"itemId":9019,"name":"kafka:idempotent_write","label":"Idempotent Write"},{"itemId":9020,"name":"kafka:describe_configs","label":"Describe Configs"},{"itemId":9021,"name":"kafka:alter_configs","label":"Alter Configs","impliedGrants":["kafka:describe_configs"]},{"itemId":9022,"name":"kafka:cluster_action","label":"Cluster Action"},{"itemId":9023,"name":"kafka:alter","label":"Alter"},{"itemId":8108,"name":"solr:query","label":"Query"},{"itemId":8208,"name":"solr:update","label":"Update"},{"itemId":202203,"name":"schema-registry:create","label":"Create"},{"itemId":202204,"name":"schema-registry:read","label":"Read"},{"itemId":202205,"name":"schema-registry:update","label":"Update"},{"itemId":202206,"name":"schema-registry:delete","label":"Delete"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
41	2024-02-08 17:01:12.868	2024-02-08 17:01:12.868	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	20	Update	2024-02-08 17:01:12.868	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411672490,"version":20,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:create","trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:select","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:insert","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate","presto:execute","presto:delete","presto:create","presto:drop","presto:select"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:read_acl","ozone:read","ozone:write","ozone:create","ozone:list","ozone:delete","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:read","hbase:create"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:repladmin","hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]},{"itemId":9010,"name":"kafka:publish","label":"Publish","impliedGrants":["kafka:describe"]},{"itemId":9011,"name":"kafka:consume","label":"Consume","impliedGrants":["kafka:describe"]},{"itemId":9014,"name":"kafka:configure","label":"Configure","impliedGrants":["kafka:describe"]},{"itemId":9015,"name":"kafka:describe","label":"Describe"},{"itemId":9016,"name":"kafka:kafka_admin","label":"Kafka Admin","impliedGrants":["kafka:idempotent_write","kafka:alter","kafka:alter_configs","kafka:describe_configs","kafka:create","kafka:describe","kafka:publish","kafka:delete","kafka:cluster_action","kafka:configure","kafka:consume"]},{"itemId":9017,"name":"kafka:create","label":"Create"},{"itemId":9018,"name":"kafka:delete","label":"Delete","impliedGrants":["kafka:describe"]},{"itemId":9019,"name":"kafka:idempotent_write","label":"Idempotent Write"},{"itemId":9020,"name":"kafka:describe_configs","label":"Describe Configs"},{"itemId":9021,"name":"kafka:alter_configs","label":"Alter Configs","impliedGrants":["kafka:describe_configs"]},{"itemId":9022,"name":"kafka:cluster_action","label":"Cluster Action"},{"itemId":9023,"name":"kafka:alter","label":"Alter"},{"itemId":8108,"name":"solr:query","label":"Query"},{"itemId":8208,"name":"solr:update","label":"Update"},{"itemId":202203,"name":"schema-registry:create","label":"Create"},{"itemId":202204,"name":"schema-registry:read","label":"Read"},{"itemId":202205,"name":"schema-registry:update","label":"Update"},{"itemId":202206,"name":"schema-registry:delete","label":"Delete"},{"itemId":10110,"name":"nifi:READ","label":"Read"},{"itemId":10210,"name":"nifi:WRITE","label":"Write"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
14	2024-02-08 17:01:08.956	2024-02-08 17:01:12.868	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	1	Create	2024-02-08 17:01:08.956	2024-02-08 17:01:12.868	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411668945,"version":1,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{},"rowFilterDef":{}}
42	2024-02-08 17:01:13.34	2024-02-08 17:01:13.34	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	21	Update	2024-02-08 17:01:13.34	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411672886,"version":21,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:indices_put"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:create","trino:delete","trino:drop","trino:use","trino:alter","trino:grant","trino:revoke","trino:show","trino:impersonate","trino:execute","trino:select","trino:insert"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:insert","presto:use","presto:alter","presto:grant","presto:revoke","presto:show","presto:impersonate","presto:execute","presto:delete","presto:create","presto:drop","presto:select"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:read_acl","ozone:read","ozone:write","ozone:create","ozone:list","ozone:delete","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:drop","kudu:metadata","kudu:select","kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:read","hbase:create"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:repladmin","hive:write","hive:read","hive:lock","hive:index","hive:alter","hive:drop","hive:create","hive:update","hive:select","hive:refresh","hive:serviceadmin"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]},{"itemId":9010,"name":"kafka:publish","label":"Publish","impliedGrants":["kafka:describe"]},{"itemId":9011,"name":"kafka:consume","label":"Consume","impliedGrants":["kafka:describe"]},{"itemId":9014,"name":"kafka:configure","label":"Configure","impliedGrants":["kafka:describe"]},{"itemId":9015,"name":"kafka:describe","label":"Describe"},{"itemId":9016,"name":"kafka:kafka_admin","label":"Kafka Admin","impliedGrants":["kafka:idempotent_write","kafka:alter","kafka:alter_configs","kafka:describe_configs","kafka:create","kafka:describe","kafka:publish","kafka:delete","kafka:cluster_action","kafka:configure","kafka:consume"]},{"itemId":9017,"name":"kafka:create","label":"Create"},{"itemId":9018,"name":"kafka:delete","label":"Delete","impliedGrants":["kafka:describe"]},{"itemId":9019,"name":"kafka:idempotent_write","label":"Idempotent Write"},{"itemId":9020,"name":"kafka:describe_configs","label":"Describe Configs"},{"itemId":9021,"name":"kafka:alter_configs","label":"Alter Configs","impliedGrants":["kafka:describe_configs"]},{"itemId":9022,"name":"kafka:cluster_action","label":"Cluster Action"},{"itemId":9023,"name":"kafka:alter","label":"Alter"},{"itemId":8108,"name":"solr:query","label":"Query"},{"itemId":8208,"name":"solr:update","label":"Update"},{"itemId":202203,"name":"schema-registry:create","label":"Create"},{"itemId":202204,"name":"schema-registry:read","label":"Read"},{"itemId":202205,"name":"schema-registry:update","label":"Update"},{"itemId":202206,"name":"schema-registry:delete","label":"Delete"},{"itemId":10110,"name":"nifi:READ","label":"Read"},{"itemId":10210,"name":"nifi:WRITE","label":"Write"},{"itemId":13113,"name":"nifi-registry:READ","label":"Read"},{"itemId":13213,"name":"nifi-registry:WRITE","label":"Write"},{"itemId":13313,"name":"nifi-registry:DELETE","label":"Delete"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
43	2024-02-08 17:01:13.783	2024-02-08 17:01:13.783	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	22	Update	2024-02-08 17:01:13.783	\N	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411673361,"version":22,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:read","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:create_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:indices_bulk","elasticsearch:monitor","elasticsearch:indices_index","elasticsearch:manage","elasticsearch:view_index_metadata"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:execute","trino:delete","trino:drop","trino:create","trino:insert","trino:select","trino:revoke","trino:impersonate","trino:show","trino:use","trino:alter","trino:grant"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:use","presto:alter","presto:execute","presto:impersonate","presto:show","presto:revoke","presto:grant","presto:select","presto:insert","presto:create","presto:delete","presto:drop"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:create","ozone:read","ozone:write","ozone:list","ozone:delete","ozone:read_acl","ozone:write_acl"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:insert","kudu:update","kudu:delete","kudu:alter","kudu:create","kudu:drop","kudu:metadata","kudu:select"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"},{"itemId":2003,"name":"hbase:read","label":"Read"},{"itemId":2004,"name":"hbase:write","label":"Write"},{"itemId":2005,"name":"hbase:create","label":"Create"},{"itemId":2006,"name":"hbase:admin","label":"Admin","impliedGrants":["hbase:write","hbase:create","hbase:read"]},{"itemId":2007,"name":"hbase:execute","label":"Execute"},{"itemId":3004,"name":"hive:select","label":"select"},{"itemId":3005,"name":"hive:update","label":"update"},{"itemId":3006,"name":"hive:create","label":"Create"},{"itemId":3007,"name":"hive:drop","label":"Drop"},{"itemId":3008,"name":"hive:alter","label":"Alter"},{"itemId":3009,"name":"hive:index","label":"Index"},{"itemId":3010,"name":"hive:lock","label":"Lock"},{"itemId":3011,"name":"hive:all","label":"All","impliedGrants":["hive:read","hive:select","hive:update","hive:create","hive:drop","hive:alter","hive:index","hive:lock","hive:write","hive:repladmin","hive:serviceadmin","hive:refresh"]},{"itemId":3012,"name":"hive:read","label":"Read"},{"itemId":3013,"name":"hive:write","label":"Write"},{"itemId":3014,"name":"hive:repladmin","label":"ReplAdmin"},{"itemId":3015,"name":"hive:serviceadmin","label":"Service Admin"},{"itemId":3016,"name":"hive:tempudfadmin","label":"Temporary UDF Admin"},{"itemId":3017,"name":"hive:refresh","label":"Refresh"},{"itemId":7008,"name":"kms:create","label":"Create"},{"itemId":7009,"name":"kms:delete","label":"Delete"},{"itemId":7010,"name":"kms:rollover","label":"Rollover"},{"itemId":7011,"name":"kms:setkeymaterial","label":"Set Key Material"},{"itemId":7012,"name":"kms:get","label":"Get"},{"itemId":7013,"name":"kms:getkeys","label":"Get Keys"},{"itemId":7014,"name":"kms:getmetadata","label":"Get Metadata"},{"itemId":7015,"name":"kms:generateeek","label":"Generate EEK"},{"itemId":7016,"name":"kms:decrypteek","label":"Decrypt EEK"},{"itemId":5006,"name":"knox:allow","label":"Allow"},{"itemId":6007,"name":"storm:submitTopology","label":"Submit Topology","impliedGrants":["storm:fileUpload","storm:fileDownload"]},{"itemId":6008,"name":"storm:fileUpload","label":"File Upload"},{"itemId":6011,"name":"storm:fileDownload","label":"File Download"},{"itemId":6012,"name":"storm:killTopology","label":"Kill Topology"},{"itemId":6013,"name":"storm:rebalance","label":"Rebalance"},{"itemId":6014,"name":"storm:activate","label":"Activate"},{"itemId":6015,"name":"storm:deactivate","label":"Deactivate"},{"itemId":6016,"name":"storm:getTopologyConf","label":"Get Topology Conf"},{"itemId":6017,"name":"storm:getTopology","label":"Get Topology"},{"itemId":6018,"name":"storm:getUserTopology","label":"Get User Topology"},{"itemId":6019,"name":"storm:getTopologyInfo","label":"Get Topology Info"},{"itemId":6020,"name":"storm:uploadNewCredentials","label":"Upload New Credential"},{"itemId":4005,"name":"yarn:submit-app","label":"submit-app"},{"itemId":4006,"name":"yarn:admin-queue","label":"admin-queue","impliedGrants":["yarn:submit-app"]},{"itemId":9010,"name":"kafka:publish","label":"Publish","impliedGrants":["kafka:describe"]},{"itemId":9011,"name":"kafka:consume","label":"Consume","impliedGrants":["kafka:describe"]},{"itemId":9014,"name":"kafka:configure","label":"Configure","impliedGrants":["kafka:describe"]},{"itemId":9015,"name":"kafka:describe","label":"Describe"},{"itemId":9016,"name":"kafka:kafka_admin","label":"Kafka Admin","impliedGrants":["kafka:consume","kafka:configure","kafka:alter_configs","kafka:describe_configs","kafka:create","kafka:describe","kafka:alter","kafka:idempotent_write","kafka:cluster_action","kafka:delete","kafka:publish"]},{"itemId":9017,"name":"kafka:create","label":"Create"},{"itemId":9018,"name":"kafka:delete","label":"Delete","impliedGrants":["kafka:describe"]},{"itemId":9019,"name":"kafka:idempotent_write","label":"Idempotent Write"},{"itemId":9020,"name":"kafka:describe_configs","label":"Describe Configs"},{"itemId":9021,"name":"kafka:alter_configs","label":"Alter Configs","impliedGrants":["kafka:describe_configs"]},{"itemId":9022,"name":"kafka:cluster_action","label":"Cluster Action"},{"itemId":9023,"name":"kafka:alter","label":"Alter"},{"itemId":8108,"name":"solr:query","label":"Query"},{"itemId":8208,"name":"solr:update","label":"Update"},{"itemId":202203,"name":"schema-registry:create","label":"Create"},{"itemId":202204,"name":"schema-registry:read","label":"Read"},{"itemId":202205,"name":"schema-registry:update","label":"Update"},{"itemId":202206,"name":"schema-registry:delete","label":"Delete"},{"itemId":10110,"name":"nifi:READ","label":"Read"},{"itemId":10210,"name":"nifi:WRITE","label":"Write"},{"itemId":13113,"name":"nifi-registry:READ","label":"Read"},{"itemId":13213,"name":"nifi-registry:WRITE","label":"Write"},{"itemId":13313,"name":"nifi-registry:DELETE","label":"Delete"},{"itemId":15016,"name":"atlas:type-create","label":"Create Type","impliedGrants":["atlas:type-read"]},{"itemId":15017,"name":"atlas:type-update","label":"Update Type","impliedGrants":["atlas:type-read"]},{"itemId":15018,"name":"atlas:type-delete","label":"Delete Type","impliedGrants":["atlas:type-read"]},{"itemId":15019,"name":"atlas:entity-read","label":"Read Entity"},{"itemId":15020,"name":"atlas:entity-create","label":"Create Entity"},{"itemId":15021,"name":"atlas:entity-update","label":"Update Entity"},{"itemId":15022,"name":"atlas:entity-delete","label":"Delete Entity"},{"itemId":15023,"name":"atlas:entity-add-classification","label":"Add Classification"},{"itemId":15024,"name":"atlas:entity-update-classification","label":"Update Classification"},{"itemId":15025,"name":"atlas:entity-remove-classification","label":"Remove Classification"},{"itemId":15026,"name":"atlas:admin-export","label":"Admin Export"},{"itemId":15027,"name":"atlas:admin-import","label":"Admin Import"},{"itemId":15028,"name":"atlas:add-relationship","label":"Add Relationship"},{"itemId":15029,"name":"atlas:update-relationship","label":"Update Relationship"},{"itemId":15030,"name":"atlas:remove-relationship","label":"Remove Relationship"},{"itemId":15031,"name":"atlas:admin-purge","label":"Admin Purge"},{"itemId":15032,"name":"atlas:entity-add-label","label":"Add Label"},{"itemId":15033,"name":"atlas:entity-remove-label","label":"Remove Label"},{"itemId":15034,"name":"atlas:entity-update-business-metadata","label":"Update Business Metadata"},{"itemId":15035,"name":"atlas:type-read","label":"Read Type"},{"itemId":15036,"name":"atlas:admin-audits","label":"Admin Audits"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"},{"itemId":3004,"name":"hive:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({col})"},{"itemId":3005,"name":"hive:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3006,"name":"hive:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":3007,"name":"hive:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({col})"},{"itemId":3008,"name":"hive:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":3009,"name":"hive:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":3015,"name":"hive:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":3016,"name":"hive:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":3004,"name":"hive:select","label":"select"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
31	2024-02-08 17:01:10.094	2024-02-08 17:01:13.783	0d047248-baff-4cf9-8e9e-d5d377284b2e	1033	100	tag	10	Update	2024-02-08 17:01:10.094	2024-02-08 17:01:13.783	{"id":100,"guid":"0d047248-baff-4cf9-8e9e-d5d377284b2e","isEnabled":true,"createTime":1707411668945,"updateTime":1707411669943,"version":10,"name":"tag","displayName":"tag","implClass":"org.apache.ranger.services.tag.RangerServiceTag","label":"TAG","description":"TAG Service Definition","options":{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"},"configs":[{"itemId":1,"name":"ranger.plugin.audit.filters","type":"string","mandatory":false,"defaultValue":"[ {'accessResult': 'DENIED', 'isAudited': true} ]","label":"Ranger Default Audit Filters"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}],"accessTypes":[{"itemId":14015,"name":"sqoop:READ","label":"READ"},{"itemId":14016,"name":"sqoop:WRITE","label":"WRITE"},{"itemId":12013,"name":"kylin:QUERY","label":"QUERY"},{"itemId":12014,"name":"kylin:OPERATION","label":"OPERATION"},{"itemId":12015,"name":"kylin:MANAGEMENT","label":"MANAGEMENT"},{"itemId":12016,"name":"kylin:ADMIN","label":"ADMIN"},{"itemId":16017,"name":"elasticsearch:all","label":"all","impliedGrants":["elasticsearch:create_index","elasticsearch:indices_index","elasticsearch:indices_bulk","elasticsearch:read_cross_cluster","elasticsearch:index","elasticsearch:create","elasticsearch:delete","elasticsearch:write","elasticsearch:delete_index","elasticsearch:indices_put","elasticsearch:indices_search_shards","elasticsearch:monitor","elasticsearch:manage","elasticsearch:view_index_metadata","elasticsearch:read"]},{"itemId":16018,"name":"elasticsearch:monitor","label":"monitor"},{"itemId":16019,"name":"elasticsearch:manage","label":"manage","impliedGrants":["elasticsearch:monitor"]},{"itemId":16020,"name":"elasticsearch:view_index_metadata","label":"view_index_metadata","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16021,"name":"elasticsearch:read","label":"read"},{"itemId":16022,"name":"elasticsearch:read_cross_cluster","label":"read_cross_cluster","impliedGrants":["elasticsearch:indices_search_shards"]},{"itemId":16023,"name":"elasticsearch:index","label":"index","impliedGrants":["elasticsearch:indices_put","elasticsearch:indices_bulk","elasticsearch:indices_index"]},{"itemId":16024,"name":"elasticsearch:create","label":"create","impliedGrants":["elasticsearch:indices_index","elasticsearch:indices_put","elasticsearch:indices_bulk"]},{"itemId":16025,"name":"elasticsearch:delete","label":"delete","impliedGrants":["elasticsearch:indices_bulk"]},{"itemId":16026,"name":"elasticsearch:write","label":"write","impliedGrants":["elasticsearch:indices_put"]},{"itemId":16027,"name":"elasticsearch:delete_index","label":"delete_index"},{"itemId":16028,"name":"elasticsearch:create_index","label":"create_index"},{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":203205,"name":"trino:insert","label":"Insert"},{"itemId":203206,"name":"trino:create","label":"Create"},{"itemId":203207,"name":"trino:drop","label":"Drop"},{"itemId":203208,"name":"trino:delete","label":"Delete"},{"itemId":203209,"name":"trino:use","label":"Use"},{"itemId":203210,"name":"trino:alter","label":"Alter"},{"itemId":203211,"name":"trino:grant","label":"Grant"},{"itemId":203212,"name":"trino:revoke","label":"Revoke"},{"itemId":203213,"name":"trino:show","label":"Show"},{"itemId":203214,"name":"trino:impersonate","label":"Impersonate"},{"itemId":203215,"name":"trino:all","label":"All","impliedGrants":["trino:select","trino:execute","trino:show","trino:revoke","trino:grant","trino:alter","trino:use","trino:drop","trino:delete","trino:create","trino:insert","trino:impersonate"]},{"itemId":203216,"name":"trino:execute","label":"execute"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":17019,"name":"presto:insert","label":"Insert"},{"itemId":17020,"name":"presto:create","label":"Create"},{"itemId":17021,"name":"presto:drop","label":"Drop"},{"itemId":17022,"name":"presto:delete","label":"Delete"},{"itemId":17023,"name":"presto:use","label":"Use"},{"itemId":17024,"name":"presto:alter","label":"Alter"},{"itemId":17025,"name":"presto:grant","label":"Grant"},{"itemId":17026,"name":"presto:revoke","label":"Revoke"},{"itemId":17027,"name":"presto:show","label":"Show"},{"itemId":17028,"name":"presto:impersonate","label":"Impersonate"},{"itemId":17029,"name":"presto:all","label":"All","impliedGrants":["presto:impersonate","presto:execute","presto:create","presto:insert","presto:delete","presto:select","presto:drop","presto:use","presto:alter","presto:grant","presto:revoke","presto:show"]},{"itemId":17030,"name":"presto:execute","label":"execute"},{"itemId":201209,"name":"ozone:all","label":"All","impliedGrants":["ozone:list","ozone:delete","ozone:read_acl","ozone:write_acl","ozone:read","ozone:write","ozone:create"]},{"itemId":201202,"name":"ozone:read","label":"Read"},{"itemId":201203,"name":"ozone:write","label":"Write"},{"itemId":201204,"name":"ozone:create","label":"Create"},{"itemId":201205,"name":"ozone:list","label":"List"},{"itemId":201206,"name":"ozone:delete","label":"Delete"},{"itemId":201207,"name":"ozone:read_acl","label":"Read_ACL"},{"itemId":201208,"name":"ozone:write_acl","label":"Write_ACL"},{"itemId":105106,"name":"kudu:select","label":"SELECT","impliedGrants":["kudu:metadata"]},{"itemId":105107,"name":"kudu:insert","label":"INSERT","impliedGrants":["kudu:metadata"]},{"itemId":105108,"name":"kudu:update","label":"UPDATE","impliedGrants":["kudu:metadata"]},{"itemId":105109,"name":"kudu:delete","label":"DELETE","impliedGrants":["kudu:metadata"]},{"itemId":105110,"name":"kudu:alter","label":"ALTER","impliedGrants":["kudu:metadata"]},{"itemId":105111,"name":"kudu:create","label":"CREATE","impliedGrants":["kudu:metadata"]},{"itemId":105112,"name":"kudu:drop","label":"DROP","impliedGrants":["kudu:metadata"]},{"itemId":105113,"name":"kudu:metadata","label":"METADATA"},{"itemId":105114,"name":"kudu:all","label":"ALL","impliedGrants":["kudu:alter","kudu:update","kudu:insert","kudu:select","kudu:metadata","kudu:delete","kudu:drop","kudu:create"]},{"itemId":205206,"name":"nestedstructure:read","label":"Read"},{"itemId":205207,"name":"nestedstructure:write","label":"Write"},{"itemId":1002,"name":"hdfs:read","label":"Read"},{"itemId":1003,"name":"hdfs:write","label":"Write"},{"itemId":1004,"name":"hdfs:execute","label":"Execute"}],"policyConditions":[{"itemId":1,"name":"accessed-after-expiry","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator","evaluatorOptions":{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"},"uiHint":"{ \\"singleValue\\":true }","label":"Accessed after expiry_date (yes/no)?","description":"Accessed after expiry_date? (yes/no)"},{"itemId":2,"name":"expression","evaluator":"org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator","evaluatorOptions":{"engineName":"JavaScript","ui.isMultiline":"true"},"uiHint":"{ \\"isMultiline\\":true }","label":"Enter boolean expression","description":"Boolean expression"}],"contextEnrichers":[{"itemId":1,"name":"TagEnricher","enricher":"org.apache.ranger.plugin.contextenricher.RangerTagEnricher","enricherOptions":{"tagRetrieverClassName":"org.apache.ranger.plugin.contextenricher.RangerAdminTagRetriever","tagRefresherPollingInterval":"60000"}}],"dataMaskDef":{"maskTypes":[{"itemId":203204,"name":"trino:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":203205,"name":"trino:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":203206,"name":"trino:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":203207,"name":"trino:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":203208,"name":"trino:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":203209,"name":"trino:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":203215,"name":"trino:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":203216,"name":"trino:CUSTOM","label":"Custom","description":"Custom"},{"itemId":17018,"name":"presto:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})"},{"itemId":17019,"name":"presto:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'X'","transformer":"cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})"},{"itemId":17020,"name":"presto:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})"},{"itemId":17021,"name":"presto:MASK_HASH","label":"Hash","description":"Hash the value of a varchar with sha256","transformer":"cast(to_hex(sha256(to_utf8({col}))) as {type})"},{"itemId":17022,"name":"presto:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":17023,"name":"presto:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":17029,"name":"presto:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"date_trunc('year', {col})"},{"itemId":17030,"name":"presto:CUSTOM","label":"Custom","description":"Custom"},{"itemId":205206,"name":"nestedstructure:MASK","label":"Redact","description":"Replace lowercase with 'x', uppercase with 'X', digits with '0'","transformer":"mask({field})"},{"itemId":205207,"name":"nestedstructure:MASK_SHOW_LAST_4","label":"Partial mask: show last 4","description":"Show last 4 characters; replace rest with 'x'","transformer":"mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205208,"name":"nestedstructure:MASK_SHOW_FIRST_4","label":"Partial mask: show first 4","description":"Show first 4 characters; replace rest with 'x'","transformer":"mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')"},{"itemId":205209,"name":"nestedstructure:MASK_HASH","label":"Hash","description":"Hash the value","transformer":"mask_hash({field})"},{"itemId":205210,"name":"nestedstructure:MASK_NULL","label":"Nullify","description":"Replace with NULL"},{"itemId":205211,"name":"nestedstructure:MASK_NONE","label":"Unmasked (retain original value)","description":"No masking"},{"itemId":205217,"name":"nestedstructure:MASK_DATE_SHOW_YEAR","label":"Date: show only year","description":"Date: show only year","transformer":"mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)"},{"itemId":205218,"name":"nestedstructure:CUSTOM","label":"Custom","description":"Custom"}],"accessTypes":[{"itemId":203204,"name":"trino:select","label":"Select"},{"itemId":17018,"name":"presto:select","label":"Select"},{"itemId":205206,"name":"nestedstructure:read","label":"Read"}],"resources":[{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}]},"rowFilterDef":{}}
45	2024-02-08 17:01:50.019	2024-02-08 17:01:50.019	7b38d7be-097a-4d80-811f-dd601327f691	1020	1	all - path	1	Create	2024-02-08 17:01:50.019	\N	{"id":1,"guid":"7b38d7be-097a-4d80-811f-dd601327f691","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411709978,"updateTime":1707411709985,"version":1,"service":"dev_hdfs","name":"all - path","policyType":0,"policyPriority":0,"description":"Policy for all - path","resourceSignature":"dfe81e379022be6cadb1665e2a3883824f2bc09626557a32efa3a236609005b6","isAuditEnabled":true,"resources":{"path":{"values":["/*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hdfs"],"delegateAdmin":true}],"serviceType":"hdfs","isDenyAllElse":false}
46	2024-02-08 17:01:50.045	2024-02-08 17:01:50.045	a12f56d5-bfd7-462c-9052-6f9a13ede01b	1020	2	kms-audit-path	1	Create	2024-02-08 17:01:50.045	\N	{"id":2,"guid":"a12f56d5-bfd7-462c-9052-6f9a13ede01b","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710033,"updateTime":1707411710034,"version":1,"service":"dev_hdfs","name":"kms-audit-path","policyType":0,"policyPriority":0,"description":"Policy for kms-audit-path","resourceSignature":"b349a238ab1cea962a44878de9da2231537b5b1ab65006ca892565679d6ab1e0","isAuditEnabled":true,"resources":{"path":{"values":["/ranger/audit/kms"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["keyadmin"],"delegateAdmin":false}],"serviceType":"hdfs","isDenyAllElse":false}
47	2024-02-08 17:01:50.066	2024-02-08 17:01:50.066	623bb4a6-39f8-4f46-86d1-bbafbfdad3f9	1020	3	hbase-archive	1	Create	2024-02-08 17:01:50.066	\N	{"id":3,"guid":"623bb4a6-39f8-4f46-86d1-bbafbfdad3f9","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710055,"updateTime":1707411710056,"version":1,"service":"dev_hdfs","name":"hbase-archive","policyType":0,"policyPriority":0,"description":"Policy for hbase archive location","resourceSignature":"37fe368bc41139223d1f995603a4e71c352b8804e0413c0a06235b09ab42b19c","isAuditEnabled":true,"resources":{"path":{"values":["/hbase/archive"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"delegateAdmin":false}],"serviceType":"hdfs","isDenyAllElse":false}
48	2024-02-08 17:01:50.084	2024-02-08 17:01:50.084	a0031e86-6c37-4266-b3f3-447b09d9b62c	1030	2	dev_tag	1	Create	2024-02-08 17:01:50.084	\N	{"id":2,"guid":"a0031e86-6c37-4266-b3f3-447b09d9b62c","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710081,"updateTime":1707411710082,"version":1,"type":"tag","name":"dev_tag","displayName":"dev_tag","configs":{"ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true} ]"},"policyVersion":1,"policyUpdateTime":1707411710082,"tagVersion":1,"tagUpdateTime":1707411710082}
49	2024-02-08 17:01:50.167	2024-02-08 17:01:50.167	59114281-789e-40df-b3be-7fbea75fabc1	1020	4	EXPIRES_ON	1	Create	2024-02-08 17:01:50.167	\N	{"id":4,"guid":"59114281-789e-40df-b3be-7fbea75fabc1","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710094,"updateTime":1707411710096,"version":1,"service":"dev_tag","name":"EXPIRES_ON","policyType":0,"policyPriority":0,"description":"Policy for data with EXPIRES_ON tag","resourceSignature":"2d8c4c28be705d39c7f0665466adf8ffdb0bc845a0b6d87e7c7abdd793e449a9","isAuditEnabled":true,"resources":{"tag":{"values":["EXPIRES_ON"],"isExcludes":false,"isRecursive":false}},"denyPolicyItems":[{"accesses":[{"type":"sqoop:READ","isAllowed":true},{"type":"sqoop:WRITE","isAllowed":true},{"type":"kylin:QUERY","isAllowed":true},{"type":"kylin:OPERATION","isAllowed":true},{"type":"kylin:MANAGEMENT","isAllowed":true},{"type":"kylin:ADMIN","isAllowed":true},{"type":"elasticsearch:all","isAllowed":true},{"type":"elasticsearch:monitor","isAllowed":true},{"type":"elasticsearch:manage","isAllowed":true},{"type":"elasticsearch:view_index_metadata","isAllowed":true},{"type":"elasticsearch:read","isAllowed":true},{"type":"elasticsearch:read_cross_cluster","isAllowed":true},{"type":"elasticsearch:index","isAllowed":true},{"type":"elasticsearch:create","isAllowed":true},{"type":"elasticsearch:delete","isAllowed":true},{"type":"elasticsearch:write","isAllowed":true},{"type":"elasticsearch:delete_index","isAllowed":true},{"type":"elasticsearch:create_index","isAllowed":true},{"type":"trino:select","isAllowed":true},{"type":"trino:insert","isAllowed":true},{"type":"trino:create","isAllowed":true},{"type":"trino:drop","isAllowed":true},{"type":"trino:delete","isAllowed":true},{"type":"trino:use","isAllowed":true},{"type":"trino:alter","isAllowed":true},{"type":"trino:grant","isAllowed":true},{"type":"trino:revoke","isAllowed":true},{"type":"trino:show","isAllowed":true},{"type":"trino:impersonate","isAllowed":true},{"type":"trino:all","isAllowed":true},{"type":"trino:execute","isAllowed":true},{"type":"presto:select","isAllowed":true},{"type":"presto:insert","isAllowed":true},{"type":"presto:create","isAllowed":true},{"type":"presto:drop","isAllowed":true},{"type":"presto:delete","isAllowed":true},{"type":"presto:use","isAllowed":true},{"type":"presto:alter","isAllowed":true},{"type":"presto:grant","isAllowed":true},{"type":"presto:revoke","isAllowed":true},{"type":"presto:show","isAllowed":true},{"type":"presto:impersonate","isAllowed":true},{"type":"presto:all","isAllowed":true},{"type":"presto:execute","isAllowed":true},{"type":"ozone:all","isAllowed":true},{"type":"ozone:read","isAllowed":true},{"type":"ozone:write","isAllowed":true},{"type":"ozone:create","isAllowed":true},{"type":"ozone:list","isAllowed":true},{"type":"ozone:delete","isAllowed":true},{"type":"ozone:read_acl","isAllowed":true},{"type":"ozone:write_acl","isAllowed":true},{"type":"kudu:select","isAllowed":true},{"type":"kudu:insert","isAllowed":true},{"type":"kudu:update","isAllowed":true},{"type":"kudu:delete","isAllowed":true},{"type":"kudu:alter","isAllowed":true},{"type":"kudu:create","isAllowed":true},{"type":"kudu:drop","isAllowed":true},{"type":"kudu:metadata","isAllowed":true},{"type":"kudu:all","isAllowed":true},{"type":"nestedstructure:read","isAllowed":true},{"type":"nestedstructure:write","isAllowed":true},{"type":"hdfs:read","isAllowed":true},{"type":"hdfs:write","isAllowed":true},{"type":"hdfs:execute","isAllowed":true},{"type":"hbase:read","isAllowed":true},{"type":"hbase:write","isAllowed":true},{"type":"hbase:create","isAllowed":true},{"type":"hbase:admin","isAllowed":true},{"type":"hbase:execute","isAllowed":true},{"type":"hive:select","isAllowed":true},{"type":"hive:update","isAllowed":true},{"type":"hive:create","isAllowed":true},{"type":"hive:drop","isAllowed":true},{"type":"hive:alter","isAllowed":true},{"type":"hive:index","isAllowed":true},{"type":"hive:lock","isAllowed":true},{"type":"hive:all","isAllowed":true},{"type":"hive:read","isAllowed":true},{"type":"hive:write","isAllowed":true},{"type":"hive:repladmin","isAllowed":true},{"type":"hive:serviceadmin","isAllowed":true},{"type":"hive:tempudfadmin","isAllowed":true},{"type":"hive:refresh","isAllowed":true},{"type":"kms:create","isAllowed":true},{"type":"kms:delete","isAllowed":true},{"type":"kms:rollover","isAllowed":true},{"type":"kms:setkeymaterial","isAllowed":true},{"type":"kms:get","isAllowed":true},{"type":"kms:getkeys","isAllowed":true},{"type":"kms:getmetadata","isAllowed":true},{"type":"kms:generateeek","isAllowed":true},{"type":"kms:decrypteek","isAllowed":true},{"type":"knox:allow","isAllowed":true},{"type":"storm:submitTopology","isAllowed":true},{"type":"storm:fileUpload","isAllowed":true},{"type":"storm:fileDownload","isAllowed":true},{"type":"storm:killTopology","isAllowed":true},{"type":"storm:rebalance","isAllowed":true},{"type":"storm:activate","isAllowed":true},{"type":"storm:deactivate","isAllowed":true},{"type":"storm:getTopologyConf","isAllowed":true},{"type":"storm:getTopology","isAllowed":true},{"type":"storm:getUserTopology","isAllowed":true},{"type":"storm:getTopologyInfo","isAllowed":true},{"type":"storm:uploadNewCredentials","isAllowed":true},{"type":"yarn:submit-app","isAllowed":true},{"type":"yarn:admin-queue","isAllowed":true},{"type":"kafka:publish","isAllowed":true},{"type":"kafka:consume","isAllowed":true},{"type":"kafka:configure","isAllowed":true},{"type":"kafka:describe","isAllowed":true},{"type":"kafka:kafka_admin","isAllowed":true},{"type":"kafka:create","isAllowed":true},{"type":"kafka:delete","isAllowed":true},{"type":"kafka:idempotent_write","isAllowed":true},{"type":"kafka:describe_configs","isAllowed":true},{"type":"kafka:alter_configs","isAllowed":true},{"type":"kafka:cluster_action","isAllowed":true},{"type":"kafka:alter","isAllowed":true},{"type":"solr:query","isAllowed":true},{"type":"solr:update","isAllowed":true},{"type":"schema-registry:create","isAllowed":true},{"type":"schema-registry:read","isAllowed":true},{"type":"schema-registry:update","isAllowed":true},{"type":"schema-registry:delete","isAllowed":true},{"type":"nifi:READ","isAllowed":true},{"type":"nifi:WRITE","isAllowed":true},{"type":"nifi-registry:READ","isAllowed":true},{"type":"nifi-registry:WRITE","isAllowed":true},{"type":"nifi-registry:DELETE","isAllowed":true},{"type":"atlas:type-create","isAllowed":true},{"type":"atlas:type-update","isAllowed":true},{"type":"atlas:type-delete","isAllowed":true},{"type":"atlas:entity-read","isAllowed":true},{"type":"atlas:entity-create","isAllowed":true},{"type":"atlas:entity-update","isAllowed":true},{"type":"atlas:entity-delete","isAllowed":true},{"type":"atlas:entity-add-classification","isAllowed":true},{"type":"atlas:entity-update-classification","isAllowed":true},{"type":"atlas:entity-remove-classification","isAllowed":true},{"type":"atlas:admin-export","isAllowed":true},{"type":"atlas:admin-import","isAllowed":true},{"type":"atlas:add-relationship","isAllowed":true},{"type":"atlas:update-relationship","isAllowed":true},{"type":"atlas:remove-relationship","isAllowed":true},{"type":"atlas:admin-purge","isAllowed":true},{"type":"atlas:entity-add-label","isAllowed":true},{"type":"atlas:entity-remove-label","isAllowed":true},{"type":"atlas:entity-update-business-metadata","isAllowed":true},{"type":"atlas:type-read","isAllowed":true},{"type":"atlas:admin-audits","isAllowed":true}],"groups":["public"],"conditions":[{"type":"accessed-after-expiry","values":["yes"]}],"delegateAdmin":false}],"serviceType":"tag","isDenyAllElse":false}
50	2024-02-08 17:01:50.202	2024-02-08 17:01:50.202	46f7102b-79d1-4738-b93e-be6b310eaffa	1030	1	dev_hdfs	2	Update	2024-02-08 17:01:50.202	\N	{"id":1,"guid":"46f7102b-79d1-4738-b93e-be6b310eaffa","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411709882,"updateTime":1707411710186,"version":2,"type":"hdfs","name":"dev_hdfs","displayName":"dev_hdfs","tagService":"dev_tag","configs":{"password":"*****","hadoop.security.authentication":"simple","fs.default.name":"hdfs://ranger-hadoop:9000","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true}, {'actions':['delete','rename'],'isAudited':true}, {'users':['hdfs'], 'actions': ['listStatus', 'getfileinfo', 'listCachePools', 'listCacheDirectives', 'listCorruptFileBlocks', 'monitorHealth', 'rollEditLog', 'open'], 'isAudited': false}, {'users': ['oozie'],'resources': {'path': {'values': ['/user/oozie/share/lib'],'isRecursive': true}},'isAudited': false},{'users': ['spark'],'resources': {'path': {'values': ['/user/spark/applicationHistory'],'isRecursive': true}},'isAudited': false},{'users': ['hue'],'resources': {'path': {'values': ['/user/hue'],'isRecursive': true}},'isAudited': false},{'users': ['hbase'],'resources': {'path': {'values': ['/hbase'],'isRecursive': true}},'isAudited': false},{'users': ['mapred'],'resources': {'path': {'values': ['/user/history'],'isRecursive': true}},'isAudited': false}, {'actions': ['getfileinfo'], 'isAudited':false} ]","username":"hdfs"},"policyVersion":1,"policyUpdateTime":1707411709884,"tagVersion":1,"tagUpdateTime":1707411709884}
44	2024-02-08 17:01:49.948	2024-02-08 17:01:50.202	46f7102b-79d1-4738-b93e-be6b310eaffa	1030	1	dev_hdfs	1	Create	2024-02-08 17:01:49.948	2024-02-08 17:01:50.202	{"id":1,"guid":"46f7102b-79d1-4738-b93e-be6b310eaffa","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411709882,"updateTime":1707411709883,"version":1,"type":"hdfs","name":"dev_hdfs","displayName":"dev_hdfs","configs":{"password":"*****","hadoop.security.authentication":"simple","fs.default.name":"hdfs://ranger-hadoop:9000","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true}, {'actions':['delete','rename'],'isAudited':true}, {'users':['hdfs'], 'actions': ['listStatus', 'getfileinfo', 'listCachePools', 'listCacheDirectives', 'listCorruptFileBlocks', 'monitorHealth', 'rollEditLog', 'open'], 'isAudited': false}, {'users': ['oozie'],'resources': {'path': {'values': ['/user/oozie/share/lib'],'isRecursive': true}},'isAudited': false},{'users': ['spark'],'resources': {'path': {'values': ['/user/spark/applicationHistory'],'isRecursive': true}},'isAudited': false},{'users': ['hue'],'resources': {'path': {'values': ['/user/hue'],'isRecursive': true}},'isAudited': false},{'users': ['hbase'],'resources': {'path': {'values': ['/hbase'],'isRecursive': true}},'isAudited': false},{'users': ['mapred'],'resources': {'path': {'values': ['/user/history'],'isRecursive': true}},'isAudited': false}, {'actions': ['getfileinfo'], 'isAudited':false} ]","username":"hdfs"},"policyVersion":1,"policyUpdateTime":1707411709884,"tagVersion":1,"tagUpdateTime":1707411709884}
51	2024-02-08 17:01:50.311	2024-02-08 17:01:50.311	dc70f778-f7d8-4eff-b464-ad563b68e9f8	1030	3	dev_yarn	1	Create	2024-02-08 17:01:50.311	\N	{"id":3,"guid":"dc70f778-f7d8-4eff-b464-ad563b68e9f8","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710297,"updateTime":1707411710297,"version":1,"type":"yarn","name":"dev_yarn","displayName":"dev_yarn","tagService":"dev_tag","configs":{"password":"*****","yarn.url":"http://ranger-hadoop:8088","ranger.plugin.audit.filters":"[]","username":"yarn"},"policyVersion":1,"policyUpdateTime":1707411710298,"tagVersion":1,"tagUpdateTime":1707411710298}
72	2024-02-08 17:01:51	2024-02-08 17:01:51	162e0e57-ebaf-430f-8115-38f213e41d93	1030	8	dev_kms	1	Create	2024-02-08 17:01:51	\N	{"id":8,"guid":"162e0e57-ebaf-430f-8115-38f213e41d93","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710986,"updateTime":1707411710986,"version":1,"type":"kms","name":"dev_kms","displayName":"dev_kms","configs":{"password":"*****","provider":"http://ranger-kms:9292","ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['keyadmin'] ,'isAudited':false} ]","username":"keyadmin"},"policyVersion":1,"policyUpdateTime":1707411710986,"tagVersion":1,"tagUpdateTime":1707411710986}
52	2024-02-08 17:01:50.335	2024-02-08 17:01:50.335	c73eb3eb-b35e-4fc4-ad2b-096e01f45f25	1020	5	all - queue	1	Create	2024-02-08 17:01:50.335	\N	{"id":5,"guid":"c73eb3eb-b35e-4fc4-ad2b-096e01f45f25","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710325,"updateTime":1707411710327,"version":1,"service":"dev_yarn","name":"all - queue","policyType":0,"policyPriority":0,"description":"Policy for all - queue","resourceSignature":"ed9b305757e6a786d0b819425ba5c88375a8ec3723a6bc12d4462d70b3f33a3f","isAuditEnabled":true,"resources":{"queue":{"values":["*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"submit-app","isAllowed":true},{"type":"admin-queue","isAllowed":true}],"users":["yarn"],"delegateAdmin":true}],"serviceType":"yarn","isDenyAllElse":false}
53	2024-02-08 17:01:50.405	2024-02-08 17:01:50.405	bc062d2e-24db-49fd-aa25-e38689dd3fec	1030	4	dev_hive	1	Create	2024-02-08 17:01:50.405	\N	{"id":4,"guid":"bc062d2e-24db-49fd-aa25-e38689dd3fec","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710389,"updateTime":1707411710389,"version":1,"type":"hive","name":"dev_hive","displayName":"dev_hive","tagService":"dev_tag","configs":{"password":"*****","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'actions':['METADATA OPERATION'], 'isAudited': false}, {'users':['hive','hue'],'actions':['SHOW_ROLES'],'isAudited':false} ]","jdbc.driverClassName":"org.apache.hive.jdbc.HiveDriver","jdbc.url":"jdbc:hive2://ranger-hive:10000","username":"hive"},"policyVersion":1,"policyUpdateTime":1707411710390,"tagVersion":1,"tagUpdateTime":1707411710390}
54	2024-02-08 17:01:50.428	2024-02-08 17:01:50.428	9509054a-3721-4fbc-b2a1-cb0d1df2ba82	1020	6	all - database	1	Create	2024-02-08 17:01:50.428	\N	{"id":6,"guid":"9509054a-3721-4fbc-b2a1-cb0d1df2ba82","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710417,"updateTime":1707411710418,"version":1,"service":"dev_hive","name":"all - database","policyType":0,"policyPriority":0,"description":"Policy for all - database","resourceSignature":"319fd63cad4bb7c8ed17fda910b636dc2e0f6b0112e28487d9e44e8a5c846314","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"create","isAllowed":true}],"groups":["public"],"delegateAdmin":false},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}],"serviceType":"hive","isDenyAllElse":false}
55	2024-02-08 17:01:50.45	2024-02-08 17:01:50.45	990f5c88-6b02-4d20-ab6d-5901f10b52b0	1020	7	all - hiveservice	1	Create	2024-02-08 17:01:50.45	\N	{"id":7,"guid":"990f5c88-6b02-4d20-ab6d-5901f10b52b0","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710439,"updateTime":1707411710439,"version":1,"service":"dev_hive","name":"all - hiveservice","policyType":0,"policyPriority":0,"description":"Policy for all - hiveservice","resourceSignature":"c052be6821aab8eaad336c15ac58111b27f1b9186353c072d6887497d4b72185","isAuditEnabled":true,"resources":{"hiveservice":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true}],"serviceType":"hive","isDenyAllElse":false}
56	2024-02-08 17:01:50.474	2024-02-08 17:01:50.474	3f31b6bc-7ec0-4684-8976-6616794a20bc	1020	8	all - database, table, column	1	Create	2024-02-08 17:01:50.474	\N	{"id":8,"guid":"3f31b6bc-7ec0-4684-8976-6616794a20bc","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710459,"updateTime":1707411710459,"version":1,"service":"dev_hive","name":"all - database, table, column","policyType":0,"policyPriority":0,"description":"Policy for all - database, table, column","resourceSignature":"ffd181600c642189ed345de83c0fb4649f19c4d89487a478b08bb5a88fa4602e","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}],"serviceType":"hive","isDenyAllElse":false}
57	2024-02-08 17:01:50.493	2024-02-08 17:01:50.493	0d6122bc-0503-48ca-b061-4269c137d03b	1020	9	all - database, table	1	Create	2024-02-08 17:01:50.493	\N	{"id":9,"guid":"0d6122bc-0503-48ca-b061-4269c137d03b","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710482,"updateTime":1707411710483,"version":1,"service":"dev_hive","name":"all - database, table","policyType":0,"policyPriority":0,"description":"Policy for all - database, table","resourceSignature":"d28afef6d5894f1db09ca5fb17f47f4eeef6795e8090c8f244bc38231d1e8cb9","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}],"serviceType":"hive","isDenyAllElse":false}
58	2024-02-08 17:01:50.515	2024-02-08 17:01:50.515	c3695d0c-197b-40b4-909f-2048019f1acd	1020	10	all - database, udf	1	Create	2024-02-08 17:01:50.515	\N	{"id":10,"guid":"c3695d0c-197b-40b4-909f-2048019f1acd","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710502,"updateTime":1707411710503,"version":1,"service":"dev_hive","name":"all - database, udf","policyType":0,"policyPriority":0,"description":"Policy for all - database, udf","resourceSignature":"a9a4ce765b10e47239e032918d1f88aadab9f6e5ca4ed9612b1f6d720f49792e","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"udf":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}],"serviceType":"hive","isDenyAllElse":false}
59	2024-02-08 17:01:50.54	2024-02-08 17:01:50.54	83780e36-d268-4dcf-8146-72b17e0b0869	1020	11	all - url	1	Create	2024-02-08 17:01:50.54	\N	{"id":11,"guid":"83780e36-d268-4dcf-8146-72b17e0b0869","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710527,"updateTime":1707411710528,"version":1,"service":"dev_hive","name":"all - url","policyType":0,"policyPriority":0,"description":"Policy for all - url","resourceSignature":"a6a328c623a4eb15d84ccf34df65c83acba3c59c7df4a601780b1caa153aa870","isAuditEnabled":true,"resources":{"url":{"values":["*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true}],"serviceType":"hive","isDenyAllElse":false}
60	2024-02-08 17:01:50.557	2024-02-08 17:01:50.557	f377c38d-3976-43d5-8f61-95c7fc777e51	1020	12	default database tables columns	1	Create	2024-02-08 17:01:50.557	\N	{"id":12,"guid":"f377c38d-3976-43d5-8f61-95c7fc777e51","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710549,"updateTime":1707411710549,"version":1,"service":"dev_hive","name":"default database tables columns","policyType":0,"policyPriority":0,"resourceSignature":"6953543a4b66b6f2035924da5ab162724650a6b3e6ef0049c02819d894bc72a5","isAuditEnabled":true,"resources":{"database":{"values":["default"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"create","isAllowed":true}],"groups":["public"],"delegateAdmin":false}],"serviceType":"hive","isDenyAllElse":false}
61	2024-02-08 17:01:50.576	2024-02-08 17:01:50.576	37e8dfed-84dd-4ff8-b779-4f045040d0a9	1020	13	Information_schema database tables columns	1	Create	2024-02-08 17:01:50.576	\N	{"id":13,"guid":"37e8dfed-84dd-4ff8-b779-4f045040d0a9","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710566,"updateTime":1707411710567,"version":1,"service":"dev_hive","name":"Information_schema database tables columns","policyType":0,"policyPriority":0,"resourceSignature":"ae84bfb2ea30aed7571ac7d10c68e30084fb38933ff1d7fca41a833e105bd6bb","isAuditEnabled":true,"resources":{"database":{"values":["information_schema"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true}],"groups":["public"],"delegateAdmin":false}],"serviceType":"hive","isDenyAllElse":false}
62	2024-02-08 17:01:50.694	2024-02-08 17:01:50.694	fe214fdb-157c-471b-a72b-190ca71fc0c5	1030	5	dev_hbase	1	Create	2024-02-08 17:01:50.694	\N	{"id":5,"guid":"fe214fdb-157c-471b-a72b-190ca71fc0c5","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710675,"updateTime":1707411710676,"version":1,"type":"hbase","name":"dev_hbase","displayName":"dev_hbase","tagService":"dev_tag","configs":{"hbase.zookeeper.quorum":"ranger-zk","password":"*****","hadoop.security.authentication":"simple","hbase.security.authentication":"simple","hadoop.security.authorization":"true","hbase.zookeeper.property.clientPort":"2181","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'table':{'values':['*-ROOT-*','*.META.*', '*_acl_*', 'hbase:meta', 'hbase:acl', 'default', 'hbase']}}, 'users':['hbase'], 'isAudited': false }, {'resources':{'table':{'values':['atlas_janus','ATLAS_ENTITY_AUDIT_EVENTS']},'column-family':{'values':['*']},'column':{'values':['*']}},'users':['atlas', 'hbase'],'isAudited':false},{'users':['hbase'], 'actions':['balance'],'isAudited':false}]","zookeeper.znode.parent":"/hbase","username":"hbase"},"policyVersion":1,"policyUpdateTime":1707411710677,"tagVersion":1,"tagUpdateTime":1707411710677}
63	2024-02-08 17:01:50.715	2024-02-08 17:01:50.715	86bcf48b-cd26-4a3c-8c17-025bf4b4f0ab	1020	14	all - table, column-family, column	1	Create	2024-02-08 17:01:50.715	\N	{"id":14,"guid":"86bcf48b-cd26-4a3c-8c17-025bf4b4f0ab","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710708,"updateTime":1707411710710,"version":1,"service":"dev_hbase","name":"all - table, column-family, column","policyType":0,"policyPriority":0,"description":"Policy for all - table, column-family, column","resourceSignature":"95b105e8d8ae812632b26539d8bfec09793853d278fc0193da8878f6fe095ef3","isAuditEnabled":true,"resources":{"column-family":{"values":["*"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"create","isAllowed":true},{"type":"admin","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"delegateAdmin":true}],"serviceType":"hbase","isDenyAllElse":false}
64	2024-02-08 17:01:50.758	2024-02-08 17:01:50.758	3c17f4a8-fb2b-49f8-a241-fe9c4dc5125f	1030	6	dev_kafka	1	Create	2024-02-08 17:01:50.758	\N	{"id":6,"guid":"3c17f4a8-fb2b-49f8-a241-fe9c4dc5125f","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710742,"updateTime":1707411710743,"version":1,"type":"kafka","name":"dev_kafka","displayName":"dev_kafka","tagService":"dev_tag","configs":{"password":"*****","zookeeper.connect":"ranger-zk.example.com:2181","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'topic':{'values':['ATLAS_ENTITIES','ATLAS_HOOK','ATLAS_SPARK_HOOK']}},'users':['atlas'],'actions':['describe','publish','consume'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_HOOK']}},'users':['hive','hbase','impala','nifi'],'actions':['publish','describe'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_ENTITIES']}},'users':['rangertagsync'],'actions':['consume','describe'],'isAudited':false},{'resources':{'consumergroup':{'values':['*']}},'users':['atlas','rangertagsync'],'actions':['consume'],'isAudited':false},{'users':['kafka'],'isAudited':false}]","username":"kafka"},"policyVersion":1,"policyUpdateTime":1707411710743,"tagVersion":1,"tagUpdateTime":1707411710743}
65	2024-02-08 17:01:50.774	2024-02-08 17:01:50.774	96ced605-0b6b-45a2-96d2-7fa2bc135b26	1020	15	all - consumergroup	1	Create	2024-02-08 17:01:50.774	\N	{"id":15,"guid":"96ced605-0b6b-45a2-96d2-7fa2bc135b26","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710767,"updateTime":1707411710768,"version":1,"service":"dev_kafka","name":"all - consumergroup","policyType":0,"policyPriority":0,"description":"Policy for all - consumergroup","resourceSignature":"8b806b6eabc6adcac1658dfcb2f95f7f2fdd2a3d2093e67f3fe4773d9562c08d","isAuditEnabled":true,"resources":{"consumergroup":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"consume","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"delete","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}],"serviceType":"kafka","isDenyAllElse":false}
66	2024-02-08 17:01:50.79	2024-02-08 17:01:50.79	c149589e-5ea7-4d33-8db4-f11190644dc6	1020	16	all - topic	1	Create	2024-02-08 17:01:50.79	\N	{"id":16,"guid":"c149589e-5ea7-4d33-8db4-f11190644dc6","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710783,"updateTime":1707411710783,"version":1,"service":"dev_kafka","name":"all - topic","policyType":0,"policyPriority":0,"description":"Policy for all - topic","resourceSignature":"875e011fb314298153184b702421bff743744ff9637778aa2c8066aecc08ecc1","isAuditEnabled":true,"resources":{"topic":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"publish","isAllowed":true},{"type":"consume","isAllowed":true},{"type":"configure","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"create","isAllowed":true},{"type":"delete","isAllowed":true},{"type":"describe_configs","isAllowed":true},{"type":"alter_configs","isAllowed":true},{"type":"alter","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}],"serviceType":"kafka","isDenyAllElse":false}
67	2024-02-08 17:01:50.804	2024-02-08 17:01:50.804	64fdaa43-c666-4259-be9c-fbbe9d5cfb6f	1020	17	all - transactionalid	1	Create	2024-02-08 17:01:50.804	\N	{"id":17,"guid":"64fdaa43-c666-4259-be9c-fbbe9d5cfb6f","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710797,"updateTime":1707411710797,"version":1,"service":"dev_kafka","name":"all - transactionalid","policyType":0,"policyPriority":0,"description":"Policy for all - transactionalid","resourceSignature":"08c233ac88f4f6024ae516f63c9f244e65eb9a0ad4581d807fe0f66f00c1f17c","isAuditEnabled":true,"resources":{"transactionalid":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"publish","isAllowed":true},{"type":"describe","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}],"serviceType":"kafka","isDenyAllElse":false}
68	2024-02-08 17:01:50.82	2024-02-08 17:01:50.82	d9cde2d0-99b3-4e8b-9e14-c7ccb14d8629	1020	18	all - cluster	1	Create	2024-02-08 17:01:50.82	\N	{"id":18,"guid":"d9cde2d0-99b3-4e8b-9e14-c7ccb14d8629","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710812,"updateTime":1707411710812,"version":1,"service":"dev_kafka","name":"all - cluster","policyType":0,"policyPriority":0,"description":"Policy for all - cluster","resourceSignature":"f0f71572fbbecb75c249a18d593c9f16b8913a1fe67ec1e03f7e513ed857ed13","isAuditEnabled":true,"resources":{"cluster":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"configure","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"kafka_admin","isAllowed":true},{"type":"create","isAllowed":true},{"type":"idempotent_write","isAllowed":true},{"type":"describe_configs","isAllowed":true},{"type":"alter_configs","isAllowed":true},{"type":"cluster_action","isAllowed":true},{"type":"alter","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}],"serviceType":"kafka","isDenyAllElse":false}
69	2024-02-08 17:01:50.834	2024-02-08 17:01:50.834	e63d642f-50f1-4143-8200-1867d4b93e06	1020	19	all - delegationtoken	1	Create	2024-02-08 17:01:50.834	\N	{"id":19,"guid":"e63d642f-50f1-4143-8200-1867d4b93e06","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710827,"updateTime":1707411710827,"version":1,"service":"dev_kafka","name":"all - delegationtoken","policyType":0,"policyPriority":0,"description":"Policy for all - delegationtoken","resourceSignature":"2cb327aea1a3008ff5871618be9eec6fd9804adffa51f703889b49d465a64635","isAuditEnabled":true,"resources":{"delegationtoken":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"describe","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}],"serviceType":"kafka","isDenyAllElse":false}
70	2024-02-08 17:01:50.934	2024-02-08 17:01:50.934	a928daf7-cafc-42b6-bd8a-a8e2f574ce43	1030	7	dev_knox	1	Create	2024-02-08 17:01:50.934	\N	{"id":7,"guid":"a928daf7-cafc-42b6-bd8a-a8e2f574ce43","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710919,"updateTime":1707411710920,"version":1,"type":"knox","name":"dev_knox","displayName":"dev_knox","tagService":"dev_tag","configs":{"password":"*****","ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['knox'] ,'isAudited':false} ]","knox.url":"https://ranger-knox:8443","username":"knox"},"policyVersion":1,"policyUpdateTime":1707411710920,"tagVersion":1,"tagUpdateTime":1707411710920}
71	2024-02-08 17:01:50.948	2024-02-08 17:01:50.948	4ea21fd4-bd30-42f7-b508-fef34692383e	1020	20	all - topology, service	1	Create	2024-02-08 17:01:50.948	\N	{"id":20,"guid":"4ea21fd4-bd30-42f7-b508-fef34692383e","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411710944,"updateTime":1707411710944,"version":1,"service":"dev_knox","name":"all - topology, service","policyType":0,"policyPriority":0,"description":"Policy for all - topology, service","resourceSignature":"bcdaa6d5b59d1ff76890aee0548b75e9abd1a9bb6964fa8a5157b6d37ffce8db","isAuditEnabled":true,"resources":{"topology":{"values":["*"],"isExcludes":false,"isRecursive":false},"service":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"allow","isAllowed":true}],"users":["knox"],"delegateAdmin":true}],"serviceType":"knox","isDenyAllElse":false}
73	2024-02-08 17:01:51.023	2024-02-08 17:01:51.023	8c73b7f6-f213-454c-ac6e-089f909fbe51	1020	21	all - keyname	1	Create	2024-02-08 17:01:51.023	\N	{"id":21,"guid":"8c73b7f6-f213-454c-ac6e-089f909fbe51","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707411711012,"updateTime":1707411711012,"version":1,"service":"dev_kms","name":"all - keyname","policyType":0,"policyPriority":0,"description":"Policy for all - keyname","resourceSignature":"43ba5ec899642b547c31144d1b915a0b8502b71fbff3216ec5733c7d6363cb2c","isAuditEnabled":true,"resources":{"keyname":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"create","isAllowed":true},{"type":"delete","isAllowed":true},{"type":"rollover","isAllowed":true},{"type":"setkeymaterial","isAllowed":true},{"type":"get","isAllowed":true},{"type":"getkeys","isAllowed":true},{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true},{"type":"decrypteek","isAllowed":true}],"users":["keyadmin"],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true}],"users":["hdfs"],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true}],"users":["om"],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"decrypteek","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"decrypteek","isAllowed":true}],"users":["hbase"],"delegateAdmin":true}],"serviceType":"kms","isDenyAllElse":false}
74	2024-02-08 17:51:47.929	2024-02-08 17:51:47.929	1be81a8c-5131-4b35-ace9-f1270b8a590d	1030	9	hadoopdev	1	Create	2024-02-08 17:51:47.929	\N	{"id":9,"guid":"1be81a8c-5131-4b35-ace9-f1270b8a590d","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707414707898,"updateTime":1707414707899,"version":1,"type":"hdfs","name":"hadoopdev","displayName":"hadoopdev","configs":{"password":"*****","hadoop.security.authentication":"simple","hadoop.rpc.protection":"authentication","fs.default.name":"http://localhost:8020","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[{'accessResult':'DENIED','isAudited':true},{'actions':['delete','rename'],'isAudited':true},{'users':['hdfs'],'actions':['listStatus','getfileinfo','listCachePools','listCacheDirectives','listCorruptFileBlocks','monitorHealth','rollEditLog','open'],'isAudited':false},{'users':['oozie'],'resources':{'path':{'values':['/user/oozie/share/lib'],'isRecursive':true}},'isAudited':false},{'users':['spark'],'resources':{'path':{'values':['/user/spark/applicationHistory'],'isRecursive':true}},'isAudited':false},{'users':['hue'],'resources':{'path':{'values':['/user/hue'],'isRecursive':true}},'isAudited':false},{'users':['hbase'],'resources':{'path':{'values':['/hbase'],'isRecursive':true}},'isAudited':false},{'users':['mapred'],'resources':{'path':{'values':['/user/history'],'isRecursive':true}},'isAudited':false},{'actions':['getfileinfo'],'isAudited':false}]","username":"hadoop"},"policyVersion":1,"policyUpdateTime":1707414707901,"tagVersion":1,"tagUpdateTime":1707414707901}
75	2024-02-08 17:51:47.992	2024-02-08 17:51:47.992	4e053429-1e49-4654-a9ec-f51a947cf116	1020	22	all - path	1	Create	2024-02-08 17:51:47.992	\N	{"id":22,"guid":"4e053429-1e49-4654-a9ec-f51a947cf116","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707414707957,"updateTime":1707414707960,"version":1,"service":"hadoopdev","name":"all - path","policyType":0,"policyPriority":0,"description":"Policy for all - path","resourceSignature":"dfe81e379022be6cadb1665e2a3883824f2bc09626557a32efa3a236609005b6","isAuditEnabled":true,"resources":{"path":{"values":["/*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hadoop"],"delegateAdmin":true}],"serviceType":"hdfs","isDenyAllElse":false}
76	2024-02-08 17:51:48.034	2024-02-08 17:51:48.034	b7b30475-730c-4ec6-90ce-0a6bc9f47059	1020	23	kms-audit-path	1	Create	2024-02-08 17:51:48.034	\N	{"id":23,"guid":"b7b30475-730c-4ec6-90ce-0a6bc9f47059","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707414708016,"updateTime":1707414708017,"version":1,"service":"hadoopdev","name":"kms-audit-path","policyType":0,"policyPriority":0,"description":"Policy for kms-audit-path","resourceSignature":"b349a238ab1cea962a44878de9da2231537b5b1ab65006ca892565679d6ab1e0","isAuditEnabled":true,"resources":{"path":{"values":["/ranger/audit/kms"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["keyadmin"],"delegateAdmin":false}],"serviceType":"hdfs","isDenyAllElse":false}
77	2024-02-08 17:51:48.064	2024-02-08 17:51:48.064	0bc61748-83c7-477d-8d62-642874952fb4	1020	24	hbase-archive	1	Create	2024-02-08 17:51:48.064	\N	{"id":24,"guid":"0bc61748-83c7-477d-8d62-642874952fb4","isEnabled":true,"createdBy":"Admin","updatedBy":"Admin","createTime":1707414708047,"updateTime":1707414708048,"version":1,"service":"hadoopdev","name":"hbase-archive","policyType":0,"policyPriority":0,"description":"Policy for hbase archive location","resourceSignature":"37fe368bc41139223d1f995603a4e71c352b8804e0413c0a06235b09ab42b19c","isAuditEnabled":true,"resources":{"path":{"values":["/hbase/archive"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"delegateAdmin":false}],"serviceType":"hdfs","isDenyAllElse":false}
\.


--
-- Data for Name: x_datamask_type_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_datamask_type_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, label, description, transformer, datamask_options, rb_key_label, rb_key_description, sort_order) FROM stdin;
1	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.591	\N	\N	3	1	MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	mask({col})	{}	\N	\N	0
2	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.593	\N	\N	3	2	MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'x'	mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	1
3	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.594	\N	\N	3	3	MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	2
4	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.595	\N	\N	3	4	MASK_HASH	Hash	Hash the value	mask_hash({col})	{}	\N	\N	3
5	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.597	\N	\N	3	5	MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	4
6	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.598	\N	\N	3	6	MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	5
7	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.599	\N	\N	3	12	MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)	{}	\N	\N	6
8	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.6	\N	\N	3	13	CUSTOM	Custom	Custom	\N	{}	\N	\N	7
9	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.16	\N	\N	203	1	MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})	{}	\N	\N	0
10	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.16	\N	\N	203	2	MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'X'	cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})	{}	\N	\N	1
11	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.161	\N	\N	203	3	MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})	{}	\N	\N	2
12	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.161	\N	\N	203	4	MASK_HASH	Hash	Hash the value of a varchar with sha256	cast(to_hex(sha256(to_utf8({col}))) as {type})	{}	\N	\N	3
13	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.162	\N	\N	203	5	MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	4
14	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.162	\N	\N	203	6	MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	5
15	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.163	\N	\N	203	12	MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	date_trunc('year', {col})	{}	\N	\N	6
16	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.163	\N	\N	203	13	CUSTOM	Custom	Custom	\N	{}	\N	\N	7
25	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.277	\N	\N	17	1	MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})	{}	\N	\N	0
26	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.277	\N	\N	17	2	MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'X'	cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})	{}	\N	\N	1
27	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.278	\N	\N	17	3	MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})	{}	\N	\N	2
28	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.278	\N	\N	17	4	MASK_HASH	Hash	Hash the value of a varchar with sha256	cast(to_hex(sha256(to_utf8({col}))) as {type})	{}	\N	\N	3
29	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.279	\N	\N	17	5	MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	4
30	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.279	\N	\N	17	6	MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	5
31	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.28	\N	\N	17	12	MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	date_trunc('year', {col})	{}	\N	\N	6
32	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.28	\N	\N	17	13	CUSTOM	Custom	Custom	\N	{}	\N	\N	7
41	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.693	\N	\N	205	1	MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	mask({field})	{}	\N	\N	0
42	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.694	\N	\N	205	2	MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'x'	mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	1
43	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.694	\N	\N	205	3	MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	2
44	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.695	\N	\N	205	4	MASK_HASH	Hash	Hash the value	mask_hash({field})	{}	\N	\N	3
45	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.695	\N	\N	205	5	MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	4
46	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.696	\N	\N	205	6	MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	5
47	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.697	\N	\N	205	12	MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)	{}	\N	\N	6
48	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.697	\N	\N	205	13	CUSTOM	Custom	Custom	\N	{}	\N	\N	7
17	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.733	\N	\N	100	203204	trino:MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})	{}	\N	\N	0
18	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.734	\N	\N	100	203205	trino:MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'X'	cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})	{}	\N	\N	1
19	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.736	\N	\N	100	203206	trino:MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})	{}	\N	\N	2
20	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.737	\N	\N	100	203207	trino:MASK_HASH	Hash	Hash the value of a varchar with sha256	cast(to_hex(sha256(to_utf8({col}))) as {type})	{}	\N	\N	3
21	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.738	\N	\N	100	203208	trino:MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	4
22	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.74	\N	\N	100	203209	trino:MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	5
23	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.741	\N	\N	100	203215	trino:MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	date_trunc('year', {col})	{}	\N	\N	6
24	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.742	\N	\N	100	203216	trino:CUSTOM	Custom	Custom	\N	{}	\N	\N	7
33	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.744	\N	\N	100	17018	presto:MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	cast(regexp_replace(regexp_replace(regexp_replace({col},'([A-Z])', 'X'),'([a-z])','x'),'([0-9])','0') as {type})	{}	\N	\N	8
34	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.746	\N	\N	100	17019	presto:MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'X'	cast(regexp_replace({col}, '(.*)(.{4}$)', x -> regexp_replace(x[1], '.', 'X') || x[2]) as {type})	{}	\N	\N	9
35	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.747	\N	\N	100	17020	presto:MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	cast(regexp_replace({col}, '(^.{4})(.*)', x -> x[1] || regexp_replace(x[2], '.', 'X')) as {type})	{}	\N	\N	10
36	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.748	\N	\N	100	17021	presto:MASK_HASH	Hash	Hash the value of a varchar with sha256	cast(to_hex(sha256(to_utf8({col}))) as {type})	{}	\N	\N	11
37	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.75	\N	\N	100	17022	presto:MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	12
38	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.751	\N	\N	100	17023	presto:MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	13
39	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.752	\N	\N	100	17029	presto:MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	date_trunc('year', {col})	{}	\N	\N	14
40	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.753	\N	\N	100	17030	presto:CUSTOM	Custom	Custom	\N	{}	\N	\N	15
49	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.754	\N	\N	100	205206	nestedstructure:MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	mask({field})	{}	\N	\N	16
50	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.755	\N	\N	100	205207	nestedstructure:MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'x'	mask_show_last_n({field}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	17
51	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.756	\N	\N	100	205208	nestedstructure:MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	mask_show_first_n({field}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	18
52	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.757	\N	\N	100	205209	nestedstructure:MASK_HASH	Hash	Hash the value	mask_hash({field})	{}	\N	\N	19
53	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.758	\N	\N	100	205210	nestedstructure:MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	20
54	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.759	\N	\N	100	205211	nestedstructure:MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	21
55	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.761	\N	\N	100	205217	nestedstructure:MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	mask({field}, 'x', 'x', 'x', -1, '1', 1, 0, -1)	{}	\N	\N	22
56	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.762	\N	\N	100	205218	nestedstructure:CUSTOM	Custom	Custom	\N	{}	\N	\N	23
57	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.763	\N	\N	100	3004	hive:MASK	Redact	Replace lowercase with 'x', uppercase with 'X', digits with '0'	mask({col})	{}	\N	\N	24
58	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.764	\N	\N	100	3005	hive:MASK_SHOW_LAST_4	Partial mask: show last 4	Show last 4 characters; replace rest with 'x'	mask_show_last_n({col}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	25
59	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.765	\N	\N	100	3006	hive:MASK_SHOW_FIRST_4	Partial mask: show first 4	Show first 4 characters; replace rest with 'x'	mask_show_first_n({col}, 4, 'x', 'x', 'x', -1, '1')	{}	\N	\N	26
60	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.769	\N	\N	100	3007	hive:MASK_HASH	Hash	Hash the value	mask_hash({col})	{}	\N	\N	27
61	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.77	\N	\N	100	3008	hive:MASK_NULL	Nullify	Replace with NULL	\N	{}	\N	\N	28
62	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.771	\N	\N	100	3009	hive:MASK_NONE	Unmasked (retain original value)	No masking	\N	{}	\N	\N	29
63	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.772	\N	\N	100	3015	hive:MASK_DATE_SHOW_YEAR	Date: show only year	Date: show only year	mask({col}, 'x', 'x', 'x', -1, '1', 1, 0, -1)	{}	\N	\N	30
64	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.774	\N	\N	100	3016	hive:CUSTOM	Custom	Custom	\N	{}	\N	\N	31
\.


--
-- Data for Name: x_db_base; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_db_base (id, create_time, update_time, added_by_id, upd_by_id) FROM stdin;
\.


--
-- Data for Name: x_db_version_h; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_db_version_h (id, version, inst_at, inst_by, updated_at, updated_by, active) FROM stdin;
1	CORE_DB_SCHEMA	2024-02-08 17:00:57.71785	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.71785	localhost	Y
2	016	2024-02-08 17:00:57.723826	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.723826	localhost	Y
3	018	2024-02-08 17:00:57.728586	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.728586	localhost	Y
4	019	2024-02-08 17:00:57.736596	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.736596	localhost	Y
5	020	2024-02-08 17:00:57.739613	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.739613	localhost	Y
6	021	2024-02-08 17:00:57.749601	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.749601	localhost	Y
7	022	2024-02-08 17:00:57.758734	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.758734	localhost	Y
8	023	2024-02-08 17:00:57.771294	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.771294	localhost	Y
9	024	2024-02-08 17:00:57.777854	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.777854	localhost	Y
10	025	2024-02-08 17:00:57.793854	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.793854	localhost	Y
11	026	2024-02-08 17:00:57.800177	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.800177	localhost	Y
12	027	2024-02-08 17:00:57.810216	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.810216	localhost	Y
13	028	2024-02-08 17:00:57.815337	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.815337	localhost	Y
14	029	2024-02-08 17:00:57.821604	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.821604	localhost	Y
15	030	2024-02-08 17:00:57.828361	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.828361	localhost	Y
16	031	2024-02-08 17:00:57.8334	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.8334	localhost	Y
17	032	2024-02-08 17:00:57.838768	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.838768	localhost	Y
18	033	2024-02-08 17:00:57.848014	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.848014	localhost	Y
19	034	2024-02-08 17:00:57.857708	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.857708	localhost	Y
20	035	2024-02-08 17:00:57.86752	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.86752	localhost	Y
21	036	2024-02-08 17:00:57.875962	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.875962	localhost	Y
22	037	2024-02-08 17:00:57.887062	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.887062	localhost	Y
23	038	2024-02-08 17:00:57.89232	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.89232	localhost	Y
24	039	2024-02-08 17:00:57.899603	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.899603	localhost	Y
25	040	2024-02-08 17:00:57.90961	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.90961	localhost	Y
26	041	2024-02-08 17:00:57.920799	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.920799	localhost	Y
27	042	2024-02-08 17:00:57.930614	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.930614	localhost	Y
28	043	2024-02-08 17:00:57.940177	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.940177	localhost	Y
29	044	2024-02-08 17:00:57.950923	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.950923	localhost	Y
30	045	2024-02-08 17:00:57.965069	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.965069	localhost	Y
31	046	2024-02-08 17:00:57.979659	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.979659	localhost	Y
32	047	2024-02-08 17:00:57.993961	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:57.993961	localhost	Y
33	048	2024-02-08 17:00:58.007314	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.007314	localhost	Y
34	049	2024-02-08 17:00:58.016563	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.016563	localhost	Y
35	050	2024-02-08 17:00:58.02827	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.02827	localhost	Y
36	051	2024-02-08 17:00:58.040395	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.040395	localhost	Y
37	052	2024-02-08 17:00:58.046125	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.046125	localhost	Y
38	054	2024-02-08 17:00:58.049558	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.049558	localhost	Y
39	055	2024-02-08 17:00:58.052704	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.052704	localhost	Y
40	056	2024-02-08 17:00:58.063203	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.063203	localhost	Y
41	057	2024-02-08 17:00:58.072567	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.072567	localhost	Y
42	058	2024-02-08 17:00:58.082948	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.082948	localhost	Y
43	059	2024-02-08 17:00:58.089065	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.089065	localhost	Y
44	060	2024-02-08 17:00:58.092466	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.092466	localhost	Y
45	065	2024-02-08 17:00:58.099044	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.099044	localhost	Y
46	066	2024-02-08 17:00:58.113533	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.113533	localhost	Y
47	DB_PATCHES	2024-02-08 17:00:58.123766	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.123766	localhost	Y
48	J10001	2024-02-08 17:00:58.277969	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.277969	localhost	Y
49	J10002	2024-02-08 17:00:58.283812	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.283812	localhost	Y
50	J10003	2024-02-08 17:00:58.289798	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.289798	localhost	Y
51	J10004	2024-02-08 17:00:58.306553	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.306553	localhost	Y
52	J10005	2024-02-08 17:00:58.330837	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.330837	localhost	Y
53	J10006	2024-02-08 17:00:58.343522	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.343522	localhost	Y
54	J10007	2024-02-08 17:00:58.358843	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.358843	localhost	Y
55	J10008	2024-02-08 17:00:58.373054	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.373054	localhost	Y
56	J10009	2024-02-08 17:00:58.38553	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.38553	localhost	Y
57	J10010	2024-02-08 17:00:58.398862	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.398862	localhost	Y
58	J10011	2024-02-08 17:00:58.416176	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.416176	localhost	Y
59	J10012	2024-02-08 17:00:58.430078	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.430078	localhost	Y
60	J10013	2024-02-08 17:00:58.441245	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.441245	localhost	Y
61	J10014	2024-02-08 17:00:58.457068	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.457068	localhost	Y
62	J10015	2024-02-08 17:00:58.468384	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.468384	localhost	Y
63	J10016	2024-02-08 17:00:58.485568	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.485568	localhost	Y
64	J10017	2024-02-08 17:00:58.504798	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.504798	localhost	Y
65	J10019	2024-02-08 17:00:58.521852	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.521852	localhost	Y
66	J10020	2024-02-08 17:00:58.537365	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.537365	localhost	Y
67	J10025	2024-02-08 17:00:58.548796	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.548796	localhost	Y
68	J10026	2024-02-08 17:00:58.566066	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.566066	localhost	Y
69	J10027	2024-02-08 17:00:58.58721	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.58721	localhost	Y
70	J10028	2024-02-08 17:00:58.600503	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.600503	localhost	Y
71	J10030	2024-02-08 17:00:58.614486	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.614486	localhost	Y
72	J10033	2024-02-08 17:00:58.628251	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.628251	localhost	Y
73	J10034	2024-02-08 17:00:58.640165	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.640165	localhost	Y
74	J10035	2024-02-08 17:00:58.650178	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.650178	localhost	Y
75	J10036	2024-02-08 17:00:58.655604	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.655604	localhost	Y
76	J10037	2024-02-08 17:00:58.667559	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.667559	localhost	Y
77	J10038	2024-02-08 17:00:58.69127	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.69127	localhost	Y
78	J10040	2024-02-08 17:00:58.712129	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.712129	localhost	Y
79	J10041	2024-02-08 17:00:58.728629	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.728629	localhost	Y
80	J10043	2024-02-08 17:00:58.747954	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.747954	localhost	Y
81	J10044	2024-02-08 17:00:58.768448	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.768448	localhost	Y
82	J10045	2024-02-08 17:00:58.777945	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.777945	localhost	Y
83	J10046	2024-02-08 17:00:58.792019	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.792019	localhost	Y
84	J10047	2024-02-08 17:00:58.805327	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.805327	localhost	Y
85	J10049	2024-02-08 17:00:58.820648	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.820648	localhost	Y
86	J10050	2024-02-08 17:00:58.833553	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.833553	localhost	Y
87	J10051	2024-02-08 17:00:58.860331	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.860331	localhost	Y
88	J10052	2024-02-08 17:00:58.863307	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.863307	localhost	Y
89	J10053	2024-02-08 17:00:58.865939	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.865939	localhost	Y
90	J10054	2024-02-08 17:00:58.872247	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.872247	localhost	Y
91	J10055	2024-02-08 17:00:58.875256	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.875256	localhost	Y
92	J10056	2024-02-08 17:00:58.878177	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.878177	localhost	Y
93	J10060	2024-02-08 17:00:58.881517	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.881517	localhost	Y
94	JAVA_PATCHES	2024-02-08 17:00:58.884232	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:00:58.884232	localhost	Y
95	DEFAULT_ALL_ADMIN_UPDATE	2024-02-08 17:01:01.449586	Ranger 3.0.0-SNAPSHOT	2024-02-08 17:01:01.449586	ranger.example.com	Y
\.


--
-- Data for Name: x_enum_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_enum_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, default_index) FROM stdin;
1	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.427	\N	\N	1	1	authnType	0
2	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.43	\N	\N	1	2	rpcProtection	0
3	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.526	\N	\N	2	1	authnType	0
4	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.747	\N	\N	4	1	authnType	0
5	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.826	\N	\N	202	1	authType	0
6	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.858	\N	\N	10	1	authType	0
7	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.881	\N	\N	13	1	authType	0
8	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.406	\N	\N	201	1	authnType	0
\.


--
-- Data for Name: x_enum_element_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_enum_element_def (id, guid, create_time, update_time, added_by_id, upd_by_id, enum_def_id, item_id, name, label, rb_key_label, sort_order) FROM stdin;
1	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.428	\N	\N	1	1	simple	Simple	\N	0
2	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.429	\N	\N	1	2	kerberos	Kerberos	\N	1
3	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.431	\N	\N	2	1	authentication	Authentication	\N	0
4	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.432	\N	\N	2	2	integrity	Integrity	\N	1
5	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.433	\N	\N	2	3	privacy	Privacy	\N	2
6	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.527	\N	\N	3	1	simple	Simple	\N	0
7	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.527	\N	\N	3	2	kerberos	Kerberos	\N	1
8	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.748	\N	\N	4	1	simple	Simple	\N	0
9	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.749	\N	\N	4	2	kerberos	Kerberos	\N	1
10	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.826	\N	\N	5	1	NONE	None	\N	0
11	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.827	\N	\N	5	2	KERBEROS	Kerberos	\N	1
12	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.859	\N	\N	6	1	NONE	None	\N	0
13	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.86	\N	\N	6	2	SSL	SSL	\N	1
14	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.882	\N	\N	7	1	NONE	None	\N	0
15	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.883	\N	\N	7	2	SSL	SSL	\N	1
16	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.407	\N	\N	8	1	simple	Simple	\N	0
17	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.407	\N	\N	8	2	kerberos	Kerberos	\N	1
\.


--
-- Data for Name: x_group; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_group (id, create_time, update_time, added_by_id, upd_by_id, group_name, descr, status, group_type, cred_store_id, group_src, is_visible, other_attributes, sync_source) FROM stdin;
1	2024-02-08 17:00:57.478026	2024-02-08 17:00:57.478026	\N	1	public	public group	0	0	\N	0	1	\N	\N
\.


--
-- Data for Name: x_group_groups; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_group_groups (id, create_time, update_time, added_by_id, upd_by_id, group_name, p_group_id, group_id) FROM stdin;
\.


--
-- Data for Name: x_group_module_perm; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_group_module_perm (id, group_id, module_id, create_time, update_time, added_by_id, upd_by_id, is_allowed) FROM stdin;
\.


--
-- Data for Name: x_group_users; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_group_users (id, create_time, update_time, added_by_id, upd_by_id, group_name, p_group_id, user_id) FROM stdin;
\.


--
-- Data for Name: x_modules_master; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_modules_master (id, create_time, update_time, added_by_id, upd_by_id, module, url) FROM stdin;
1	2024-02-08 17:00:57.48137	2024-02-08 17:00:57.48137	1	1	Resource Based Policies	
2	2024-02-08 17:00:57.484141	2024-02-08 17:00:57.484141	1	1	Users/Groups	
3	2024-02-08 17:00:57.488208	2024-02-08 17:00:57.488208	1	1	Reports	
4	2024-02-08 17:00:57.492221	2024-02-08 17:00:57.492221	1	1	Audit	
5	2024-02-08 17:00:57.496497	2024-02-08 17:00:57.496497	1	1	Key Manager	
6	2024-02-08 17:00:57.694329	2024-02-08 17:00:57.694329	1	1	Tag Based Policies	
7	2024-02-08 17:00:57.701398	2024-02-08 17:00:57.701398	1	1	Security Zone	
\.


--
-- Data for Name: x_perm_map; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_perm_map (id, create_time, update_time, added_by_id, upd_by_id, perm_group, res_id, group_id, user_id, perm_for, perm_type, is_recursive, is_wild_card, grant_revoke, ip_address) FROM stdin;
\.


--
-- Data for Name: x_plugin_info; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_plugin_info (id, create_time, update_time, service_name, app_type, host_name, ip_address, info) FROM stdin;
1	2024-02-08 17:52:08.899	2024-02-08 17:52:09.162	hadoopdev	hdfs	namenode	172.22.0.8	{"roleActiveVersion":"-1","roleDownloadedVersion":"1","roleActivationTime":"1707414698875","pluginCapabilities":"fffff","roleDownloadTime":"1707414728896","adminCapabilities":"7ffff","policyDownloadedVersion":"4","policyDownloadTime":"1707414729153"}
\.


--
-- Data for Name: x_policy; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy (id, guid, create_time, update_time, added_by_id, upd_by_id, version, service, name, policy_type, description, resource_signature, is_enabled, is_audit_enabled, policy_options, policy_priority, policy_text, zone_id) FROM stdin;
1	7b38d7be-097a-4d80-811f-dd601327f691	2024-02-08 17:01:49.978	2024-02-08 17:01:49.985	1	1	1	1	all - path	0	Policy for all - path	dfe81e379022be6cadb1665e2a3883824f2bc09626557a32efa3a236609005b6	t	t	\N	0	{"service":"dev_hdfs","name":"all - path","policyType":0,"policyPriority":0,"description":"Policy for all - path","resourceSignature":"dfe81e379022be6cadb1665e2a3883824f2bc09626557a32efa3a236609005b6","isAuditEnabled":true,"resources":{"path":{"values":["/*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hdfs"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hdfs","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"7b38d7be-097a-4d80-811f-dd601327f691","isEnabled":true,"version":1}	1
2	a12f56d5-bfd7-462c-9052-6f9a13ede01b	2024-02-08 17:01:50.033	2024-02-08 17:01:50.034	1	1	1	1	kms-audit-path	0	Policy for kms-audit-path	b349a238ab1cea962a44878de9da2231537b5b1ab65006ca892565679d6ab1e0	t	t	\N	0	{"service":"dev_hdfs","name":"kms-audit-path","policyType":0,"policyPriority":0,"description":"Policy for kms-audit-path","resourceSignature":"b349a238ab1cea962a44878de9da2231537b5b1ab65006ca892565679d6ab1e0","isAuditEnabled":true,"resources":{"path":{"values":["/ranger/audit/kms"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["keyadmin"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hdfs","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"a12f56d5-bfd7-462c-9052-6f9a13ede01b","isEnabled":true,"version":1}	1
3	623bb4a6-39f8-4f46-86d1-bbafbfdad3f9	2024-02-08 17:01:50.055	2024-02-08 17:01:50.056	1	1	1	1	hbase-archive	0	Policy for hbase archive location	37fe368bc41139223d1f995603a4e71c352b8804e0413c0a06235b09ab42b19c	t	t	\N	0	{"service":"dev_hdfs","name":"hbase-archive","policyType":0,"policyPriority":0,"description":"Policy for hbase archive location","resourceSignature":"37fe368bc41139223d1f995603a4e71c352b8804e0413c0a06235b09ab42b19c","isAuditEnabled":true,"resources":{"path":{"values":["/hbase/archive"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hdfs","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"623bb4a6-39f8-4f46-86d1-bbafbfdad3f9","isEnabled":true,"version":1}	1
4	59114281-789e-40df-b3be-7fbea75fabc1	2024-02-08 17:01:50.094	2024-02-08 17:01:50.096	1	1	1	2	EXPIRES_ON	0	Policy for data with EXPIRES_ON tag	2d8c4c28be705d39c7f0665466adf8ffdb0bc845a0b6d87e7c7abdd793e449a9	t	t	\N	0	{"service":"dev_tag","name":"EXPIRES_ON","policyType":0,"policyPriority":0,"description":"Policy for data with EXPIRES_ON tag","resourceSignature":"2d8c4c28be705d39c7f0665466adf8ffdb0bc845a0b6d87e7c7abdd793e449a9","isAuditEnabled":true,"resources":{"tag":{"values":["EXPIRES_ON"],"isExcludes":false,"isRecursive":false}},"policyItems":[],"denyPolicyItems":[{"accesses":[{"type":"sqoop:READ","isAllowed":true},{"type":"sqoop:WRITE","isAllowed":true},{"type":"kylin:QUERY","isAllowed":true},{"type":"kylin:OPERATION","isAllowed":true},{"type":"kylin:MANAGEMENT","isAllowed":true},{"type":"kylin:ADMIN","isAllowed":true},{"type":"elasticsearch:all","isAllowed":true},{"type":"elasticsearch:monitor","isAllowed":true},{"type":"elasticsearch:manage","isAllowed":true},{"type":"elasticsearch:view_index_metadata","isAllowed":true},{"type":"elasticsearch:read","isAllowed":true},{"type":"elasticsearch:read_cross_cluster","isAllowed":true},{"type":"elasticsearch:index","isAllowed":true},{"type":"elasticsearch:create","isAllowed":true},{"type":"elasticsearch:delete","isAllowed":true},{"type":"elasticsearch:write","isAllowed":true},{"type":"elasticsearch:delete_index","isAllowed":true},{"type":"elasticsearch:create_index","isAllowed":true},{"type":"trino:select","isAllowed":true},{"type":"trino:insert","isAllowed":true},{"type":"trino:create","isAllowed":true},{"type":"trino:drop","isAllowed":true},{"type":"trino:delete","isAllowed":true},{"type":"trino:use","isAllowed":true},{"type":"trino:alter","isAllowed":true},{"type":"trino:grant","isAllowed":true},{"type":"trino:revoke","isAllowed":true},{"type":"trino:show","isAllowed":true},{"type":"trino:impersonate","isAllowed":true},{"type":"trino:all","isAllowed":true},{"type":"trino:execute","isAllowed":true},{"type":"presto:select","isAllowed":true},{"type":"presto:insert","isAllowed":true},{"type":"presto:create","isAllowed":true},{"type":"presto:drop","isAllowed":true},{"type":"presto:delete","isAllowed":true},{"type":"presto:use","isAllowed":true},{"type":"presto:alter","isAllowed":true},{"type":"presto:grant","isAllowed":true},{"type":"presto:revoke","isAllowed":true},{"type":"presto:show","isAllowed":true},{"type":"presto:impersonate","isAllowed":true},{"type":"presto:all","isAllowed":true},{"type":"presto:execute","isAllowed":true},{"type":"ozone:all","isAllowed":true},{"type":"ozone:read","isAllowed":true},{"type":"ozone:write","isAllowed":true},{"type":"ozone:create","isAllowed":true},{"type":"ozone:list","isAllowed":true},{"type":"ozone:delete","isAllowed":true},{"type":"ozone:read_acl","isAllowed":true},{"type":"ozone:write_acl","isAllowed":true},{"type":"kudu:select","isAllowed":true},{"type":"kudu:insert","isAllowed":true},{"type":"kudu:update","isAllowed":true},{"type":"kudu:delete","isAllowed":true},{"type":"kudu:alter","isAllowed":true},{"type":"kudu:create","isAllowed":true},{"type":"kudu:drop","isAllowed":true},{"type":"kudu:metadata","isAllowed":true},{"type":"kudu:all","isAllowed":true},{"type":"nestedstructure:read","isAllowed":true},{"type":"nestedstructure:write","isAllowed":true},{"type":"hdfs:read","isAllowed":true},{"type":"hdfs:write","isAllowed":true},{"type":"hdfs:execute","isAllowed":true},{"type":"hbase:read","isAllowed":true},{"type":"hbase:write","isAllowed":true},{"type":"hbase:create","isAllowed":true},{"type":"hbase:admin","isAllowed":true},{"type":"hbase:execute","isAllowed":true},{"type":"hive:select","isAllowed":true},{"type":"hive:update","isAllowed":true},{"type":"hive:create","isAllowed":true},{"type":"hive:drop","isAllowed":true},{"type":"hive:alter","isAllowed":true},{"type":"hive:index","isAllowed":true},{"type":"hive:lock","isAllowed":true},{"type":"hive:all","isAllowed":true},{"type":"hive:read","isAllowed":true},{"type":"hive:write","isAllowed":true},{"type":"hive:repladmin","isAllowed":true},{"type":"hive:serviceadmin","isAllowed":true},{"type":"hive:tempudfadmin","isAllowed":true},{"type":"hive:refresh","isAllowed":true},{"type":"kms:create","isAllowed":true},{"type":"kms:delete","isAllowed":true},{"type":"kms:rollover","isAllowed":true},{"type":"kms:setkeymaterial","isAllowed":true},{"type":"kms:get","isAllowed":true},{"type":"kms:getkeys","isAllowed":true},{"type":"kms:getmetadata","isAllowed":true},{"type":"kms:generateeek","isAllowed":true},{"type":"kms:decrypteek","isAllowed":true},{"type":"knox:allow","isAllowed":true},{"type":"storm:submitTopology","isAllowed":true},{"type":"storm:fileUpload","isAllowed":true},{"type":"storm:fileDownload","isAllowed":true},{"type":"storm:killTopology","isAllowed":true},{"type":"storm:rebalance","isAllowed":true},{"type":"storm:activate","isAllowed":true},{"type":"storm:deactivate","isAllowed":true},{"type":"storm:getTopologyConf","isAllowed":true},{"type":"storm:getTopology","isAllowed":true},{"type":"storm:getUserTopology","isAllowed":true},{"type":"storm:getTopologyInfo","isAllowed":true},{"type":"storm:uploadNewCredentials","isAllowed":true},{"type":"yarn:submit-app","isAllowed":true},{"type":"yarn:admin-queue","isAllowed":true},{"type":"kafka:publish","isAllowed":true},{"type":"kafka:consume","isAllowed":true},{"type":"kafka:configure","isAllowed":true},{"type":"kafka:describe","isAllowed":true},{"type":"kafka:kafka_admin","isAllowed":true},{"type":"kafka:create","isAllowed":true},{"type":"kafka:delete","isAllowed":true},{"type":"kafka:idempotent_write","isAllowed":true},{"type":"kafka:describe_configs","isAllowed":true},{"type":"kafka:alter_configs","isAllowed":true},{"type":"kafka:cluster_action","isAllowed":true},{"type":"kafka:alter","isAllowed":true},{"type":"solr:query","isAllowed":true},{"type":"solr:update","isAllowed":true},{"type":"schema-registry:create","isAllowed":true},{"type":"schema-registry:read","isAllowed":true},{"type":"schema-registry:update","isAllowed":true},{"type":"schema-registry:delete","isAllowed":true},{"type":"nifi:READ","isAllowed":true},{"type":"nifi:WRITE","isAllowed":true},{"type":"nifi-registry:READ","isAllowed":true},{"type":"nifi-registry:WRITE","isAllowed":true},{"type":"nifi-registry:DELETE","isAllowed":true},{"type":"atlas:type-create","isAllowed":true},{"type":"atlas:type-update","isAllowed":true},{"type":"atlas:type-delete","isAllowed":true},{"type":"atlas:entity-read","isAllowed":true},{"type":"atlas:entity-create","isAllowed":true},{"type":"atlas:entity-update","isAllowed":true},{"type":"atlas:entity-delete","isAllowed":true},{"type":"atlas:entity-add-classification","isAllowed":true},{"type":"atlas:entity-update-classification","isAllowed":true},{"type":"atlas:entity-remove-classification","isAllowed":true},{"type":"atlas:admin-export","isAllowed":true},{"type":"atlas:admin-import","isAllowed":true},{"type":"atlas:add-relationship","isAllowed":true},{"type":"atlas:update-relationship","isAllowed":true},{"type":"atlas:remove-relationship","isAllowed":true},{"type":"atlas:admin-purge","isAllowed":true},{"type":"atlas:entity-add-label","isAllowed":true},{"type":"atlas:entity-remove-label","isAllowed":true},{"type":"atlas:entity-update-business-metadata","isAllowed":true},{"type":"atlas:type-read","isAllowed":true},{"type":"atlas:admin-audits","isAllowed":true}],"users":[],"groups":["public"],"roles":[],"conditions":[{"type":"accessed-after-expiry","values":["yes"]}],"delegateAdmin":false}],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"tag","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"59114281-789e-40df-b3be-7fbea75fabc1","isEnabled":true,"version":1}	1
5	c73eb3eb-b35e-4fc4-ad2b-096e01f45f25	2024-02-08 17:01:50.325	2024-02-08 17:01:50.327	1	1	1	3	all - queue	0	Policy for all - queue	ed9b305757e6a786d0b819425ba5c88375a8ec3723a6bc12d4462d70b3f33a3f	t	t	\N	0	{"service":"dev_yarn","name":"all - queue","policyType":0,"policyPriority":0,"description":"Policy for all - queue","resourceSignature":"ed9b305757e6a786d0b819425ba5c88375a8ec3723a6bc12d4462d70b3f33a3f","isAuditEnabled":true,"resources":{"queue":{"values":["*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"submit-app","isAllowed":true},{"type":"admin-queue","isAllowed":true}],"users":["yarn"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"yarn","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"c73eb3eb-b35e-4fc4-ad2b-096e01f45f25","isEnabled":true,"version":1}	1
6	9509054a-3721-4fbc-b2a1-cb0d1df2ba82	2024-02-08 17:01:50.417	2024-02-08 17:01:50.418	1	1	1	4	all - database	0	Policy for all - database	319fd63cad4bb7c8ed17fda910b636dc2e0f6b0112e28487d9e44e8a5c846314	t	t	\N	0	{"service":"dev_hive","name":"all - database","policyType":0,"policyPriority":0,"description":"Policy for all - database","resourceSignature":"319fd63cad4bb7c8ed17fda910b636dc2e0f6b0112e28487d9e44e8a5c846314","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"create","isAllowed":true}],"users":[],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":false},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"9509054a-3721-4fbc-b2a1-cb0d1df2ba82","isEnabled":true,"version":1}	1
7	990f5c88-6b02-4d20-ab6d-5901f10b52b0	2024-02-08 17:01:50.439	2024-02-08 17:01:50.439	1	1	1	4	all - hiveservice	0	Policy for all - hiveservice	c052be6821aab8eaad336c15ac58111b27f1b9186353c072d6887497d4b72185	t	t	\N	0	{"service":"dev_hive","name":"all - hiveservice","policyType":0,"policyPriority":0,"description":"Policy for all - hiveservice","resourceSignature":"c052be6821aab8eaad336c15ac58111b27f1b9186353c072d6887497d4b72185","isAuditEnabled":true,"resources":{"hiveservice":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"990f5c88-6b02-4d20-ab6d-5901f10b52b0","isEnabled":true,"version":1}	1
8	3f31b6bc-7ec0-4684-8976-6616794a20bc	2024-02-08 17:01:50.459	2024-02-08 17:01:50.459	1	1	1	4	all - database, table, column	0	Policy for all - database, table, column	ffd181600c642189ed345de83c0fb4649f19c4d89487a478b08bb5a88fa4602e	t	t	\N	0	{"service":"dev_hive","name":"all - database, table, column","policyType":0,"policyPriority":0,"description":"Policy for all - database, table, column","resourceSignature":"ffd181600c642189ed345de83c0fb4649f19c4d89487a478b08bb5a88fa4602e","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"3f31b6bc-7ec0-4684-8976-6616794a20bc","isEnabled":true,"version":1}	1
9	0d6122bc-0503-48ca-b061-4269c137d03b	2024-02-08 17:01:50.482	2024-02-08 17:01:50.483	1	1	1	4	all - database, table	0	Policy for all - database, table	d28afef6d5894f1db09ca5fb17f47f4eeef6795e8090c8f244bc38231d1e8cb9	t	t	\N	0	{"service":"dev_hive","name":"all - database, table","policyType":0,"policyPriority":0,"description":"Policy for all - database, table","resourceSignature":"d28afef6d5894f1db09ca5fb17f47f4eeef6795e8090c8f244bc38231d1e8cb9","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"0d6122bc-0503-48ca-b061-4269c137d03b","isEnabled":true,"version":1}	1
10	c3695d0c-197b-40b4-909f-2048019f1acd	2024-02-08 17:01:50.502	2024-02-08 17:01:50.503	1	1	1	4	all - database, udf	0	Policy for all - database, udf	a9a4ce765b10e47239e032918d1f88aadab9f6e5ca4ed9612b1f6d720f49792e	t	t	\N	0	{"service":"dev_hive","name":"all - database, udf","policyType":0,"policyPriority":0,"description":"Policy for all - database, udf","resourceSignature":"a9a4ce765b10e47239e032918d1f88aadab9f6e5ca4ed9612b1f6d720f49792e","isAuditEnabled":true,"resources":{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"udf":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"c3695d0c-197b-40b4-909f-2048019f1acd","isEnabled":true,"version":1}	1
11	83780e36-d268-4dcf-8146-72b17e0b0869	2024-02-08 17:01:50.527	2024-02-08 17:01:50.528	1	1	1	4	all - url	0	Policy for all - url	a6a328c623a4eb15d84ccf34df65c83acba3c59c7df4a601780b1caa153aa870	t	t	\N	0	{"service":"dev_hive","name":"all - url","policyType":0,"policyPriority":0,"description":"Policy for all - url","resourceSignature":"a6a328c623a4eb15d84ccf34df65c83acba3c59c7df4a601780b1caa153aa870","isAuditEnabled":true,"resources":{"url":{"values":["*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"83780e36-d268-4dcf-8146-72b17e0b0869","isEnabled":true,"version":1}	1
12	f377c38d-3976-43d5-8f61-95c7fc777e51	2024-02-08 17:01:50.549	2024-02-08 17:01:50.549	1	1	1	4	default database tables columns	0	\N	6953543a4b66b6f2035924da5ab162724650a6b3e6ef0049c02819d894bc72a5	t	t	\N	0	{"service":"dev_hive","name":"default database tables columns","policyType":0,"policyPriority":0,"resourceSignature":"6953543a4b66b6f2035924da5ab162724650a6b3e6ef0049c02819d894bc72a5","isAuditEnabled":true,"resources":{"database":{"values":["default"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"create","isAllowed":true}],"users":[],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"f377c38d-3976-43d5-8f61-95c7fc777e51","isEnabled":true,"version":1}	1
13	37e8dfed-84dd-4ff8-b779-4f045040d0a9	2024-02-08 17:01:50.566	2024-02-08 17:01:50.567	1	1	1	4	Information_schema database tables columns	0	\N	ae84bfb2ea30aed7571ac7d10c68e30084fb38933ff1d7fca41a833e105bd6bb	t	t	\N	0	{"service":"dev_hive","name":"Information_schema database tables columns","policyType":0,"policyPriority":0,"resourceSignature":"ae84bfb2ea30aed7571ac7d10c68e30084fb38933ff1d7fca41a833e105bd6bb","isAuditEnabled":true,"resources":{"database":{"values":["information_schema"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"select","isAllowed":true}],"users":[],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hive","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"37e8dfed-84dd-4ff8-b779-4f045040d0a9","isEnabled":true,"version":1}	1
14	86bcf48b-cd26-4a3c-8c17-025bf4b4f0ab	2024-02-08 17:01:50.708	2024-02-08 17:01:50.71	1	1	1	5	all - table, column-family, column	0	Policy for all - table, column-family, column	95b105e8d8ae812632b26539d8bfec09793853d278fc0193da8878f6fe095ef3	t	t	\N	0	{"service":"dev_hbase","name":"all - table, column-family, column","policyType":0,"policyPriority":0,"description":"Policy for all - table, column-family, column","resourceSignature":"95b105e8d8ae812632b26539d8bfec09793853d278fc0193da8878f6fe095ef3","isAuditEnabled":true,"resources":{"column-family":{"values":["*"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"create","isAllowed":true},{"type":"admin","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hbase","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"86bcf48b-cd26-4a3c-8c17-025bf4b4f0ab","isEnabled":true,"version":1}	1
15	96ced605-0b6b-45a2-96d2-7fa2bc135b26	2024-02-08 17:01:50.767	2024-02-08 17:01:50.768	1	1	1	6	all - consumergroup	0	Policy for all - consumergroup	8b806b6eabc6adcac1658dfcb2f95f7f2fdd2a3d2093e67f3fe4773d9562c08d	t	t	\N	0	{"service":"dev_kafka","name":"all - consumergroup","policyType":0,"policyPriority":0,"description":"Policy for all - consumergroup","resourceSignature":"8b806b6eabc6adcac1658dfcb2f95f7f2fdd2a3d2093e67f3fe4773d9562c08d","isAuditEnabled":true,"resources":{"consumergroup":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"consume","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"delete","isAllowed":true}],"users":["kafka"],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kafka","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"96ced605-0b6b-45a2-96d2-7fa2bc135b26","isEnabled":true,"version":1}	1
16	c149589e-5ea7-4d33-8db4-f11190644dc6	2024-02-08 17:01:50.783	2024-02-08 17:01:50.783	1	1	1	6	all - topic	0	Policy for all - topic	875e011fb314298153184b702421bff743744ff9637778aa2c8066aecc08ecc1	t	t	\N	0	{"service":"dev_kafka","name":"all - topic","policyType":0,"policyPriority":0,"description":"Policy for all - topic","resourceSignature":"875e011fb314298153184b702421bff743744ff9637778aa2c8066aecc08ecc1","isAuditEnabled":true,"resources":{"topic":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"publish","isAllowed":true},{"type":"consume","isAllowed":true},{"type":"configure","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"create","isAllowed":true},{"type":"delete","isAllowed":true},{"type":"describe_configs","isAllowed":true},{"type":"alter_configs","isAllowed":true},{"type":"alter","isAllowed":true}],"users":["kafka"],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kafka","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"c149589e-5ea7-4d33-8db4-f11190644dc6","isEnabled":true,"version":1}	1
17	64fdaa43-c666-4259-be9c-fbbe9d5cfb6f	2024-02-08 17:01:50.797	2024-02-08 17:01:50.797	1	1	1	6	all - transactionalid	0	Policy for all - transactionalid	08c233ac88f4f6024ae516f63c9f244e65eb9a0ad4581d807fe0f66f00c1f17c	t	t	\N	0	{"service":"dev_kafka","name":"all - transactionalid","policyType":0,"policyPriority":0,"description":"Policy for all - transactionalid","resourceSignature":"08c233ac88f4f6024ae516f63c9f244e65eb9a0ad4581d807fe0f66f00c1f17c","isAuditEnabled":true,"resources":{"transactionalid":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"publish","isAllowed":true},{"type":"describe","isAllowed":true}],"users":["kafka"],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kafka","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"64fdaa43-c666-4259-be9c-fbbe9d5cfb6f","isEnabled":true,"version":1}	1
18	d9cde2d0-99b3-4e8b-9e14-c7ccb14d8629	2024-02-08 17:01:50.812	2024-02-08 17:01:50.812	1	1	1	6	all - cluster	0	Policy for all - cluster	f0f71572fbbecb75c249a18d593c9f16b8913a1fe67ec1e03f7e513ed857ed13	t	t	\N	0	{"service":"dev_kafka","name":"all - cluster","policyType":0,"policyPriority":0,"description":"Policy for all - cluster","resourceSignature":"f0f71572fbbecb75c249a18d593c9f16b8913a1fe67ec1e03f7e513ed857ed13","isAuditEnabled":true,"resources":{"cluster":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"configure","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"kafka_admin","isAllowed":true},{"type":"create","isAllowed":true},{"type":"idempotent_write","isAllowed":true},{"type":"describe_configs","isAllowed":true},{"type":"alter_configs","isAllowed":true},{"type":"cluster_action","isAllowed":true},{"type":"alter","isAllowed":true}],"users":["kafka"],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kafka","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"d9cde2d0-99b3-4e8b-9e14-c7ccb14d8629","isEnabled":true,"version":1}	1
19	e63d642f-50f1-4143-8200-1867d4b93e06	2024-02-08 17:01:50.827	2024-02-08 17:01:50.827	1	1	1	6	all - delegationtoken	0	Policy for all - delegationtoken	2cb327aea1a3008ff5871618be9eec6fd9804adffa51f703889b49d465a64635	t	t	\N	0	{"service":"dev_kafka","name":"all - delegationtoken","policyType":0,"policyPriority":0,"description":"Policy for all - delegationtoken","resourceSignature":"2cb327aea1a3008ff5871618be9eec6fd9804adffa51f703889b49d465a64635","isAuditEnabled":true,"resources":{"delegationtoken":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"describe","isAllowed":true}],"users":["kafka"],"groups":["public"],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kafka","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"e63d642f-50f1-4143-8200-1867d4b93e06","isEnabled":true,"version":1}	1
20	4ea21fd4-bd30-42f7-b508-fef34692383e	2024-02-08 17:01:50.944	2024-02-08 17:01:50.944	1	1	1	7	all - topology, service	0	Policy for all - topology, service	bcdaa6d5b59d1ff76890aee0548b75e9abd1a9bb6964fa8a5157b6d37ffce8db	t	t	\N	0	{"service":"dev_knox","name":"all - topology, service","policyType":0,"policyPriority":0,"description":"Policy for all - topology, service","resourceSignature":"bcdaa6d5b59d1ff76890aee0548b75e9abd1a9bb6964fa8a5157b6d37ffce8db","isAuditEnabled":true,"resources":{"topology":{"values":["*"],"isExcludes":false,"isRecursive":false},"service":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"allow","isAllowed":true}],"users":["knox"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"knox","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"4ea21fd4-bd30-42f7-b508-fef34692383e","isEnabled":true,"version":1}	1
21	8c73b7f6-f213-454c-ac6e-089f909fbe51	2024-02-08 17:01:51.012	2024-02-08 17:01:51.012	1	1	1	8	all - keyname	0	Policy for all - keyname	43ba5ec899642b547c31144d1b915a0b8502b71fbff3216ec5733c7d6363cb2c	t	t	\N	0	{"service":"dev_kms","name":"all - keyname","policyType":0,"policyPriority":0,"description":"Policy for all - keyname","resourceSignature":"43ba5ec899642b547c31144d1b915a0b8502b71fbff3216ec5733c7d6363cb2c","isAuditEnabled":true,"resources":{"keyname":{"values":["*"],"isExcludes":false,"isRecursive":false}},"policyItems":[{"accesses":[{"type":"create","isAllowed":true},{"type":"delete","isAllowed":true},{"type":"rollover","isAllowed":true},{"type":"setkeymaterial","isAllowed":true},{"type":"get","isAllowed":true},{"type":"getkeys","isAllowed":true},{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true},{"type":"decrypteek","isAllowed":true}],"users":["keyadmin"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true}],"users":["hdfs"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true}],"users":["om"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"decrypteek","isAllowed":true}],"users":["hive"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true},{"accesses":[{"type":"decrypteek","isAllowed":true}],"users":["hbase"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"kms","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"8c73b7f6-f213-454c-ac6e-089f909fbe51","isEnabled":true,"version":1}	1
22	4e053429-1e49-4654-a9ec-f51a947cf116	2024-02-08 17:51:47.957	2024-02-08 17:51:47.96	1	1	1	9	all - path	0	Policy for all - path	dfe81e379022be6cadb1665e2a3883824f2bc09626557a32efa3a236609005b6	t	t	\N	0	{"service":"hadoopdev","name":"all - path","policyType":0,"policyPriority":0,"description":"Policy for all - path","resourceSignature":"dfe81e379022be6cadb1665e2a3883824f2bc09626557a32efa3a236609005b6","isAuditEnabled":true,"resources":{"path":{"values":["/*"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hadoop"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":true}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hdfs","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"4e053429-1e49-4654-a9ec-f51a947cf116","isEnabled":true,"version":1}	1
23	b7b30475-730c-4ec6-90ce-0a6bc9f47059	2024-02-08 17:51:48.016	2024-02-08 17:51:48.017	1	1	1	9	kms-audit-path	0	Policy for kms-audit-path	b349a238ab1cea962a44878de9da2231537b5b1ab65006ca892565679d6ab1e0	t	t	\N	0	{"service":"hadoopdev","name":"kms-audit-path","policyType":0,"policyPriority":0,"description":"Policy for kms-audit-path","resourceSignature":"b349a238ab1cea962a44878de9da2231537b5b1ab65006ca892565679d6ab1e0","isAuditEnabled":true,"resources":{"path":{"values":["/ranger/audit/kms"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["keyadmin"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hdfs","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"b7b30475-730c-4ec6-90ce-0a6bc9f47059","isEnabled":true,"version":1}	1
24	0bc61748-83c7-477d-8d62-642874952fb4	2024-02-08 17:51:48.047	2024-02-08 17:51:48.048	1	1	1	9	hbase-archive	0	Policy for hbase archive location	37fe368bc41139223d1f995603a4e71c352b8804e0413c0a06235b09ab42b19c	t	t	\N	0	{"service":"hadoopdev","name":"hbase-archive","policyType":0,"policyPriority":0,"description":"Policy for hbase archive location","resourceSignature":"37fe368bc41139223d1f995603a4e71c352b8804e0413c0a06235b09ab42b19c","isAuditEnabled":true,"resources":{"path":{"values":["/hbase/archive"],"isExcludes":false,"isRecursive":true}},"policyItems":[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"groups":[],"roles":[],"conditions":[],"delegateAdmin":false}],"denyPolicyItems":[],"allowExceptions":[],"denyExceptions":[],"dataMaskPolicyItems":[],"rowFilterPolicyItems":[],"serviceType":"hdfs","options":{},"validitySchedules":[],"policyLabels":[],"isDenyAllElse":false,"guid":"0bc61748-83c7-477d-8d62-642874952fb4","isEnabled":true,"version":1}	1
\.


--
-- Data for Name: x_policy_change_log; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_change_log (id, create_time, service_id, change_type, policy_version, service_type, policy_type, zone_name, policy_id, policy_guid) FROM stdin;
\.


--
-- Data for Name: x_policy_condition_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_condition_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, evaluator, evaluator_options, validation_reg_ex, validation_message, ui_hint, label, description, rb_key_label, rb_key_description, rb_key_validation_message, sort_order) FROM stdin;
1	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.685	\N	\N	5	1	ip-range	org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher	{}			{ "isMultiValue":true }	IP Address Range	IP Address Range	\N	\N	\N	0
2	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.781	\N	\N	9	1	ip-range	org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher	{}			{ "isMultiValue":true }	IP Address Range	IP Address Range	\N	\N	\N	0
3	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.802	\N	\N	8	100	ip-range	org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher	{}			{ "isMultiValue":true }	IP Address Range	IP Address Range	\N	\N	\N	0
4	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.825	\N	\N	202	1	ip-range	org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher	{}			{ "isMultiValue":true }	IP Address Range	IP Address Range	\N	\N	\N	0
7	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.405	\N	\N	201	1	ip-range	org.apache.ranger.plugin.conditionevaluator.RangerIpMatcher	{}			{ "isMultiValue":true }	IP Address Range	IP Address Range	\N	\N	\N	0
5	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.724	\N	\N	100	1	accessed-after-expiry	org.apache.ranger.plugin.conditionevaluator.RangerScriptTemplateConditionEvaluator	{"scriptTemplate":"ctx.isAccessedAfter('expiry_date');"}	\N	\N	{ "singleValue":true }	Accessed after expiry_date (yes/no)?	Accessed after expiry_date? (yes/no)	\N	\N	\N	0
6	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.725	\N	\N	100	2	expression	org.apache.ranger.plugin.conditionevaluator.RangerScriptConditionEvaluator	{"engineName":"JavaScript","ui.isMultiline":"true"}	\N	\N	{ "isMultiline":true }	Enter boolean expression	Boolean expression	\N	\N	\N	1
\.


--
-- Data for Name: x_policy_export_audit; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_export_audit (id, create_time, update_time, added_by_id, upd_by_id, client_ip, agent_id, req_epoch, last_updated, repository_name, exported_json, http_ret_code, cluster_name, zone_name, policy_version) FROM stdin;
1	2024-02-08 17:52:09.152	2024-02-08 17:52:09.154	\N	\N	172.22.0.8	hdfs@namenode-hadoopdev	-1	\N	hadoopdev	\N	200			\N
\.


--
-- Data for Name: x_policy_item; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, delegate_admin, sort_order, item_type, is_enabled, comments) FROM stdin;
\.


--
-- Data for Name: x_policy_item_access; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item_access (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_item_id, type, is_allowed, sort_order) FROM stdin;
\.


--
-- Data for Name: x_policy_item_condition; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item_condition (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_item_id, type, value, sort_order) FROM stdin;
\.


--
-- Data for Name: x_policy_item_datamask; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item_datamask (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_item_id, type, condition_expr, value_expr) FROM stdin;
\.


--
-- Data for Name: x_policy_item_group_perm; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item_group_perm (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_item_id, group_id, sort_order) FROM stdin;
\.


--
-- Data for Name: x_policy_item_rowfilter; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item_rowfilter (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_item_id, filter_expr) FROM stdin;
\.


--
-- Data for Name: x_policy_item_user_perm; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_item_user_perm (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_item_id, user_id, sort_order) FROM stdin;
\.


--
-- Data for Name: x_policy_label; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_label (id, guid, create_time, update_time, added_by_id, upd_by_id, label_name) FROM stdin;
\.


--
-- Data for Name: x_policy_label_map; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_label_map (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, policy_label_id) FROM stdin;
\.


--
-- Data for Name: x_policy_ref_access_type; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_access_type (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, access_def_id, access_type_name) FROM stdin;
1	\N	2024-02-08 17:01:49.978	2024-02-08 17:01:50.011	1	1	1	1	read
2	\N	2024-02-08 17:01:49.978	2024-02-08 17:01:50.012	1	1	1	2	write
3	\N	2024-02-08 17:01:49.978	2024-02-08 17:01:50.012	1	1	1	3	execute
4	\N	2024-02-08 17:01:50.033	2024-02-08 17:01:50.041	1	1	2	1	read
6	\N	2024-02-08 17:01:50.033	2024-02-08 17:01:50.042	1	1	2	3	execute
5	\N	2024-02-08 17:01:50.033	2024-02-08 17:01:50.042	1	1	2	2	write
7	\N	2024-02-08 17:01:50.055	2024-02-08 17:01:50.063	1	1	3	1	read
8	\N	2024-02-08 17:01:50.055	2024-02-08 17:01:50.063	1	1	3	2	write
9	\N	2024-02-08 17:01:50.055	2024-02-08 17:01:50.064	1	1	3	3	execute
10	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.132	1	1	4	194	ozone:write_acl
58	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	292	atlas:entity-delete
105	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	273	kafka:cluster_action
53	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	302	atlas:entity-add-label
140	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	305	atlas:type-read
115	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	282	nifi:WRITE
82	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	102	kylin:ADMIN
44	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	242	kms:setkeymaterial
20	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	270	kafka:idempotent_write
110	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	297	atlas:admin-import
94	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	217	hdfs:read
36	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	298	atlas:add-relationship
134	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	188	ozone:read
95	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	124	elasticsearch:write
83	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	300	atlas:remove-relationship
38	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	204	kudu:select
21	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	234	hive:write
41	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	126	elasticsearch:create_index
118	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	257	storm:getTopology
17	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	256	storm:getTopologyConf
34	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	264	kafka:consume
142	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	99	kylin:QUERY
93	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	142	trino:create
31	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	178	presto:execute
57	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	238	hive:refresh
139	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	207	kudu:delete
107	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	218	hdfs:write
29	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	294	atlas:entity-update-classification
103	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	254	storm:activate
12	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.132	1	1	4	288	atlas:type-delete
74	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	241	kms:rollover
59	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	177	presto:all
23	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	147	trino:grant
14	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	224	hbase:execute
66	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	125	elasticsearch:delete_index
158	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.147	1	1	4	221	hbase:write
51	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	293	atlas:entity-add-classification
119	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	220	hbase:read
89	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	170	presto:delete
60	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	291	atlas:entity-update
63	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	206	kudu:update
109	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	122	elasticsearch:create
124	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	227	hive:create
155	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	222	hbase:create
16	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	244	kms:getkeys
152	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	231	hive:lock
55	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	267	kafka:kafka_admin
62	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	141	trino:insert
97	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	272	kafka:alter_configs
85	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	252	storm:killTopology
137	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	281	nifi:READ
120	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	245	kms:getmetadata
92	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	276	solr:update
96	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	229	hive:alter
117	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	259	storm:getTopologyInfo
143	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	120	elasticsearch:read_cross_cluster
101	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	287	atlas:type-update
113	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	286	atlas:type-create
39	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	171	presto:use
67	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	175	presto:show
28	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	172	presto:alter
79	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	152	trino:execute
68	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	189	ozone:write
75	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	118	elasticsearch:view_index_metadata
43	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	215	nestedstructure:read
159	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.147	1	1	4	119	elasticsearch:read
114	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	212	kudu:all
49	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	121	elasticsearch:index
128	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	283	nifi-registry:READ
135	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	149	trino:show
73	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	173	presto:grant
111	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	247	kms:decrypteek
121	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	250	storm:fileUpload
148	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	299	atlas:update-relationship
40	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	236	hive:serviceadmin
37	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	143	trino:drop
11	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.132	1	1	4	243	kms:get
81	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	240	kms:delete
33	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	301	atlas:admin-purge
132	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	285	nifi-registry:DELETE
88	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	93	sqoop:READ
116	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	94	sqoop:WRITE
106	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	150	trino:impersonate
18	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	190	ozone:create
19	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	237	hive:tempudfadmin
102	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	249	storm:submitTopology
151	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	253	storm:rebalance
48	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	255	storm:deactivate
77	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	263	kafka:publish
25	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	296	atlas:admin-export
146	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	191	ozone:list
150	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	284	nifi-registry:WRITE
84	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	101	kylin:MANAGEMENT
123	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	228	hive:drop
71	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	303	atlas:entity-remove-label
147	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	216	nestedstructure:write
87	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	226	hive:update
50	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	274	kafka:alter
145	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	166	presto:select
46	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	277	schema-registry:create
32	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	266	kafka:describe
144	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	117	elasticsearch:manage
52	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	295	atlas:entity-remove-classification
47	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	176	presto:impersonate
112	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	275	solr:query
45	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.136	1	1	4	100	kylin:OPERATION
98	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	258	storm:getUserTopology
125	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	262	yarn:admin-queue
156	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	123	elasticsearch:delete
56	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	169	presto:drop
108	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.142	1	1	4	223	hbase:admin
133	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	239	kms:create
27	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	289	atlas:entity-read
30	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	140	trino:select
86	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	209	kudu:create
76	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	168	presto:create
69	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	233	hive:read
129	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	235	hive:repladmin
130	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	211	kudu:metadata
154	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	248	knox:allow
22	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	145	trino:use
26	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	265	kafka:configure
138	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	225	hive:select
54	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.137	1	1	4	279	schema-registry:update
99	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	260	storm:uploadNewCredentials
61	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	116	elasticsearch:monitor
160	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.147	1	1	4	208	kudu:alter
13	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	290	atlas:entity-create
64	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	278	schema-registry:read
24	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.134	1	1	4	219	hdfs:execute
35	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	144	trino:delete
42	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.135	1	1	4	230	hive:index
104	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	246	kms:generateeek
15	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.133	1	1	4	251	storm:fileDownload
162	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.147	1	1	4	115	elasticsearch:all
78	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	268	kafka:create
149	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	148	trino:revoke
157	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	210	kudu:drop
72	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	151	trino:all
70	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	187	ozone:all
127	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	192	ozone:delete
91	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	261	yarn:submit-app
80	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.139	1	1	4	232	hive:all
100	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.141	1	1	4	167	presto:insert
90	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.14	1	1	4	304	atlas:entity-update-business-metadata
161	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.147	1	1	4	205	kudu:insert
136	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	193	ozone:read_acl
131	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	280	schema-registry:delete
126	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.144	1	1	4	271	kafka:describe_configs
153	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.146	1	1	4	174	presto:revoke
122	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.143	1	1	4	146	trino:alter
65	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.138	1	1	4	306	atlas:admin-audits
141	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.145	1	1	4	269	kafka:delete
163	\N	2024-02-08 17:01:50.325	2024-02-08 17:01:50.333	1	1	5	45	submit-app
164	\N	2024-02-08 17:01:50.325	2024-02-08 17:01:50.333	1	1	5	46	admin-queue
165	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	12	drop
169	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	10	update
178	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.426	1	1	6	13	alter
168	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	17	read
175	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.426	1	1	6	15	lock
170	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	14	index
172	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	21	tempudfadmin
176	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.426	1	1	6	19	repladmin
171	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	22	refresh
167	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	9	select
173	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.426	1	1	6	20	serviceadmin
166	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.425	1	1	6	16	all
177	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.426	1	1	6	18	write
174	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.426	1	1	6	11	create
179	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.445	1	1	7	12	drop
185	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	22	refresh
191	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.447	1	1	7	18	write
186	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	21	tempudfadmin
184	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	14	index
180	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	16	all
192	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.447	1	1	7	13	alter
190	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.447	1	1	7	19	repladmin
183	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	10	update
188	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	11	create
181	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	9	select
187	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	20	serviceadmin
189	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	15	lock
182	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.446	1	1	7	17	read
193	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.47	1	1	8	12	drop
203	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	15	lock
194	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.47	1	1	8	16	all
200	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	21	tempudfadmin
197	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.47	1	1	8	10	update
204	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	19	repladmin
202	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	11	create
196	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.47	1	1	8	17	read
205	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	18	write
198	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.47	1	1	8	14	index
206	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	13	alter
201	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	20	serviceadmin
199	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.471	1	1	8	22	refresh
195	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.47	1	1	8	9	select
207	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	12	drop
220	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.491	1	1	9	13	alter
216	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.491	1	1	9	11	create
211	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	10	update
213	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	22	refresh
217	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.491	1	1	9	15	lock
208	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	16	all
209	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	9	select
214	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	21	tempudfadmin
215	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	20	serviceadmin
210	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	17	read
219	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.491	1	1	9	18	write
212	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.49	1	1	9	14	index
218	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.491	1	1	9	19	repladmin
221	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.51	1	1	10	12	drop
232	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.512	1	1	10	19	repladmin
230	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.512	1	1	10	11	create
229	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.512	1	1	10	20	serviceadmin
223	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	9	select
224	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	17	read
222	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	16	all
227	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	22	refresh
228	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	21	tempudfadmin
226	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	14	index
225	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.511	1	1	10	10	update
234	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.512	1	1	10	13	alter
233	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.512	1	1	10	18	write
231	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.512	1	1	10	15	lock
235	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.535	1	1	11	12	drop
246	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.537	1	1	11	19	repladmin
244	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	11	create
247	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.537	1	1	11	18	write
238	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	17	read
237	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	9	select
240	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	14	index
243	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	20	serviceadmin
248	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.537	1	1	11	13	alter
241	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	22	refresh
242	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	21	tempudfadmin
245	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.537	1	1	11	15	lock
239	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	10	update
236	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.536	1	1	11	16	all
249	\N	2024-02-08 17:01:50.549	2024-02-08 17:01:50.555	1	1	12	11	create
250	\N	2024-02-08 17:01:50.566	2024-02-08 17:01:50.574	1	1	13	9	select
251	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.713	1	1	14	4	read
255	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.714	1	1	14	8	execute
253	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.714	1	1	14	7	admin
252	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.714	1	1	14	6	create
254	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.714	1	1	14	5	write
256	\N	2024-02-08 17:01:50.767	2024-02-08 17:01:50.773	1	1	15	48	consume
257	\N	2024-02-08 17:01:50.767	2024-02-08 17:01:50.773	1	1	15	50	describe
258	\N	2024-02-08 17:01:50.767	2024-02-08 17:01:50.773	1	1	15	53	delete
259	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	55	describe_configs
265	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	50	describe
263	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	48	consume
260	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	56	alter_configs
261	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	47	publish
266	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	53	delete
262	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	52	create
267	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	58	alter
264	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.788	1	1	16	49	configure
268	\N	2024-02-08 17:01:50.797	2024-02-08 17:01:50.802	1	1	17	47	publish
269	\N	2024-02-08 17:01:50.797	2024-02-08 17:01:50.802	1	1	17	50	describe
270	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.817	1	1	18	55	describe_configs
275	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.818	1	1	18	50	describe
274	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.817	1	1	18	49	configure
273	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.817	1	1	18	52	create
276	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.818	1	1	18	51	kafka_admin
271	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.817	1	1	18	56	alter_configs
272	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.817	1	1	18	54	idempotent_write
278	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.818	1	1	18	58	alter
277	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.818	1	1	18	57	cluster_action
279	\N	2024-02-08 17:01:50.827	2024-02-08 17:01:50.832	1	1	19	50	describe
280	\N	2024-02-08 17:01:50.944	2024-02-08 17:01:50.947	1	1	20	32	allow
281	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.018	1	1	21	27	get
287	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.019	1	1	21	31	decrypteek
283	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.018	1	1	21	23	create
285	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.019	1	1	21	26	setkeymaterial
286	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.019	1	1	21	28	getkeys
282	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.018	1	1	21	29	getmetadata
288	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.019	1	1	21	30	generateeek
284	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.018	1	1	21	25	rollover
289	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.019	1	1	21	24	delete
290	\N	2024-02-08 17:51:47.957	2024-02-08 17:51:47.985	1	1	22	1	read
292	\N	2024-02-08 17:51:47.957	2024-02-08 17:51:47.987	1	1	22	3	execute
291	\N	2024-02-08 17:51:47.957	2024-02-08 17:51:47.987	1	1	22	2	write
293	\N	2024-02-08 17:51:48.016	2024-02-08 17:51:48.03	1	1	23	1	read
294	\N	2024-02-08 17:51:48.016	2024-02-08 17:51:48.03	1	1	23	2	write
295	\N	2024-02-08 17:51:48.016	2024-02-08 17:51:48.03	1	1	23	3	execute
296	\N	2024-02-08 17:51:48.047	2024-02-08 17:51:48.059	1	1	24	1	read
298	\N	2024-02-08 17:51:48.047	2024-02-08 17:51:48.059	1	1	24	3	execute
297	\N	2024-02-08 17:51:48.047	2024-02-08 17:51:48.059	1	1	24	2	write
\.


--
-- Data for Name: x_policy_ref_condition; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_condition (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, condition_def_id, condition_name) FROM stdin;
1	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.162	1	1	4	5	accessed-after-expiry
\.


--
-- Data for Name: x_policy_ref_datamask_type; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_datamask_type (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, datamask_def_id, datamask_type_name) FROM stdin;
\.


--
-- Data for Name: x_policy_ref_group; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_group (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, group_id, group_name) FROM stdin;
1	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.104	1	1	4	1	public
2	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.422	1	1	6	1	public
3	\N	2024-02-08 17:01:50.549	2024-02-08 17:01:50.554	1	1	12	1	public
4	\N	2024-02-08 17:01:50.566	2024-02-08 17:01:50.573	1	1	13	1	public
5	\N	2024-02-08 17:01:50.767	2024-02-08 17:01:50.772	1	1	15	1	public
6	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.786	1	1	16	1	public
7	\N	2024-02-08 17:01:50.797	2024-02-08 17:01:50.801	1	1	17	1	public
8	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.815	1	1	18	1	public
9	\N	2024-02-08 17:01:50.827	2024-02-08 17:01:50.831	1	1	19	1	public
\.


--
-- Data for Name: x_policy_ref_resource; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_resource (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, resource_def_id, resource_name) FROM stdin;
1	\N	2024-02-08 17:01:49.978	2024-02-08 17:01:50.006	1	1	1	1	path
2	\N	2024-02-08 17:01:50.033	2024-02-08 17:01:50.039	1	1	2	1	path
3	\N	2024-02-08 17:01:50.055	2024-02-08 17:01:50.061	1	1	3	1	path
4	\N	2024-02-08 17:01:50.094	2024-02-08 17:01:50.102	1	1	4	50	tag
5	\N	2024-02-08 17:01:50.325	2024-02-08 17:01:50.331	1	1	5	16	queue
6	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.421	1	1	6	5	database
7	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.443	1	1	7	10	hiveservice
8	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.465	1	1	8	5	database
10	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.466	1	1	8	6	table
9	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.466	1	1	8	8	column
11	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.486	1	1	9	5	database
12	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.487	1	1	9	6	table
13	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.506	1	1	10	5	database
14	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.507	1	1	10	7	udf
15	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.532	1	1	11	9	url
16	\N	2024-02-08 17:01:50.549	2024-02-08 17:01:50.553	1	1	12	5	database
18	\N	2024-02-08 17:01:50.549	2024-02-08 17:01:50.553	1	1	12	6	table
17	\N	2024-02-08 17:01:50.549	2024-02-08 17:01:50.553	1	1	12	8	column
19	\N	2024-02-08 17:01:50.566	2024-02-08 17:01:50.571	1	1	13	5	database
21	\N	2024-02-08 17:01:50.566	2024-02-08 17:01:50.572	1	1	13	6	table
20	\N	2024-02-08 17:01:50.566	2024-02-08 17:01:50.572	1	1	13	8	column
22	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.712	1	1	14	3	column-family
24	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.712	1	1	14	2	table
23	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.712	1	1	14	4	column
25	\N	2024-02-08 17:01:50.767	2024-02-08 17:01:50.771	1	1	15	21	consumergroup
26	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.785	1	1	16	17	topic
27	\N	2024-02-08 17:01:50.797	2024-02-08 17:01:50.8	1	1	17	18	transactionalid
28	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.815	1	1	18	19	cluster
29	\N	2024-02-08 17:01:50.827	2024-02-08 17:01:50.83	1	1	19	20	delegationtoken
30	\N	2024-02-08 17:01:50.944	2024-02-08 17:01:50.947	1	1	20	13	topology
31	\N	2024-02-08 17:01:50.944	2024-02-08 17:01:50.947	1	1	20	14	service
32	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.014	1	1	21	12	keyname
33	\N	2024-02-08 17:51:47.957	2024-02-08 17:51:47.983	1	1	22	1	path
34	\N	2024-02-08 17:51:48.016	2024-02-08 17:51:48.026	1	1	23	1	path
35	\N	2024-02-08 17:51:48.047	2024-02-08 17:51:48.055	1	1	24	1	path
\.


--
-- Data for Name: x_policy_ref_role; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_role (id, create_time, update_time, added_by_id, upd_by_id, policy_id, role_id, role_name) FROM stdin;
\.


--
-- Data for Name: x_policy_ref_user; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_ref_user (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, user_id, user_name) FROM stdin;
1	\N	2024-02-08 17:01:50.033	2024-02-08 17:01:50.04	1	1	2	3	keyadmin
2	\N	2024-02-08 17:01:49.978	2024-02-08 17:01:50.261	1	1	1	7	hdfs
3	\N	2024-02-08 17:01:50.055	2024-02-08 17:01:50.275	1	1	3	8	hbase
4	\N	2024-02-08 17:01:50.325	2024-02-08 17:01:50.364	1	1	5	9	yarn
5	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.423	1	1	6	6	{OWNER}
6	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.467	1	1	8	6	{OWNER}
7	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.487	1	1	9	6	{OWNER}
8	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.508	1	1	10	6	{OWNER}
9	\N	2024-02-08 17:01:50.417	2024-02-08 17:01:50.601	1	1	6	10	hive
10	\N	2024-02-08 17:01:50.439	2024-02-08 17:01:50.608	1	1	7	10	hive
11	\N	2024-02-08 17:01:50.459	2024-02-08 17:01:50.617	1	1	8	10	hive
12	\N	2024-02-08 17:01:50.482	2024-02-08 17:01:50.624	1	1	9	10	hive
13	\N	2024-02-08 17:01:50.502	2024-02-08 17:01:50.63	1	1	10	10	hive
14	\N	2024-02-08 17:01:50.527	2024-02-08 17:01:50.64	1	1	11	10	hive
15	\N	2024-02-08 17:01:50.708	2024-02-08 17:01:50.713	1	1	14	8	hbase
16	\N	2024-02-08 17:01:50.767	2024-02-08 17:01:50.86	1	1	15	11	kafka
17	\N	2024-02-08 17:01:50.783	2024-02-08 17:01:50.871	1	1	16	11	kafka
18	\N	2024-02-08 17:01:50.797	2024-02-08 17:01:50.878	1	1	17	11	kafka
19	\N	2024-02-08 17:01:50.812	2024-02-08 17:01:50.887	1	1	18	11	kafka
20	\N	2024-02-08 17:01:50.827	2024-02-08 17:01:50.902	1	1	19	11	kafka
21	\N	2024-02-08 17:01:50.944	2024-02-08 17:01:50.97	1	1	20	12	knox
22	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.014	1	1	21	10	hive
23	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.015	1	1	21	3	keyadmin
24	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.015	1	1	21	7	hdfs
25	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.016	1	1	21	8	hbase
26	\N	2024-02-08 17:01:51.012	2024-02-08 17:01:51.045	1	1	21	13	om
27	\N	2024-02-08 17:51:48.016	2024-02-08 17:51:48.028	1	1	23	3	keyadmin
28	\N	2024-02-08 17:51:48.047	2024-02-08 17:51:48.057	1	1	24	8	hbase
29	\N	2024-02-08 17:51:47.957	2024-02-08 17:51:48.095	1	1	22	14	hadoop
\.


--
-- Data for Name: x_policy_resource; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_resource (id, guid, create_time, update_time, added_by_id, upd_by_id, policy_id, res_def_id, is_excludes, is_recursive) FROM stdin;
\.


--
-- Data for Name: x_policy_resource_map; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_policy_resource_map (id, guid, create_time, update_time, added_by_id, upd_by_id, resource_id, value, sort_order) FROM stdin;
\.


--
-- Data for Name: x_portal_user; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_portal_user (id, create_time, update_time, added_by_id, upd_by_id, first_name, last_name, pub_scr_name, login_id, password, email, status, user_src, notes, other_attributes, sync_source, old_passwords, password_updated_time) FROM stdin;
1	2024-02-08 17:00:57.465244	2024-02-08 17:01:14.267	\N	\N	Admin		Admin	admin	170213c34ea180bbe9dc19dcbed8b8440651b4d046d1816f4375ab43670357b8		1	0	\N	\N	\N	\N	\N
4	2024-02-08 17:00:57.67673	2024-02-08 17:01:14.271	\N	\N	rangertagsync		rangertagsync	rangertagsync	984c1d776d26afb5162b965673e8d4cb2a8e113ca7eda00abd6d4b5f68dc7919	rangertagsync	1	0	\N	\N	\N	\N	\N
2	2024-02-08 17:00:57.499368	2024-02-08 17:01:14.274	\N	\N	rangerusersync		rangerusersync	rangerusersync	9a5d1b500c4caf1fd8d7637ac9fc1c3b520f2b7e8dc28bfb4ea0a4f0b65645e2	rangerusersync	1	0	\N	\N	\N	\N	\N
3	2024-02-08 17:00:57.527626	2024-02-08 17:01:14.276	\N	\N	keyadmin		keyadmin	keyadmin	8d673476c40716db5610f68588fdd60debffdda1bdb92506f5f60f4ad6c18eda	keyadmin	1	0	\N	\N	\N	\N	\N
5	2024-02-08 17:01:50.22	2024-02-08 17:01:50.221	1	1	\N	\N	hdfs	hdfs	0963a3848979a444fd8dcbdf954d8f7438d9ca0c60d846d91d0b03295e649727	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:50.22
6	2024-02-08 17:01:50.246	2024-02-08 17:01:50.246	1	1	\N	\N	hbase	hbase	192be8bd7f759aca745b7d9d41d38840444ef43363b324afb20527830bcfcf59	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:50.246
7	2024-02-08 17:01:50.349	2024-02-08 17:01:50.349	1	1	\N	\N	yarn	yarn	304469000b0ce2d3beaec3dc53486278777b6e00a8bf5ba55e6f99ccb8033a57	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:50.349
8	2024-02-08 17:01:50.589	2024-02-08 17:01:50.59	1	1	\N	\N	hive	hive	8a665c74c69ea22a485c4ce14e93ce0b3087b82f893b6e2197e099cbef16d548	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:50.589
9	2024-02-08 17:01:50.845	2024-02-08 17:01:50.845	1	1	\N	\N	kafka	kafka	9f0b6444579c53f94401d1d5fcf73b72e16cf846fe42b5cb2303209c195d60c3	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:50.845
10	2024-02-08 17:01:50.958	2024-02-08 17:01:50.958	1	1	\N	\N	knox	knox	b19a997a04a792631d162319e49bc33391162c246922956e48719c408abe096d	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:50.958
11	2024-02-08 17:01:51.036	2024-02-08 17:01:51.036	1	1	\N	\N	om	om	4340b88eca591caa95161fc727cbe6b5a74d0b7dc213ee9207e950649922b7c0	\N	1	1	\N	\N	\N	\N	2024-02-08 17:01:51.036
12	2024-02-08 17:51:48.079	2024-02-08 17:51:48.08	1	1	\N	\N	hadoop	hadoop	0a9918cf7fcb18b18801fe8ec0a5ec6b772dc902f7e849d9dfbf61932467ad8d	\N	1	1	\N	\N	\N	\N	2024-02-08 17:51:48.08
\.


--
-- Data for Name: x_portal_user_role; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_portal_user_role (id, create_time, update_time, added_by_id, upd_by_id, user_id, user_role, status) FROM stdin;
1	2024-02-08 17:00:57.468673	2024-02-08 17:00:57.468673	\N	\N	1	ROLE_SYS_ADMIN	1
2	2024-02-08 17:00:57.504822	2024-02-08 17:00:57.504822	\N	\N	2	ROLE_SYS_ADMIN	1
3	2024-02-08 17:00:57.537493	2024-02-08 17:00:57.537493	\N	\N	3	ROLE_KEY_ADMIN	1
4	2024-02-08 17:00:57.682785	2024-02-08 17:00:57.682785	\N	\N	4	ROLE_SYS_ADMIN	1
5	2024-02-08 17:01:50.222	2024-02-08 17:01:50.222	1	1	5	ROLE_USER	1
6	2024-02-08 17:01:50.247	2024-02-08 17:01:50.247	1	1	6	ROLE_USER	1
7	2024-02-08 17:01:50.35	2024-02-08 17:01:50.35	1	1	7	ROLE_USER	1
8	2024-02-08 17:01:50.59	2024-02-08 17:01:50.59	1	1	8	ROLE_USER	1
9	2024-02-08 17:01:50.846	2024-02-08 17:01:50.846	1	1	9	ROLE_USER	1
10	2024-02-08 17:01:50.958	2024-02-08 17:01:50.959	1	1	10	ROLE_USER	1
11	2024-02-08 17:01:51.037	2024-02-08 17:01:51.037	1	1	11	ROLE_USER	1
12	2024-02-08 17:51:48.081	2024-02-08 17:51:48.081	1	1	12	ROLE_USER	1
\.


--
-- Data for Name: x_ranger_global_state; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_ranger_global_state (id, create_time, update_time, added_by_id, upd_by_id, version, state_name, app_data) FROM stdin;
1	2024-02-08 17:00:58.266344	2024-02-08 17:00:58.266344	1	1	1	RangerRole	{"Version":"1"}
2	2024-02-08 17:00:58.270457	2024-02-08 17:00:58.270457	1	1	1	RangerUserStore	{"Version":"1"}
3	2024-02-08 17:00:58.274633	2024-02-08 17:00:58.274633	1	1	1	RangerSecurityZone	{"Version":"1"}
\.


--
-- Data for Name: x_resource; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_resource (id, create_time, update_time, added_by_id, upd_by_id, res_name, descr, res_type, asset_id, parent_id, parent_path, is_encrypt, is_recursive, res_group, res_dbs, res_tables, res_col_fams, res_cols, res_udfs, res_status, table_type, col_type, policy_name, res_topologies, res_services) FROM stdin;
\.


--
-- Data for Name: x_resource_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_resource_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, type, res_level, parent, mandatory, look_up_supported, recursive_supported, excludes_supported, matcher, matcher_options, validation_reg_ex, validation_message, ui_hint, label, description, rb_key_label, rb_key_description, rb_key_validation_message, sort_order, datamask_options, rowfilter_options) FROM stdin;
1	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.42	\N	\N	1	1	path	path	10	\N	t	t	t	f	org.apache.ranger.plugin.resourcematcher.RangerPathResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Resource Path	HDFS file or directory path	\N	\N	\N	0	\N	\N
2	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.509	\N	\N	2	1	table	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}				HBase Table	HBase Table	\N	\N	\N	0	\N	\N
3	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.511	\N	\N	2	2	column-family	string	20	2	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}				HBase Column-family	HBase Column-family	\N	\N	\N	1	\N	\N
4	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.515	\N	\N	2	3	column	string	30	3	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				HBase Column	HBase Column	\N	\N	\N	2	\N	\N
7	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.562	\N	\N	3	3	udf	string	20	5	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Hive UDF	Hive UDF	\N	\N	\N	2	\N	\N
9	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.565	\N	\N	3	5	url	string	10	\N	t	f	t	f	org.apache.ranger.plugin.resourcematcher.RangerURLResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				URL	URL	\N	\N	\N	4	\N	\N
10	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.567	\N	\N	3	6	hiveservice	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Hive Service	Hive Service	\N	\N	\N	5	\N	\N
11	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.569	\N	\N	3	7	global	string	10	\N	f	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Global	Global	\N	\N	\N	6	\N	\N
5	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.608	\N	\N	3	1	database	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Hive Database	Hive Database	\N	\N	\N	0	{"itemId":1,"name":"database","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Database","description":"Hive Database","isValidLeaf":false}	{"itemId":1,"name":"database","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Database","description":"Hive Database","isValidLeaf":false}
6	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.609	\N	\N	3	2	table	string	20	5	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Hive Table	Hive Table	\N	\N	\N	1	{"itemId":2,"name":"table","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Table","description":"Hive Table","isValidLeaf":false}	{"itemId":2,"name":"table","type":"string","level":20,"parent":"database","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Table","description":"Hive Table","isValidLeaf":true}
8	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.61	\N	\N	3	4	column	string	30	6	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Hive Column	Hive Column	\N	\N	\N	3	{"itemId":4,"name":"column","type":"string","level":30,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Hive Column","description":"Hive Column","isValidLeaf":true}	\N
12	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.651	\N	\N	7	1	keyname	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Key Name	Key Name	\N	\N	\N	0	\N	\N
13	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.682	\N	\N	5	1	topology	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}				Knox Topology	Knox Topology	\N	\N	\N	0	\N	\N
14	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.683	\N	\N	5	2	service	string	20	13	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Knox Service	Knox Service	\N	\N	\N	1	\N	\N
15	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.706	\N	\N	6	1	topology	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Storm Topology	Storm Topology	\N	\N	\N	0	\N	\N
16	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.745	\N	\N	4	1	queue	string	10	\N	t	t	t	f	org.apache.ranger.plugin.resourcematcher.RangerPathResourceMatcher	{"wildCard":"true","ignoreCase":"false","pathSeparatorChar":".","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Queue	Queue	\N	\N	\N	0	\N	\N
17	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.764	\N	\N	9	1	topic	string	1	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"create\\",\\"delete\\",\\"configure\\",\\"alter\\",\\"alter_configs\\",\\"describe\\",\\"describe_configs\\",\\"consume\\",\\"publish\\"]","__isValidLeaf":"true"}				Topic	Topic	\N	\N	\N	0	\N	\N
18	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.765	\N	\N	9	2	transactionalid	string	1	\N	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"publish\\",\\"describe\\"]","__isValidLeaf":"true"}	\N	\N	\N	Transactional Id	Transactional Id	\N	\N	\N	1	\N	\N
19	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.765	\N	\N	9	3	cluster	string	1	\N	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"create\\",\\"configure\\",\\"alter\\",\\"alter_configs\\",\\"describe\\",\\"describe_configs\\",\\"kafka_admin\\",\\"idempotent_write\\",\\"cluster_action\\"]","__isValidLeaf":"true"}	\N	\N	\N	Cluster	Cluster	\N	\N	\N	2	\N	\N
20	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.766	\N	\N	9	4	delegationtoken	string	1	\N	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"describe\\"]","__isValidLeaf":"true"}	\N	\N	\N	Delegation Token	Delegation Token	\N	\N	\N	3	\N	\N
21	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.766	\N	\N	9	5	consumergroup	string	1	\N	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"consume\\",\\"describe\\",\\"delete\\"]","__isValidLeaf":"true"}	\N	\N	\N	Consumer Group	Consumer Group	\N	\N	\N	4	\N	\N
22	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.798	\N	\N	8	100	collection	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Solr Collection	Solr Collection	\N	\N	\N	0	\N	\N
23	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.799	\N	\N	8	101	config	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Solr Config	Solr Config	\N	\N	\N	1	\N	\N
24	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.8	\N	\N	8	102	schema	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Schema of a collection	The schema of a collection	\N	\N	\N	2	\N	\N
25	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.8	\N	\N	8	103	admin	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Solr Admin	Solr Admin	\N	\N	\N	3	\N	\N
26	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.817	\N	\N	202	1	registry-service	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}	^\\*$			Schema Registry Service	Schema Registry Service	\N	\N	\N	0	\N	\N
27	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.818	\N	\N	202	2	schema-group	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}				Schema Group	Schema Group	\N	\N	\N	1	\N	\N
28	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.819	\N	\N	202	3	schema-metadata	string	20	27	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Schema Name	Schema Name	\N	\N	\N	2	\N	\N
29	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.82	\N	\N	202	4	schema-branch	string	30	28	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Schema Branch	Schema Branch	\N	\N	\N	3	\N	\N
30	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.821	\N	\N	202	5	schema-version	string	40	29	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}	^\\*$			Schema Version	Schema Version	\N	\N	\N	4	\N	\N
31	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.822	\N	\N	202	6	serde	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}	^\\*$			Serializer/Deserializer	Serializer/Deserializer	\N	\N	\N	5	\N	\N
32	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.854	\N	\N	10	100	nifi-resource	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				NiFi Resource Identifier	NiFi Resource	\N	\N	\N	0	\N	\N
33	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.879	\N	\N	13	100	nifi-registry-resource	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				NiFi Registry Resource Identifier	NiFi Registry Resource	\N	\N	\N	0	\N	\N
34	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.904	\N	\N	15	1	type-category	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	Type Catagory	Type Catagory	\N	\N	\N	0	\N	\N
35	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.906	\N	\N	15	2	type	string	20	34	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[\\"type-read\\",\\"type-create\\",\\"type-update\\",\\"type-delete\\"]","__isValidLeaf":"true"}	\N	\N	\N	Type Name	Type Name	\N	\N	\N	1	\N	\N
36	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.907	\N	\N	15	3	entity-type	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	Entity Type	Entity Type	\N	\N	\N	2	\N	\N
37	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.908	\N	\N	15	4	entity-classification	string	20	36	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	Entity Classification	Entity Classification	\N	\N	\N	3	\N	\N
38	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.909	\N	\N	15	5	entity	string	30	37	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"entity-read\\",\\"entity-create\\",\\"entity-update\\",\\"entity-delete\\"]","__isValidLeaf":"true"}	\N	\N	\N	Entity ID	Entity ID	\N	\N	\N	4	\N	\N
39	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.91	\N	\N	15	6	atlas-service	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"admin-import\\",\\"admin-export\\",\\"admin-purge\\",\\"admin-audits\\"]","__isValidLeaf":"true"}	\N	\N	\N	Atlas Service	Atlas Service	\N	\N	\N	5	\N	\N
40	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.911	\N	\N	15	7	relationship-type	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	Relationship Type	Relationship Type	\N	\N	\N	6	\N	\N
41	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.912	\N	\N	15	8	end-one-entity-type	string	20	40	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	End1 Entity Type	End1 Entity Type	\N	\N	\N	7	\N	\N
42	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.913	\N	\N	15	9	end-one-entity-classification	string	30	41	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	End1 Entity Classification	End1 Entity Classification	\N	\N	\N	8	\N	\N
43	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.913	\N	\N	15	10	end-one-entity	string	40	42	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	End1 Entity ID	End1 Entity ID	\N	\N	\N	9	\N	\N
44	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.914	\N	\N	15	11	end-two-entity-type	string	50	43	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	End2 Entity Type	End2 Entity Type	\N	\N	\N	10	\N	\N
45	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.915	\N	\N	15	12	end-two-entity-classification	string	60	44	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"false"}	\N	\N	\N	End2 Entity Classification	End2 Entity Classification	\N	\N	\N	11	\N	\N
46	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.916	\N	\N	15	13	end-two-entity	string	70	45	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"add-relationship\\",\\"update-relationship\\",\\"remove-relationship\\"]","__isValidLeaf":"true"}	\N	\N	\N	End2 Entity ID	End2 Entity ID	\N	\N	\N	12	\N	\N
47	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.917	\N	\N	15	14	entity-label	string	40	38	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"entity-add-label\\",\\"entity-remove-label\\"]","__isValidLeaf":"true"}	\N	\N	\N	Label	Label	\N	\N	\N	13	\N	\N
48	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.918	\N	\N	15	15	entity-business-metadata	string	40	38	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"entity-update-business-metadata\\"]","__isValidLeaf":"true"}	\N	\N	\N	Business Metadata	Business Metadata	\N	\N	\N	14	\N	\N
49	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.919	\N	\N	15	16	classification	string	40	38	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[\\"entity-add-classification\\",\\"entity-update-classification\\",\\"entity-remove-classification\\"]","__isValidLeaf":"true"}	\N	\N	\N	Targetted classifications	Targetted classifications	\N	\N	\N	15	\N	\N
51	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.966	\N	\N	14	1	connector	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Connector	Sqoop Connector	\N	\N	\N	0	\N	\N
52	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.967	\N	\N	14	2	link	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Link	Sqoop Link	\N	\N	\N	1	\N	\N
53	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.968	\N	\N	14	3	job	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Job	Sqoop Job	\N	\N	\N	2	\N	\N
54	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.027	\N	\N	12	1	project	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Kylin Project	Kylin Project	\N	\N	\N	0	\N	\N
55	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.063	\N	\N	16	1	index	string	10	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Index	Elasticsearch Index	\N	\N	\N	0	\N	\N
60	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.144	\N	\N	203	5	trinouser	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"impersonate\\"]","__isValidLeaf":"true"}				Trino User	Trino User	\N	\N	\N	4	\N	\N
61	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.145	\N	\N	203	6	systemproperty	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"alter\\"]","__isValidLeaf":"true"}				System Property	Trino System Property	\N	\N	\N	5	\N	\N
62	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.145	\N	\N	203	7	sessionproperty	string	20	56	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"alter\\"]","__isValidLeaf":"true"}				Catalog Session Property	Trino Catalog Session Property	\N	\N	\N	6	\N	\N
63	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.146	\N	\N	203	8	function	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"execute\\",\\"grant\\"]","__isValidLeaf":"true"}				Trino Function	Trino Function	\N	\N	\N	7	\N	\N
64	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.147	\N	\N	203	9	procedure	string	30	57	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"execute\\",\\"grant\\"]","__isValidLeaf":"true"}				Schema Procedure	Schema Procedure	\N	\N	\N	8	\N	\N
56	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.166	\N	\N	203	1	catalog	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Trino Catalog	Trino Catalog	\N	\N	\N	0	{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Catalog","description":"Trino Catalog","isValidLeaf":false}	{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Catalog","description":"Trino Catalog","isValidLeaf":false}
57	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.166	\N	\N	203	2	schema	string	20	56	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Trino Schema	Trino Schema	\N	\N	\N	1	{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Schema","description":"Trino Schema","isValidLeaf":false}	{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Schema","description":"Trino Schema","isValidLeaf":false}
58	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.167	\N	\N	203	3	table	string	30	57	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Trino Table	Trino Table	\N	\N	\N	2	{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Table","description":"Trino Table","isValidLeaf":false}	{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Table","description":"Trino Table","isValidLeaf":true}
59	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.167	\N	\N	203	4	column	string	40	58	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Trino Column	Trino Column	\N	\N	\N	3	{"itemId":4,"name":"column","type":"string","level":40,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Trino Column","description":"Trino Column","isValidLeaf":true}	\N
69	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.259	\N	\N	17	5	prestouser	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"impersonate\\"]","__isValidLeaf":"true"}				Presto User	Presto User	\N	\N	\N	4	\N	\N
70	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.26	\N	\N	17	6	systemproperty	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"alter\\"]","__isValidLeaf":"true"}				System Property	Presto System Property	\N	\N	\N	5	\N	\N
71	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.261	\N	\N	17	7	sessionproperty	string	20	65	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"alter\\"]","__isValidLeaf":"true"}				Catalog Session Property	Presto Catalog Session Property	\N	\N	\N	6	\N	\N
72	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.262	\N	\N	17	8	function	string	10	\N	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"execute\\",\\"grant\\"]","__isValidLeaf":"true"}				Presto Function	Presto Function	\N	\N	\N	7	\N	\N
73	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.263	\N	\N	17	9	procedure	string	30	66	t	f	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[\\"execute\\",\\"grant\\"]","__isValidLeaf":"true"}				Schema Procedure	Schema Procedure	\N	\N	\N	8	\N	\N
65	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.282	\N	\N	17	1	catalog	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Presto Catalog	Presto Catalog	\N	\N	\N	0	{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Catalog","description":"Presto Catalog","isValidLeaf":false}	{"itemId":1,"name":"catalog","type":"string","level":10,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Catalog","description":"Presto Catalog","isValidLeaf":false}
66	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.283	\N	\N	17	2	schema	string	20	65	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Presto Schema	Presto Schema	\N	\N	\N	1	{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Schema","description":"Presto Schema","isValidLeaf":false}	{"itemId":2,"name":"schema","type":"string","level":20,"parent":"catalog","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Schema","description":"Presto Schema","isValidLeaf":false}
67	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.283	\N	\N	17	3	table	string	30	66	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Presto Table	Presto Table	\N	\N	\N	2	{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Table","description":"Presto Table","isValidLeaf":false}	{"itemId":3,"name":"table","type":"string","level":30,"parent":"schema","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Table","description":"Presto Table","isValidLeaf":true}
68	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.284	\N	\N	17	4	column	string	40	67	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Presto Column	Presto Column	\N	\N	\N	3	{"itemId":4,"name":"column","type":"string","level":40,"parent":"table","mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"true","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"Presto Column","description":"Presto Column","isValidLeaf":true}	\N
74	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.394	\N	\N	201	1	volume	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"false","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Ozone Volume	Ozone Volume	\N	\N	\N	0	\N	\N
75	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.395	\N	\N	201	2	bucket	string	20	74	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Ozone Bucket	Ozone Bucket	\N	\N	\N	1	\N	\N
76	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.396	\N	\N	201	3	key	string	30	75	t	t	t	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Ozone Key	Ozone Key	\N	\N	\N	2	\N	\N
77	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.524	\N	\N	105	1	database	string	10	\N	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Database	Database	\N	\N	\N	0	\N	\N
78	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.526	\N	\N	105	2	table	string	20	77	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Table	Table	\N	\N	\N	1	\N	\N
79	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.527	\N	\N	105	3	column	string	30	78	t	t	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}				Column	Column	\N	\N	\N	2	\N	\N
80	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.7	\N	\N	205	1	schema	string	10	\N	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}	\N	\N	\N	NestedStructure Schema	Schema of the nested structure returned from Microservice GET, etc	\N	\N	\N	0	{"itemId":1,"name":"schema","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"NestedStructure Schema","description":"NestedStructure Schema returned from Microservice GET, etc","isValidLeaf":false}	{"itemId":1,"name":"schema","type":"string","level":10,"mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"NestedStructure Schema","description":"NestedStructure Schema returned from Microservice GET, etc","isValidLeaf":true}
81	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.701	\N	\N	205	2	field	string	20	80	t	f	f	t	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"wildCard":"true","ignoreCase":"true","__accessTypeRestrictions":"[]","__isValidLeaf":"true"}	\N	\N	\N	NestedStructure Schema Field	NestedStructure Schema Field	\N	\N	\N	1	{"itemId":2,"name":"field","type":"string","level":20,"parent":"schema","mandatory":true,"lookupSupported":false,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"wildCard":"false","ignoreCase":"true"},"uiHint":"{ \\"singleValue\\":true }","label":"NestedStructure Schema Field","description":"NestedStructure Schema Field","isValidLeaf":true}	\N
50	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.377	\N	\N	100	1	tag	string	1	\N	t	t	f	f	org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher	{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"}			{ "singleValue":true }	TAG	TAG	\N	\N	\N	0	{"itemId":1,"name":"tag","type":"string","level":1,"mandatory":true,"lookupSupported":true,"recursiveSupported":false,"excludesSupported":false,"matcher":"org.apache.ranger.plugin.resourcematcher.RangerDefaultResourceMatcher","matcherOptions":{"__isValidLeaf":"true","wildCard":"false","__accessTypeRestrictions":"[]","ignoreCase":"false"},"uiHint":"{ \\"singleValue\\":true }","label":"TAG","description":"TAG","isValidLeaf":true}	\N
\.


--
-- Data for Name: x_rms_mapping_provider; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_rms_mapping_provider (id, change_timestamp, name, last_known_version) FROM stdin;
\.


--
-- Data for Name: x_rms_notification; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_rms_notification (id, hms_name, notification_id, change_timestamp, change_type, hl_resource_id, hl_service_id, ll_resource_id, ll_service_id) FROM stdin;
\.


--
-- Data for Name: x_rms_resource_mapping; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_rms_resource_mapping (id, change_timestamp, hl_resource_id, ll_resource_id) FROM stdin;
\.


--
-- Data for Name: x_rms_service_resource; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_rms_service_resource (id, guid, create_time, update_time, added_by_id, upd_by_id, version, service_id, resource_signature, is_enabled, service_resource_elements_text) FROM stdin;
\.


--
-- Data for Name: x_role; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_role (id, create_time, update_time, added_by_id, upd_by_id, version, name, description, role_options, role_text) FROM stdin;
\.


--
-- Data for Name: x_role_ref_group; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_role_ref_group (id, create_time, update_time, added_by_id, upd_by_id, role_id, group_id, group_name, priv_type) FROM stdin;
\.


--
-- Data for Name: x_role_ref_role; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_role_ref_role (id, create_time, update_time, added_by_id, upd_by_id, role_ref_id, role_id, role_name, priv_type) FROM stdin;
\.


--
-- Data for Name: x_role_ref_user; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_role_ref_user (id, create_time, update_time, added_by_id, upd_by_id, role_id, user_id, user_name, priv_type) FROM stdin;
\.


--
-- Data for Name: x_security_zone; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone (id, create_time, update_time, added_by_id, upd_by_id, version, name, jsondata, description) FROM stdin;
1	2024-02-08 17:00:57.71023	2024-02-08 17:00:57.71023	1	1	1	 		Unzoned zone
\.


--
-- Data for Name: x_security_zone_ref_group; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone_ref_group (id, create_time, update_time, added_by_id, upd_by_id, zone_id, group_id, group_name, group_type) FROM stdin;
\.


--
-- Data for Name: x_security_zone_ref_resource; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone_ref_resource (id, create_time, update_time, added_by_id, upd_by_id, zone_id, resource_def_id, resource_name) FROM stdin;
\.


--
-- Data for Name: x_security_zone_ref_role; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone_ref_role (id, create_time, update_time, added_by_id, upd_by_id, zone_id, role_id, role_name) FROM stdin;
\.


--
-- Data for Name: x_security_zone_ref_service; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone_ref_service (id, create_time, update_time, added_by_id, upd_by_id, zone_id, service_id, service_name) FROM stdin;
\.


--
-- Data for Name: x_security_zone_ref_tag_srvc; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone_ref_tag_srvc (id, create_time, update_time, added_by_id, upd_by_id, zone_id, tag_srvc_id, tag_srvc_name) FROM stdin;
\.


--
-- Data for Name: x_security_zone_ref_user; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_security_zone_ref_user (id, create_time, update_time, added_by_id, upd_by_id, zone_id, user_id, user_name, user_type) FROM stdin;
\.


--
-- Data for Name: x_service; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_service (id, guid, create_time, update_time, added_by_id, upd_by_id, version, type, name, display_name, policy_version, policy_update_time, description, is_enabled, tag_service, tag_version, tag_update_time) FROM stdin;
2	a0031e86-6c37-4266-b3f3-447b09d9b62c	2024-02-08 17:01:50.081	2024-02-08 17:01:50.082	1	1	1	100	dev_tag	dev_tag	\N	\N	\N	t	\N	1	\N
1	46f7102b-79d1-4738-b93e-be6b310eaffa	2024-02-08 17:01:49.882	2024-02-08 17:01:50.186	1	1	2	1	dev_hdfs	dev_hdfs	\N	\N	\N	t	2	1	\N
3	dc70f778-f7d8-4eff-b464-ad563b68e9f8	2024-02-08 17:01:50.297	2024-02-08 17:01:50.297	1	1	1	4	dev_yarn	dev_yarn	\N	\N	\N	t	2	1	\N
4	bc062d2e-24db-49fd-aa25-e38689dd3fec	2024-02-08 17:01:50.389	2024-02-08 17:01:50.389	1	1	1	3	dev_hive	dev_hive	\N	\N	\N	t	2	1	\N
5	fe214fdb-157c-471b-a72b-190ca71fc0c5	2024-02-08 17:01:50.675	2024-02-08 17:01:50.676	1	1	1	2	dev_hbase	dev_hbase	\N	\N	\N	t	2	1	\N
6	3c17f4a8-fb2b-49f8-a241-fe9c4dc5125f	2024-02-08 17:01:50.742	2024-02-08 17:01:50.743	1	1	1	9	dev_kafka	dev_kafka	\N	\N	\N	t	2	1	\N
7	a928daf7-cafc-42b6-bd8a-a8e2f574ce43	2024-02-08 17:01:50.919	2024-02-08 17:01:50.92	1	1	1	5	dev_knox	dev_knox	\N	\N	\N	t	2	1	\N
8	162e0e57-ebaf-430f-8115-38f213e41d93	2024-02-08 17:01:50.986	2024-02-08 17:01:50.986	1	1	1	7	dev_kms	dev_kms	\N	\N	\N	t	\N	1	\N
9	1be81a8c-5131-4b35-ace9-f1270b8a590d	2024-02-08 17:51:47.898	2024-02-08 17:51:47.899	1	1	1	1	hadoopdev	hadoopdev	\N	\N		t	\N	1	\N
\.


--
-- Data for Name: x_service_config_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_service_config_def (id, guid, create_time, update_time, added_by_id, upd_by_id, def_id, item_id, name, type, sub_type, is_mandatory, default_value, validation_reg_ex, validation_message, ui_hint, label, description, rb_key_label, rb_key_description, rb_key_validation_message, sort_order) FROM stdin;
1	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.387	\N	\N	1	1	username	string		t	\N				Username	\N	\N	\N	\N	0
2	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.402	\N	\N	1	2	password	password		t	\N				Password	\N	\N	\N	\N	1
3	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.403	\N	\N	1	3	fs.default.name	string		t	\N			{"TextFieldWithIcon":true, "info": "1.For one Namenode Url, eg.<br>hdfs://&lt;host&gt;:&lt;port&gt;<br>2.For HA Namenode Urls(use , delimiter), eg.<br>hdfs://&lt;host&gt;:&lt;port&gt;,hdfs://&lt;host2&gt;:&lt;port2&gt;<br>"}	Namenode URL	\N	\N	\N	\N	2
4	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.404	\N	\N	1	4	hadoop.security.authorization	bool	YesTrue:NoFalse	t	false				Authorization Enabled	\N	\N	\N	\N	3
5	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.405	\N	\N	1	5	hadoop.security.authentication	enum	authnType	t	simple				Authentication Type	\N	\N	\N	\N	4
6	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.407	\N	\N	1	6	hadoop.security.auth_to_local	string		f	\N				\N	\N	\N	\N	\N	5
7	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.407	\N	\N	1	7	dfs.datanode.kerberos.principal	string		f	\N				\N	\N	\N	\N	\N	6
8	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.409	\N	\N	1	8	dfs.namenode.kerberos.principal	string		f	\N				\N	\N	\N	\N	\N	7
9	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.41	\N	\N	1	9	dfs.secondary.namenode.kerberos.principal	string		f	\N				\N	\N	\N	\N	\N	8
10	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.41	\N	\N	1	10	hadoop.rpc.protection	enum	rpcProtection	f	authentication				RPC Protection Type	\N	\N	\N	\N	9
11	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.411	\N	\N	1	11	commonNameForCertificate	string		f	\N				Common Name for Certificate	\N	\N	\N	\N	10
12	\N	2024-02-08 17:01:08.205	2024-02-08 17:01:08.412	\N	\N	1	12	ranger.plugin.audit.filters	string		f	[{'accessResult': 'DENIED', 'isAudited': true}, {'actions':['delete','rename'],'isAudited':true}, {'users':['hdfs'], 'actions': ['listStatus', 'getfileinfo', 'listCachePools', 'listCacheDirectives', 'listCorruptFileBlocks', 'monitorHealth', 'rollEditLog', 'open'], 'isAudited': false}, {'users': ['oozie'],'resources': {'path': {'values': ['/user/oozie/share/lib'],'isRecursive': true}},'isAudited': false},{'users': ['spark'],'resources': {'path': {'values': ['/user/spark/applicationHistory'],'isRecursive': true}},'isAudited': false},{'users': ['hue'],'resources': {'path': {'values': ['/user/hue'],'isRecursive': true}},'isAudited': false},{'users': ['hbase'],'resources': {'path': {'values': ['/hbase'],'isRecursive': true}},'isAudited': false},{'users': ['mapred'],'resources': {'path': {'values': ['/user/history'],'isRecursive': true}},'isAudited': false}, {'actions': ['getfileinfo'], 'isAudited':false} ]				Ranger Default Audit Filters	\N	\N	\N	\N	11
13	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.5	\N	\N	2	1	username	string		t	\N				Username	\N	\N	\N	\N	0
14	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.5	\N	\N	2	2	password	password		t	\N				Password	\N	\N	\N	\N	1
15	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.501	\N	\N	2	3	hadoop.security.authentication	enum	authnType	t	simple				\N	\N	\N	\N	\N	2
16	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.502	\N	\N	2	4	hbase.master.kerberos.principal	string		f		\N	\N	\N	\N	\N	\N	\N	\N	3
17	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.503	\N	\N	2	5	hbase.security.authentication	enum	authnType	t	simple				\N	\N	\N	\N	\N	4
18	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.504	\N	\N	2	6	hbase.zookeeper.property.clientPort	int		t	2181				\N	\N	\N	\N	\N	5
19	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.504	\N	\N	2	7	hbase.zookeeper.quorum	string		t				\N	\N	\N	\N	\N	\N	6
20	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.505	\N	\N	2	8	zookeeper.znode.parent	string		t	/hbase				\N	\N	\N	\N	\N	7
21	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.506	\N	\N	2	9	commonNameForCertificate	string		f	\N				Common Name for Certificate	\N	\N	\N	\N	8
22	\N	2024-02-08 17:01:08.494	2024-02-08 17:01:08.507	\N	\N	2	10	ranger.plugin.audit.filters	string		f	[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'table':{'values':['*-ROOT-*','*.META.*', '*_acl_*', 'hbase:meta', 'hbase:acl', 'default', 'hbase']}}, 'users':['hbase'], 'isAudited': false }, {'resources':{'table':{'values':['atlas_janus','ATLAS_ENTITY_AUDIT_EVENTS']},'column-family':{'values':['*']},'column':{'values':['*']}},'users':['atlas', 'hbase'],'isAudited':false},{'users':['hbase'], 'actions':['balance'],'isAudited':false}]				Ranger Default Audit Filters	\N	\N	\N	\N	9
23	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.554	\N	\N	3	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
24	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.555	\N	\N	3	2	password	password	\N	t	\N				Password	\N	\N	\N	\N	1
25	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.555	\N	\N	3	3	jdbc.driverClassName	string	\N	t	org.apache.hive.jdbc.HiveDriver				\N	\N	\N	\N	\N	2
26	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.556	\N	\N	3	4	jdbc.url	string	\N	t				{"TextFieldWithIcon":true, "info": "1.For Remote Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;<br>2.For Embedded Mode (no host or port), eg.<br>jdbc:hive2:///;initFile=&lt;file&gt;<br>3.For HTTP Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;/;<br>transportMode=http;httpPath=&lt;httpPath&gt;<br>4.For SSL Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;/;ssl=true;<br>sslTrustStore=tStore;trustStorePassword=pw<br>5.For ZooKeeper Mode, eg.<br>jdbc:hive2://&lt;host&gt;/;serviceDiscoveryMode=<br>zooKeeper;zooKeeperNamespace=hiveserver2<br>6.For Kerberos Mode, eg.<br>jdbc:hive2://&lt;host&gt;:&lt;port&gt;/;<br>principal=hive/domain@EXAMPLE.COM<br>"}	\N	\N	\N	\N	\N	3
27	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.557	\N	\N	3	5	commonNameForCertificate	string	\N	f	\N				Common Name for Certificate	\N	\N	\N	\N	4
28	\N	2024-02-08 17:01:08.548	2024-02-08 17:01:08.558	\N	\N	3	6	ranger.plugin.audit.filters	string		f	[ {'accessResult': 'DENIED', 'isAudited': true}, {'actions':['METADATA OPERATION'], 'isAudited': false}, {'users':['hive','hue'],'actions':['SHOW_ROLES'],'isAudited':false} ]				Ranger Default Audit Filters	\N	\N	\N	\N	5
29	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.649	\N	\N	7	1	provider	string	\N	t	\N	\N	\N	\N	KMS URL	\N	\N	\N	\N	0
30	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.649	\N	\N	7	2	username	string	\N	t	\N	\N	\N	\N	Username	\N	\N	\N	\N	1
31	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.65	\N	\N	7	3	password	password	\N	t	\N	\N	\N	\N	Password	\N	\N	\N	\N	2
32	\N	2024-02-08 17:01:08.644	2024-02-08 17:01:08.65	\N	\N	7	4	ranger.plugin.audit.filters	string	\N	f	[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['keyadmin'] ,'isAudited':false} ]				Ranger Default Audit Filters	\N	\N	\N	\N	3
33	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.678	\N	\N	5	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
34	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.678	\N	\N	5	2	password	password	\N	t	\N				Password	\N	\N	\N	\N	1
35	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.679	\N	\N	5	3	knox.url	string	\N	t					\N	\N	\N	\N	\N	2
36	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.68	\N	\N	5	4	commonNameForCertificate	string	\N	f	\N				Common Name for Certificate	\N	\N	\N	\N	3
37	\N	2024-02-08 17:01:08.673	2024-02-08 17:01:08.68	\N	\N	5	5	ranger.plugin.audit.filters	string		f	[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['knox'] ,'isAudited':false} ]				Ranger Default Audit Filters	\N	\N	\N	\N	4
38	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.704	\N	\N	6	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
39	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.704	\N	\N	6	2	password	password	\N	t	\N				Password	\N	\N	\N	\N	1
40	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.705	\N	\N	6	3	nimbus.url	string	\N	t					Nimbus URL	\N	\N	\N	\N	2
41	\N	2024-02-08 17:01:08.699	2024-02-08 17:01:08.705	\N	\N	6	4	commonNameForCertificate	string	\N	f	\N				Common Name for Certificate	\N	\N	\N	\N	3
42	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.742	\N	\N	4	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
43	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.743	\N	\N	4	2	password	password	\N	t	\N				Password	\N	\N	\N	\N	1
44	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.743	\N	\N	4	3	yarn.url	string	\N	t				{"TextFieldWithIcon":true, "info": "1.For one url, eg.<br>'http or https://&lt;ipaddr&gt;:8088'<br>2.For multiple urls (use , or ; delimiter), eg.<br>'http://&lt;ipaddr1&gt;:8088,http://&lt;ipaddr2&gt;:8088'"}	YARN REST URL	\N	\N	\N	\N	2
45	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.744	\N	\N	4	4	hadoop.security.authentication	enum	authnType	f	simple				Authentication Type	\N	\N	\N	\N	3
46	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.744	\N	\N	4	5	commonNameForCertificate	string	\N	f	\N				Common Name for Certificate	\N	\N	\N	\N	4
47	\N	2024-02-08 17:01:08.738	2024-02-08 17:01:08.745	\N	\N	4	6	ranger.plugin.audit.filters	string		f	[]				Ranger Default Audit Filters	\N	\N	\N	\N	5
48	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.762	\N	\N	9	1	username	string	\N	t	\N	\N	\N	\N	Username	\N	\N	\N	\N	0
49	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.762	\N	\N	9	2	password	password	\N	t	\N	\N	\N	\N	Password	\N	\N	\N	\N	1
50	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.763	\N	\N	9	3	zookeeper.connect	string	\N	t	localhost:2181	\N	\N	\N	Zookeeper Connect String	\N	\N	\N	\N	2
51	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.763	\N	\N	9	4	commonNameForCertificate	string	\N	f	\N	\N	\N	\N	Ranger Plugin SSL CName	\N	\N	\N	\N	3
52	\N	2024-02-08 17:01:08.758	2024-02-08 17:01:08.763	\N	\N	9	5	ranger.plugin.audit.filters	string		f	[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'topic':{'values':['ATLAS_ENTITIES','ATLAS_HOOK','ATLAS_SPARK_HOOK']}},'users':['atlas'],'actions':['describe','publish','consume'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_HOOK']}},'users':['hive','hbase','impala','nifi'],'actions':['publish','describe'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_ENTITIES']}},'users':['rangertagsync'],'actions':['consume','describe'],'isAudited':false},{'resources':{'consumergroup':{'values':['*']}},'users':['atlas','rangertagsync'],'actions':['consume'],'isAudited':false},{'users':['kafka'],'isAudited':false}]				Ranger Default Audit Filters	\N	\N	\N	\N	4
53	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.795	\N	\N	8	100	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
54	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.796	\N	\N	8	200	password	password	\N	t	\N				Password	\N	\N	\N	\N	1
55	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.796	\N	\N	8	300	solr.zookeeper.quorum	string	\N	f					Solr Zookeeper Quorum	\N	\N	\N	\N	2
56	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.797	\N	\N	8	400	solr.url	string	\N	t					Solr URL	\N	\N	\N	\N	3
57	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.797	\N	\N	8	500	commonNameForCertificate	string	\N	f	\N				Ranger Plugin SSL CName	\N	\N	\N	\N	4
58	\N	2024-02-08 17:01:08.792	2024-02-08 17:01:08.797	\N	\N	8	600	ranger.plugin.audit.filters	string		f	[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['hive','hdfs','kafka','hbase','solr','rangerraz','knox','atlas','yarn','impala'] ,'isAudited':false} ]				Ranger Default Audit Filters	\N	\N	\N	\N	5
59	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.815	\N	\N	202	1	schema.registry.url	string	\N	t					Schema Registry URL	\N	\N	\N	\N	0
60	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.815	\N	\N	202	2	schema-registry.authentication	enum	authType	t	KERBEROS				Authentication Type	\N	\N	\N	\N	1
61	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.816	\N	\N	202	3	commonNameForCertificate	string	\N	f	\N				Ranger Plugin SSL CName	\N	\N	\N	\N	2
62	\N	2024-02-08 17:01:08.812	2024-02-08 17:01:08.816	\N	\N	202	4	ranger.plugin.audit.filters	string		f	[]				Ranger Default Audit Filters	\N	\N	\N	\N	3
63	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.845	\N	\N	10	400	nifi.url	string	\N	t	http://localhost:8080/nifi-api/resources			{"TextFieldWithIcon":true, "info": "The URL of the NiFi REST API that provides the available resources."}	NiFi URL	\N	\N	\N	\N	0
64	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.846	\N	\N	10	410	nifi.authentication	enum	authType	t	NONE				Authentication Type	\N	\N	\N	\N	1
65	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.848	\N	\N	10	411	nifi.ssl.use.default.context	bool	YesTrue:NoFalse	t	false			{"TextFieldWithIcon":true, "info": "If true, then Ranger's keystore and truststore will be used to communicate with NiFi. If false, the keystore and truststore properties must be provided."}	Use Ranger's Default SSL Context	\N	\N	\N	\N	2
66	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.849	\N	\N	10	500	nifi.ssl.keystore	string	\N	f					Keystore	\N	\N	\N	\N	3
67	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.849	\N	\N	10	510	nifi.ssl.keystoreType	string	\N	f					Keystore Type	\N	\N	\N	\N	4
68	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.85	\N	\N	10	520	nifi.ssl.keystorePassword	password	\N	f					Keystore Password	\N	\N	\N	\N	5
69	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.85	\N	\N	10	530	nifi.ssl.truststore	string	\N	f					Truststore	\N	\N	\N	\N	6
70	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.851	\N	\N	10	540	nifi.ssl.truststoreType	string	\N	f					Truststore Type	\N	\N	\N	\N	7
71	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.852	\N	\N	10	550	nifi.ssl.truststorePassword	password	\N	f					Truststore Password	\N	\N	\N	\N	8
72	\N	2024-02-08 17:01:08.84	2024-02-08 17:01:08.852	\N	\N	10	560	ranger.plugin.audit.filters	string		f	[]				Ranger Default Audit Filters	\N	\N	\N	\N	9
73	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.873	\N	\N	13	400	nifi.registry.url	string	\N	t	http://localhost:18080/nifi-registry-api/policies/resources			{"TextFieldWithIcon":true, "info": "The URL of the NiFi Registry REST API that provides the available resources."}	NiFi Registry URL	\N	\N	\N	\N	0
74	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.873	\N	\N	13	410	nifi.registry.authentication	enum	authType	t	NONE				Authentication Type	\N	\N	\N	\N	1
75	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.874	\N	\N	13	411	nifi.registry.ssl.use.default.context	bool	YesTrue:NoFalse	t	false			{"TextFieldWithIcon":true, "info": "If true, then Ranger's keystore and truststore will be used to communicate with NiFi Registry. If false, the keystore and truststore properties must be provided."}	Use Ranger's Default SSL Context	\N	\N	\N	\N	2
76	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.874	\N	\N	13	500	nifi.registry.ssl.keystore	string	\N	f					Keystore	\N	\N	\N	\N	3
77	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.875	\N	\N	13	510	nifi.registry.ssl.keystoreType	string	\N	f					Keystore Type	\N	\N	\N	\N	4
78	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.875	\N	\N	13	520	nifi.registry.ssl.keystorePassword	password	\N	f					Keystore Password	\N	\N	\N	\N	5
79	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.876	\N	\N	13	530	nifi.registry.ssl.truststore	string	\N	f					Truststore	\N	\N	\N	\N	6
80	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.876	\N	\N	13	540	nifi.registry.ssl.truststoreType	string	\N	f					Truststore Type	\N	\N	\N	\N	7
81	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.877	\N	\N	13	550	nifi.registry.ssl.truststorePassword	password	\N	f					Truststore Password	\N	\N	\N	\N	8
82	\N	2024-02-08 17:01:08.869	2024-02-08 17:01:08.878	\N	\N	13	560	ranger.plugin.audit.filters	string		f	[]				Ranger Default Audit Filters	\N	\N	\N	\N	9
83	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.9	\N	\N	15	1	username	string	\N	t	\N	\N	\N	\N	Username	\N	\N	\N	\N	0
84	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.901	\N	\N	15	2	password	password	\N	t	\N	\N	\N	\N	Password	\N	\N	\N	\N	1
85	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.901	\N	\N	15	3	atlas.rest.address	string	\N	t	http://localhost:21000	\N	\N	\N	\N	\N	\N	\N	\N	2
86	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.902	\N	\N	15	4	commonNameForCertificate	string	\N	f	\N	\N	\N	\N	Common Name for Certificate	\N	\N	\N	\N	3
87	\N	2024-02-08 17:01:08.894	2024-02-08 17:01:08.903	\N	\N	15	5	ranger.plugin.audit.filters	string		f	[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['atlas'] ,'isAudited':false}, {'accessResult':'ALLOWED', 'isAudited':false, 'actions':['entity-read'], 'accessTypes':['entity-read'], 'users':['nifi']} ]				Ranger Default Audit Filters	\N	\N	\N	\N	4
89	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.964	\N	\N	14	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
90	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.965	\N	\N	14	2	sqoop.url	string	\N	t				{"TextFieldWithIcon":true, "info": "eg. 'http://&lt;ipaddr&gt;:12000'"}	Sqoop URL	\N	\N	\N	\N	1
91	\N	2024-02-08 17:01:08.961	2024-02-08 17:01:08.965	\N	\N	14	3	commonNameForCertificate	string	\N	f	\N				Common Name for Certificate	\N	\N	\N	\N	2
92	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.023	\N	\N	12	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
93	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.024	\N	\N	12	2	password	password	\N	t	\N				Password	\N	\N	\N	\N	1
94	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.024	\N	\N	12	3	kylin.url	string	\N	t				{"TextFieldWithIcon":true, "info": "1.For one url, eg.<br>'http://&lt;ipaddr&gt;:7070'<br>2.For multiple urls (use , or ; delimiter), eg.<br>'http://&lt;ipaddr1&gt;:7070,http://&lt;ipaddr2&gt;:7070'"}	Kylin URL	\N	\N	\N	\N	2
95	\N	2024-02-08 17:01:09.019	2024-02-08 17:01:09.025	\N	\N	12	4	commonNameForCertificate	string	\N	f	\N				Common Name for Certificate	\N	\N	\N	\N	3
96	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.062	\N	\N	16	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
97	\N	2024-02-08 17:01:09.058	2024-02-08 17:01:09.062	\N	\N	16	2	elasticsearch.url	string	\N	t				{"TextFieldWithIcon":true, "info": "eg. 'http://&lt;ipaddr&gt;:9200'"}	Elasticsearch URL	\N	\N	\N	\N	1
98	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.138	\N	\N	203	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
99	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.138	\N	\N	203	2	password	password	\N	f	\N				Password	\N	\N	\N	\N	1
100	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.139	\N	\N	203	3	jdbc.driverClassName	string	\N	t	io.trino.jdbc.TrinoDriver				\N	\N	\N	\N	\N	2
101	\N	2024-02-08 17:01:09.134	2024-02-08 17:01:09.139	\N	\N	203	4	jdbc.url	string	\N	t					\N	\N	\N	\N	\N	3
102	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.252	\N	\N	17	1	username	string	\N	t	\N				Username	\N	\N	\N	\N	0
103	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.252	\N	\N	17	2	password	password	\N	f	\N				Password	\N	\N	\N	\N	1
104	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.253	\N	\N	17	3	jdbc.driverClassName	string	\N	t	io.prestosql.jdbc.PrestoDriver				\N	\N	\N	\N	\N	2
105	\N	2024-02-08 17:01:09.247	2024-02-08 17:01:09.254	\N	\N	17	4	jdbc.url	string	\N	t					\N	\N	\N	\N	\N	3
106	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.39	\N	\N	201	1	username	string		t	\N				Username	\N	\N	\N	\N	0
107	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.39	\N	\N	201	2	password	password		t	\N				Password	\N	\N	\N	\N	1
108	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.391	\N	\N	201	3	ozone.om.http-address	string		t	\N			{"TextFieldWithIcon":true, "info": "For Ozone Url, eg.<br>&lt;host&gt;:&lt;port&gt;<br>"}	Ozone URL	\N	\N	\N	\N	2
109	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.391	\N	\N	201	4	hadoop.security.authorization	bool	YesTrue:NoFalse	f	false				Authorization Enabled	\N	\N	\N	\N	3
110	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.392	\N	\N	201	5	hadoop.security.authentication	enum	authnType	t	simple				Authentication Type	\N	\N	\N	\N	4
111	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.392	\N	\N	201	6	hadoop.security.auth_to_local	string		f	\N				\N	\N	\N	\N	\N	5
112	\N	2024-02-08 17:01:09.385	2024-02-08 17:01:09.393	\N	\N	201	7	ranger.plugin.audit.filters	string		f	[ {'accessResult': 'DENIED', 'isAudited': true} ]				Ranger Default Audit Filters	\N	\N	\N	\N	6
113	\N	2024-02-08 17:01:09.518	2024-02-08 17:01:09.523	\N	\N	105	1	ranger.plugin.audit.filters	string		f	[]				Ranger Default Audit Filters	\N	\N	\N	\N	0
114	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.689	\N	\N	205	1	commonNameForCertificate	string	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	0
115	\N	2024-02-08 17:01:09.685	2024-02-08 17:01:09.69	\N	\N	205	2	policy.download.auth.users	string	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	1
88	\N	2024-02-08 17:01:08.945	2024-02-08 17:01:13.376	\N	\N	100	1	ranger.plugin.audit.filters	string		f	[ {'accessResult': 'DENIED', 'isAudited': true} ]				Ranger Default Audit Filters	\N	\N	\N	\N	0
\.


--
-- Data for Name: x_service_config_map; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_service_config_map (id, guid, create_time, update_time, added_by_id, upd_by_id, service, config_key, config_value) FROM stdin;
7	\N	2024-02-08 17:01:50.081	2024-02-08 17:01:50.083	1	1	2	ranger.plugin.audit.filters	[ {'accessResult': 'DENIED', 'isAudited': true} ]
8	\N	2024-02-08 17:01:49.882	2024-02-08 17:01:50.195	1	1	1	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,fPgjHXl2PQZP3yR8BxJXKA==,Skv13/UKMtyoJOdGJ1BTVg==
9	\N	2024-02-08 17:01:49.882	2024-02-08 17:01:50.196	1	1	1	hadoop.security.authentication	simple
10	\N	2024-02-08 17:01:49.882	2024-02-08 17:01:50.197	1	1	1	fs.default.name	hdfs://ranger-hadoop:9000
11	\N	2024-02-08 17:01:49.882	2024-02-08 17:01:50.197	1	1	1	hadoop.security.authorization	true
12	\N	2024-02-08 17:01:49.882	2024-02-08 17:01:50.198	1	1	1	ranger.plugin.audit.filters	[{'accessResult': 'DENIED', 'isAudited': true}, {'actions':['delete','rename'],'isAudited':true}, {'users':['hdfs'], 'actions': ['listStatus', 'getfileinfo', 'listCachePools', 'listCacheDirectives', 'listCorruptFileBlocks', 'monitorHealth', 'rollEditLog', 'open'], 'isAudited': false}, {'users': ['oozie'],'resources': {'path': {'values': ['/user/oozie/share/lib'],'isRecursive': true}},'isAudited': false},{'users': ['spark'],'resources': {'path': {'values': ['/user/spark/applicationHistory'],'isRecursive': true}},'isAudited': false},{'users': ['hue'],'resources': {'path': {'values': ['/user/hue'],'isRecursive': true}},'isAudited': false},{'users': ['hbase'],'resources': {'path': {'values': ['/hbase'],'isRecursive': true}},'isAudited': false},{'users': ['mapred'],'resources': {'path': {'values': ['/user/history'],'isRecursive': true}},'isAudited': false}, {'actions': ['getfileinfo'], 'isAudited':false} ]
13	\N	2024-02-08 17:01:49.882	2024-02-08 17:01:50.201	1	1	1	username	hdfs
14	\N	2024-02-08 17:01:50.297	2024-02-08 17:01:50.309	1	1	3	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,Ro6xPK8C+naN/p8d1aq8TA==,Siox2drowYMJWMLAKBTIpg==
15	\N	2024-02-08 17:01:50.297	2024-02-08 17:01:50.309	1	1	3	yarn.url	http://ranger-hadoop:8088
16	\N	2024-02-08 17:01:50.297	2024-02-08 17:01:50.31	1	1	3	ranger.plugin.audit.filters	[]
17	\N	2024-02-08 17:01:50.297	2024-02-08 17:01:50.311	1	1	3	username	yarn
18	\N	2024-02-08 17:01:50.389	2024-02-08 17:01:50.403	1	1	4	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,2ySUCK6p1AZQKuSMJcfR7g==,EY/okRDRIz1bjrQrmddiGQ==
19	\N	2024-02-08 17:01:50.389	2024-02-08 17:01:50.403	1	1	4	hadoop.security.authorization	true
20	\N	2024-02-08 17:01:50.389	2024-02-08 17:01:50.403	1	1	4	ranger.plugin.audit.filters	[ {'accessResult': 'DENIED', 'isAudited': true}, {'actions':['METADATA OPERATION'], 'isAudited': false}, {'users':['hive','hue'],'actions':['SHOW_ROLES'],'isAudited':false} ]
21	\N	2024-02-08 17:01:50.389	2024-02-08 17:01:50.404	1	1	4	jdbc.driverClassName	org.apache.hive.jdbc.HiveDriver
22	\N	2024-02-08 17:01:50.389	2024-02-08 17:01:50.404	1	1	4	jdbc.url	jdbc:hive2://ranger-hive:10000
23	\N	2024-02-08 17:01:50.389	2024-02-08 17:01:50.405	1	1	4	username	hive
24	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.677	1	1	5	hbase.zookeeper.quorum	ranger-zk
25	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.691	1	1	5	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,xOAWqmO+WtIOGfG22gLM0w==,rgQaQ0A9VUFvmW1uuBEQIg==
26	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.692	1	1	5	hadoop.security.authentication	simple
27	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.692	1	1	5	hbase.security.authentication	simple
28	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.692	1	1	5	hadoop.security.authorization	true
29	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.692	1	1	5	hbase.zookeeper.property.clientPort	2181
30	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.692	1	1	5	ranger.plugin.audit.filters	[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'table':{'values':['*-ROOT-*','*.META.*', '*_acl_*', 'hbase:meta', 'hbase:acl', 'default', 'hbase']}}, 'users':['hbase'], 'isAudited': false }, {'resources':{'table':{'values':['atlas_janus','ATLAS_ENTITY_AUDIT_EVENTS']},'column-family':{'values':['*']},'column':{'values':['*']}},'users':['atlas', 'hbase'],'isAudited':false},{'users':['hbase'], 'actions':['balance'],'isAudited':false}]
31	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.693	1	1	5	zookeeper.znode.parent	/hbase
32	\N	2024-02-08 17:01:50.675	2024-02-08 17:01:50.693	1	1	5	username	hbase
33	\N	2024-02-08 17:01:50.742	2024-02-08 17:01:50.756	1	1	6	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,xLUkQxA3f2SU4IGxRs4xlw==,0KadU/nr6kEyl8jcjkZd5Q==
34	\N	2024-02-08 17:01:50.742	2024-02-08 17:01:50.756	1	1	6	zookeeper.connect	ranger-zk.example.com:2181
35	\N	2024-02-08 17:01:50.742	2024-02-08 17:01:50.756	1	1	6	ranger.plugin.audit.filters	[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'topic':{'values':['ATLAS_ENTITIES','ATLAS_HOOK','ATLAS_SPARK_HOOK']}},'users':['atlas'],'actions':['describe','publish','consume'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_HOOK']}},'users':['hive','hbase','impala','nifi'],'actions':['publish','describe'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_ENTITIES']}},'users':['rangertagsync'],'actions':['consume','describe'],'isAudited':false},{'resources':{'consumergroup':{'values':['*']}},'users':['atlas','rangertagsync'],'actions':['consume'],'isAudited':false},{'users':['kafka'],'isAudited':false}]
36	\N	2024-02-08 17:01:50.742	2024-02-08 17:01:50.757	1	1	6	username	kafka
37	\N	2024-02-08 17:01:50.919	2024-02-08 17:01:50.932	1	1	7	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,dgnZJnqF7HXznbcgYaWLog==,Hlo9cN3pLJdgFziQrNvJsQ==
38	\N	2024-02-08 17:01:50.919	2024-02-08 17:01:50.933	1	1	7	ranger.plugin.audit.filters	[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['knox'] ,'isAudited':false} ]
39	\N	2024-02-08 17:01:50.919	2024-02-08 17:01:50.933	1	1	7	knox.url	https://ranger-knox:8443
40	\N	2024-02-08 17:01:50.919	2024-02-08 17:01:50.934	1	1	7	username	knox
41	\N	2024-02-08 17:01:50.986	2024-02-08 17:01:50.999	1	1	8	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,Oh5QA7G8Dt/U+1qWEGxQJg==,xNQNv8epfE5kiCaNhKeM6Q==
42	\N	2024-02-08 17:01:50.986	2024-02-08 17:01:50.999	1	1	8	provider	http://ranger-kms:9292
43	\N	2024-02-08 17:01:50.986	2024-02-08 17:01:50.999	1	1	8	ranger.plugin.audit.filters	[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['keyadmin'] ,'isAudited':false} ]
44	\N	2024-02-08 17:01:50.986	2024-02-08 17:01:51	1	1	8	username	keyadmin
45	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.923	1	1	9	password	PBEWithHmacSHA512AndAES_128,tzL1AKl5uc4NKYaoQ4P3WLGIBFPXWPWdu1fRm9004jtQiV,f77aLYLo,1000,HyOgpAQoW0l/2iyynKwynQ==,VpaD1wHPH9AHtCIl91bG3w==
46	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.924	1	1	9	hadoop.security.authentication	simple
47	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.924	1	1	9	hadoop.rpc.protection	authentication
48	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.925	1	1	9	fs.default.name	http://localhost:8020
49	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.925	1	1	9	hadoop.security.authorization	true
50	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.926	1	1	9	ranger.plugin.audit.filters	[{'accessResult':'DENIED','isAudited':true},{'actions':['delete','rename'],'isAudited':true},{'users':['hdfs'],'actions':['listStatus','getfileinfo','listCachePools','listCacheDirectives','listCorruptFileBlocks','monitorHealth','rollEditLog','open'],'isAudited':false},{'users':['oozie'],'resources':{'path':{'values':['/user/oozie/share/lib'],'isRecursive':true}},'isAudited':false},{'users':['spark'],'resources':{'path':{'values':['/user/spark/applicationHistory'],'isRecursive':true}},'isAudited':false},{'users':['hue'],'resources':{'path':{'values':['/user/hue'],'isRecursive':true}},'isAudited':false},{'users':['hbase'],'resources':{'path':{'values':['/hbase'],'isRecursive':true}},'isAudited':false},{'users':['mapred'],'resources':{'path':{'values':['/user/history'],'isRecursive':true}},'isAudited':false},{'actions':['getfileinfo'],'isAudited':false}]
51	\N	2024-02-08 17:51:47.898	2024-02-08 17:51:47.928	1	1	9	username	hadoop
\.


--
-- Data for Name: x_service_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_service_def (id, guid, create_time, update_time, added_by_id, upd_by_id, version, name, display_name, impl_class_name, label, description, rb_key_label, rb_key_description, is_enabled, def_options) FROM stdin;
1	0d047247-bafe-4cf8-8e9b-d5d377284b2d	2024-02-08 17:01:08.205	2024-02-08 17:01:08.322	\N	\N	1	hdfs	hdfs	org.apache.ranger.services.hdfs.RangerServiceHdfs	HDFS Repository	HDFS Repository	\N	\N	t	{}
2	d6cea1f0-2509-4791-8fc1-7b092399ba3b	2024-02-08 17:01:08.494	2024-02-08 17:01:08.494	\N	\N	1	hbase	hbase	org.apache.ranger.services.hbase.RangerServiceHBase	HBase	HBase	\N	\N	t	{}
3	3e1afb5a-184a-4e82-9d9c-87a5cacc243c	2024-02-08 17:01:08.548	2024-02-08 17:01:08.548	\N	\N	1	hive	Hadoop SQL	org.apache.ranger.services.hive.RangerServiceHive	Hive Server2	Hive Server2	\N	\N	t	{}
7	50fd3b41-3aa6-49af-814d-32859bcf5f17	2024-02-08 17:01:08.644	2024-02-08 17:01:08.644	\N	\N	1	kms	kms	org.apache.ranger.services.kms.RangerServiceKMS	KMS	KMS	\N	\N	t	{"ui.pages":"encryption","security.allowed.roles":"keyadmin"}
5	84b481b5-f23b-4f71-b8b6-ab33977149ca	2024-02-08 17:01:08.673	2024-02-08 17:01:08.673	\N	\N	1	knox	knox	org.apache.ranger.services.knox.RangerServiceKnox	Knox Gateway	Knox Gateway	\N	\N	t	{}
6	2a60f427-edcf-4e20-834c-a9a267b5b963	2024-02-08 17:01:08.699	2024-02-08 17:01:08.699	\N	\N	1	storm	storm	org.apache.ranger.services.storm.RangerServiceStorm	Storm	Storm	\N	\N	t	{}
4	5b710438-edcf-4e20-834c-a9a267b5b963	2024-02-08 17:01:08.738	2024-02-08 17:01:08.738	\N	\N	1	yarn	yarn	org.apache.ranger.services.yarn.RangerServiceYarn	YARN	YARN	\N	\N	t	{}
9	f0a466d7-fcb8-41ce-a54d-a5488a5dc54a	2024-02-08 17:01:08.758	2024-02-08 17:01:08.758	\N	\N	1	kafka	kafka	org.apache.ranger.services.kafka.RangerServiceKafka	Kafka	Apache Kafka	\N	\N	t	{}
8	b80fbc96-5851-4a74-8b1b-6a95abc8fd53	2024-02-08 17:01:08.792	2024-02-08 17:01:08.792	\N	\N	1	solr	solr	org.apache.ranger.services.solr.RangerServiceSolr	SOLR	Solr	\N	\N	t	{}
202	9d71df31-5c2c-462b-b4f5-142d2331e245	2024-02-08 17:01:08.812	2024-02-08 17:01:08.812	\N	\N	1	schema-registry	schema-registry	org.apache.ranger.services.schema.registry.RangerServiceSchemaRegistry	Schema Registry	Schema Registry	\N	\N	t	{}
10	21890f77-ed89-4bfd-88d7-35614b0c98c4	2024-02-08 17:01:08.84	2024-02-08 17:01:08.84	\N	\N	1	nifi	nifi	org.apache.ranger.services.nifi.RangerServiceNiFi	NIFI	NiFi	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"false"}
13	c6da6567-f1b3-48bf-a1ca-314aef19d5e5	2024-02-08 17:01:08.869	2024-02-08 17:01:08.869	\N	\N	1	nifi-registry	nifi-registry	org.apache.ranger.services.nifi.registry.RangerServiceNiFiRegistry	NIFI Registry	NiFi Registry	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"false"}
15	311a79b7-16f5-46f4-9829-a0224b9999c5	2024-02-08 17:01:08.894	2024-02-08 17:01:08.894	\N	\N	1	atlas	atlas	org.apache.ranger.services.atlas.RangerServiceAtlas	Atlas Metadata Server	Atlas Metadata Server	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"true"}
14	6c63d385-5876-4a4c-ac4a-3b99b50ed600	2024-02-08 17:01:08.961	2024-02-08 17:01:08.961	\N	\N	1	sqoop	sqoop	org.apache.ranger.services.sqoop.RangerServiceSqoop	SQOOP	SQOOP	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"false"}
12	88ab8471-3e27-40c2-8bd8-458b5b1a9b25	2024-02-08 17:01:09.019	2024-02-08 17:01:09.019	\N	\N	1	kylin	kylin	org.apache.ranger.services.kylin.RangerServiceKylin	KYLIN	KYLIN	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"false"}
16	c0682ba7-7052-4c9c-a30e-84ccd5d98457	2024-02-08 17:01:09.058	2024-02-08 17:01:09.058	\N	\N	1	elasticsearch	elasticsearch	org.apache.ranger.services.elasticsearch.RangerServiceElasticsearch	ELASTICSEARCH	ELASTICSEARCH	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"false"}
203	379a9fe5-1b6e-4091-a584-4890e245e6c1	2024-02-08 17:01:09.134	2024-02-08 17:01:09.134	\N	\N	1	trino	trino	org.apache.ranger.services.trino.RangerServiceTrino	Trino	Trino	\N	\N	t	{}
17	379a9fe5-1b6e-4091-a584-4890e245e6c1	2024-02-08 17:01:09.247	2024-02-08 17:01:09.247	\N	\N	1	presto	presto	org.apache.ranger.services.presto.RangerServicePresto	Presto	Presto	\N	\N	t	{}
201	a978ad0a-263e-4b86-957c-9e26ab028ee5	2024-02-08 17:01:09.385	2024-02-08 17:01:09.385	\N	\N	1	ozone	ozone	org.apache.ranger.services.ozone.RangerServiceOzone	OZONE	Ozone Repository	\N	\N	t	{}
105	3afccea8-2307-4627-90c1-c8db61b25584	2024-02-08 17:01:09.518	2024-02-08 17:01:09.518	\N	\N	1	kudu	kudu	org.apache.ranger.services.kudu.RangerServiceKudu	Kudu	Kudu	\N	\N	t	{}
205	3b048585-a04f-4f83-8801-f5cb97d40360	2024-02-08 17:01:09.685	2024-02-08 17:01:09.685	\N	\N	1	nestedstructure	nestedstructure		NestedStructure	Plugin to enforce READ and WRITE access control on nested structures such as JSON response objects from microservice API resource calls	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"true"}
100	0d047248-baff-4cf9-8e9e-d5d377284b2e	2024-02-08 17:01:08.945	2024-02-08 17:01:13.361	\N	\N	22	tag	tag	org.apache.ranger.services.tag.RangerServiceTag	TAG	TAG Service Definition	\N	\N	t	{"enableDenyAndExceptionsInPolicies":"true","ui.pages":"tag-based-policies"}
\.


--
-- Data for Name: x_service_resource; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_service_resource (id, guid, create_time, update_time, added_by_id, upd_by_id, version, service_id, resource_signature, is_enabled, service_resource_elements_text, tags_text) FROM stdin;
\.


--
-- Data for Name: x_service_version_info; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_service_version_info (id, service_id, policy_version, policy_update_time, tag_version, tag_update_time, role_version, role_update_time, version) FROM stdin;
2	2	2	2024-02-08 17:01:50.211	1	2024-02-08 17:01:50.082	1	2024-02-08 17:01:50.082	2
1	1	5	2024-02-08 17:01:50.279	1	2024-02-08 17:01:49.884	1	2024-02-08 17:01:49.884	5
3	3	2	2024-02-08 17:01:50.37	1	2024-02-08 17:01:50.298	1	2024-02-08 17:01:50.298	2
4	4	9	2024-02-08 17:01:50.652	1	2024-02-08 17:01:50.39	1	2024-02-08 17:01:50.39	9
5	5	2	2024-02-08 17:01:50.727	1	2024-02-08 17:01:50.677	1	2024-02-08 17:01:50.677	2
6	6	6	2024-02-08 17:01:50.906	1	2024-02-08 17:01:50.743	1	2024-02-08 17:01:50.743	6
7	7	2	2024-02-08 17:01:50.973	1	2024-02-08 17:01:50.92	1	2024-02-08 17:01:50.92	2
8	8	2	2024-02-08 17:01:51.05	1	2024-02-08 17:01:50.986	1	2024-02-08 17:01:50.986	2
9	9	4	2024-02-08 17:51:48.103	1	2024-02-08 17:51:47.901	1	2024-02-08 17:51:47.901	4
\.


--
-- Data for Name: x_tag; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_tag (id, guid, create_time, update_time, added_by_id, upd_by_id, version, type, owned_by, policy_options, tag_attrs_text) FROM stdin;
\.


--
-- Data for Name: x_tag_change_log; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_tag_change_log (id, create_time, service_id, change_type, service_tags_version, service_resource_id, tag_id) FROM stdin;
\.


--
-- Data for Name: x_tag_def; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_tag_def (id, guid, create_time, update_time, added_by_id, upd_by_id, version, name, source, is_enabled, tag_attrs_def_text) FROM stdin;
\.


--
-- Data for Name: x_tag_resource_map; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_tag_resource_map (id, guid, create_time, update_time, added_by_id, upd_by_id, tag_id, res_id) FROM stdin;
\.


--
-- Data for Name: x_trx_log; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_trx_log (id, create_time, update_time, added_by_id, upd_by_id, class_type, object_id, parent_object_id, parent_object_class_type, parent_object_name, object_name, attr_name, prev_val, new_val, trx_id, action, sess_id, req_id, sess_type) FROM stdin;
1	2024-02-08 17:01:14.268	2024-02-08 17:01:14.268	1	1	7	1	\N	0	\N	admin	Password	*****	*****	-5241518041160662071	password change	\N	-5241518041160662071	Spring Authenticated Session
2	2024-02-08 17:01:14.272	2024-02-08 17:01:14.272	4	4	7	4	\N	0	\N	rangertagsync	Password	*****	*****	-1917067211591237609	password change	\N	-1917067211591237609	Spring Authenticated Session
3	2024-02-08 17:01:14.275	2024-02-08 17:01:14.275	2	2	7	2	\N	0	\N	rangerusersync	Password	*****	*****	1363927128365549232	password change	\N	1363927128365549232	Spring Authenticated Session
4	2024-02-08 17:01:14.277	2024-02-08 17:01:14.277	3	3	7	3	\N	0	\N	keyadmin	Password	*****	*****	5048790489688065274	password change	\N	5048790489688065274	Spring Authenticated Session
5	2024-02-08 17:01:49.951	2024-02-08 17:01:49.954	1	1	1030	1	1	1033	hdfs	dev_hdfs	Service Name	\N	dev_hdfs	5284309592427610769	create	2	5284309592427610769	Spring Authenticated Session
6	2024-02-08 17:01:49.952	2024-02-08 17:01:49.956	1	1	1030	1	1	1033	hdfs	dev_hdfs	Service Display Name	\N	dev_hdfs	5284309592427610769	create	2	5284309592427610769	Spring Authenticated Session
7	2024-02-08 17:01:49.952	2024-02-08 17:01:49.957	1	1	1030	1	1	1033	hdfs	dev_hdfs	Service Description	\N	null	5284309592427610769	create	2	5284309592427610769	Spring Authenticated Session
8	2024-02-08 17:01:49.952	2024-02-08 17:01:49.958	1	1	1030	1	1	1033	hdfs	dev_hdfs	Tag Service Name	\N	null	5284309592427610769	create	2	5284309592427610769	Spring Authenticated Session
9	2024-02-08 17:01:49.953	2024-02-08 17:01:49.959	1	1	1030	1	1	1033	hdfs	dev_hdfs	Connection Configurations	\N	{"password":"*****","hadoop.security.authentication":"simple","fs.default.name":"hdfs://ranger-hadoop:9000","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true}, {'actions':['delete','rename'],'isAudited':true}, {'users':['hdfs'], 'actions': ['listStatus', 'getfileinfo', 'listCachePools', 'listCacheDirectives', 'listCorruptFileBlocks', 'monitorHealth', 'rollEditLog', 'open'], 'isAudited': false}, {'users': ['oozie'],'resources': {'path': {'values': ['/user/oozie/share/lib'],'isRecursive': true}},'isAudited': false},{'users': ['spark'],'resources': {'path': {'values': ['/user/spark/applicationHistory'],'isRecursive': true}},'isAudited': false},{'users': ['hue'],'resources': {'path': {'values': ['/user/hue'],'isRecursive': true}},'isAudited': false},{'users': ['hbase'],'resources': {'path': {'values': ['/hbase'],'isRecursive': true}},'isAudited': false},{'users': ['mapred'],'resources': {'path': {'values': ['/user/history'],'isRecursive': true}},'isAudited': false}, {'actions': ['getfileinfo'], 'isAudited':false} ]","username":"hdfs"}	5284309592427610769	create	2	5284309592427610769	Spring Authenticated Session
10	2024-02-08 17:01:49.953	2024-02-08 17:01:49.96	1	1	1030	1	1	1033	hdfs	dev_hdfs	Service Status	\N	true	5284309592427610769	create	2	5284309592427610769	Spring Authenticated Session
11	2024-02-08 17:01:50.023	2024-02-08 17:01:50.027	1	1	1020	1	1	1030	dev_hdfs	all - path	Policy Name	\N	all - path	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
12	2024-02-08 17:01:50.024	2024-02-08 17:01:50.028	1	1	1020	1	1	1030	dev_hdfs	all - path	Priority	\N	0	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
13	2024-02-08 17:01:50.024	2024-02-08 17:01:50.028	1	1	1020	1	1	1030	dev_hdfs	all - path	Policy Description	\N	Policy for all - path	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
14	2024-02-08 17:01:50.024	2024-02-08 17:01:50.029	1	1	1020	1	1	1030	dev_hdfs	all - path	Audit Status	\N	true	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
15	2024-02-08 17:01:50.024	2024-02-08 17:01:50.029	1	1	1020	1	1	1030	dev_hdfs	all - path	Policy Resources	\N	{"path":{"values":["/*"],"isExcludes":false,"isRecursive":true}}	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
16	2024-02-08 17:01:50.025	2024-02-08 17:01:50.03	1	1	1020	1	1	1030	dev_hdfs	all - path	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hdfs"],"delegateAdmin":true}]	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
17	2024-02-08 17:01:50.026	2024-02-08 17:01:50.03	1	1	1020	1	1	1030	dev_hdfs	all - path	Validity Schedules	\N	[]	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
18	2024-02-08 17:01:50.026	2024-02-08 17:01:50.031	1	1	1020	1	1	1030	dev_hdfs	all - path	Policy Labels	\N	[]	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
19	2024-02-08 17:01:50.027	2024-02-08 17:01:50.031	1	1	1020	1	1	1030	dev_hdfs	all - path	Deny All Other Accesses	\N	false	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
20	2024-02-08 17:01:50.027	2024-02-08 17:01:50.031	1	1	1020	1	1	1030	dev_hdfs	all - path	Policy Status	\N	true	-787142324680963154	create	2	-787142324680963154	Spring Authenticated Session
21	2024-02-08 17:01:50.046	2024-02-08 17:01:50.05	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Policy Name	\N	kms-audit-path	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
22	2024-02-08 17:01:50.047	2024-02-08 17:01:50.05	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Priority	\N	0	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
23	2024-02-08 17:01:50.047	2024-02-08 17:01:50.05	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Policy Description	\N	Policy for kms-audit-path	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
24	2024-02-08 17:01:50.047	2024-02-08 17:01:50.051	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Audit Status	\N	true	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
25	2024-02-08 17:01:50.047	2024-02-08 17:01:50.051	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Policy Resources	\N	{"path":{"values":["/ranger/audit/kms"],"isExcludes":false,"isRecursive":true}}	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
26	2024-02-08 17:01:50.048	2024-02-08 17:01:50.052	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["keyadmin"],"delegateAdmin":false}]	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
27	2024-02-08 17:01:50.048	2024-02-08 17:01:50.052	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Validity Schedules	\N	[]	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
28	2024-02-08 17:01:50.049	2024-02-08 17:01:50.053	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Policy Labels	\N	[]	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
29	2024-02-08 17:01:50.049	2024-02-08 17:01:50.053	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Deny All Other Accesses	\N	false	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
30	2024-02-08 17:01:50.049	2024-02-08 17:01:50.054	1	1	1020	2	1	1030	dev_hdfs	kms-audit-path	Policy Status	\N	true	7470480873682780701	create	2	7470480873682780701	Spring Authenticated Session
31	2024-02-08 17:01:50.067	2024-02-08 17:01:50.071	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Policy Name	\N	hbase-archive	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
32	2024-02-08 17:01:50.067	2024-02-08 17:01:50.071	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Priority	\N	0	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
33	2024-02-08 17:01:50.068	2024-02-08 17:01:50.071	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Policy Description	\N	Policy for hbase archive location	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
34	2024-02-08 17:01:50.068	2024-02-08 17:01:50.072	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Audit Status	\N	true	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
35	2024-02-08 17:01:50.068	2024-02-08 17:01:50.072	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Policy Resources	\N	{"path":{"values":["/hbase/archive"],"isExcludes":false,"isRecursive":true}}	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
36	2024-02-08 17:01:50.068	2024-02-08 17:01:50.073	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"delegateAdmin":false}]	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
37	2024-02-08 17:01:50.07	2024-02-08 17:01:50.073	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Validity Schedules	\N	[]	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
38	2024-02-08 17:01:50.07	2024-02-08 17:01:50.074	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Policy Labels	\N	[]	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
39	2024-02-08 17:01:50.07	2024-02-08 17:01:50.074	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Deny All Other Accesses	\N	false	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
40	2024-02-08 17:01:50.07	2024-02-08 17:01:50.075	1	1	1020	3	1	1030	dev_hdfs	hbase-archive	Policy Status	\N	true	-5988802739299859699	create	2	-5988802739299859699	Spring Authenticated Session
41	2024-02-08 17:01:50.084	2024-02-08 17:01:50.085	1	1	1030	2	100	1033	tag	dev_tag	Service Name	\N	dev_tag	8971305887449957465	create	2	8971305887449957465	Spring Authenticated Session
42	2024-02-08 17:01:50.084	2024-02-08 17:01:50.085	1	1	1030	2	100	1033	tag	dev_tag	Service Display Name	\N	dev_tag	8971305887449957465	create	2	8971305887449957465	Spring Authenticated Session
43	2024-02-08 17:01:50.084	2024-02-08 17:01:50.086	1	1	1030	2	100	1033	tag	dev_tag	Service Description	\N	null	8971305887449957465	create	2	8971305887449957465	Spring Authenticated Session
44	2024-02-08 17:01:50.084	2024-02-08 17:01:50.086	1	1	1030	2	100	1033	tag	dev_tag	Tag Service Name	\N	null	8971305887449957465	create	2	8971305887449957465	Spring Authenticated Session
45	2024-02-08 17:01:50.085	2024-02-08 17:01:50.087	1	1	1030	2	100	1033	tag	dev_tag	Connection Configurations	\N	{"ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true} ]"}	8971305887449957465	create	2	8971305887449957465	Spring Authenticated Session
46	2024-02-08 17:01:50.085	2024-02-08 17:01:50.087	1	1	1030	2	100	1033	tag	dev_tag	Service Status	\N	true	8971305887449957465	create	2	8971305887449957465	Spring Authenticated Session
47	2024-02-08 17:01:50.17	2024-02-08 17:01:50.174	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Policy Name	\N	EXPIRES_ON	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
48	2024-02-08 17:01:50.17	2024-02-08 17:01:50.175	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Priority	\N	0	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
49	2024-02-08 17:01:50.171	2024-02-08 17:01:50.175	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Policy Description	\N	Policy for data with EXPIRES_ON tag	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
50	2024-02-08 17:01:50.171	2024-02-08 17:01:50.176	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Audit Status	\N	true	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
51	2024-02-08 17:01:50.171	2024-02-08 17:01:50.176	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Policy Resources	\N	{"tag":{"values":["EXPIRES_ON"],"isExcludes":false,"isRecursive":false}}	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
52	2024-02-08 17:01:50.172	2024-02-08 17:01:50.177	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	DenyPolicy Items	\N	[{"accesses":[{"type":"sqoop:READ","isAllowed":true},{"type":"sqoop:WRITE","isAllowed":true},{"type":"kylin:QUERY","isAllowed":true},{"type":"kylin:OPERATION","isAllowed":true},{"type":"kylin:MANAGEMENT","isAllowed":true},{"type":"kylin:ADMIN","isAllowed":true},{"type":"elasticsearch:all","isAllowed":true},{"type":"elasticsearch:monitor","isAllowed":true},{"type":"elasticsearch:manage","isAllowed":true},{"type":"elasticsearch:view_index_metadata","isAllowed":true},{"type":"elasticsearch:read","isAllowed":true},{"type":"elasticsearch:read_cross_cluster","isAllowed":true},{"type":"elasticsearch:index","isAllowed":true},{"type":"elasticsearch:create","isAllowed":true},{"type":"elasticsearch:delete","isAllowed":true},{"type":"elasticsearch:write","isAllowed":true},{"type":"elasticsearch:delete_index","isAllowed":true},{"type":"elasticsearch:create_index","isAllowed":true},{"type":"trino:select","isAllowed":true},{"type":"trino:insert","isAllowed":true},{"type":"trino:create","isAllowed":true},{"type":"trino:drop","isAllowed":true},{"type":"trino:delete","isAllowed":true},{"type":"trino:use","isAllowed":true},{"type":"trino:alter","isAllowed":true},{"type":"trino:grant","isAllowed":true},{"type":"trino:revoke","isAllowed":true},{"type":"trino:show","isAllowed":true},{"type":"trino:impersonate","isAllowed":true},{"type":"trino:all","isAllowed":true},{"type":"trino:execute","isAllowed":true},{"type":"presto:select","isAllowed":true},{"type":"presto:insert","isAllowed":true},{"type":"presto:create","isAllowed":true},{"type":"presto:drop","isAllowed":true},{"type":"presto:delete","isAllowed":true},{"type":"presto:use","isAllowed":true},{"type":"presto:alter","isAllowed":true},{"type":"presto:grant","isAllowed":true},{"type":"presto:revoke","isAllowed":true},{"type":"presto:show","isAllowed":true},{"type":"presto:impersonate","isAllowed":true},{"type":"presto:all","isAllowed":true},{"type":"presto:execute","isAllowed":true},{"type":"ozone:all","isAllowed":true},{"type":"ozone:read","isAllowed":true},{"type":"ozone:write","isAllowed":true},{"type":"ozone:create","isAllowed":true},{"type":"ozone:list","isAllowed":true},{"type":"ozone:delete","isAllowed":true},{"type":"ozone:read_acl","isAllowed":true},{"type":"ozone:write_acl","isAllowed":true},{"type":"kudu:select","isAllowed":true},{"type":"kudu:insert","isAllowed":true},{"type":"kudu:update","isAllowed":true},{"type":"kudu:delete","isAllowed":true},{"type":"kudu:alter","isAllowed":true},{"type":"kudu:create","isAllowed":true},{"type":"kudu:drop","isAllowed":true},{"type":"kudu:metadata","isAllowed":true},{"type":"kudu:all","isAllowed":true},{"type":"nestedstructure:read","isAllowed":true},{"type":"nestedstructure:write","isAllowed":true},{"type":"hdfs:read","isAllowed":true},{"type":"hdfs:write","isAllowed":true},{"type":"hdfs:execute","isAllowed":true},{"type":"hbase:read","isAllowed":true},{"type":"hbase:write","isAllowed":true},{"type":"hbase:create","isAllowed":true},{"type":"hbase:admin","isAllowed":true},{"type":"hbase:execute","isAllowed":true},{"type":"hive:select","isAllowed":true},{"type":"hive:update","isAllowed":true},{"type":"hive:create","isAllowed":true},{"type":"hive:drop","isAllowed":true},{"type":"hive:alter","isAllowed":true},{"type":"hive:index","isAllowed":true},{"type":"hive:lock","isAllowed":true},{"type":"hive:all","isAllowed":true},{"type":"hive:read","isAllowed":true},{"type":"hive:write","isAllowed":true},{"type":"hive:repladmin","isAllowed":true},{"type":"hive:serviceadmin","isAllowed":true},{"type":"hive:tempudfadmin","isAllowed":true},{"type":"hive:refresh","isAllowed":true},{"type":"kms:create","isAllowed":true},{"type":"kms:delete","isAllowed":true},{"type":"kms:rollover","isAllowed":true},{"type":"kms:setkeymaterial","isAllowed":true},{"type":"kms:get","isAllowed":true},{"type":"kms:getkeys","isAllowed":true},{"type":"kms:getmetadata","isAllowed":true},{"type":"kms:generateeek","isAllowed":true},{"type":"kms:decrypteek","isAllowed":true},{"type":"knox:allow","isAllowed":true},{"type":"storm:submitTopology","isAllowed":true},{"type":"storm:fileUpload","isAllowed":true},{"type":"storm:fileDownload","isAllowed":true},{"type":"storm:killTopology","isAllowed":true},{"type":"storm:rebalance","isAllowed":true},{"type":"storm:activate","isAllowed":true},{"type":"storm:deactivate","isAllowed":true},{"type":"storm:getTopologyConf","isAllowed":true},{"type":"storm:getTopology","isAllowed":true},{"type":"storm:getUserTopology","isAllowed":true},{"type":"storm:getTopologyInfo","isAllowed":true},{"type":"storm:uploadNewCredentials","isAllowed":true},{"type":"yarn:submit-app","isAllowed":true},{"type":"yarn:admin-queue","isAllowed":true},{"type":"kafka:publish","isAllowed":true},{"type":"kafka:consume","isAllowed":true},{"type":"kafka:configure","isAllowed":true},{"type":"kafka:describe","isAllowed":true},{"type":"kafka:kafka_admin","isAllowed":true},{"type":"kafka:create","isAllowed":true},{"type":"kafka:delete","isAllowed":true},{"type":"kafka:idempotent_write","isAllowed":true},{"type":"kafka:describe_configs","isAllowed":true},{"type":"kafka:alter_configs","isAllowed":true},{"type":"kafka:cluster_action","isAllowed":true},{"type":"kafka:alter","isAllowed":true},{"type":"solr:query","isAllowed":true},{"type":"solr:update","isAllowed":true},{"type":"schema-registry:create","isAllowed":true},{"type":"schema-registry:read","isAllowed":true},{"type":"schema-registry:update","isAllowed":true},{"type":"schema-registry:delete","isAllowed":true},{"type":"nifi:READ","isAllowed":true},{"type":"nifi:WRITE","isAllowed":true},{"type":"nifi-registry:READ","isAllowed":true},{"type":"nifi-registry:WRITE","isAllowed":true},{"type":"nifi-registry:DELETE","isAllowed":true},{"type":"atlas:type-create","isAllowed":true},{"type":"atlas:type-update","isAllowed":true},{"type":"atlas:type-delete","isAllowed":true},{"type":"atlas:entity-read","isAllowed":true},{"type":"atlas:entity-create","isAllowed":true},{"type":"atlas:entity-update","isAllowed":true},{"type":"atlas:entity-delete","isAllowed":true},{"type":"atlas:entity-add-classification","isAllowed":true},{"type":"atlas:entity-update-classification","isAllowed":true},{"type":"atlas:entity-remove-classification","isAllowed":true},{"type":"atlas:admin-export","isAllowed":true},{"type":"atlas:admin-import","isAllowed":true},{"type":"atlas:add-relationship","isAllowed":true},{"type":"atlas:update-relationship","isAllowed":true},{"type":"atlas:remove-relationship","isAllowed":true},{"type":"atlas:admin-purge","isAllowed":true},{"type":"atlas:entity-add-label","isAllowed":true},{"type":"atlas:entity-remove-label","isAllowed":true},{"type":"atlas:entity-update-business-metadata","isAllowed":true},{"type":"atlas:type-read","isAllowed":true},{"type":"atlas:admin-audits","isAllowed":true}],"groups":["public"],"conditions":[{"type":"accessed-after-expiry","values":["yes"]}],"delegateAdmin":false}]	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
53	2024-02-08 17:01:50.173	2024-02-08 17:01:50.177	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Validity Schedules	\N	[]	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
54	2024-02-08 17:01:50.173	2024-02-08 17:01:50.178	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Policy Labels	\N	[]	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
55	2024-02-08 17:01:50.174	2024-02-08 17:01:50.178	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Deny All Other Accesses	\N	false	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
56	2024-02-08 17:01:50.174	2024-02-08 17:01:50.179	1	1	1020	4	2	1030	dev_tag	EXPIRES_ON	Policy Status	\N	true	-6707769032598797905	create	2	-6707769032598797905	Spring Authenticated Session
57	2024-02-08 17:01:50.183	2024-02-08 17:01:50.206	1	1	1030	1	1	1033	hdfs	dev_hdfs	Tag Service Name	null	dev_tag	-5313468772755357451	update	2	-5313468772755357451	Spring Authenticated Session
58	2024-02-08 17:01:50.227	2024-02-08 17:01:50.227	1	1	1003	7	\N	0	\N	hdfs	Login ID	\N	hdfs	6364657438361601407	create	2	6364657438361601407	Spring Authenticated Session
59	2024-02-08 17:01:50.227	2024-02-08 17:01:50.228	1	1	1003	7	\N	0	\N	hdfs	User Role	\N	[ROLE_USER]	6364657438361601407	create	2	6364657438361601407	Spring Authenticated Session
60	2024-02-08 17:01:50.249	2024-02-08 17:01:50.249	1	1	1003	8	\N	0	\N	hbase	Login ID	\N	hbase	-419595322279509063	create	2	-419595322279509063	Spring Authenticated Session
61	2024-02-08 17:01:50.249	2024-02-08 17:01:50.25	1	1	1003	8	\N	0	\N	hbase	User Role	\N	[ROLE_USER]	-419595322279509063	create	2	-419595322279509063	Spring Authenticated Session
62	2024-02-08 17:01:50.313	2024-02-08 17:01:50.314	1	1	1030	3	4	1033	yarn	dev_yarn	Service Name	\N	dev_yarn	3351498379180460185	create	2	3351498379180460185	Spring Authenticated Session
63	2024-02-08 17:01:50.313	2024-02-08 17:01:50.314	1	1	1030	3	4	1033	yarn	dev_yarn	Service Display Name	\N	dev_yarn	3351498379180460185	create	2	3351498379180460185	Spring Authenticated Session
64	2024-02-08 17:01:50.313	2024-02-08 17:01:50.315	1	1	1030	3	4	1033	yarn	dev_yarn	Service Description	\N	null	3351498379180460185	create	2	3351498379180460185	Spring Authenticated Session
65	2024-02-08 17:01:50.313	2024-02-08 17:01:50.315	1	1	1030	3	4	1033	yarn	dev_yarn	Tag Service Name	\N	dev_tag	3351498379180460185	create	2	3351498379180460185	Spring Authenticated Session
66	2024-02-08 17:01:50.313	2024-02-08 17:01:50.315	1	1	1030	3	4	1033	yarn	dev_yarn	Connection Configurations	\N	{"password":"*****","yarn.url":"http://ranger-hadoop:8088","ranger.plugin.audit.filters":"[]","username":"yarn"}	3351498379180460185	create	2	3351498379180460185	Spring Authenticated Session
67	2024-02-08 17:01:50.314	2024-02-08 17:01:50.316	1	1	1030	3	4	1033	yarn	dev_yarn	Service Status	\N	true	3351498379180460185	create	2	3351498379180460185	Spring Authenticated Session
68	2024-02-08 17:01:50.338	2024-02-08 17:01:50.341	1	1	1020	5	3	1030	dev_yarn	all - queue	Policy Name	\N	all - queue	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
69	2024-02-08 17:01:50.339	2024-02-08 17:01:50.342	1	1	1020	5	3	1030	dev_yarn	all - queue	Priority	\N	0	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
70	2024-02-08 17:01:50.339	2024-02-08 17:01:50.342	1	1	1020	5	3	1030	dev_yarn	all - queue	Policy Description	\N	Policy for all - queue	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
71	2024-02-08 17:01:50.339	2024-02-08 17:01:50.342	1	1	1020	5	3	1030	dev_yarn	all - queue	Audit Status	\N	true	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
72	2024-02-08 17:01:50.339	2024-02-08 17:01:50.343	1	1	1020	5	3	1030	dev_yarn	all - queue	Policy Resources	\N	{"queue":{"values":["*"],"isExcludes":false,"isRecursive":true}}	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
73	2024-02-08 17:01:50.34	2024-02-08 17:01:50.343	1	1	1020	5	3	1030	dev_yarn	all - queue	Policy Items	\N	[{"accesses":[{"type":"submit-app","isAllowed":true},{"type":"admin-queue","isAllowed":true}],"users":["yarn"],"delegateAdmin":true}]	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
74	2024-02-08 17:01:50.34	2024-02-08 17:01:50.343	1	1	1020	5	3	1030	dev_yarn	all - queue	Validity Schedules	\N	[]	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
75	2024-02-08 17:01:50.341	2024-02-08 17:01:50.344	1	1	1020	5	3	1030	dev_yarn	all - queue	Policy Labels	\N	[]	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
76	2024-02-08 17:01:50.341	2024-02-08 17:01:50.344	1	1	1020	5	3	1030	dev_yarn	all - queue	Deny All Other Accesses	\N	false	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
77	2024-02-08 17:01:50.341	2024-02-08 17:01:50.344	1	1	1020	5	3	1030	dev_yarn	all - queue	Policy Status	\N	true	-6896248859070411559	create	2	-6896248859070411559	Spring Authenticated Session
78	2024-02-08 17:01:50.353	2024-02-08 17:01:50.353	1	1	1003	9	\N	0	\N	yarn	Login ID	\N	yarn	-7796734127968008029	create	2	-7796734127968008029	Spring Authenticated Session
79	2024-02-08 17:01:50.353	2024-02-08 17:01:50.354	1	1	1003	9	\N	0	\N	yarn	User Role	\N	[ROLE_USER]	-7796734127968008029	create	2	-7796734127968008029	Spring Authenticated Session
80	2024-02-08 17:01:50.406	2024-02-08 17:01:50.407	1	1	1030	4	3	1033	hive	dev_hive	Service Name	\N	dev_hive	2002516119207234881	create	2	2002516119207234881	Spring Authenticated Session
81	2024-02-08 17:01:50.406	2024-02-08 17:01:50.408	1	1	1030	4	3	1033	hive	dev_hive	Service Display Name	\N	dev_hive	2002516119207234881	create	2	2002516119207234881	Spring Authenticated Session
82	2024-02-08 17:01:50.407	2024-02-08 17:01:50.408	1	1	1030	4	3	1033	hive	dev_hive	Service Description	\N	null	2002516119207234881	create	2	2002516119207234881	Spring Authenticated Session
83	2024-02-08 17:01:50.407	2024-02-08 17:01:50.408	1	1	1030	4	3	1033	hive	dev_hive	Tag Service Name	\N	dev_tag	2002516119207234881	create	2	2002516119207234881	Spring Authenticated Session
84	2024-02-08 17:01:50.407	2024-02-08 17:01:50.408	1	1	1030	4	3	1033	hive	dev_hive	Connection Configurations	\N	{"password":"*****","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'actions':['METADATA OPERATION'], 'isAudited': false}, {'users':['hive','hue'],'actions':['SHOW_ROLES'],'isAudited':false} ]","jdbc.driverClassName":"org.apache.hive.jdbc.HiveDriver","jdbc.url":"jdbc:hive2://ranger-hive:10000","username":"hive"}	2002516119207234881	create	2	2002516119207234881	Spring Authenticated Session
85	2024-02-08 17:01:50.407	2024-02-08 17:01:50.409	1	1	1030	4	3	1033	hive	dev_hive	Service Status	\N	true	2002516119207234881	create	2	2002516119207234881	Spring Authenticated Session
86	2024-02-08 17:01:50.431	2024-02-08 17:01:50.435	1	1	1020	6	4	1030	dev_hive	all - database	Policy Name	\N	all - database	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
87	2024-02-08 17:01:50.431	2024-02-08 17:01:50.435	1	1	1020	6	4	1030	dev_hive	all - database	Priority	\N	0	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
88	2024-02-08 17:01:50.432	2024-02-08 17:01:50.436	1	1	1020	6	4	1030	dev_hive	all - database	Policy Description	\N	Policy for all - database	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
89	2024-02-08 17:01:50.432	2024-02-08 17:01:50.436	1	1	1020	6	4	1030	dev_hive	all - database	Audit Status	\N	true	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
90	2024-02-08 17:01:50.432	2024-02-08 17:01:50.436	1	1	1020	6	4	1030	dev_hive	all - database	Policy Resources	\N	{"database":{"values":["*"],"isExcludes":false,"isRecursive":false}}	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
91	2024-02-08 17:01:50.432	2024-02-08 17:01:50.436	1	1	1020	6	4	1030	dev_hive	all - database	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"create","isAllowed":true}],"groups":["public"],"delegateAdmin":false},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}]	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
92	2024-02-08 17:01:50.434	2024-02-08 17:01:50.437	1	1	1020	6	4	1030	dev_hive	all - database	Validity Schedules	\N	[]	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
93	2024-02-08 17:01:50.434	2024-02-08 17:01:50.437	1	1	1020	6	4	1030	dev_hive	all - database	Policy Labels	\N	[]	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
94	2024-02-08 17:01:50.434	2024-02-08 17:01:50.437	1	1	1020	6	4	1030	dev_hive	all - database	Deny All Other Accesses	\N	false	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
95	2024-02-08 17:01:50.435	2024-02-08 17:01:50.438	1	1	1020	6	4	1030	dev_hive	all - database	Policy Status	\N	true	8247757111648145389	create	2	8247757111648145389	Spring Authenticated Session
96	2024-02-08 17:01:50.451	2024-02-08 17:01:50.453	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Policy Name	\N	all - hiveservice	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
97	2024-02-08 17:01:50.451	2024-02-08 17:01:50.454	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Priority	\N	0	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
98	2024-02-08 17:01:50.451	2024-02-08 17:01:50.454	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Policy Description	\N	Policy for all - hiveservice	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
99	2024-02-08 17:01:50.451	2024-02-08 17:01:50.455	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Audit Status	\N	true	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
100	2024-02-08 17:01:50.451	2024-02-08 17:01:50.455	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Policy Resources	\N	{"hiveservice":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
101	2024-02-08 17:01:50.452	2024-02-08 17:01:50.455	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true}]	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
102	2024-02-08 17:01:50.452	2024-02-08 17:01:50.456	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Validity Schedules	\N	[]	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
103	2024-02-08 17:01:50.452	2024-02-08 17:01:50.456	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Policy Labels	\N	[]	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
104	2024-02-08 17:01:50.453	2024-02-08 17:01:50.457	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Deny All Other Accesses	\N	false	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
105	2024-02-08 17:01:50.453	2024-02-08 17:01:50.457	1	1	1020	7	4	1030	dev_hive	all - hiveservice	Policy Status	\N	true	-2094044543778732319	create	2	-2094044543778732319	Spring Authenticated Session
106	2024-02-08 17:01:50.475	2024-02-08 17:01:50.478	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Policy Name	\N	all - database, table, column	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
107	2024-02-08 17:01:50.475	2024-02-08 17:01:50.478	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Priority	\N	0	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
108	2024-02-08 17:01:50.475	2024-02-08 17:01:50.479	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Policy Description	\N	Policy for all - database, table, column	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
109	2024-02-08 17:01:50.476	2024-02-08 17:01:50.479	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Audit Status	\N	true	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
110	2024-02-08 17:01:50.476	2024-02-08 17:01:50.479	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Policy Resources	\N	{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
111	2024-02-08 17:01:50.476	2024-02-08 17:01:50.48	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}]	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
112	2024-02-08 17:01:50.477	2024-02-08 17:01:50.48	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Validity Schedules	\N	[]	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
113	2024-02-08 17:01:50.477	2024-02-08 17:01:50.48	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Policy Labels	\N	[]	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
114	2024-02-08 17:01:50.477	2024-02-08 17:01:50.481	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Deny All Other Accesses	\N	false	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
115	2024-02-08 17:01:50.478	2024-02-08 17:01:50.481	1	1	1020	8	4	1030	dev_hive	all - database, table, column	Policy Status	\N	true	-5742114813330897486	create	2	-5742114813330897486	Spring Authenticated Session
116	2024-02-08 17:01:50.494	2024-02-08 17:01:50.497	1	1	1020	9	4	1030	dev_hive	all - database, table	Policy Name	\N	all - database, table	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
117	2024-02-08 17:01:50.494	2024-02-08 17:01:50.498	1	1	1020	9	4	1030	dev_hive	all - database, table	Priority	\N	0	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
118	2024-02-08 17:01:50.495	2024-02-08 17:01:50.498	1	1	1020	9	4	1030	dev_hive	all - database, table	Policy Description	\N	Policy for all - database, table	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
119	2024-02-08 17:01:50.495	2024-02-08 17:01:50.499	1	1	1020	9	4	1030	dev_hive	all - database, table	Audit Status	\N	true	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
120	2024-02-08 17:01:50.495	2024-02-08 17:01:50.499	1	1	1020	9	4	1030	dev_hive	all - database, table	Policy Resources	\N	{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
121	2024-02-08 17:01:50.495	2024-02-08 17:01:50.499	1	1	1020	9	4	1030	dev_hive	all - database, table	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}]	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
122	2024-02-08 17:01:50.496	2024-02-08 17:01:50.5	1	1	1020	9	4	1030	dev_hive	all - database, table	Validity Schedules	\N	[]	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
123	2024-02-08 17:01:50.497	2024-02-08 17:01:50.5	1	1	1020	9	4	1030	dev_hive	all - database, table	Policy Labels	\N	[]	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
124	2024-02-08 17:01:50.497	2024-02-08 17:01:50.5	1	1	1020	9	4	1030	dev_hive	all - database, table	Deny All Other Accesses	\N	false	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
125	2024-02-08 17:01:50.497	2024-02-08 17:01:50.501	1	1	1020	9	4	1030	dev_hive	all - database, table	Policy Status	\N	true	-3682782673637651836	create	2	-3682782673637651836	Spring Authenticated Session
126	2024-02-08 17:01:50.516	2024-02-08 17:01:50.52	1	1	1020	10	4	1030	dev_hive	all - database, udf	Policy Name	\N	all - database, udf	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
127	2024-02-08 17:01:50.516	2024-02-08 17:01:50.521	1	1	1020	10	4	1030	dev_hive	all - database, udf	Priority	\N	0	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
128	2024-02-08 17:01:50.517	2024-02-08 17:01:50.522	1	1	1020	10	4	1030	dev_hive	all - database, udf	Policy Description	\N	Policy for all - database, udf	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
129	2024-02-08 17:01:50.517	2024-02-08 17:01:50.522	1	1	1020	10	4	1030	dev_hive	all - database, udf	Audit Status	\N	true	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
130	2024-02-08 17:01:50.517	2024-02-08 17:01:50.523	1	1	1020	10	4	1030	dev_hive	all - database, udf	Policy Resources	\N	{"database":{"values":["*"],"isExcludes":false,"isRecursive":false},"udf":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
131	2024-02-08 17:01:50.518	2024-02-08 17:01:50.523	1	1	1020	10	4	1030	dev_hive	all - database, udf	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"all","isAllowed":true}],"users":["{OWNER}"],"delegateAdmin":true}]	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
132	2024-02-08 17:01:50.519	2024-02-08 17:01:50.523	1	1	1020	10	4	1030	dev_hive	all - database, udf	Validity Schedules	\N	[]	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
133	2024-02-08 17:01:50.519	2024-02-08 17:01:50.524	1	1	1020	10	4	1030	dev_hive	all - database, udf	Policy Labels	\N	[]	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
134	2024-02-08 17:01:50.52	2024-02-08 17:01:50.524	1	1	1020	10	4	1030	dev_hive	all - database, udf	Deny All Other Accesses	\N	false	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
135	2024-02-08 17:01:50.52	2024-02-08 17:01:50.525	1	1	1020	10	4	1030	dev_hive	all - database, udf	Policy Status	\N	true	-1040839142453918779	create	2	-1040839142453918779	Spring Authenticated Session
136	2024-02-08 17:01:50.54	2024-02-08 17:01:50.544	1	1	1020	11	4	1030	dev_hive	all - url	Policy Name	\N	all - url	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
137	2024-02-08 17:01:50.541	2024-02-08 17:01:50.544	1	1	1020	11	4	1030	dev_hive	all - url	Priority	\N	0	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
138	2024-02-08 17:01:50.541	2024-02-08 17:01:50.545	1	1	1020	11	4	1030	dev_hive	all - url	Policy Description	\N	Policy for all - url	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
139	2024-02-08 17:01:50.541	2024-02-08 17:01:50.545	1	1	1020	11	4	1030	dev_hive	all - url	Audit Status	\N	true	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
140	2024-02-08 17:01:50.541	2024-02-08 17:01:50.545	1	1	1020	11	4	1030	dev_hive	all - url	Policy Resources	\N	{"url":{"values":["*"],"isExcludes":false,"isRecursive":true}}	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
141	2024-02-08 17:01:50.542	2024-02-08 17:01:50.546	1	1	1020	11	4	1030	dev_hive	all - url	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true},{"type":"update","isAllowed":true},{"type":"create","isAllowed":true},{"type":"drop","isAllowed":true},{"type":"alter","isAllowed":true},{"type":"index","isAllowed":true},{"type":"lock","isAllowed":true},{"type":"all","isAllowed":true},{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"repladmin","isAllowed":true},{"type":"serviceadmin","isAllowed":true},{"type":"tempudfadmin","isAllowed":true},{"type":"refresh","isAllowed":true}],"users":["hive"],"delegateAdmin":true}]	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
142	2024-02-08 17:01:50.543	2024-02-08 17:01:50.546	1	1	1020	11	4	1030	dev_hive	all - url	Validity Schedules	\N	[]	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
143	2024-02-08 17:01:50.543	2024-02-08 17:01:50.546	1	1	1020	11	4	1030	dev_hive	all - url	Policy Labels	\N	[]	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
144	2024-02-08 17:01:50.543	2024-02-08 17:01:50.547	1	1	1020	11	4	1030	dev_hive	all - url	Deny All Other Accesses	\N	false	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
145	2024-02-08 17:01:50.544	2024-02-08 17:01:50.547	1	1	1020	11	4	1030	dev_hive	all - url	Policy Status	\N	true	-8555748452556584460	create	2	-8555748452556584460	Spring Authenticated Session
146	2024-02-08 17:01:50.558	2024-02-08 17:01:50.562	1	1	1020	12	4	1030	dev_hive	default database tables columns	Policy Name	\N	default database tables columns	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
147	2024-02-08 17:01:50.559	2024-02-08 17:01:50.562	1	1	1020	12	4	1030	dev_hive	default database tables columns	Priority	\N	0	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
148	2024-02-08 17:01:50.559	2024-02-08 17:01:50.562	1	1	1020	12	4	1030	dev_hive	default database tables columns	Policy Description	\N	null	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
149	2024-02-08 17:01:50.559	2024-02-08 17:01:50.563	1	1	1020	12	4	1030	dev_hive	default database tables columns	Audit Status	\N	true	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
150	2024-02-08 17:01:50.559	2024-02-08 17:01:50.563	1	1	1020	12	4	1030	dev_hive	default database tables columns	Policy Resources	\N	{"database":{"values":["default"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}}	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
151	2024-02-08 17:01:50.56	2024-02-08 17:01:50.564	1	1	1020	12	4	1030	dev_hive	default database tables columns	Policy Items	\N	[{"accesses":[{"type":"create","isAllowed":true}],"groups":["public"],"delegateAdmin":false}]	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
152	2024-02-08 17:01:50.561	2024-02-08 17:01:50.564	1	1	1020	12	4	1030	dev_hive	default database tables columns	Validity Schedules	\N	[]	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
153	2024-02-08 17:01:50.561	2024-02-08 17:01:50.564	1	1	1020	12	4	1030	dev_hive	default database tables columns	Policy Labels	\N	[]	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
154	2024-02-08 17:01:50.561	2024-02-08 17:01:50.565	1	1	1020	12	4	1030	dev_hive	default database tables columns	Deny All Other Accesses	\N	false	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
155	2024-02-08 17:01:50.561	2024-02-08 17:01:50.565	1	1	1020	12	4	1030	dev_hive	default database tables columns	Policy Status	\N	true	8022694302091724097	create	2	8022694302091724097	Spring Authenticated Session
156	2024-02-08 17:01:50.577	2024-02-08 17:01:50.581	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Policy Name	\N	Information_schema database tables columns	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
157	2024-02-08 17:01:50.578	2024-02-08 17:01:50.582	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Priority	\N	0	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
158	2024-02-08 17:01:50.578	2024-02-08 17:01:50.582	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Policy Description	\N	null	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
159	2024-02-08 17:01:50.578	2024-02-08 17:01:50.583	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Audit Status	\N	true	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
160	2024-02-08 17:01:50.578	2024-02-08 17:01:50.583	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Policy Resources	\N	{"database":{"values":["information_schema"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
161	2024-02-08 17:01:50.579	2024-02-08 17:01:50.584	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Policy Items	\N	[{"accesses":[{"type":"select","isAllowed":true}],"groups":["public"],"delegateAdmin":false}]	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
162	2024-02-08 17:01:50.58	2024-02-08 17:01:50.584	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Validity Schedules	\N	[]	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
163	2024-02-08 17:01:50.58	2024-02-08 17:01:50.584	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Policy Labels	\N	[]	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
164	2024-02-08 17:01:50.581	2024-02-08 17:01:50.585	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Deny All Other Accesses	\N	false	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
165	2024-02-08 17:01:50.581	2024-02-08 17:01:50.585	1	1	1020	13	4	1030	dev_hive	Information_schema database tables columns	Policy Status	\N	true	-4464608201672538850	create	2	-4464608201672538850	Spring Authenticated Session
166	2024-02-08 17:01:50.592	2024-02-08 17:01:50.593	1	1	1003	10	\N	0	\N	hive	Login ID	\N	hive	-2989366566346538473	create	2	-2989366566346538473	Spring Authenticated Session
167	2024-02-08 17:01:50.592	2024-02-08 17:01:50.593	1	1	1003	10	\N	0	\N	hive	User Role	\N	[ROLE_USER]	-2989366566346538473	create	2	-2989366566346538473	Spring Authenticated Session
168	2024-02-08 17:01:50.695	2024-02-08 17:01:50.696	1	1	1030	5	2	1033	hbase	dev_hbase	Service Name	\N	dev_hbase	-1416831849536991285	create	2	-1416831849536991285	Spring Authenticated Session
169	2024-02-08 17:01:50.695	2024-02-08 17:01:50.696	1	1	1030	5	2	1033	hbase	dev_hbase	Service Display Name	\N	dev_hbase	-1416831849536991285	create	2	-1416831849536991285	Spring Authenticated Session
170	2024-02-08 17:01:50.695	2024-02-08 17:01:50.696	1	1	1030	5	2	1033	hbase	dev_hbase	Service Description	\N	null	-1416831849536991285	create	2	-1416831849536991285	Spring Authenticated Session
171	2024-02-08 17:01:50.695	2024-02-08 17:01:50.696	1	1	1030	5	2	1033	hbase	dev_hbase	Tag Service Name	\N	dev_tag	-1416831849536991285	create	2	-1416831849536991285	Spring Authenticated Session
172	2024-02-08 17:01:50.695	2024-02-08 17:01:50.697	1	1	1030	5	2	1033	hbase	dev_hbase	Connection Configurations	\N	{"hbase.zookeeper.quorum":"ranger-zk","password":"*****","hadoop.security.authentication":"simple","hbase.security.authentication":"simple","hadoop.security.authorization":"true","hbase.zookeeper.property.clientPort":"2181","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'table':{'values':['*-ROOT-*','*.META.*', '*_acl_*', 'hbase:meta', 'hbase:acl', 'default', 'hbase']}}, 'users':['hbase'], 'isAudited': false }, {'resources':{'table':{'values':['atlas_janus','ATLAS_ENTITY_AUDIT_EVENTS']},'column-family':{'values':['*']},'column':{'values':['*']}},'users':['atlas', 'hbase'],'isAudited':false},{'users':['hbase'], 'actions':['balance'],'isAudited':false}]","zookeeper.znode.parent":"/hbase","username":"hbase"}	-1416831849536991285	create	2	-1416831849536991285	Spring Authenticated Session
173	2024-02-08 17:01:50.695	2024-02-08 17:01:50.697	1	1	1030	5	2	1033	hbase	dev_hbase	Service Status	\N	true	-1416831849536991285	create	2	-1416831849536991285	Spring Authenticated Session
174	2024-02-08 17:01:50.718	2024-02-08 17:01:50.721	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Policy Name	\N	all - table, column-family, column	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
175	2024-02-08 17:01:50.718	2024-02-08 17:01:50.721	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Priority	\N	0	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
176	2024-02-08 17:01:50.718	2024-02-08 17:01:50.721	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Policy Description	\N	Policy for all - table, column-family, column	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
177	2024-02-08 17:01:50.718	2024-02-08 17:01:50.722	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Audit Status	\N	true	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
178	2024-02-08 17:01:50.718	2024-02-08 17:01:50.722	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Policy Resources	\N	{"column-family":{"values":["*"],"isExcludes":false,"isRecursive":false},"column":{"values":["*"],"isExcludes":false,"isRecursive":false},"table":{"values":["*"],"isExcludes":false,"isRecursive":false}}	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
179	2024-02-08 17:01:50.719	2024-02-08 17:01:50.722	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"create","isAllowed":true},{"type":"admin","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"delegateAdmin":true}]	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
180	2024-02-08 17:01:50.72	2024-02-08 17:01:50.723	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Validity Schedules	\N	[]	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
181	2024-02-08 17:01:50.72	2024-02-08 17:01:50.723	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Policy Labels	\N	[]	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
182	2024-02-08 17:01:50.72	2024-02-08 17:01:50.723	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Deny All Other Accesses	\N	false	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
183	2024-02-08 17:01:50.72	2024-02-08 17:01:50.724	1	1	1020	14	5	1030	dev_hbase	all - table, column-family, column	Policy Status	\N	true	106069503466163237	create	2	106069503466163237	Spring Authenticated Session
184	2024-02-08 17:01:50.759	2024-02-08 17:01:50.76	1	1	1030	6	9	1033	kafka	dev_kafka	Service Name	\N	dev_kafka	-8852016880665475247	create	2	-8852016880665475247	Spring Authenticated Session
185	2024-02-08 17:01:50.759	2024-02-08 17:01:50.76	1	1	1030	6	9	1033	kafka	dev_kafka	Service Display Name	\N	dev_kafka	-8852016880665475247	create	2	-8852016880665475247	Spring Authenticated Session
186	2024-02-08 17:01:50.759	2024-02-08 17:01:50.76	1	1	1030	6	9	1033	kafka	dev_kafka	Service Description	\N	null	-8852016880665475247	create	2	-8852016880665475247	Spring Authenticated Session
187	2024-02-08 17:01:50.759	2024-02-08 17:01:50.76	1	1	1030	6	9	1033	kafka	dev_kafka	Tag Service Name	\N	dev_tag	-8852016880665475247	create	2	-8852016880665475247	Spring Authenticated Session
188	2024-02-08 17:01:50.759	2024-02-08 17:01:50.761	1	1	1030	6	9	1033	kafka	dev_kafka	Connection Configurations	\N	{"password":"*****","zookeeper.connect":"ranger-zk.example.com:2181","ranger.plugin.audit.filters":"[{'accessResult': 'DENIED', 'isAudited': true},{'resources':{'topic':{'values':['ATLAS_ENTITIES','ATLAS_HOOK','ATLAS_SPARK_HOOK']}},'users':['atlas'],'actions':['describe','publish','consume'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_HOOK']}},'users':['hive','hbase','impala','nifi'],'actions':['publish','describe'],'isAudited':false},{'resources':{'topic':{'values':['ATLAS_ENTITIES']}},'users':['rangertagsync'],'actions':['consume','describe'],'isAudited':false},{'resources':{'consumergroup':{'values':['*']}},'users':['atlas','rangertagsync'],'actions':['consume'],'isAudited':false},{'users':['kafka'],'isAudited':false}]","username":"kafka"}	-8852016880665475247	create	2	-8852016880665475247	Spring Authenticated Session
189	2024-02-08 17:01:50.759	2024-02-08 17:01:50.761	1	1	1030	6	9	1033	kafka	dev_kafka	Service Status	\N	true	-8852016880665475247	create	2	-8852016880665475247	Spring Authenticated Session
190	2024-02-08 17:01:50.777	2024-02-08 17:01:50.78	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Policy Name	\N	all - consumergroup	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
191	2024-02-08 17:01:50.777	2024-02-08 17:01:50.78	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Priority	\N	0	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
192	2024-02-08 17:01:50.777	2024-02-08 17:01:50.78	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Policy Description	\N	Policy for all - consumergroup	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
193	2024-02-08 17:01:50.777	2024-02-08 17:01:50.78	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Audit Status	\N	true	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
194	2024-02-08 17:01:50.777	2024-02-08 17:01:50.781	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Policy Resources	\N	{"consumergroup":{"values":["*"],"isExcludes":false,"isRecursive":false}}	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
195	2024-02-08 17:01:50.778	2024-02-08 17:01:50.781	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Policy Items	\N	[{"accesses":[{"type":"consume","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"delete","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}]	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
196	2024-02-08 17:01:50.779	2024-02-08 17:01:50.781	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Validity Schedules	\N	[]	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
197	2024-02-08 17:01:50.779	2024-02-08 17:01:50.781	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Policy Labels	\N	[]	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
198	2024-02-08 17:01:50.779	2024-02-08 17:01:50.782	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Deny All Other Accesses	\N	false	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
199	2024-02-08 17:01:50.779	2024-02-08 17:01:50.782	1	1	1020	15	6	1030	dev_kafka	all - consumergroup	Policy Status	\N	true	5160107022149371335	create	2	5160107022149371335	Spring Authenticated Session
200	2024-02-08 17:01:50.792	2024-02-08 17:01:50.794	1	1	1020	16	6	1030	dev_kafka	all - topic	Policy Name	\N	all - topic	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
201	2024-02-08 17:01:50.792	2024-02-08 17:01:50.794	1	1	1020	16	6	1030	dev_kafka	all - topic	Priority	\N	0	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
202	2024-02-08 17:01:50.792	2024-02-08 17:01:50.795	1	1	1020	16	6	1030	dev_kafka	all - topic	Policy Description	\N	Policy for all - topic	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
203	2024-02-08 17:01:50.792	2024-02-08 17:01:50.795	1	1	1020	16	6	1030	dev_kafka	all - topic	Audit Status	\N	true	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
204	2024-02-08 17:01:50.793	2024-02-08 17:01:50.795	1	1	1020	16	6	1030	dev_kafka	all - topic	Policy Resources	\N	{"topic":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
205	2024-02-08 17:01:50.793	2024-02-08 17:01:50.795	1	1	1020	16	6	1030	dev_kafka	all - topic	Policy Items	\N	[{"accesses":[{"type":"publish","isAllowed":true},{"type":"consume","isAllowed":true},{"type":"configure","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"create","isAllowed":true},{"type":"delete","isAllowed":true},{"type":"describe_configs","isAllowed":true},{"type":"alter_configs","isAllowed":true},{"type":"alter","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}]	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
206	2024-02-08 17:01:50.793	2024-02-08 17:01:50.795	1	1	1020	16	6	1030	dev_kafka	all - topic	Validity Schedules	\N	[]	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
207	2024-02-08 17:01:50.794	2024-02-08 17:01:50.796	1	1	1020	16	6	1030	dev_kafka	all - topic	Policy Labels	\N	[]	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
208	2024-02-08 17:01:50.794	2024-02-08 17:01:50.796	1	1	1020	16	6	1030	dev_kafka	all - topic	Deny All Other Accesses	\N	false	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
209	2024-02-08 17:01:50.794	2024-02-08 17:01:50.796	1	1	1020	16	6	1030	dev_kafka	all - topic	Policy Status	\N	true	-1375621017259389511	create	2	-1375621017259389511	Spring Authenticated Session
210	2024-02-08 17:01:50.804	2024-02-08 17:01:50.807	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Policy Name	\N	all - transactionalid	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
211	2024-02-08 17:01:50.805	2024-02-08 17:01:50.808	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Priority	\N	0	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
212	2024-02-08 17:01:50.805	2024-02-08 17:01:50.808	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Policy Description	\N	Policy for all - transactionalid	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
213	2024-02-08 17:01:50.805	2024-02-08 17:01:50.808	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Audit Status	\N	true	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
214	2024-02-08 17:01:50.805	2024-02-08 17:01:50.809	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Policy Resources	\N	{"transactionalid":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
215	2024-02-08 17:01:50.806	2024-02-08 17:01:50.809	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Policy Items	\N	[{"accesses":[{"type":"publish","isAllowed":true},{"type":"describe","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}]	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
216	2024-02-08 17:01:50.806	2024-02-08 17:01:50.809	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Validity Schedules	\N	[]	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
217	2024-02-08 17:01:50.807	2024-02-08 17:01:50.81	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Policy Labels	\N	[]	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
218	2024-02-08 17:01:50.807	2024-02-08 17:01:50.81	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Deny All Other Accesses	\N	false	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
219	2024-02-08 17:01:50.807	2024-02-08 17:01:50.81	1	1	1020	17	6	1030	dev_kafka	all - transactionalid	Policy Status	\N	true	-4817155438789115390	create	2	-4817155438789115390	Spring Authenticated Session
220	2024-02-08 17:01:50.82	2024-02-08 17:01:50.823	1	1	1020	18	6	1030	dev_kafka	all - cluster	Policy Name	\N	all - cluster	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
221	2024-02-08 17:01:50.821	2024-02-08 17:01:50.823	1	1	1020	18	6	1030	dev_kafka	all - cluster	Priority	\N	0	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
222	2024-02-08 17:01:50.821	2024-02-08 17:01:50.824	1	1	1020	18	6	1030	dev_kafka	all - cluster	Policy Description	\N	Policy for all - cluster	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
223	2024-02-08 17:01:50.821	2024-02-08 17:01:50.824	1	1	1020	18	6	1030	dev_kafka	all - cluster	Audit Status	\N	true	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
224	2024-02-08 17:01:50.821	2024-02-08 17:01:50.824	1	1	1020	18	6	1030	dev_kafka	all - cluster	Policy Resources	\N	{"cluster":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
225	2024-02-08 17:01:50.821	2024-02-08 17:01:50.824	1	1	1020	18	6	1030	dev_kafka	all - cluster	Policy Items	\N	[{"accesses":[{"type":"configure","isAllowed":true},{"type":"describe","isAllowed":true},{"type":"kafka_admin","isAllowed":true},{"type":"create","isAllowed":true},{"type":"idempotent_write","isAllowed":true},{"type":"describe_configs","isAllowed":true},{"type":"alter_configs","isAllowed":true},{"type":"cluster_action","isAllowed":true},{"type":"alter","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}]	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
226	2024-02-08 17:01:50.822	2024-02-08 17:01:50.825	1	1	1020	18	6	1030	dev_kafka	all - cluster	Validity Schedules	\N	[]	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
227	2024-02-08 17:01:50.822	2024-02-08 17:01:50.825	1	1	1020	18	6	1030	dev_kafka	all - cluster	Policy Labels	\N	[]	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
228	2024-02-08 17:01:50.823	2024-02-08 17:01:50.825	1	1	1020	18	6	1030	dev_kafka	all - cluster	Deny All Other Accesses	\N	false	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
229	2024-02-08 17:01:50.823	2024-02-08 17:01:50.826	1	1	1020	18	6	1030	dev_kafka	all - cluster	Policy Status	\N	true	-4840811953248842649	create	2	-4840811953248842649	Spring Authenticated Session
230	2024-02-08 17:01:50.834	2024-02-08 17:01:50.837	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Policy Name	\N	all - delegationtoken	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
231	2024-02-08 17:01:50.834	2024-02-08 17:01:50.837	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Priority	\N	0	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
232	2024-02-08 17:01:50.835	2024-02-08 17:01:50.838	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Policy Description	\N	Policy for all - delegationtoken	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
233	2024-02-08 17:01:50.835	2024-02-08 17:01:50.838	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Audit Status	\N	true	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
234	2024-02-08 17:01:50.835	2024-02-08 17:01:50.838	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Policy Resources	\N	{"delegationtoken":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
235	2024-02-08 17:01:50.835	2024-02-08 17:01:50.839	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Policy Items	\N	[{"accesses":[{"type":"describe","isAllowed":true}],"users":["kafka"],"groups":["public"],"delegateAdmin":true}]	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
236	2024-02-08 17:01:50.836	2024-02-08 17:01:50.839	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Validity Schedules	\N	[]	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
237	2024-02-08 17:01:50.836	2024-02-08 17:01:50.839	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Policy Labels	\N	[]	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
238	2024-02-08 17:01:50.837	2024-02-08 17:01:50.839	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Deny All Other Accesses	\N	false	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
239	2024-02-08 17:01:50.837	2024-02-08 17:01:50.84	1	1	1020	19	6	1030	dev_kafka	all - delegationtoken	Policy Status	\N	true	-4046941297815762871	create	2	-4046941297815762871	Spring Authenticated Session
240	2024-02-08 17:01:50.848	2024-02-08 17:01:50.848	1	1	1003	11	\N	0	\N	kafka	Login ID	\N	kafka	-2603548348325215484	create	2	-2603548348325215484	Spring Authenticated Session
241	2024-02-08 17:01:50.848	2024-02-08 17:01:50.848	1	1	1003	11	\N	0	\N	kafka	User Role	\N	[ROLE_USER]	-2603548348325215484	create	2	-2603548348325215484	Spring Authenticated Session
242	2024-02-08 17:01:50.935	2024-02-08 17:01:50.935	1	1	1030	7	5	1033	knox	dev_knox	Service Name	\N	dev_knox	-5499347513641318151	create	2	-5499347513641318151	Spring Authenticated Session
243	2024-02-08 17:01:50.935	2024-02-08 17:01:50.936	1	1	1030	7	5	1033	knox	dev_knox	Service Display Name	\N	dev_knox	-5499347513641318151	create	2	-5499347513641318151	Spring Authenticated Session
244	2024-02-08 17:01:50.935	2024-02-08 17:01:50.936	1	1	1030	7	5	1033	knox	dev_knox	Service Description	\N	null	-5499347513641318151	create	2	-5499347513641318151	Spring Authenticated Session
245	2024-02-08 17:01:50.935	2024-02-08 17:01:50.936	1	1	1030	7	5	1033	knox	dev_knox	Tag Service Name	\N	dev_tag	-5499347513641318151	create	2	-5499347513641318151	Spring Authenticated Session
246	2024-02-08 17:01:50.935	2024-02-08 17:01:50.936	1	1	1030	7	5	1033	knox	dev_knox	Connection Configurations	\N	{"password":"*****","ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['knox'] ,'isAudited':false} ]","knox.url":"https://ranger-knox:8443","username":"knox"}	-5499347513641318151	create	2	-5499347513641318151	Spring Authenticated Session
247	2024-02-08 17:01:50.935	2024-02-08 17:01:50.937	1	1	1030	7	5	1033	knox	dev_knox	Service Status	\N	true	-5499347513641318151	create	2	-5499347513641318151	Spring Authenticated Session
248	2024-02-08 17:01:50.949	2024-02-08 17:01:50.951	1	1	1020	20	7	1030	dev_knox	all - topology, service	Policy Name	\N	all - topology, service	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
249	2024-02-08 17:01:50.949	2024-02-08 17:01:50.951	1	1	1020	20	7	1030	dev_knox	all - topology, service	Priority	\N	0	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
250	2024-02-08 17:01:50.949	2024-02-08 17:01:50.951	1	1	1020	20	7	1030	dev_knox	all - topology, service	Policy Description	\N	Policy for all - topology, service	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
251	2024-02-08 17:01:50.949	2024-02-08 17:01:50.952	1	1	1020	20	7	1030	dev_knox	all - topology, service	Audit Status	\N	true	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
252	2024-02-08 17:01:50.949	2024-02-08 17:01:50.952	1	1	1020	20	7	1030	dev_knox	all - topology, service	Policy Resources	\N	{"topology":{"values":["*"],"isExcludes":false,"isRecursive":false},"service":{"values":["*"],"isExcludes":false,"isRecursive":false}}	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
310	2024-02-08 17:51:48.069	2024-02-08 17:51:48.074	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Policy Labels	\N	[]	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
253	2024-02-08 17:01:50.95	2024-02-08 17:01:50.952	1	1	1020	20	7	1030	dev_knox	all - topology, service	Policy Items	\N	[{"accesses":[{"type":"allow","isAllowed":true}],"users":["knox"],"delegateAdmin":true}]	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
254	2024-02-08 17:01:50.95	2024-02-08 17:01:50.952	1	1	1020	20	7	1030	dev_knox	all - topology, service	Validity Schedules	\N	[]	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
255	2024-02-08 17:01:50.95	2024-02-08 17:01:50.952	1	1	1020	20	7	1030	dev_knox	all - topology, service	Policy Labels	\N	[]	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
256	2024-02-08 17:01:50.951	2024-02-08 17:01:50.953	1	1	1020	20	7	1030	dev_knox	all - topology, service	Deny All Other Accesses	\N	false	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
257	2024-02-08 17:01:50.951	2024-02-08 17:01:50.953	1	1	1020	20	7	1030	dev_knox	all - topology, service	Policy Status	\N	true	-4060092483225698197	create	2	-4060092483225698197	Spring Authenticated Session
258	2024-02-08 17:01:50.961	2024-02-08 17:01:50.961	1	1	1003	12	\N	0	\N	knox	Login ID	\N	knox	6018754902095054620	create	2	6018754902095054620	Spring Authenticated Session
259	2024-02-08 17:01:50.961	2024-02-08 17:01:50.961	1	1	1003	12	\N	0	\N	knox	User Role	\N	[ROLE_USER]	6018754902095054620	create	2	6018754902095054620	Spring Authenticated Session
260	2024-02-08 17:01:51.001	2024-02-08 17:01:51.001	1	1	1030	8	7	1033	kms	dev_kms	Service Name	\N	dev_kms	-4967994786657843978	create	2	-4967994786657843978	Spring Authenticated Session
261	2024-02-08 17:01:51.001	2024-02-08 17:01:51.002	1	1	1030	8	7	1033	kms	dev_kms	Service Display Name	\N	dev_kms	-4967994786657843978	create	2	-4967994786657843978	Spring Authenticated Session
262	2024-02-08 17:01:51.001	2024-02-08 17:01:51.002	1	1	1030	8	7	1033	kms	dev_kms	Service Description	\N	null	-4967994786657843978	create	2	-4967994786657843978	Spring Authenticated Session
263	2024-02-08 17:01:51.001	2024-02-08 17:01:51.002	1	1	1030	8	7	1033	kms	dev_kms	Tag Service Name	\N	null	-4967994786657843978	create	2	-4967994786657843978	Spring Authenticated Session
264	2024-02-08 17:01:51.001	2024-02-08 17:01:51.002	1	1	1030	8	7	1033	kms	dev_kms	Connection Configurations	\N	{"password":"*****","provider":"http://ranger-kms:9292","ranger.plugin.audit.filters":"[ {'accessResult': 'DENIED', 'isAudited': true}, {'users':['keyadmin'] ,'isAudited':false} ]","username":"keyadmin"}	-4967994786657843978	create	2	-4967994786657843978	Spring Authenticated Session
265	2024-02-08 17:01:51.001	2024-02-08 17:01:51.002	1	1	1030	8	7	1033	kms	dev_kms	Service Status	\N	true	-4967994786657843978	create	2	-4967994786657843978	Spring Authenticated Session
266	2024-02-08 17:01:51.024	2024-02-08 17:01:51.028	1	1	1020	21	8	1030	dev_kms	all - keyname	Policy Name	\N	all - keyname	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
267	2024-02-08 17:01:51.024	2024-02-08 17:01:51.028	1	1	1020	21	8	1030	dev_kms	all - keyname	Priority	\N	0	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
268	2024-02-08 17:01:51.025	2024-02-08 17:01:51.028	1	1	1020	21	8	1030	dev_kms	all - keyname	Policy Description	\N	Policy for all - keyname	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
269	2024-02-08 17:01:51.025	2024-02-08 17:01:51.029	1	1	1020	21	8	1030	dev_kms	all - keyname	Audit Status	\N	true	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
270	2024-02-08 17:01:51.025	2024-02-08 17:01:51.029	1	1	1020	21	8	1030	dev_kms	all - keyname	Policy Resources	\N	{"keyname":{"values":["*"],"isExcludes":false,"isRecursive":false}}	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
271	2024-02-08 17:01:51.026	2024-02-08 17:01:51.029	1	1	1020	21	8	1030	dev_kms	all - keyname	Policy Items	\N	[{"accesses":[{"type":"create","isAllowed":true},{"type":"delete","isAllowed":true},{"type":"rollover","isAllowed":true},{"type":"setkeymaterial","isAllowed":true},{"type":"get","isAllowed":true},{"type":"getkeys","isAllowed":true},{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true},{"type":"decrypteek","isAllowed":true}],"users":["keyadmin"],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true}],"users":["hdfs"],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"generateeek","isAllowed":true}],"users":["om"],"delegateAdmin":true},{"accesses":[{"type":"getmetadata","isAllowed":true},{"type":"decrypteek","isAllowed":true}],"users":["hive"],"delegateAdmin":true},{"accesses":[{"type":"decrypteek","isAllowed":true}],"users":["hbase"],"delegateAdmin":true}]	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
272	2024-02-08 17:01:51.027	2024-02-08 17:01:51.03	1	1	1020	21	8	1030	dev_kms	all - keyname	Validity Schedules	\N	[]	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
273	2024-02-08 17:01:51.027	2024-02-08 17:01:51.03	1	1	1020	21	8	1030	dev_kms	all - keyname	Policy Labels	\N	[]	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
274	2024-02-08 17:01:51.027	2024-02-08 17:01:51.03	1	1	1020	21	8	1030	dev_kms	all - keyname	Deny All Other Accesses	\N	false	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
275	2024-02-08 17:01:51.027	2024-02-08 17:01:51.03	1	1	1020	21	8	1030	dev_kms	all - keyname	Policy Status	\N	true	854482113671676143	create	2	854482113671676143	Spring Authenticated Session
276	2024-02-08 17:01:51.038	2024-02-08 17:01:51.038	1	1	1003	13	\N	0	\N	om	Login ID	\N	om	-8094297249300460961	create	2	-8094297249300460961	Spring Authenticated Session
277	2024-02-08 17:01:51.038	2024-02-08 17:01:51.039	1	1	1003	13	\N	0	\N	om	User Role	\N	[ROLE_USER]	-8094297249300460961	create	2	-8094297249300460961	Spring Authenticated Session
278	2024-02-08 17:51:47.935	2024-02-08 17:51:47.938	1	1	1030	9	1	1033	hdfs	hadoopdev	Service Name	\N	hadoopdev	-6207639662533590796	create	4	-6207639662533590796	Spring Authenticated Session
279	2024-02-08 17:51:47.936	2024-02-08 17:51:47.941	1	1	1030	9	1	1033	hdfs	hadoopdev	Service Display Name	\N	hadoopdev	-6207639662533590796	create	4	-6207639662533590796	Spring Authenticated Session
280	2024-02-08 17:51:47.936	2024-02-08 17:51:47.941	1	1	1030	9	1	1033	hdfs	hadoopdev	Tag Service Name	\N	null	-6207639662533590796	create	4	-6207639662533590796	Spring Authenticated Session
308	2024-02-08 17:51:48.067	2024-02-08 17:51:48.073	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hbase"],"delegateAdmin":false}]	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
281	2024-02-08 17:51:47.936	2024-02-08 17:51:47.942	1	1	1030	9	1	1033	hdfs	hadoopdev	Connection Configurations	\N	{"password":"*****","hadoop.security.authentication":"simple","hadoop.rpc.protection":"authentication","fs.default.name":"http://localhost:8020","hadoop.security.authorization":"true","ranger.plugin.audit.filters":"[{'accessResult':'DENIED','isAudited':true},{'actions':['delete','rename'],'isAudited':true},{'users':['hdfs'],'actions':['listStatus','getfileinfo','listCachePools','listCacheDirectives','listCorruptFileBlocks','monitorHealth','rollEditLog','open'],'isAudited':false},{'users':['oozie'],'resources':{'path':{'values':['/user/oozie/share/lib'],'isRecursive':true}},'isAudited':false},{'users':['spark'],'resources':{'path':{'values':['/user/spark/applicationHistory'],'isRecursive':true}},'isAudited':false},{'users':['hue'],'resources':{'path':{'values':['/user/hue'],'isRecursive':true}},'isAudited':false},{'users':['hbase'],'resources':{'path':{'values':['/hbase'],'isRecursive':true}},'isAudited':false},{'users':['mapred'],'resources':{'path':{'values':['/user/history'],'isRecursive':true}},'isAudited':false},{'actions':['getfileinfo'],'isAudited':false}]","username":"hadoop"}	-6207639662533590796	create	4	-6207639662533590796	Spring Authenticated Session
282	2024-02-08 17:51:47.937	2024-02-08 17:51:47.943	1	1	1030	9	1	1033	hdfs	hadoopdev	Service Status	\N	true	-6207639662533590796	create	4	-6207639662533590796	Spring Authenticated Session
283	2024-02-08 17:51:48.002	2024-02-08 17:51:48.008	1	1	1020	22	9	1030	hadoopdev	all - path	Policy Name	\N	all - path	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
284	2024-02-08 17:51:48.003	2024-02-08 17:51:48.008	1	1	1020	22	9	1030	hadoopdev	all - path	Priority	\N	0	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
285	2024-02-08 17:51:48.003	2024-02-08 17:51:48.009	1	1	1020	22	9	1030	hadoopdev	all - path	Policy Description	\N	Policy for all - path	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
286	2024-02-08 17:51:48.003	2024-02-08 17:51:48.01	1	1	1020	22	9	1030	hadoopdev	all - path	Audit Status	\N	true	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
287	2024-02-08 17:51:48.003	2024-02-08 17:51:48.01	1	1	1020	22	9	1030	hadoopdev	all - path	Policy Resources	\N	{"path":{"values":["/*"],"isExcludes":false,"isRecursive":true}}	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
288	2024-02-08 17:51:48.005	2024-02-08 17:51:48.011	1	1	1020	22	9	1030	hadoopdev	all - path	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["hadoop"],"delegateAdmin":true}]	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
289	2024-02-08 17:51:48.006	2024-02-08 17:51:48.012	1	1	1020	22	9	1030	hadoopdev	all - path	Validity Schedules	\N	[]	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
290	2024-02-08 17:51:48.007	2024-02-08 17:51:48.013	1	1	1020	22	9	1030	hadoopdev	all - path	Policy Labels	\N	[]	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
291	2024-02-08 17:51:48.007	2024-02-08 17:51:48.014	1	1	1020	22	9	1030	hadoopdev	all - path	Deny All Other Accesses	\N	false	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
292	2024-02-08 17:51:48.007	2024-02-08 17:51:48.014	1	1	1020	22	9	1030	hadoopdev	all - path	Policy Status	\N	true	6181440110186548268	create	4	6181440110186548268	Spring Authenticated Session
293	2024-02-08 17:51:48.036	2024-02-08 17:51:48.04	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Policy Name	\N	kms-audit-path	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
294	2024-02-08 17:51:48.036	2024-02-08 17:51:48.041	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Priority	\N	0	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
295	2024-02-08 17:51:48.036	2024-02-08 17:51:48.042	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Policy Description	\N	Policy for kms-audit-path	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
296	2024-02-08 17:51:48.037	2024-02-08 17:51:48.042	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Audit Status	\N	true	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
297	2024-02-08 17:51:48.037	2024-02-08 17:51:48.043	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Policy Resources	\N	{"path":{"values":["/ranger/audit/kms"],"isExcludes":false,"isRecursive":true}}	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
298	2024-02-08 17:51:48.037	2024-02-08 17:51:48.043	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Policy Items	\N	[{"accesses":[{"type":"read","isAllowed":true},{"type":"write","isAllowed":true},{"type":"execute","isAllowed":true}],"users":["keyadmin"],"delegateAdmin":false}]	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
299	2024-02-08 17:51:48.039	2024-02-08 17:51:48.044	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Validity Schedules	\N	[]	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
300	2024-02-08 17:51:48.039	2024-02-08 17:51:48.044	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Policy Labels	\N	[]	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
301	2024-02-08 17:51:48.04	2024-02-08 17:51:48.045	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Deny All Other Accesses	\N	false	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
302	2024-02-08 17:51:48.04	2024-02-08 17:51:48.045	1	1	1020	23	9	1030	hadoopdev	kms-audit-path	Policy Status	\N	true	5203557564610203559	create	4	5203557564610203559	Spring Authenticated Session
303	2024-02-08 17:51:48.065	2024-02-08 17:51:48.07	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Policy Name	\N	hbase-archive	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
304	2024-02-08 17:51:48.065	2024-02-08 17:51:48.071	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Priority	\N	0	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
305	2024-02-08 17:51:48.066	2024-02-08 17:51:48.071	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Policy Description	\N	Policy for hbase archive location	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
306	2024-02-08 17:51:48.066	2024-02-08 17:51:48.072	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Audit Status	\N	true	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
307	2024-02-08 17:51:48.066	2024-02-08 17:51:48.072	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Policy Resources	\N	{"path":{"values":["/hbase/archive"],"isExcludes":false,"isRecursive":true}}	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
309	2024-02-08 17:51:48.069	2024-02-08 17:51:48.073	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Validity Schedules	\N	[]	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
311	2024-02-08 17:51:48.069	2024-02-08 17:51:48.075	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Deny All Other Accesses	\N	false	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
312	2024-02-08 17:51:48.07	2024-02-08 17:51:48.075	1	1	1020	24	9	1030	hadoopdev	hbase-archive	Policy Status	\N	true	-6862757058001745770	create	4	-6862757058001745770	Spring Authenticated Session
313	2024-02-08 17:51:48.084	2024-02-08 17:51:48.085	1	1	1003	14	\N	0	\N	hadoop	Login ID	\N	hadoop	5671178381699072370	create	4	5671178381699072370	Spring Authenticated Session
314	2024-02-08 17:51:48.085	2024-02-08 17:51:48.085	1	1	1003	14	\N	0	\N	hadoop	User Role	\N	[ROLE_USER]	5671178381699072370	create	4	5671178381699072370	Spring Authenticated Session
\.


--
-- Data for Name: x_ugsync_audit_info; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_ugsync_audit_info (id, create_time, update_time, added_by_id, upd_by_id, event_time, user_name, sync_source, no_of_new_users, no_of_new_groups, no_of_modified_users, no_of_modified_groups, sync_source_info, session_id) FROM stdin;
\.


--
-- Data for Name: x_user; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_user (id, create_time, update_time, added_by_id, upd_by_id, user_name, descr, status, cred_store_id, is_visible, other_attributes, sync_source) FROM stdin;
1	2024-02-08 17:00:57.472014	2024-02-08 17:00:57.472014	\N	\N	admin	Administrator	0	\N	1	\N	\N
2	2024-02-08 17:00:57.514618	2024-02-08 17:00:57.514618	\N	\N	rangerusersync	rangerusersync	0	\N	1	\N	\N
3	2024-02-08 17:00:57.603325	2024-02-08 17:00:57.603325	\N	\N	keyadmin	keyadmin	0	\N	1	\N	\N
4	2024-02-08 17:00:57.689488	2024-02-08 17:00:57.689488	\N	\N	rangertagsync	rangertagsync	0	\N	1	\N	\N
5	2024-02-08 17:01:13.873	2024-02-08 17:01:13.88	1	1	{USER}	{USER}	0	\N	1	\N	\N
6	2024-02-08 17:01:13.885	2024-02-08 17:01:13.886	1	1	{OWNER}	{OWNER}	0	\N	1	\N	\N
7	2024-02-08 17:01:50.224	2024-02-08 17:01:50.224	1	1	hdfs	hdfs	0	\N	1	\N	\N
8	2024-02-08 17:01:50.248	2024-02-08 17:01:50.248	1	1	hbase	hbase	0	\N	1	\N	\N
9	2024-02-08 17:01:50.351	2024-02-08 17:01:50.352	1	1	yarn	yarn	0	\N	1	\N	\N
10	2024-02-08 17:01:50.591	2024-02-08 17:01:50.591	1	1	hive	hive	0	\N	1	\N	\N
11	2024-02-08 17:01:50.847	2024-02-08 17:01:50.847	1	1	kafka	kafka	0	\N	1	\N	\N
12	2024-02-08 17:01:50.96	2024-02-08 17:01:50.96	1	1	knox	knox	0	\N	1	\N	\N
13	2024-02-08 17:01:51.037	2024-02-08 17:01:51.037	1	1	om	om	0	\N	1	\N	\N
14	2024-02-08 17:51:48.083	2024-02-08 17:51:48.083	1	1	hadoop	hadoop	0	\N	1	\N	\N
\.


--
-- Data for Name: x_user_module_perm; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.x_user_module_perm (id, user_id, module_id, create_time, update_time, added_by_id, upd_by_id, is_allowed) FROM stdin;
1	1	3	2024-02-08 17:00:58.130599	2024-02-08 17:00:58.130599	1	1	1
2	1	1	2024-02-08 17:00:58.144703	2024-02-08 17:00:58.144703	1	1	1
3	1	4	2024-02-08 17:00:58.153775	2024-02-08 17:00:58.153775	1	1	1
4	1	2	2024-02-08 17:00:58.157237	2024-02-08 17:00:58.157237	1	1	1
5	1	6	2024-02-08 17:00:58.168801	2024-02-08 17:00:58.168801	1	1	1
6	2	3	2024-02-08 17:00:58.179335	2024-02-08 17:00:58.179335	1	1	1
7	2	1	2024-02-08 17:00:58.183085	2024-02-08 17:00:58.183085	1	1	1
8	2	4	2024-02-08 17:00:58.189289	2024-02-08 17:00:58.189289	1	1	1
9	2	2	2024-02-08 17:00:58.194877	2024-02-08 17:00:58.194877	1	1	1
10	2	6	2024-02-08 17:00:58.202238	2024-02-08 17:00:58.202238	1	1	1
11	3	5	2024-02-08 17:00:58.209417	2024-02-08 17:00:58.209417	1	1	1
12	3	3	2024-02-08 17:00:58.212933	2024-02-08 17:00:58.212933	1	1	1
13	3	1	2024-02-08 17:00:58.221938	2024-02-08 17:00:58.221938	1	1	1
14	4	3	2024-02-08 17:00:58.225584	2024-02-08 17:00:58.225584	1	1	1
15	4	1	2024-02-08 17:00:58.234116	2024-02-08 17:00:58.234116	1	1	1
16	4	4	2024-02-08 17:00:58.237156	2024-02-08 17:00:58.237156	1	1	1
17	4	2	2024-02-08 17:00:58.240209	2024-02-08 17:00:58.240209	1	1	1
18	4	6	2024-02-08 17:00:58.243243	2024-02-08 17:00:58.243243	1	1	1
19	3	2	2024-02-08 17:00:58.247537	2024-02-08 17:00:58.247537	1	1	1
20	3	4	2024-02-08 17:00:58.250759	2024-02-08 17:00:58.250759	1	1	1
21	1	7	2024-02-08 17:00:58.253888	2024-02-08 17:00:58.253888	1	1	1
22	2	7	2024-02-08 17:00:58.257007	2024-02-08 17:00:58.257007	1	1	1
23	4	7	2024-02-08 17:00:58.263001	2024-02-08 17:00:58.263001	1	1	1
24	5	1	2024-02-08 17:01:50.232	2024-02-08 17:01:50.233	1	1	1
25	5	3	2024-02-08 17:01:50.235	2024-02-08 17:01:50.236	1	1	1
26	5	7	2024-02-08 17:01:50.238	2024-02-08 17:01:50.238	1	1	1
27	6	1	2024-02-08 17:01:50.251	2024-02-08 17:01:50.251	1	1	1
28	6	3	2024-02-08 17:01:50.253	2024-02-08 17:01:50.253	1	1	1
29	6	7	2024-02-08 17:01:50.255	2024-02-08 17:01:50.255	1	1	1
30	7	1	2024-02-08 17:01:50.354	2024-02-08 17:01:50.355	1	1	1
31	7	3	2024-02-08 17:01:50.356	2024-02-08 17:01:50.357	1	1	1
32	7	7	2024-02-08 17:01:50.357	2024-02-08 17:01:50.358	1	1	1
33	8	1	2024-02-08 17:01:50.594	2024-02-08 17:01:50.594	1	1	1
34	8	3	2024-02-08 17:01:50.595	2024-02-08 17:01:50.595	1	1	1
35	8	7	2024-02-08 17:01:50.596	2024-02-08 17:01:50.596	1	1	1
36	9	1	2024-02-08 17:01:50.849	2024-02-08 17:01:50.85	1	1	1
37	9	3	2024-02-08 17:01:50.85	2024-02-08 17:01:50.851	1	1	1
38	9	7	2024-02-08 17:01:50.852	2024-02-08 17:01:50.852	1	1	1
39	10	1	2024-02-08 17:01:50.962	2024-02-08 17:01:50.963	1	1	1
40	10	3	2024-02-08 17:01:50.964	2024-02-08 17:01:50.964	1	1	1
41	10	7	2024-02-08 17:01:50.965	2024-02-08 17:01:50.965	1	1	1
42	11	1	2024-02-08 17:01:51.039	2024-02-08 17:01:51.04	1	1	1
43	11	3	2024-02-08 17:01:51.04	2024-02-08 17:01:51.041	1	1	1
44	11	7	2024-02-08 17:01:51.041	2024-02-08 17:01:51.042	1	1	1
45	12	1	2024-02-08 17:51:48.087	2024-02-08 17:51:48.088	1	1	1
46	12	3	2024-02-08 17:51:48.09	2024-02-08 17:51:48.09	1	1	1
47	12	7	2024-02-08 17:51:48.091	2024-02-08 17:51:48.092	1	1	1
\.


--
-- Data for Name: xa_access_audit; Type: TABLE DATA; Schema: public; Owner: rangeradmin
--

COPY public.xa_access_audit (id, create_time, update_time, added_by_id, upd_by_id, audit_type, access_result, access_type, acl_enforcer, agent_id, client_ip, client_type, policy_id, repo_name, repo_type, result_reason, session_id, event_time, request_user, action, request_data, resource_path, resource_type) FROM stdin;
\.


--
-- Name: x_access_type_def_grants_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_access_type_def_grants_seq', 218, true);


--
-- Name: x_access_type_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_access_type_def_seq', 306, true);


--
-- Name: x_asset_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_asset_seq', 1, false);


--
-- Name: x_audit_map_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_audit_map_seq', 1, false);


--
-- Name: x_auth_sess_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_auth_sess_seq', 4, true);


--
-- Name: x_context_enricher_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_context_enricher_def_seq', 1, true);


--
-- Name: x_cred_store_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_cred_store_seq', 1, false);


--
-- Name: x_data_hist_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_data_hist_seq', 77, true);


--
-- Name: x_datamask_type_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_datamask_type_def_seq', 64, true);


--
-- Name: x_db_base_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_db_base_seq', 1, false);


--
-- Name: x_db_version_h_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_db_version_h_id_seq', 95, true);


--
-- Name: x_enum_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_enum_def_seq', 8, true);


--
-- Name: x_enum_element_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_enum_element_def_seq', 17, true);


--
-- Name: x_group_groups_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_group_groups_seq', 1, false);


--
-- Name: x_group_module_perm_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_group_module_perm_seq', 1, false);


--
-- Name: x_group_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_group_seq', 1, true);


--
-- Name: x_group_users_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_group_users_seq', 1, false);


--
-- Name: x_modules_master_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_modules_master_seq', 7, true);


--
-- Name: x_perm_map_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_perm_map_seq', 1, false);


--
-- Name: x_plugin_info_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_plugin_info_seq', 1, true);


--
-- Name: x_policy_change_log_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_change_log_seq', 1, false);


--
-- Name: x_policy_condition_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_condition_def_seq', 7, true);


--
-- Name: x_policy_export_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_export_seq', 1, true);


--
-- Name: x_policy_item_access_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_access_seq', 1, false);


--
-- Name: x_policy_item_condition_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_condition_seq', 1, false);


--
-- Name: x_policy_item_datamask_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_datamask_seq', 1, false);


--
-- Name: x_policy_item_group_perm_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_group_perm_seq', 1, false);


--
-- Name: x_policy_item_rowfilter_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_rowfilter_seq', 1, false);


--
-- Name: x_policy_item_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_seq', 1, false);


--
-- Name: x_policy_item_user_perm_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_item_user_perm_seq', 1, false);


--
-- Name: x_policy_label_map_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_label_map_seq', 1, false);


--
-- Name: x_policy_label_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_label_seq', 1, false);


--
-- Name: x_policy_ref_access_type_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_access_type_seq', 298, true);


--
-- Name: x_policy_ref_condition_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_condition_seq', 1, true);


--
-- Name: x_policy_ref_datamask_type_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_datamask_type_seq', 1, false);


--
-- Name: x_policy_ref_group_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_group_seq', 9, true);


--
-- Name: x_policy_ref_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_resource_seq', 35, true);


--
-- Name: x_policy_ref_role_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_role_seq', 1, false);


--
-- Name: x_policy_ref_user_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_ref_user_seq', 29, true);


--
-- Name: x_policy_resource_map_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_resource_map_seq', 1, false);


--
-- Name: x_policy_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_resource_seq', 1, false);


--
-- Name: x_policy_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_policy_seq', 24, true);


--
-- Name: x_portal_user_role_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_portal_user_role_seq', 12, true);


--
-- Name: x_portal_user_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_portal_user_seq', 12, true);


--
-- Name: x_ranger_global_state_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_ranger_global_state_seq', 3, true);


--
-- Name: x_resource_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_resource_def_seq', 81, true);


--
-- Name: x_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_resource_seq', 1, false);


--
-- Name: x_rms_mapping_provider_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_rms_mapping_provider_seq', 1, false);


--
-- Name: x_rms_notification_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_rms_notification_seq', 1, false);


--
-- Name: x_rms_resource_mapping_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_rms_resource_mapping_seq', 1, false);


--
-- Name: x_rms_service_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_rms_service_resource_seq', 1, false);


--
-- Name: x_role_ref_group_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_role_ref_group_seq', 1, false);


--
-- Name: x_role_ref_role_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_role_ref_role_seq', 1, false);


--
-- Name: x_role_ref_user_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_role_ref_user_seq', 1, false);


--
-- Name: x_role_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_role_seq', 1, false);


--
-- Name: x_sec_zone_ref_group_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_sec_zone_ref_group_seq', 1, false);


--
-- Name: x_sec_zone_ref_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_sec_zone_ref_resource_seq', 1, false);


--
-- Name: x_sec_zone_ref_role_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_sec_zone_ref_role_seq', 1, false);


--
-- Name: x_sec_zone_ref_service_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_sec_zone_ref_service_seq', 1, false);


--
-- Name: x_sec_zone_ref_tag_srvc_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_sec_zone_ref_tag_srvc_seq', 1, false);


--
-- Name: x_sec_zone_ref_user_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_sec_zone_ref_user_seq', 1, false);


--
-- Name: x_security_zone_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_security_zone_seq', 1, true);


--
-- Name: x_service_config_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_service_config_def_seq', 115, true);


--
-- Name: x_service_config_map_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_service_config_map_seq', 51, true);


--
-- Name: x_service_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_service_def_seq', 205, true);


--
-- Name: x_service_resource_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_service_resource_seq', 1, false);


--
-- Name: x_service_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_service_seq', 9, true);


--
-- Name: x_service_version_info_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_service_version_info_seq', 9, true);


--
-- Name: x_tag_change_log_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_tag_change_log_seq', 1, false);


--
-- Name: x_tag_def_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_tag_def_seq', 1, false);


--
-- Name: x_tag_resource_map_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_tag_resource_map_seq', 1, false);


--
-- Name: x_tag_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_tag_seq', 1, false);


--
-- Name: x_trx_log_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_trx_log_seq', 314, true);


--
-- Name: x_ugsync_audit_info_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_ugsync_audit_info_seq', 1, false);


--
-- Name: x_user_module_perm_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_user_module_perm_seq', 47, true);


--
-- Name: x_user_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.x_user_seq', 14, true);


--
-- Name: xa_access_audit_seq; Type: SEQUENCE SET; Schema: public; Owner: rangeradmin
--

SELECT pg_catalog.setval('public.xa_access_audit_seq', 1, false);


--
-- Name: x_access_type_def_grants x_access_type_def_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def_grants
    ADD CONSTRAINT x_access_type_def_grants_pkey PRIMARY KEY (id);


--
-- Name: x_access_type_def x_access_type_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def
    ADD CONSTRAINT x_access_type_def_pkey PRIMARY KEY (id);


--
-- Name: x_asset x_asset_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_asset
    ADD CONSTRAINT x_asset_pkey PRIMARY KEY (id);


--
-- Name: x_audit_map x_audit_map_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_audit_map
    ADD CONSTRAINT x_audit_map_pkey PRIMARY KEY (id);


--
-- Name: x_auth_sess x_auth_sess_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_auth_sess
    ADD CONSTRAINT x_auth_sess_pkey PRIMARY KEY (id);


--
-- Name: x_context_enricher_def x_context_enricher_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_context_enricher_def
    ADD CONSTRAINT x_context_enricher_def_pkey PRIMARY KEY (id);


--
-- Name: x_cred_store x_cred_store_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_cred_store
    ADD CONSTRAINT x_cred_store_pkey PRIMARY KEY (id);


--
-- Name: x_data_hist x_data_hist_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_data_hist
    ADD CONSTRAINT x_data_hist_pkey PRIMARY KEY (id);


--
-- Name: x_datamask_type_def x_datamask_type_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_datamask_type_def
    ADD CONSTRAINT x_datamask_type_def_pkey PRIMARY KEY (id);


--
-- Name: x_db_base x_db_base_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_db_base
    ADD CONSTRAINT x_db_base_pkey PRIMARY KEY (id);


--
-- Name: x_db_version_h x_db_version_h_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_db_version_h
    ADD CONSTRAINT x_db_version_h_pkey PRIMARY KEY (id);


--
-- Name: x_enum_def x_enum_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_def
    ADD CONSTRAINT x_enum_def_pkey PRIMARY KEY (id);


--
-- Name: x_enum_element_def x_enum_element_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_element_def
    ADD CONSTRAINT x_enum_element_def_pkey PRIMARY KEY (id);


--
-- Name: x_group_groups x_group_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_groups
    ADD CONSTRAINT x_group_groups_pkey PRIMARY KEY (id);


--
-- Name: x_group_module_perm x_group_module_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_module_perm
    ADD CONSTRAINT x_group_module_perm_pkey PRIMARY KEY (id);


--
-- Name: x_group x_group_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group
    ADD CONSTRAINT x_group_pkey PRIMARY KEY (id);


--
-- Name: x_group x_group_uk_group_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group
    ADD CONSTRAINT x_group_uk_group_name UNIQUE (group_name);


--
-- Name: x_group_users x_group_users_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_users
    ADD CONSTRAINT x_group_users_pkey PRIMARY KEY (id);


--
-- Name: x_group_users x_group_users_uk_uid_gname; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_users
    ADD CONSTRAINT x_group_users_uk_uid_gname UNIQUE (user_id, group_name);


--
-- Name: x_modules_master x_modules_master_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_modules_master
    ADD CONSTRAINT x_modules_master_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_access_type x_p_ref_acc_uk_polid_accdefid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_access_type
    ADD CONSTRAINT x_p_ref_acc_uk_polid_accdefid UNIQUE (policy_id, access_def_id);


--
-- Name: x_policy_ref_condition x_p_ref_cond_uk_polid_cdefid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_condition
    ADD CONSTRAINT x_p_ref_cond_uk_polid_cdefid UNIQUE (policy_id, condition_def_id);


--
-- Name: x_policy_ref_datamask_type x_p_ref_dmk_uk_polid_ddefid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_datamask_type
    ADD CONSTRAINT x_p_ref_dmk_uk_polid_ddefid UNIQUE (policy_id, datamask_def_id);


--
-- Name: x_policy_ref_group x_p_ref_grp_uk_polid_grpid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_group
    ADD CONSTRAINT x_p_ref_grp_uk_polid_grpid UNIQUE (policy_id, group_id);


--
-- Name: x_policy_ref_resource x_p_ref_res_uk_polid_resdefid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_resource
    ADD CONSTRAINT x_p_ref_res_uk_polid_resdefid UNIQUE (policy_id, resource_def_id);


--
-- Name: x_policy_ref_user x_p_ref_usr_uk_polid_userid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_user
    ADD CONSTRAINT x_p_ref_usr_uk_polid_userid UNIQUE (policy_id, user_id);


--
-- Name: x_perm_map x_perm_map_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_perm_map
    ADD CONSTRAINT x_perm_map_pkey PRIMARY KEY (id);


--
-- Name: x_plugin_info x_plugin_info_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_plugin_info
    ADD CONSTRAINT x_plugin_info_pkey PRIMARY KEY (id);


--
-- Name: x_plugin_info x_plugin_info_uk; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_plugin_info
    ADD CONSTRAINT x_plugin_info_uk UNIQUE (service_name, host_name, app_type);


--
-- Name: x_policy_ref_role x_pol_ref_role_uk_polid_roleid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_role
    ADD CONSTRAINT x_pol_ref_role_uk_polid_roleid UNIQUE (policy_id, role_id);


--
-- Name: x_policy_change_log x_policy_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_change_log
    ADD CONSTRAINT x_policy_change_log_pkey PRIMARY KEY (id);


--
-- Name: x_policy_change_log x_policy_change_log_uk_service_id_policy_version; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_change_log
    ADD CONSTRAINT x_policy_change_log_uk_service_id_policy_version UNIQUE (service_id, policy_version);


--
-- Name: x_policy_condition_def x_policy_condition_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_condition_def
    ADD CONSTRAINT x_policy_condition_def_pkey PRIMARY KEY (id);


--
-- Name: x_policy_export_audit x_policy_export_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_export_audit
    ADD CONSTRAINT x_policy_export_audit_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item_access x_policy_item_access_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_access
    ADD CONSTRAINT x_policy_item_access_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item_condition x_policy_item_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_condition
    ADD CONSTRAINT x_policy_item_condition_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item_datamask x_policy_item_datamask_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_datamask
    ADD CONSTRAINT x_policy_item_datamask_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item_group_perm x_policy_item_group_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_group_perm
    ADD CONSTRAINT x_policy_item_group_perm_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item x_policy_item_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item
    ADD CONSTRAINT x_policy_item_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item_rowfilter x_policy_item_rowfilter_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_rowfilter
    ADD CONSTRAINT x_policy_item_rowfilter_pkey PRIMARY KEY (id);


--
-- Name: x_policy_item_user_perm x_policy_item_user_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_user_perm
    ADD CONSTRAINT x_policy_item_user_perm_pkey PRIMARY KEY (id);


--
-- Name: x_policy_label_map x_policy_label_map_pid_plid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label_map
    ADD CONSTRAINT x_policy_label_map_pid_plid UNIQUE (policy_id, policy_label_id);


--
-- Name: x_policy_label_map x_policy_label_map_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label_map
    ADD CONSTRAINT x_policy_label_map_pkey PRIMARY KEY (id);


--
-- Name: x_policy_label x_policy_label_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label
    ADD CONSTRAINT x_policy_label_pkey PRIMARY KEY (id);


--
-- Name: x_policy_label x_policy_label_uk_label_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label
    ADD CONSTRAINT x_policy_label_uk_label_name UNIQUE (label_name);


--
-- Name: x_policy x_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_access_type x_policy_ref_access_type_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_access_type
    ADD CONSTRAINT x_policy_ref_access_type_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_condition x_policy_ref_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_condition
    ADD CONSTRAINT x_policy_ref_condition_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_datamask_type x_policy_ref_datamask_type_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_datamask_type
    ADD CONSTRAINT x_policy_ref_datamask_type_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_group x_policy_ref_group_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_group
    ADD CONSTRAINT x_policy_ref_group_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_resource x_policy_ref_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_resource
    ADD CONSTRAINT x_policy_ref_resource_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_role x_policy_ref_role_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_role
    ADD CONSTRAINT x_policy_ref_role_pkey PRIMARY KEY (id);


--
-- Name: x_policy_ref_user x_policy_ref_user_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_user
    ADD CONSTRAINT x_policy_ref_user_pkey PRIMARY KEY (id);


--
-- Name: x_policy_resource_map x_policy_resource_map_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource_map
    ADD CONSTRAINT x_policy_resource_map_pkey PRIMARY KEY (id);


--
-- Name: x_policy_resource x_policy_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource
    ADD CONSTRAINT x_policy_resource_pkey PRIMARY KEY (id);


--
-- Name: x_policy x_policy_uk_guid_service_zone; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_uk_guid_service_zone UNIQUE (guid, service, zone_id);


--
-- Name: x_policy x_policy_uk_name_service_zone; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_uk_name_service_zone UNIQUE (name, service, zone_id);


--
-- Name: x_policy x_policy_uk_service_signature; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_uk_service_signature UNIQUE (service, resource_signature);


--
-- Name: x_portal_user x_portal_user_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user
    ADD CONSTRAINT x_portal_user_pkey PRIMARY KEY (id);


--
-- Name: x_portal_user_role x_portal_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user_role
    ADD CONSTRAINT x_portal_user_role_pkey PRIMARY KEY (id);


--
-- Name: x_portal_user x_portal_user_uk_email; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user
    ADD CONSTRAINT x_portal_user_uk_email UNIQUE (email);


--
-- Name: x_portal_user x_portal_user_uk_login_id; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user
    ADD CONSTRAINT x_portal_user_uk_login_id UNIQUE (login_id);


--
-- Name: x_ranger_global_state x_ranger_global_state_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_ranger_global_state
    ADD CONSTRAINT x_ranger_global_state_pkey PRIMARY KEY (id);


--
-- Name: x_ranger_global_state x_ranger_global_state_uk_state_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_ranger_global_state
    ADD CONSTRAINT x_ranger_global_state_uk_state_name UNIQUE (state_name);


--
-- Name: x_resource_def x_resource_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource_def
    ADD CONSTRAINT x_resource_def_pkey PRIMARY KEY (id);


--
-- Name: x_resource x_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource
    ADD CONSTRAINT x_resource_pkey PRIMARY KEY (id);


--
-- Name: x_resource x_resource_uk_policy_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource
    ADD CONSTRAINT x_resource_uk_policy_name UNIQUE (policy_name);


--
-- Name: x_rms_mapping_provider x_rms_mapping_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_mapping_provider
    ADD CONSTRAINT x_rms_mapping_provider_pkey PRIMARY KEY (id);


--
-- Name: x_rms_mapping_provider x_rms_mapping_provider_uk_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_mapping_provider
    ADD CONSTRAINT x_rms_mapping_provider_uk_name UNIQUE (name);


--
-- Name: x_rms_notification x_rms_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_notification
    ADD CONSTRAINT x_rms_notification_pkey PRIMARY KEY (id);


--
-- Name: x_rms_resource_mapping x_rms_res_map_uk_hl_res_id_ll_res_id; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_resource_mapping
    ADD CONSTRAINT x_rms_res_map_uk_hl_res_id_ll_res_id UNIQUE (hl_resource_id, ll_resource_id);


--
-- Name: x_rms_resource_mapping x_rms_resource_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_resource_mapping
    ADD CONSTRAINT x_rms_resource_mapping_pkey PRIMARY KEY (id);


--
-- Name: x_rms_service_resource x_rms_service_res_uk_guid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_service_resource
    ADD CONSTRAINT x_rms_service_res_uk_guid UNIQUE (guid);


--
-- Name: x_rms_service_resource x_rms_service_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_service_resource
    ADD CONSTRAINT x_rms_service_resource_pkey PRIMARY KEY (id);


--
-- Name: x_rms_service_resource x_rms_service_resource_uk_resource_signature; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_service_resource
    ADD CONSTRAINT x_rms_service_resource_uk_resource_signature UNIQUE (resource_signature);


--
-- Name: x_role x_role_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role
    ADD CONSTRAINT x_role_pkey PRIMARY KEY (id);


--
-- Name: x_role_ref_group x_role_ref_group_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_group
    ADD CONSTRAINT x_role_ref_group_pkey PRIMARY KEY (id);


--
-- Name: x_role_ref_role x_role_ref_role_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_role
    ADD CONSTRAINT x_role_ref_role_pkey PRIMARY KEY (id);


--
-- Name: x_role_ref_user x_role_ref_user_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_user
    ADD CONSTRAINT x_role_ref_user_pkey PRIMARY KEY (id);


--
-- Name: x_role x_role_uk_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role
    ADD CONSTRAINT x_role_uk_name UNIQUE (name);


--
-- Name: x_security_zone x_security_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone
    ADD CONSTRAINT x_security_zone_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone_ref_group x_security_zone_ref_group_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_group
    ADD CONSTRAINT x_security_zone_ref_group_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone_ref_resource x_security_zone_ref_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_resource
    ADD CONSTRAINT x_security_zone_ref_resource_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone_ref_role x_security_zone_ref_role_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_role
    ADD CONSTRAINT x_security_zone_ref_role_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone_ref_service x_security_zone_ref_service_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_service
    ADD CONSTRAINT x_security_zone_ref_service_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone_ref_tag_srvc x_security_zone_ref_tag_srvc_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_tag_srvc
    ADD CONSTRAINT x_security_zone_ref_tag_srvc_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone_ref_user x_security_zone_ref_user_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_user
    ADD CONSTRAINT x_security_zone_ref_user_pkey PRIMARY KEY (id);


--
-- Name: x_security_zone x_security_zone_uk_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone
    ADD CONSTRAINT x_security_zone_uk_name UNIQUE (name);


--
-- Name: x_service_config_def x_service_config_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_def
    ADD CONSTRAINT x_service_config_def_pkey PRIMARY KEY (id);


--
-- Name: x_service_config_map x_service_config_map_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_map
    ADD CONSTRAINT x_service_config_map_pkey PRIMARY KEY (id);


--
-- Name: x_service_def x_service_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_def
    ADD CONSTRAINT x_service_def_pkey PRIMARY KEY (id);


--
-- Name: x_service x_service_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service
    ADD CONSTRAINT x_service_name UNIQUE (name);


--
-- Name: x_service x_service_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service
    ADD CONSTRAINT x_service_pkey PRIMARY KEY (id);


--
-- Name: x_service_resource x_service_res_uk_guid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_resource
    ADD CONSTRAINT x_service_res_uk_guid UNIQUE (guid);


--
-- Name: x_service_resource x_service_resource_idx_svc_id_resource_signature; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_resource
    ADD CONSTRAINT x_service_resource_idx_svc_id_resource_signature UNIQUE (service_id, resource_signature);


--
-- Name: x_service_resource x_service_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_resource
    ADD CONSTRAINT x_service_resource_pkey PRIMARY KEY (id);


--
-- Name: x_service_version_info x_service_version_info_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_version_info
    ADD CONSTRAINT x_service_version_info_pkey PRIMARY KEY (id);


--
-- Name: x_tag_change_log x_tag_change_log_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_change_log
    ADD CONSTRAINT x_tag_change_log_pkey PRIMARY KEY (id);


--
-- Name: x_tag_change_log x_tag_change_log_uk_service_id_service_tags_version; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_change_log
    ADD CONSTRAINT x_tag_change_log_uk_service_id_service_tags_version UNIQUE (service_id, service_tags_version);


--
-- Name: x_tag_def x_tag_def_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_def
    ADD CONSTRAINT x_tag_def_pkey PRIMARY KEY (id);


--
-- Name: x_tag_def x_tag_def_uk_guid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_def
    ADD CONSTRAINT x_tag_def_uk_guid UNIQUE (guid);


--
-- Name: x_tag_def x_tag_def_uk_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_def
    ADD CONSTRAINT x_tag_def_uk_name UNIQUE (name);


--
-- Name: x_tag x_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag
    ADD CONSTRAINT x_tag_pkey PRIMARY KEY (id);


--
-- Name: x_tag_resource_map x_tag_res_map_uk_guid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_resource_map
    ADD CONSTRAINT x_tag_res_map_uk_guid UNIQUE (guid);


--
-- Name: x_tag_resource_map x_tag_resource_map_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_resource_map
    ADD CONSTRAINT x_tag_resource_map_pkey PRIMARY KEY (id);


--
-- Name: x_tag x_tag_uk_guid; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag
    ADD CONSTRAINT x_tag_uk_guid UNIQUE (guid);


--
-- Name: x_trx_log x_trx_log_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_trx_log
    ADD CONSTRAINT x_trx_log_pkey PRIMARY KEY (id);


--
-- Name: x_ugsync_audit_info x_ugsync_audit_info_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_ugsync_audit_info
    ADD CONSTRAINT x_ugsync_audit_info_pkey PRIMARY KEY (id);


--
-- Name: x_user_module_perm x_user_module_perm_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user_module_perm
    ADD CONSTRAINT x_user_module_perm_pkey PRIMARY KEY (id);


--
-- Name: x_user x_user_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user
    ADD CONSTRAINT x_user_pkey PRIMARY KEY (id);


--
-- Name: x_user x_user_uk_user_name; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user
    ADD CONSTRAINT x_user_uk_user_name UNIQUE (user_name);


--
-- Name: xa_access_audit xa_access_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.xa_access_audit
    ADD CONSTRAINT xa_access_audit_pkey PRIMARY KEY (id);


--
-- Name: x_access_type_def_idx_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_access_type_def_idx_def_id ON public.x_access_type_def USING btree (def_id);


--
-- Name: x_access_type_def_idx_grants_atd_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_access_type_def_idx_grants_atd_id ON public.x_access_type_def_grants USING btree (atd_id);


--
-- Name: x_asset_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_asset_cr_time ON public.x_asset USING btree (create_time);


--
-- Name: x_asset_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_asset_fk_added_by_id ON public.x_asset USING btree (added_by_id);


--
-- Name: x_asset_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_asset_fk_upd_by_id ON public.x_asset USING btree (upd_by_id);


--
-- Name: x_asset_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_asset_up_time ON public.x_asset USING btree (update_time);


--
-- Name: x_audit_map_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_cr_time ON public.x_audit_map USING btree (create_time);


--
-- Name: x_audit_map_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_fk_added_by_id ON public.x_audit_map USING btree (added_by_id);


--
-- Name: x_audit_map_fk_group_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_fk_group_id ON public.x_audit_map USING btree (group_id);


--
-- Name: x_audit_map_fk_res_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_fk_res_id ON public.x_audit_map USING btree (res_id);


--
-- Name: x_audit_map_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_fk_upd_by_id ON public.x_audit_map USING btree (upd_by_id);


--
-- Name: x_audit_map_fk_user_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_fk_user_id ON public.x_audit_map USING btree (user_id);


--
-- Name: x_audit_map_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_audit_map_up_time ON public.x_audit_map USING btree (update_time);


--
-- Name: x_auth_sess_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_auth_sess_cr_time ON public.x_auth_sess USING btree (create_time);


--
-- Name: x_auth_sess_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_auth_sess_fk_added_by_id ON public.x_auth_sess USING btree (added_by_id);


--
-- Name: x_auth_sess_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_auth_sess_fk_upd_by_id ON public.x_auth_sess USING btree (upd_by_id);


--
-- Name: x_auth_sess_fk_user_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_auth_sess_fk_user_id ON public.x_auth_sess USING btree (user_id);


--
-- Name: x_auth_sess_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_auth_sess_up_time ON public.x_auth_sess USING btree (update_time);


--
-- Name: x_context_enricher_def_idx_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_context_enricher_def_idx_def_id ON public.x_context_enricher_def USING btree (def_id);


--
-- Name: x_cred_store_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_cred_store_cr_time ON public.x_cred_store USING btree (create_time);


--
-- Name: x_cred_store_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_cred_store_fk_added_by_id ON public.x_cred_store USING btree (added_by_id);


--
-- Name: x_cred_store_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_cred_store_fk_upd_by_id ON public.x_cred_store USING btree (upd_by_id);


--
-- Name: x_cred_store_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_cred_store_up_time ON public.x_cred_store USING btree (update_time);


--
-- Name: x_data_hist_idx_objid_objclstype; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_data_hist_idx_objid_objclstype ON public.x_data_hist USING btree (obj_id, obj_class_type);


--
-- Name: x_datamask_type_def_idx_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_datamask_type_def_idx_def_id ON public.x_datamask_type_def USING btree (def_id);


--
-- Name: x_db_base_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_db_base_cr_time ON public.x_db_base USING btree (create_time);


--
-- Name: x_db_base_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_db_base_fk_added_by_id ON public.x_db_base USING btree (added_by_id);


--
-- Name: x_db_base_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_db_base_fk_upd_by_id ON public.x_db_base USING btree (upd_by_id);


--
-- Name: x_db_base_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_db_base_up_time ON public.x_db_base USING btree (update_time);


--
-- Name: x_enum_def_idx_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_enum_def_idx_def_id ON public.x_enum_def USING btree (def_id);


--
-- Name: x_enum_element_def_idx_enum_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_enum_element_def_idx_enum_def_id ON public.x_enum_element_def USING btree (enum_def_id);


--
-- Name: x_group_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_cr_time ON public.x_group USING btree (create_time);


--
-- Name: x_group_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_fk_added_by_id ON public.x_group USING btree (added_by_id);


--
-- Name: x_group_fk_cred_store_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_fk_cred_store_id ON public.x_group USING btree (cred_store_id);


--
-- Name: x_group_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_fk_upd_by_id ON public.x_group USING btree (upd_by_id);


--
-- Name: x_group_groups_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_groups_cr_time ON public.x_group_groups USING btree (create_time);


--
-- Name: x_group_groups_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_groups_fk_added_by_id ON public.x_group_groups USING btree (added_by_id);


--
-- Name: x_group_groups_fk_group_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_groups_fk_group_id ON public.x_group_groups USING btree (group_id);


--
-- Name: x_group_groups_fk_p_group_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_groups_fk_p_group_id ON public.x_group_groups USING btree (p_group_id);


--
-- Name: x_group_groups_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_groups_fk_upd_by_id ON public.x_group_groups USING btree (upd_by_id);


--
-- Name: x_group_groups_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_groups_up_time ON public.x_group_groups USING btree (update_time);


--
-- Name: x_group_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_up_time ON public.x_group USING btree (update_time);


--
-- Name: x_group_users_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_users_cr_time ON public.x_group_users USING btree (create_time);


--
-- Name: x_group_users_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_users_fk_added_by_id ON public.x_group_users USING btree (added_by_id);


--
-- Name: x_group_users_fk_p_group_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_users_fk_p_group_id ON public.x_group_users USING btree (p_group_id);


--
-- Name: x_group_users_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_users_fk_upd_by_id ON public.x_group_users USING btree (upd_by_id);


--
-- Name: x_group_users_fk_user_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_users_fk_user_id ON public.x_group_users USING btree (user_id);


--
-- Name: x_group_users_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_group_users_up_time ON public.x_group_users USING btree (update_time);


--
-- Name: x_grp_module_perm_idx_groupid; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_grp_module_perm_idx_groupid ON public.x_group_module_perm USING btree (group_id);


--
-- Name: x_grp_module_perm_idx_moduleid; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_grp_module_perm_idx_moduleid ON public.x_group_module_perm USING btree (module_id);


--
-- Name: x_perm_map_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_cr_time ON public.x_perm_map USING btree (create_time);


--
-- Name: x_perm_map_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_fk_added_by_id ON public.x_perm_map USING btree (added_by_id);


--
-- Name: x_perm_map_fk_group_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_fk_group_id ON public.x_perm_map USING btree (group_id);


--
-- Name: x_perm_map_fk_res_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_fk_res_id ON public.x_perm_map USING btree (res_id);


--
-- Name: x_perm_map_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_fk_upd_by_id ON public.x_perm_map USING btree (upd_by_id);


--
-- Name: x_perm_map_fk_user_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_fk_user_id ON public.x_perm_map USING btree (user_id);


--
-- Name: x_perm_map_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_perm_map_up_time ON public.x_perm_map USING btree (update_time);


--
-- Name: x_plugin_info_idx_host_name; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_plugin_info_idx_host_name ON public.x_plugin_info USING btree (host_name);


--
-- Name: x_plugin_info_idx_service_name; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_plugin_info_idx_service_name ON public.x_plugin_info USING btree (service_name);


--
-- Name: x_policy_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_added_by_id ON public.x_policy USING btree (added_by_id);


--
-- Name: x_policy_change_log_idx_policy_version; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_change_log_idx_policy_version ON public.x_policy_change_log USING btree (policy_version);


--
-- Name: x_policy_change_log_idx_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_change_log_idx_service_id ON public.x_policy_change_log USING btree (service_id);


--
-- Name: x_policy_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_cr_time ON public.x_policy USING btree (create_time);


--
-- Name: x_policy_export_audit_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_export_audit_cr_time ON public.x_policy_export_audit USING btree (create_time);


--
-- Name: x_policy_export_audit_fk_added; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_export_audit_fk_added ON public.x_policy_export_audit USING btree (added_by_id);


--
-- Name: x_policy_export_audit_fk_upd; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_export_audit_fk_upd ON public.x_policy_export_audit USING btree (upd_by_id);


--
-- Name: x_policy_export_audit_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_export_audit_up_time ON public.x_policy_export_audit USING btree (update_time);


--
-- Name: x_policy_item_access_idx_policy_item_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_access_idx_policy_item_id ON public.x_policy_item_access USING btree (policy_item_id);


--
-- Name: x_policy_item_access_idx_type; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_access_idx_type ON public.x_policy_item_access USING btree (type);


--
-- Name: x_policy_item_condition_idx_policy_item_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_condition_idx_policy_item_id ON public.x_policy_item_condition USING btree (policy_item_id);


--
-- Name: x_policy_item_condition_idx_type; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_condition_idx_type ON public.x_policy_item_condition USING btree (type);


--
-- Name: x_policy_item_datamask_idx_policy_item_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_datamask_idx_policy_item_id ON public.x_policy_item_datamask USING btree (policy_item_id);


--
-- Name: x_policy_item_group_perm_idx_group_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_group_perm_idx_group_id ON public.x_policy_item_group_perm USING btree (group_id);


--
-- Name: x_policy_item_group_perm_idx_policy_item_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_group_perm_idx_policy_item_id ON public.x_policy_item_group_perm USING btree (policy_item_id);


--
-- Name: x_policy_item_idx_policy_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_idx_policy_id ON public.x_policy_item USING btree (policy_id);


--
-- Name: x_policy_item_rowfilter_idx_policy_item_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_rowfilter_idx_policy_item_id ON public.x_policy_item_rowfilter USING btree (policy_item_id);


--
-- Name: x_policy_item_user_perm_idx_policy_item_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_user_perm_idx_policy_item_id ON public.x_policy_item_user_perm USING btree (policy_item_id);


--
-- Name: x_policy_item_user_perm_idx_user_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_item_user_perm_idx_user_id ON public.x_policy_item_user_perm USING btree (user_id);


--
-- Name: x_policy_label_label_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_label_label_id ON public.x_policy_label USING btree (id);


--
-- Name: x_policy_label_label_map_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_label_label_map_id ON public.x_policy_label_map USING btree (id);


--
-- Name: x_policy_label_label_name; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_label_label_name ON public.x_policy_label USING btree (label_name);


--
-- Name: x_policy_resource_idx_policy_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_resource_idx_policy_id ON public.x_policy_resource USING btree (policy_id);


--
-- Name: x_policy_resource_idx_res_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_resource_idx_res_def_id ON public.x_policy_resource USING btree (res_def_id);


--
-- Name: x_policy_resource_map_idx_resource_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_resource_map_idx_resource_id ON public.x_policy_resource_map USING btree (resource_id);


--
-- Name: x_policy_resource_signature; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_resource_signature ON public.x_policy USING btree (resource_signature);


--
-- Name: x_policy_service; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_service ON public.x_policy USING btree (service);


--
-- Name: x_policy_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_up_time ON public.x_policy USING btree (update_time);


--
-- Name: x_policy_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_policy_upd_by_id ON public.x_policy USING btree (upd_by_id);


--
-- Name: x_portal_user_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_cr_time ON public.x_portal_user USING btree (create_time);


--
-- Name: x_portal_user_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_fk_added_by_id ON public.x_portal_user USING btree (added_by_id);


--
-- Name: x_portal_user_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_fk_upd_by_id ON public.x_portal_user USING btree (upd_by_id);


--
-- Name: x_portal_user_name; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_name ON public.x_portal_user USING btree (first_name);


--
-- Name: x_portal_user_role_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_role_cr_time ON public.x_portal_user_role USING btree (create_time);


--
-- Name: x_portal_user_role_fk_added; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_role_fk_added ON public.x_portal_user_role USING btree (added_by_id);


--
-- Name: x_portal_user_role_fk_upd; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_role_fk_upd ON public.x_portal_user_role USING btree (upd_by_id);


--
-- Name: x_portal_user_role_fk_user_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_role_fk_user_id ON public.x_portal_user_role USING btree (user_id);


--
-- Name: x_portal_user_role_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_role_up_time ON public.x_portal_user_role USING btree (update_time);


--
-- Name: x_portal_user_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_portal_user_up_time ON public.x_portal_user USING btree (update_time);


--
-- Name: x_resource_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_cr_time ON public.x_resource USING btree (create_time);


--
-- Name: x_resource_def_idx_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_def_idx_def_id ON public.x_resource_def USING btree (def_id);


--
-- Name: x_resource_def_parent; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_def_parent ON public.x_resource_def USING btree (parent);


--
-- Name: x_resource_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_fk_added_by_id ON public.x_resource USING btree (added_by_id);


--
-- Name: x_resource_fk_asset_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_fk_asset_id ON public.x_resource USING btree (asset_id);


--
-- Name: x_resource_fk_parent_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_fk_parent_id ON public.x_resource USING btree (parent_id);


--
-- Name: x_resource_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_fk_upd_by_id ON public.x_resource USING btree (upd_by_id);


--
-- Name: x_resource_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_resource_up_time ON public.x_resource USING btree (update_time);


--
-- Name: x_rms_notification_idx_hl_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_notification_idx_hl_service_id ON public.x_rms_notification USING btree (hl_service_id);


--
-- Name: x_rms_notification_idx_hms_name_notification_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_notification_idx_hms_name_notification_id ON public.x_rms_notification USING btree (hms_name, notification_id);


--
-- Name: x_rms_notification_idx_ll_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_notification_idx_ll_service_id ON public.x_rms_notification USING btree (ll_service_id);


--
-- Name: x_rms_notification_idx_notification_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_notification_idx_notification_id ON public.x_rms_notification USING btree (notification_id);


--
-- Name: x_rms_resource_mapping_idx_hl_resource_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_resource_mapping_idx_hl_resource_id ON public.x_rms_resource_mapping USING btree (hl_resource_id);


--
-- Name: x_rms_resource_mapping_idx_ll_resource_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_resource_mapping_idx_ll_resource_id ON public.x_rms_resource_mapping USING btree (ll_resource_id);


--
-- Name: x_rms_service_resource_idx_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_rms_service_resource_idx_service_id ON public.x_rms_service_resource USING btree (service_id);


--
-- Name: x_service_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_added_by_id ON public.x_service USING btree (added_by_id);


--
-- Name: x_service_config_def_idx_def_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_config_def_idx_def_id ON public.x_service_config_def USING btree (def_id);


--
-- Name: x_service_config_map_idx_service; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_config_map_idx_service ON public.x_service_config_map USING btree (service);


--
-- Name: x_service_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_cr_time ON public.x_service USING btree (create_time);


--
-- Name: x_service_def_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_def_added_by_id ON public.x_service_def USING btree (added_by_id);


--
-- Name: x_service_def_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_def_cr_time ON public.x_service_def USING btree (create_time);


--
-- Name: x_service_def_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_def_up_time ON public.x_service_def USING btree (update_time);


--
-- Name: x_service_def_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_def_upd_by_id ON public.x_service_def USING btree (upd_by_id);


--
-- Name: x_service_res_idx_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_res_idx_added_by_id ON public.x_service_resource USING btree (added_by_id);


--
-- Name: x_service_res_idx_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_res_idx_upd_by_id ON public.x_service_resource USING btree (upd_by_id);


--
-- Name: x_service_resource_idx_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_resource_idx_service_id ON public.x_service_resource USING btree (service_id);


--
-- Name: x_service_type; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_type ON public.x_service USING btree (type);


--
-- Name: x_service_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_up_time ON public.x_service USING btree (update_time);


--
-- Name: x_service_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_upd_by_id ON public.x_service USING btree (upd_by_id);


--
-- Name: x_service_version_info_idx_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_service_version_info_idx_service_id ON public.x_service_version_info USING btree (service_id);


--
-- Name: x_tag_change_log_idx_service_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_change_log_idx_service_id ON public.x_tag_change_log USING btree (service_id);


--
-- Name: x_tag_change_log_idx_tag_version; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_change_log_idx_tag_version ON public.x_tag_change_log USING btree (service_tags_version);


--
-- Name: x_tag_def_idx_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_def_idx_added_by_id ON public.x_tag_def USING btree (added_by_id);


--
-- Name: x_tag_def_idx_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_def_idx_upd_by_id ON public.x_tag_def USING btree (upd_by_id);


--
-- Name: x_tag_idx_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_idx_added_by_id ON public.x_tag USING btree (added_by_id);


--
-- Name: x_tag_idx_type; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_idx_type ON public.x_tag USING btree (type);


--
-- Name: x_tag_idx_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_idx_upd_by_id ON public.x_tag USING btree (upd_by_id);


--
-- Name: x_tag_res_map_idx_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_res_map_idx_added_by_id ON public.x_tag_resource_map USING btree (added_by_id);


--
-- Name: x_tag_res_map_idx_res_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_res_map_idx_res_id ON public.x_tag_resource_map USING btree (res_id);


--
-- Name: x_tag_res_map_idx_tag_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_res_map_idx_tag_id ON public.x_tag_resource_map USING btree (tag_id);


--
-- Name: x_tag_res_map_idx_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_tag_res_map_idx_upd_by_id ON public.x_tag_resource_map USING btree (upd_by_id);


--
-- Name: x_trx_log_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_trx_log_cr_time ON public.x_trx_log USING btree (create_time);


--
-- Name: x_trx_log_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_trx_log_fk_added_by_id ON public.x_trx_log USING btree (added_by_id);


--
-- Name: x_trx_log_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_trx_log_fk_upd_by_id ON public.x_trx_log USING btree (upd_by_id);


--
-- Name: x_trx_log_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_trx_log_up_time ON public.x_trx_log USING btree (update_time);


--
-- Name: x_ugsync_audit_info_etime; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_ugsync_audit_info_etime ON public.x_ugsync_audit_info USING btree (event_time);


--
-- Name: x_ugsync_audit_info_sync_src; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_ugsync_audit_info_sync_src ON public.x_ugsync_audit_info USING btree (sync_source);


--
-- Name: x_ugsync_audit_info_uname; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_ugsync_audit_info_uname ON public.x_ugsync_audit_info USING btree (user_name);


--
-- Name: x_user_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_user_cr_time ON public.x_user USING btree (create_time);


--
-- Name: x_user_fk_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_user_fk_added_by_id ON public.x_user USING btree (added_by_id);


--
-- Name: x_user_fk_cred_store_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_user_fk_cred_store_id ON public.x_user USING btree (cred_store_id);


--
-- Name: x_user_fk_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_user_fk_upd_by_id ON public.x_user USING btree (upd_by_id);


--
-- Name: x_user_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_user_up_time ON public.x_user USING btree (update_time);


--
-- Name: x_usr_module_perm_idx_moduleid; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_usr_module_perm_idx_moduleid ON public.x_user_module_perm USING btree (module_id);


--
-- Name: x_usr_module_perm_idx_userid; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX x_usr_module_perm_idx_userid ON public.x_user_module_perm USING btree (user_id);


--
-- Name: xa_access_audit_added_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX xa_access_audit_added_by_id ON public.xa_access_audit USING btree (added_by_id);


--
-- Name: xa_access_audit_cr_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX xa_access_audit_cr_time ON public.xa_access_audit USING btree (create_time);


--
-- Name: xa_access_audit_event_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX xa_access_audit_event_time ON public.xa_access_audit USING btree (event_time);


--
-- Name: xa_access_audit_up_time; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX xa_access_audit_up_time ON public.xa_access_audit USING btree (update_time);


--
-- Name: xa_access_audit_upd_by_id; Type: INDEX; Schema: public; Owner: rangeradmin
--

CREATE INDEX xa_access_audit_upd_by_id ON public.xa_access_audit USING btree (upd_by_id);


--
-- Name: x_access_type_def x_access_type_def_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def
    ADD CONSTRAINT x_access_type_def_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_access_type_def x_access_type_def_fk_defid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def
    ADD CONSTRAINT x_access_type_def_fk_defid FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_access_type_def x_access_type_def_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def
    ADD CONSTRAINT x_access_type_def_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_asset x_asset_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_asset
    ADD CONSTRAINT x_asset_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_asset x_asset_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_asset
    ADD CONSTRAINT x_asset_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_access_type_def_grants x_atd_grants_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def_grants
    ADD CONSTRAINT x_atd_grants_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_access_type_def_grants x_atd_grants_fk_atdid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def_grants
    ADD CONSTRAINT x_atd_grants_fk_atdid FOREIGN KEY (atd_id) REFERENCES public.x_access_type_def(id);


--
-- Name: x_access_type_def_grants x_atd_grants_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_access_type_def_grants
    ADD CONSTRAINT x_atd_grants_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_audit_map x_audit_map_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_audit_map
    ADD CONSTRAINT x_audit_map_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_audit_map x_audit_map_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_audit_map
    ADD CONSTRAINT x_audit_map_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_audit_map x_audit_map_fk_res_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_audit_map
    ADD CONSTRAINT x_audit_map_fk_res_id FOREIGN KEY (res_id) REFERENCES public.x_resource(id);


--
-- Name: x_audit_map x_audit_map_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_audit_map
    ADD CONSTRAINT x_audit_map_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_audit_map x_audit_map_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_audit_map
    ADD CONSTRAINT x_audit_map_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_auth_sess x_auth_sess_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_auth_sess
    ADD CONSTRAINT x_auth_sess_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_auth_sess x_auth_sess_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_auth_sess
    ADD CONSTRAINT x_auth_sess_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_auth_sess x_auth_sess_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_auth_sess
    ADD CONSTRAINT x_auth_sess_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_context_enricher_def x_context_enricher_def_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_context_enricher_def
    ADD CONSTRAINT x_context_enricher_def_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_context_enricher_def x_context_enricher_def_fk_defid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_context_enricher_def
    ADD CONSTRAINT x_context_enricher_def_fk_defid FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_context_enricher_def x_context_enricher_def_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_context_enricher_def
    ADD CONSTRAINT x_context_enricher_def_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_cred_store x_cred_store_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_cred_store
    ADD CONSTRAINT x_cred_store_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_cred_store x_cred_store_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_cred_store
    ADD CONSTRAINT x_cred_store_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_datamask_type_def x_datamask_type_def_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_datamask_type_def
    ADD CONSTRAINT x_datamask_type_def_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_datamask_type_def x_datamask_type_def_fk_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_datamask_type_def
    ADD CONSTRAINT x_datamask_type_def_fk_def_id FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_datamask_type_def x_datamask_type_def_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_datamask_type_def
    ADD CONSTRAINT x_datamask_type_def_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_db_base x_db_base_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_db_base
    ADD CONSTRAINT x_db_base_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_db_base x_db_base_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_db_base
    ADD CONSTRAINT x_db_base_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_enum_def x_enum_def_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_def
    ADD CONSTRAINT x_enum_def_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_enum_def x_enum_def_fk_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_def
    ADD CONSTRAINT x_enum_def_fk_def_id FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_enum_def x_enum_def_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_def
    ADD CONSTRAINT x_enum_def_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_enum_element_def x_enum_element_def_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_element_def
    ADD CONSTRAINT x_enum_element_def_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_enum_element_def x_enum_element_def_fk_defid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_element_def
    ADD CONSTRAINT x_enum_element_def_fk_defid FOREIGN KEY (enum_def_id) REFERENCES public.x_enum_def(id);


--
-- Name: x_enum_element_def x_enum_element_def_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_enum_element_def
    ADD CONSTRAINT x_enum_element_def_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group x_group_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group
    ADD CONSTRAINT x_group_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group x_group_fk_cred_store_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group
    ADD CONSTRAINT x_group_fk_cred_store_id FOREIGN KEY (cred_store_id) REFERENCES public.x_cred_store(id);


--
-- Name: x_group x_group_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group
    ADD CONSTRAINT x_group_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group_groups x_group_groups_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_groups
    ADD CONSTRAINT x_group_groups_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group_groups x_group_groups_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_groups
    ADD CONSTRAINT x_group_groups_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_group_groups x_group_groups_fk_p_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_groups
    ADD CONSTRAINT x_group_groups_fk_p_group_id FOREIGN KEY (p_group_id) REFERENCES public.x_group(id);


--
-- Name: x_group_groups x_group_groups_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_groups
    ADD CONSTRAINT x_group_groups_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group_users x_group_users_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_users
    ADD CONSTRAINT x_group_users_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group_users x_group_users_fk_p_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_users
    ADD CONSTRAINT x_group_users_fk_p_group_id FOREIGN KEY (p_group_id) REFERENCES public.x_group(id);


--
-- Name: x_group_users x_group_users_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_users
    ADD CONSTRAINT x_group_users_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_group_users x_group_users_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_users
    ADD CONSTRAINT x_group_users_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_group_module_perm x_grp_module_perm_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_module_perm
    ADD CONSTRAINT x_grp_module_perm_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_group_module_perm x_grp_module_perm_fk_module_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_group_module_perm
    ADD CONSTRAINT x_grp_module_perm_fk_module_id FOREIGN KEY (module_id) REFERENCES public.x_modules_master(id);


--
-- Name: x_policy_ref_access_type x_p_ref_acc_fk_acc_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_access_type
    ADD CONSTRAINT x_p_ref_acc_fk_acc_def_id FOREIGN KEY (access_def_id) REFERENCES public.x_access_type_def(id);


--
-- Name: x_policy_ref_access_type x_p_ref_acc_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_access_type
    ADD CONSTRAINT x_p_ref_acc_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_access_type x_p_ref_acc_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_access_type
    ADD CONSTRAINT x_p_ref_acc_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_access_type x_p_ref_acc_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_access_type
    ADD CONSTRAINT x_p_ref_acc_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_condition x_p_ref_cond_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_condition
    ADD CONSTRAINT x_p_ref_cond_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_condition x_p_ref_cond_fk_cond_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_condition
    ADD CONSTRAINT x_p_ref_cond_fk_cond_def_id FOREIGN KEY (condition_def_id) REFERENCES public.x_policy_condition_def(id);


--
-- Name: x_policy_ref_condition x_p_ref_cond_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_condition
    ADD CONSTRAINT x_p_ref_cond_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_condition x_p_ref_cond_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_condition
    ADD CONSTRAINT x_p_ref_cond_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_datamask_type x_p_ref_dmk_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_datamask_type
    ADD CONSTRAINT x_p_ref_dmk_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_datamask_type x_p_ref_dmk_fk_dmk_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_datamask_type
    ADD CONSTRAINT x_p_ref_dmk_fk_dmk_def_id FOREIGN KEY (datamask_def_id) REFERENCES public.x_datamask_type_def(id);


--
-- Name: x_policy_ref_datamask_type x_p_ref_dmk_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_datamask_type
    ADD CONSTRAINT x_p_ref_dmk_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_datamask_type x_p_ref_dmk_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_datamask_type
    ADD CONSTRAINT x_p_ref_dmk_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_group x_p_ref_grp_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_group
    ADD CONSTRAINT x_p_ref_grp_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_group x_p_ref_grp_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_group
    ADD CONSTRAINT x_p_ref_grp_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_policy_ref_group x_p_ref_grp_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_group
    ADD CONSTRAINT x_p_ref_grp_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_group x_p_ref_grp_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_group
    ADD CONSTRAINT x_p_ref_grp_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_resource x_p_ref_res_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_resource
    ADD CONSTRAINT x_p_ref_res_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_resource x_p_ref_res_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_resource
    ADD CONSTRAINT x_p_ref_res_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_resource x_p_ref_res_fk_resource_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_resource
    ADD CONSTRAINT x_p_ref_res_fk_resource_def_id FOREIGN KEY (resource_def_id) REFERENCES public.x_resource_def(id);


--
-- Name: x_policy_ref_resource x_p_ref_res_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_resource
    ADD CONSTRAINT x_p_ref_res_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_user x_p_ref_usr_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_user
    ADD CONSTRAINT x_p_ref_usr_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_user x_p_ref_usr_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_user
    ADD CONSTRAINT x_p_ref_usr_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_user x_p_ref_usr_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_user
    ADD CONSTRAINT x_p_ref_usr_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_user x_p_ref_usr_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_user
    ADD CONSTRAINT x_p_ref_usr_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_perm_map x_perm_map_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_perm_map
    ADD CONSTRAINT x_perm_map_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_perm_map x_perm_map_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_perm_map
    ADD CONSTRAINT x_perm_map_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_perm_map x_perm_map_fk_res_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_perm_map
    ADD CONSTRAINT x_perm_map_fk_res_id FOREIGN KEY (res_id) REFERENCES public.x_resource(id);


--
-- Name: x_perm_map x_perm_map_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_perm_map
    ADD CONSTRAINT x_perm_map_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_perm_map x_perm_map_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_perm_map
    ADD CONSTRAINT x_perm_map_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_policy_item_access x_plc_item_access_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_access
    ADD CONSTRAINT x_plc_item_access_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_access x_plc_item_access_fk_atd_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_access
    ADD CONSTRAINT x_plc_item_access_fk_atd_id FOREIGN KEY (type) REFERENCES public.x_access_type_def(id);


--
-- Name: x_policy_item_access x_plc_item_access_fk_pi_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_access
    ADD CONSTRAINT x_plc_item_access_fk_pi_id FOREIGN KEY (policy_item_id) REFERENCES public.x_policy_item(id);


--
-- Name: x_policy_item_access x_plc_item_access_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_access
    ADD CONSTRAINT x_plc_item_access_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_condition x_plc_item_cond_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_condition
    ADD CONSTRAINT x_plc_item_cond_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_condition x_plc_item_cond_fk_pcd_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_condition
    ADD CONSTRAINT x_plc_item_cond_fk_pcd_id FOREIGN KEY (type) REFERENCES public.x_policy_condition_def(id);


--
-- Name: x_policy_item_condition x_plc_item_cond_fk_pi_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_condition
    ADD CONSTRAINT x_plc_item_cond_fk_pi_id FOREIGN KEY (policy_item_id) REFERENCES public.x_policy_item(id);


--
-- Name: x_policy_item_condition x_plc_item_cond_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_condition
    ADD CONSTRAINT x_plc_item_cond_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_group_perm x_plc_itm_grp_perm_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_group_perm
    ADD CONSTRAINT x_plc_itm_grp_perm_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_group_perm x_plc_itm_grp_perm_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_group_perm
    ADD CONSTRAINT x_plc_itm_grp_perm_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_policy_item_group_perm x_plc_itm_grp_perm_fk_pi_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_group_perm
    ADD CONSTRAINT x_plc_itm_grp_perm_fk_pi_id FOREIGN KEY (policy_item_id) REFERENCES public.x_policy_item(id);


--
-- Name: x_policy_item_group_perm x_plc_itm_grp_perm_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_group_perm
    ADD CONSTRAINT x_plc_itm_grp_perm_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_user_perm x_plc_itm_usr_perm_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_user_perm
    ADD CONSTRAINT x_plc_itm_usr_perm_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_user_perm x_plc_itm_usr_perm_fk_pi_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_user_perm
    ADD CONSTRAINT x_plc_itm_usr_perm_fk_pi_id FOREIGN KEY (policy_item_id) REFERENCES public.x_policy_item(id);


--
-- Name: x_policy_item_user_perm x_plc_itm_usr_perm_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_user_perm
    ADD CONSTRAINT x_plc_itm_usr_perm_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_user_perm x_plc_itm_usr_perm_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_user_perm
    ADD CONSTRAINT x_plc_itm_usr_perm_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_policy_ref_role x_pol_ref_role_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_role
    ADD CONSTRAINT x_pol_ref_role_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_ref_role x_pol_ref_role_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_role
    ADD CONSTRAINT x_pol_ref_role_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_ref_role x_pol_ref_role_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_role
    ADD CONSTRAINT x_pol_ref_role_fk_role_id FOREIGN KEY (role_id) REFERENCES public.x_role(id);


--
-- Name: x_policy_ref_role x_pol_ref_role_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_ref_role
    ADD CONSTRAINT x_pol_ref_role_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_condition_def x_policy_cond_def_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_condition_def
    ADD CONSTRAINT x_policy_cond_def_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_condition_def x_policy_cond_def_fk_defid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_condition_def
    ADD CONSTRAINT x_policy_cond_def_fk_defid FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_policy_condition_def x_policy_cond_def_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_condition_def
    ADD CONSTRAINT x_policy_cond_def_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_export_audit x_policy_export_audit_fk_added; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_export_audit
    ADD CONSTRAINT x_policy_export_audit_fk_added FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_export_audit x_policy_export_audit_fk_upd; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_export_audit
    ADD CONSTRAINT x_policy_export_audit_fk_upd FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy x_policy_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy x_policy_fk_service; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_fk_service FOREIGN KEY (service) REFERENCES public.x_service(id);


--
-- Name: x_policy x_policy_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy x_policy_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy
    ADD CONSTRAINT x_policy_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_policy_item_datamask x_policy_item_datamask_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_datamask
    ADD CONSTRAINT x_policy_item_datamask_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_datamask x_policy_item_datamask_fk_policy_item_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_datamask
    ADD CONSTRAINT x_policy_item_datamask_fk_policy_item_id FOREIGN KEY (policy_item_id) REFERENCES public.x_policy_item(id);


--
-- Name: x_policy_item_datamask x_policy_item_datamask_fk_type; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_datamask
    ADD CONSTRAINT x_policy_item_datamask_fk_type FOREIGN KEY (type) REFERENCES public.x_datamask_type_def(id);


--
-- Name: x_policy_item_datamask x_policy_item_datamask_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_datamask
    ADD CONSTRAINT x_policy_item_datamask_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item x_policy_item_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item
    ADD CONSTRAINT x_policy_item_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item x_policy_item_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item
    ADD CONSTRAINT x_policy_item_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_item x_policy_item_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item
    ADD CONSTRAINT x_policy_item_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_rowfilter x_policy_item_rowfilter_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_rowfilter
    ADD CONSTRAINT x_policy_item_rowfilter_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_item_rowfilter x_policy_item_rowfilter_fk_policy_item_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_rowfilter
    ADD CONSTRAINT x_policy_item_rowfilter_fk_policy_item_id FOREIGN KEY (policy_item_id) REFERENCES public.x_policy_item(id);


--
-- Name: x_policy_item_rowfilter x_policy_item_rowfilter_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_item_rowfilter
    ADD CONSTRAINT x_policy_item_rowfilter_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_label x_policy_label_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label
    ADD CONSTRAINT x_policy_label_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_label x_policy_label_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label
    ADD CONSTRAINT x_policy_label_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_label_map x_policy_label_map_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label_map
    ADD CONSTRAINT x_policy_label_map_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_label_map x_policy_label_map_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label_map
    ADD CONSTRAINT x_policy_label_map_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_label_map x_policy_label_map_fk_policy_label_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label_map
    ADD CONSTRAINT x_policy_label_map_fk_policy_label_id FOREIGN KEY (policy_label_id) REFERENCES public.x_policy_label(id);


--
-- Name: x_policy_label_map x_policy_label_map_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_label_map
    ADD CONSTRAINT x_policy_label_map_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_resource x_policy_res_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource
    ADD CONSTRAINT x_policy_res_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_resource x_policy_res_fk_policy_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource
    ADD CONSTRAINT x_policy_res_fk_policy_id FOREIGN KEY (policy_id) REFERENCES public.x_policy(id);


--
-- Name: x_policy_resource x_policy_res_fk_res_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource
    ADD CONSTRAINT x_policy_res_fk_res_def_id FOREIGN KEY (res_def_id) REFERENCES public.x_resource_def(id);


--
-- Name: x_policy_resource x_policy_res_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource
    ADD CONSTRAINT x_policy_res_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_resource_map x_policy_res_map_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource_map
    ADD CONSTRAINT x_policy_res_map_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_policy_resource_map x_policy_res_map_fk_res_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource_map
    ADD CONSTRAINT x_policy_res_map_fk_res_id FOREIGN KEY (resource_id) REFERENCES public.x_policy_resource(id);


--
-- Name: x_policy_resource_map x_policy_res_map_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_policy_resource_map
    ADD CONSTRAINT x_policy_res_map_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_portal_user x_portal_user_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user
    ADD CONSTRAINT x_portal_user_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_portal_user x_portal_user_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user
    ADD CONSTRAINT x_portal_user_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_portal_user_role x_portal_user_role_fk_addedby; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user_role
    ADD CONSTRAINT x_portal_user_role_fk_addedby FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_portal_user_role x_portal_user_role_fk_updby; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user_role
    ADD CONSTRAINT x_portal_user_role_fk_updby FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_portal_user_role x_portal_user_role_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_portal_user_role
    ADD CONSTRAINT x_portal_user_role_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_ranger_global_state x_ranger_global_state_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_ranger_global_state
    ADD CONSTRAINT x_ranger_global_state_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_ranger_global_state x_ranger_global_state_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_ranger_global_state
    ADD CONSTRAINT x_ranger_global_state_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_resource_def x_resource_def_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource_def
    ADD CONSTRAINT x_resource_def_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_resource_def x_resource_def_fk_defid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource_def
    ADD CONSTRAINT x_resource_def_fk_defid FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_resource_def x_resource_def_fk_parent; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource_def
    ADD CONSTRAINT x_resource_def_fk_parent FOREIGN KEY (parent) REFERENCES public.x_resource_def(id);


--
-- Name: x_resource_def x_resource_def_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource_def
    ADD CONSTRAINT x_resource_def_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_resource x_resource_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource
    ADD CONSTRAINT x_resource_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_resource x_resource_fk_asset_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource
    ADD CONSTRAINT x_resource_fk_asset_id FOREIGN KEY (asset_id) REFERENCES public.x_asset(id);


--
-- Name: x_resource x_resource_fk_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource
    ADD CONSTRAINT x_resource_fk_parent_id FOREIGN KEY (parent_id) REFERENCES public.x_resource(id);


--
-- Name: x_resource x_resource_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_resource
    ADD CONSTRAINT x_resource_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_rms_notification x_rms_notification_fk_hl_service_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_notification
    ADD CONSTRAINT x_rms_notification_fk_hl_service_id FOREIGN KEY (hl_service_id) REFERENCES public.x_service(id);


--
-- Name: x_rms_notification x_rms_notification_fk_ll_service_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_notification
    ADD CONSTRAINT x_rms_notification_fk_ll_service_id FOREIGN KEY (ll_service_id) REFERENCES public.x_service(id);


--
-- Name: x_rms_resource_mapping x_rms_res_map_fk_hl_res_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_resource_mapping
    ADD CONSTRAINT x_rms_res_map_fk_hl_res_id FOREIGN KEY (hl_resource_id) REFERENCES public.x_rms_service_resource(id);


--
-- Name: x_rms_resource_mapping x_rms_res_map_fk_ll_res_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_resource_mapping
    ADD CONSTRAINT x_rms_res_map_fk_ll_res_id FOREIGN KEY (ll_resource_id) REFERENCES public.x_rms_service_resource(id);


--
-- Name: x_rms_service_resource x_rms_service_res_fk_service_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_rms_service_resource
    ADD CONSTRAINT x_rms_service_res_fk_service_id FOREIGN KEY (service_id) REFERENCES public.x_service(id);


--
-- Name: x_role x_role_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role
    ADD CONSTRAINT x_role_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role x_role_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role
    ADD CONSTRAINT x_role_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_group x_role_ref_grp_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_group
    ADD CONSTRAINT x_role_ref_grp_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_group x_role_ref_grp_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_group
    ADD CONSTRAINT x_role_ref_grp_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_role_ref_group x_role_ref_grp_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_group
    ADD CONSTRAINT x_role_ref_grp_fk_role_id FOREIGN KEY (role_id) REFERENCES public.x_role(id);


--
-- Name: x_role_ref_group x_role_ref_grp_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_group
    ADD CONSTRAINT x_role_ref_grp_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_role x_role_ref_role_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_role
    ADD CONSTRAINT x_role_ref_role_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_role x_role_ref_role_fk_role_ref_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_role
    ADD CONSTRAINT x_role_ref_role_fk_role_ref_id FOREIGN KEY (role_ref_id) REFERENCES public.x_role(id);


--
-- Name: x_role_ref_role x_role_ref_role_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_role
    ADD CONSTRAINT x_role_ref_role_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_user x_role_ref_user_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_user
    ADD CONSTRAINT x_role_ref_user_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_user x_role_ref_user_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_user
    ADD CONSTRAINT x_role_ref_user_fk_role_id FOREIGN KEY (role_id) REFERENCES public.x_role(id);


--
-- Name: x_role_ref_user x_role_ref_user_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_user
    ADD CONSTRAINT x_role_ref_user_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_role_ref_user x_role_ref_user_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_role_ref_user
    ADD CONSTRAINT x_role_ref_user_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_security_zone x_security_zone_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone
    ADD CONSTRAINT x_security_zone_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone x_security_zone_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone
    ADD CONSTRAINT x_security_zone_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_config_def x_service_conf_def_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_def
    ADD CONSTRAINT x_service_conf_def_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_config_def x_service_conf_def_fk_defid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_def
    ADD CONSTRAINT x_service_conf_def_fk_defid FOREIGN KEY (def_id) REFERENCES public.x_service_def(id);


--
-- Name: x_service_config_def x_service_conf_def_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_def
    ADD CONSTRAINT x_service_conf_def_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_config_map x_service_conf_map_fk_added_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_map
    ADD CONSTRAINT x_service_conf_map_fk_added_by FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_config_map x_service_conf_map_fk_service; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_map
    ADD CONSTRAINT x_service_conf_map_fk_service FOREIGN KEY (service) REFERENCES public.x_service(id);


--
-- Name: x_service_config_map x_service_conf_map_fk_upd_by; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_config_map
    ADD CONSTRAINT x_service_conf_map_fk_upd_by FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_def x_service_def_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_def
    ADD CONSTRAINT x_service_def_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_def x_service_def_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_def
    ADD CONSTRAINT x_service_def_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service x_service_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service
    ADD CONSTRAINT x_service_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service x_service_fk_tag_service; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service
    ADD CONSTRAINT x_service_fk_tag_service FOREIGN KEY (tag_service) REFERENCES public.x_service(id);


--
-- Name: x_service x_service_fk_type; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service
    ADD CONSTRAINT x_service_fk_type FOREIGN KEY (type) REFERENCES public.x_service_def(id);


--
-- Name: x_service x_service_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service
    ADD CONSTRAINT x_service_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_resource x_service_res_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_resource
    ADD CONSTRAINT x_service_res_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_resource x_service_res_fk_service_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_resource
    ADD CONSTRAINT x_service_res_fk_service_id FOREIGN KEY (service_id) REFERENCES public.x_service(id);


--
-- Name: x_service_resource x_service_res_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_resource
    ADD CONSTRAINT x_service_res_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_service_version_info x_service_version_info_service_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_service_version_info
    ADD CONSTRAINT x_service_version_info_service_id FOREIGN KEY (service_id) REFERENCES public.x_service(id);


--
-- Name: x_security_zone_ref_group x_sz_ref_group_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_group
    ADD CONSTRAINT x_sz_ref_group_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_group x_sz_ref_group_fk_group_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_group
    ADD CONSTRAINT x_sz_ref_group_fk_group_id FOREIGN KEY (group_id) REFERENCES public.x_group(id);


--
-- Name: x_security_zone_ref_group x_sz_ref_group_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_group
    ADD CONSTRAINT x_sz_ref_group_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_group x_sz_ref_group_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_group
    ADD CONSTRAINT x_sz_ref_group_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_security_zone_ref_resource x_sz_ref_res_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_resource
    ADD CONSTRAINT x_sz_ref_res_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_resource x_sz_ref_res_fk_resource_def_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_resource
    ADD CONSTRAINT x_sz_ref_res_fk_resource_def_id FOREIGN KEY (resource_def_id) REFERENCES public.x_resource_def(id);


--
-- Name: x_security_zone_ref_resource x_sz_ref_res_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_resource
    ADD CONSTRAINT x_sz_ref_res_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_role x_sz_ref_role_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_role
    ADD CONSTRAINT x_sz_ref_role_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_role x_sz_ref_role_fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_role
    ADD CONSTRAINT x_sz_ref_role_fk_role_id FOREIGN KEY (role_id) REFERENCES public.x_role(id);


--
-- Name: x_security_zone_ref_role x_sz_ref_role_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_role
    ADD CONSTRAINT x_sz_ref_role_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_role x_sz_ref_role_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_role
    ADD CONSTRAINT x_sz_ref_role_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_security_zone_ref_service x_sz_ref_service_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_service
    ADD CONSTRAINT x_sz_ref_service_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_service x_sz_ref_service_fk_service_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_service
    ADD CONSTRAINT x_sz_ref_service_fk_service_id FOREIGN KEY (service_id) REFERENCES public.x_service(id);


--
-- Name: x_security_zone_ref_service x_sz_ref_service_fk_service_name; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_service
    ADD CONSTRAINT x_sz_ref_service_fk_service_name FOREIGN KEY (service_name) REFERENCES public.x_service(name);


--
-- Name: x_security_zone_ref_service x_sz_ref_service_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_service
    ADD CONSTRAINT x_sz_ref_service_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_service x_sz_ref_service_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_service
    ADD CONSTRAINT x_sz_ref_service_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_security_zone_ref_resource x_sz_ref_service_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_resource
    ADD CONSTRAINT x_sz_ref_service_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_security_zone_ref_user x_sz_ref_user_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_user
    ADD CONSTRAINT x_sz_ref_user_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_user x_sz_ref_user_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_user
    ADD CONSTRAINT x_sz_ref_user_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_user x_sz_ref_user_fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_user
    ADD CONSTRAINT x_sz_ref_user_fk_user_id FOREIGN KEY (user_id) REFERENCES public.x_user(id);


--
-- Name: x_security_zone_ref_user x_sz_ref_user_fk_user_name; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_user
    ADD CONSTRAINT x_sz_ref_user_fk_user_name FOREIGN KEY (user_name) REFERENCES public.x_user(user_name);


--
-- Name: x_security_zone_ref_user x_sz_ref_user_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_user
    ADD CONSTRAINT x_sz_ref_user_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_security_zone_ref_tag_srvc x_sz_reftagsrvc_fk_aded_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_tag_srvc
    ADD CONSTRAINT x_sz_reftagsrvc_fk_aded_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_tag_srvc x_sz_reftagsrvc_fk_tag_srvc_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_tag_srvc
    ADD CONSTRAINT x_sz_reftagsrvc_fk_tag_srvc_id FOREIGN KEY (tag_srvc_id) REFERENCES public.x_service(id);


--
-- Name: x_security_zone_ref_tag_srvc x_sz_reftagsrvc_fk_tag_srvc_name; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_tag_srvc
    ADD CONSTRAINT x_sz_reftagsrvc_fk_tag_srvc_name FOREIGN KEY (tag_srvc_name) REFERENCES public.x_service(name);


--
-- Name: x_security_zone_ref_tag_srvc x_sz_reftagsrvc_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_tag_srvc
    ADD CONSTRAINT x_sz_reftagsrvc_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_security_zone_ref_tag_srvc x_sz_reftagsrvc_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_security_zone_ref_tag_srvc
    ADD CONSTRAINT x_sz_reftagsrvc_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.x_security_zone(id);


--
-- Name: x_tag_def x_tag_def_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_def
    ADD CONSTRAINT x_tag_def_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_tag_def x_tag_def_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_def
    ADD CONSTRAINT x_tag_def_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_tag x_tag_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag
    ADD CONSTRAINT x_tag_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_tag x_tag_fk_type; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag
    ADD CONSTRAINT x_tag_fk_type FOREIGN KEY (type) REFERENCES public.x_tag_def(id);


--
-- Name: x_tag x_tag_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag
    ADD CONSTRAINT x_tag_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_tag_resource_map x_tag_res_map_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_resource_map
    ADD CONSTRAINT x_tag_res_map_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_tag_resource_map x_tag_res_map_fk_res_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_resource_map
    ADD CONSTRAINT x_tag_res_map_fk_res_id FOREIGN KEY (res_id) REFERENCES public.x_service_resource(id);


--
-- Name: x_tag_resource_map x_tag_res_map_fk_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_resource_map
    ADD CONSTRAINT x_tag_res_map_fk_tag_id FOREIGN KEY (tag_id) REFERENCES public.x_tag(id);


--
-- Name: x_tag_resource_map x_tag_res_map_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_tag_resource_map
    ADD CONSTRAINT x_tag_res_map_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_trx_log x_trx_log_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_trx_log
    ADD CONSTRAINT x_trx_log_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_trx_log x_trx_log_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_trx_log
    ADD CONSTRAINT x_trx_log_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_user x_user_fk_added_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user
    ADD CONSTRAINT x_user_fk_added_by_id FOREIGN KEY (added_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_user x_user_fk_cred_store_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user
    ADD CONSTRAINT x_user_fk_cred_store_id FOREIGN KEY (cred_store_id) REFERENCES public.x_cred_store(id);


--
-- Name: x_user x_user_fk_upd_by_id; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user
    ADD CONSTRAINT x_user_fk_upd_by_id FOREIGN KEY (upd_by_id) REFERENCES public.x_portal_user(id);


--
-- Name: x_user_module_perm x_user_module_perm_fk_moduleid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user_module_perm
    ADD CONSTRAINT x_user_module_perm_fk_moduleid FOREIGN KEY (module_id) REFERENCES public.x_modules_master(id);


--
-- Name: x_user_module_perm x_user_module_perm_fk_userid; Type: FK CONSTRAINT; Schema: public; Owner: rangeradmin
--

ALTER TABLE ONLY public.x_user_module_perm
    ADD CONSTRAINT x_user_module_perm_fk_userid FOREIGN KEY (user_id) REFERENCES public.x_portal_user(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO rangeradmin;


--
-- PostgreSQL database dump complete
--

