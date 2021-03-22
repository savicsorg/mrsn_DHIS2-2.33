--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-1.pgdg16.04+1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-1.pgdg16.04+1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: generate_uid(); Type: FUNCTION; Schema: public; Owner: dhis
--

CREATE FUNCTION public.generate_uid() RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
chars  text [] := '{0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z}';
 result text := chars [11 + random() * (array_length(chars, 1) - 11)];
begin
 for i in 1..10 loop
 result := result || chars [1 + random() * (array_length(chars, 1) - 1)];
 end loop;
return result;
end;
$$;


ALTER FUNCTION public.generate_uid() OWNER TO dhis;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: attribute; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.attribute (
    attributeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50),
    description text,
    valuetype character varying(50) NOT NULL,
    mandatory boolean NOT NULL,
    isunique boolean,
    dataelementattribute boolean NOT NULL,
    dataelementgroupattribute boolean,
    indicatorattribute boolean NOT NULL,
    indicatorgroupattribute boolean,
    datasetattribute boolean,
    organisationunitattribute boolean NOT NULL,
    organisationunitgroupattribute boolean,
    organisationunitgroupsetattribute boolean,
    userattribute boolean NOT NULL,
    usergroupattribute boolean,
    programattribute boolean,
    programstageattribute boolean,
    trackedentitytypeattribute boolean,
    trackedentityattributeattribute boolean,
    categoryoptionattribute boolean,
    categoryoptiongroupattribute boolean,
    documentattribute boolean,
    optionattribute boolean,
    optionsetattribute boolean,
    constantattribute boolean,
    legendsetattribute boolean,
    programindicatorattribute boolean,
    sqlviewattribute boolean,
    sectionattribute boolean,
    categoryoptioncomboattribute boolean,
    categoryoptiongroupsetattribute boolean,
    dataelementgroupsetattribute boolean,
    validationruleattribute boolean,
    validationrulegroupattribute boolean,
    categoryattribute boolean,
    sortorder integer,
    optionsetid bigint,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.attribute OWNER TO dhis;

--
-- Name: attributeuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.attributeuseraccesses (
    attributeid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.attributeuseraccesses OWNER TO dhis;

--
-- Name: attributeusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.attributeusergroupaccesses (
    attributeid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.attributeusergroupaccesses OWNER TO dhis;

--
-- Name: attributevalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.attributevalue (
    attributevalueid bigint NOT NULL,
    created timestamp without time zone,
    lastupdated timestamp without time zone,
    value text,
    attributeid bigint NOT NULL
);


ALTER TABLE public.attributevalue OWNER TO dhis;

--
-- Name: categories_categoryoptions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categories_categoryoptions (
    categoryid bigint NOT NULL,
    sort_order integer NOT NULL,
    categoryoptionid bigint NOT NULL
);


ALTER TABLE public.categories_categoryoptions OWNER TO dhis;

--
-- Name: categoryattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryattributevalues (
    categoryid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.categoryattributevalues OWNER TO dhis;

--
-- Name: categorycombo; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorycombo (
    categorycomboid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    datadimensiontype character varying(255) NOT NULL,
    skiptotal boolean NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.categorycombo OWNER TO dhis;

--
-- Name: categorycombos_categories; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorycombos_categories (
    categoryid bigint,
    sort_order integer NOT NULL,
    categorycomboid bigint NOT NULL
);


ALTER TABLE public.categorycombos_categories OWNER TO dhis;

--
-- Name: categorycombos_optioncombos; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorycombos_optioncombos (
    categoryoptioncomboid bigint NOT NULL,
    categorycomboid bigint NOT NULL
);


ALTER TABLE public.categorycombos_optioncombos OWNER TO dhis;

--
-- Name: categorycombouseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorycombouseraccesses (
    categorycomboid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.categorycombouseraccesses OWNER TO dhis;

--
-- Name: categorycombousergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorycombousergroupaccesses (
    categorycomboid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.categorycombousergroupaccesses OWNER TO dhis;

--
-- Name: categorydimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorydimension (
    categorydimensionid integer NOT NULL,
    categoryid bigint
);


ALTER TABLE public.categorydimension OWNER TO dhis;

--
-- Name: categorydimension_items; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categorydimension_items (
    categorydimensionid integer NOT NULL,
    sort_order integer NOT NULL,
    categoryoptionid bigint NOT NULL
);


ALTER TABLE public.categorydimension_items OWNER TO dhis;

--
-- Name: categoryoption_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoption_organisationunits (
    organisationunitid bigint NOT NULL,
    categoryoptionid bigint NOT NULL
);


ALTER TABLE public.categoryoption_organisationunits OWNER TO dhis;

--
-- Name: categoryoptioncombo; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptioncombo (
    categoryoptioncomboid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name text,
    ignoreapproval boolean,
    translations jsonb
);


ALTER TABLE public.categoryoptioncombo OWNER TO dhis;

--
-- Name: categoryoptioncomboattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptioncomboattributevalues (
    categoryoptioncomboid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.categoryoptioncomboattributevalues OWNER TO dhis;

--
-- Name: categoryoptioncombos_categoryoptions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptioncombos_categoryoptions (
    categoryoptioncomboid bigint NOT NULL,
    categoryoptionid bigint NOT NULL
);


ALTER TABLE public.categoryoptioncombos_categoryoptions OWNER TO dhis;

--
-- Name: categoryoptiongroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroup (
    categoryoptiongroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    datadimensiontype character varying(255),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.categoryoptiongroup OWNER TO dhis;

--
-- Name: categoryoptiongroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupattributevalues (
    categoryoptiongroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.categoryoptiongroupattributevalues OWNER TO dhis;

--
-- Name: categoryoptiongroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupmembers (
    categoryoptiongroupid bigint NOT NULL,
    categoryoptionid bigint NOT NULL
);


ALTER TABLE public.categoryoptiongroupmembers OWNER TO dhis;

--
-- Name: categoryoptiongroupset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupset (
    categoryoptiongroupsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    datadimension boolean NOT NULL,
    datadimensiontype character varying(255),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.categoryoptiongroupset OWNER TO dhis;

--
-- Name: categoryoptiongroupsetattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupsetattributevalues (
    categoryoptiongroupsetid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.categoryoptiongroupsetattributevalues OWNER TO dhis;

--
-- Name: categoryoptiongroupsetdimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupsetdimension (
    categoryoptiongroupsetdimensionid integer NOT NULL,
    categoryoptiongroupsetid bigint
);


ALTER TABLE public.categoryoptiongroupsetdimension OWNER TO dhis;

--
-- Name: categoryoptiongroupsetdimension_items; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupsetdimension_items (
    categoryoptiongroupsetdimensionid integer NOT NULL,
    sort_order integer NOT NULL,
    categoryoptiongroupid bigint NOT NULL
);


ALTER TABLE public.categoryoptiongroupsetdimension_items OWNER TO dhis;

--
-- Name: categoryoptiongroupsetmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupsetmembers (
    categoryoptiongroupid bigint,
    categoryoptiongroupsetid bigint NOT NULL,
    sort_order integer NOT NULL
);


ALTER TABLE public.categoryoptiongroupsetmembers OWNER TO dhis;

--
-- Name: categoryoptiongroupsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupsetuseraccesses (
    categoryoptiongroupsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.categoryoptiongroupsetuseraccesses OWNER TO dhis;

--
-- Name: categoryoptiongroupsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupsetusergroupaccesses (
    categoryoptiongroupsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.categoryoptiongroupsetusergroupaccesses OWNER TO dhis;

--
-- Name: categoryoptiongroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupuseraccesses (
    categoryoptiongroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.categoryoptiongroupuseraccesses OWNER TO dhis;

--
-- Name: categoryoptiongroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.categoryoptiongroupusergroupaccesses (
    categoryoptiongroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.categoryoptiongroupusergroupaccesses OWNER TO dhis;

--
-- Name: chart; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart (
    chartid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    domainaxislabel character varying(255),
    rangeaxislabel character varying(255),
    type character varying(40) NOT NULL,
    series character varying(255),
    category character varying(255),
    hidelegend boolean,
    nospacebetweencolumns boolean,
    regressiontype character varying(40) NOT NULL,
    title character varying(255),
    subtitle character varying(255),
    hidetitle boolean,
    hidesubtitle boolean,
    targetlinevalue double precision,
    targetlinelabel character varying(255),
    baselinevalue double precision,
    baselinelabel character varying(255),
    relativeperiodsid integer,
    userorganisationunit boolean,
    userorganisationunitchildren boolean,
    userorganisationunitgrandchildren boolean,
    aggregationtype character varying(40),
    completedonly boolean,
    showdata boolean,
    hideemptyrowitems character varying(40),
    percentstackedvalues boolean,
    cumulativevalues boolean,
    rangeaxismaxvalue double precision,
    rangeaxisminvalue double precision,
    rangeaxissteps integer,
    rangeaxisdecimals integer,
    legendsetid bigint,
    legenddisplaystrategy character varying(40),
    colorsetid bigint,
    sortorder integer,
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    favorites jsonb,
    subscribers jsonb,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    translations jsonb
);


ALTER TABLE public.chart OWNER TO dhis;

--
-- Name: chart_categorydimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_categorydimensions (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    categorydimensionid integer NOT NULL
);


ALTER TABLE public.chart_categorydimensions OWNER TO dhis;

--
-- Name: chart_categoryoptiongroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_categoryoptiongroupsetdimensions (
    chart bigint NOT NULL,
    sort_order integer NOT NULL,
    categoryoptiongroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.chart_categoryoptiongroupsetdimensions OWNER TO dhis;

--
-- Name: chart_datadimensionitems; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_datadimensionitems (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    datadimensionitemid integer NOT NULL
);


ALTER TABLE public.chart_datadimensionitems OWNER TO dhis;

--
-- Name: chart_dataelementgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_dataelementgroupsetdimensions (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    dataelementgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.chart_dataelementgroupsetdimensions OWNER TO dhis;

--
-- Name: chart_filters; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_filters (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    filter character varying(255)
);


ALTER TABLE public.chart_filters OWNER TO dhis;

--
-- Name: chart_itemorgunitgroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_itemorgunitgroups (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.chart_itemorgunitgroups OWNER TO dhis;

--
-- Name: chart_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_organisationunits (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.chart_organisationunits OWNER TO dhis;

--
-- Name: chart_orgunitgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_orgunitgroupsetdimensions (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.chart_orgunitgroupsetdimensions OWNER TO dhis;

--
-- Name: chart_orgunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_orgunitlevels (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitlevel integer
);


ALTER TABLE public.chart_orgunitlevels OWNER TO dhis;

--
-- Name: chart_periods; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_periods (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    periodid bigint NOT NULL
);


ALTER TABLE public.chart_periods OWNER TO dhis;

--
-- Name: chart_seriesitems; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_seriesitems (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    seriesid bigint NOT NULL
);


ALTER TABLE public.chart_seriesitems OWNER TO dhis;

--
-- Name: chart_yearlyseries; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chart_yearlyseries (
    chartid bigint NOT NULL,
    sort_order integer NOT NULL,
    yearlyseries character varying(255)
);


ALTER TABLE public.chart_yearlyseries OWNER TO dhis;

--
-- Name: chartuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chartuseraccesses (
    chartid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.chartuseraccesses OWNER TO dhis;

--
-- Name: chartusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.chartusergroupaccesses (
    chartid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.chartusergroupaccesses OWNER TO dhis;

--
-- Name: color; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.color (
    colorid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    color character varying(255),
    translations jsonb
);


ALTER TABLE public.color OWNER TO dhis;

--
-- Name: colorset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.colorset (
    colorsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    translations jsonb
);


ALTER TABLE public.colorset OWNER TO dhis;

--
-- Name: colorset_colors; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.colorset_colors (
    colorsetid bigint NOT NULL,
    sort_order integer NOT NULL,
    colorid bigint NOT NULL
);


ALTER TABLE public.colorset_colors OWNER TO dhis;

--
-- Name: completedatasetregistration; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.completedatasetregistration (
    datasetid bigint NOT NULL,
    periodid bigint NOT NULL,
    sourceid bigint NOT NULL,
    attributeoptioncomboid bigint NOT NULL,
    date timestamp without time zone,
    storedby character varying(255),
    lastupdatedby character varying(255),
    lastupdated timestamp without time zone,
    completed boolean NOT NULL
);


ALTER TABLE public.completedatasetregistration OWNER TO dhis;

--
-- Name: configuration; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.configuration (
    configurationid integer NOT NULL,
    systemid character varying(255),
    feedbackrecipientsid bigint,
    offlineorgunitlevelid bigint,
    infrastructuralindicatorsid bigint,
    infrastructuraldataelementsid bigint,
    infrastructuralperiodtypeid integer,
    selfregistrationrole bigint,
    selfregistrationorgunit bigint
);


ALTER TABLE public.configuration OWNER TO dhis;

--
-- Name: configuration_corswhitelist; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.configuration_corswhitelist (
    configurationid integer NOT NULL,
    corswhitelist character varying(255)
);


ALTER TABLE public.configuration_corswhitelist OWNER TO dhis;

--
-- Name: constant; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.constant (
    constantid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50),
    description text,
    value double precision NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.constant OWNER TO dhis;

--
-- Name: constantattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.constantattributevalues (
    constantid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.constantattributevalues OWNER TO dhis;

--
-- Name: constantuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.constantuseraccesses (
    constantid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.constantuseraccesses OWNER TO dhis;

--
-- Name: constantusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.constantusergroupaccesses (
    constantid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.constantusergroupaccesses OWNER TO dhis;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboard (
    dashboardid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    userid bigint,
    externalaccess boolean,
    publicaccess character varying(8),
    favorites jsonb,
    translations jsonb
);


ALTER TABLE public.dashboard OWNER TO dhis;

--
-- Name: dashboard_items; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboard_items (
    dashboardid bigint NOT NULL,
    sort_order integer NOT NULL,
    dashboarditemid bigint NOT NULL
);


ALTER TABLE public.dashboard_items OWNER TO dhis;

--
-- Name: dashboarditem; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboarditem (
    dashboarditemid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    chartid bigint,
    eventchartid bigint,
    mapid bigint,
    reporttable bigint,
    textcontent text,
    messages boolean,
    appkey character varying(255),
    shape character varying(50),
    x integer,
    y integer,
    height integer,
    width integer,
    eventreport bigint,
    translations jsonb
);


ALTER TABLE public.dashboarditem OWNER TO dhis;

--
-- Name: dashboarditem_reports; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboarditem_reports (
    dashboarditemid bigint NOT NULL,
    sort_order integer NOT NULL,
    reportid bigint NOT NULL
);


ALTER TABLE public.dashboarditem_reports OWNER TO dhis;

--
-- Name: dashboarditem_resources; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboarditem_resources (
    dashboarditemid bigint NOT NULL,
    sort_order integer NOT NULL,
    resourceid bigint NOT NULL
);


ALTER TABLE public.dashboarditem_resources OWNER TO dhis;

--
-- Name: dashboarditem_users; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboarditem_users (
    dashboarditemid bigint NOT NULL,
    sort_order integer NOT NULL,
    userid bigint NOT NULL
);


ALTER TABLE public.dashboarditem_users OWNER TO dhis;

--
-- Name: dashboarduseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboarduseraccesses (
    dashboardid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dashboarduseraccesses OWNER TO dhis;

--
-- Name: dashboardusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dashboardusergroupaccesses (
    dashboardid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dashboardusergroupaccesses OWNER TO dhis;

--
-- Name: dataapproval; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapproval (
    dataapprovalid integer NOT NULL,
    dataapprovallevelid bigint NOT NULL,
    workflowid bigint NOT NULL,
    periodid bigint NOT NULL,
    organisationunitid bigint NOT NULL,
    attributeoptioncomboid bigint NOT NULL,
    accepted boolean NOT NULL,
    created timestamp without time zone NOT NULL,
    creator bigint NOT NULL
);


ALTER TABLE public.dataapproval OWNER TO dhis;

--
-- Name: dataapprovalaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovalaudit (
    dataapprovalauditid integer NOT NULL,
    levelid bigint NOT NULL,
    workflowid bigint NOT NULL,
    periodid bigint NOT NULL,
    organisationunitid bigint NOT NULL,
    attributeoptioncomboid bigint NOT NULL,
    action character varying(100) NOT NULL,
    created timestamp without time zone NOT NULL,
    creator bigint NOT NULL
);


ALTER TABLE public.dataapprovalaudit OWNER TO dhis;

--
-- Name: dataapprovallevel; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovallevel (
    dataapprovallevelid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    level integer NOT NULL,
    orgunitlevel integer NOT NULL,
    categoryoptiongroupsetid bigint,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.dataapprovallevel OWNER TO dhis;

--
-- Name: dataapprovalleveluseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovalleveluseraccesses (
    dataapprovallevelid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataapprovalleveluseraccesses OWNER TO dhis;

--
-- Name: dataapprovallevelusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovallevelusergroupaccesses (
    dataapprovallevelid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataapprovallevelusergroupaccesses OWNER TO dhis;

--
-- Name: dataapprovalworkflow; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovalworkflow (
    workflowid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    periodtypeid integer NOT NULL,
    categorycomboid bigint,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.dataapprovalworkflow OWNER TO dhis;

--
-- Name: dataapprovalworkflowlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovalworkflowlevels (
    workflowid bigint NOT NULL,
    dataapprovallevelid bigint NOT NULL
);


ALTER TABLE public.dataapprovalworkflowlevels OWNER TO dhis;

--
-- Name: dataapprovalworkflowuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovalworkflowuseraccesses (
    workflowid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataapprovalworkflowuseraccesses OWNER TO dhis;

--
-- Name: dataapprovalworkflowusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataapprovalworkflowusergroupaccesses (
    workflowid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataapprovalworkflowusergroupaccesses OWNER TO dhis;

--
-- Name: datadimensionitem; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datadimensionitem (
    datadimensionitemid integer NOT NULL,
    indicatorid bigint,
    dataelementid bigint,
    dataelementoperand_dataelementid bigint,
    dataelementoperand_categoryoptioncomboid bigint,
    datasetid bigint,
    metric character varying(50),
    programindicatorid bigint,
    programdataelement_programid bigint,
    programdataelement_dataelementid bigint,
    programattribute_programid bigint,
    programattribute_attributeid bigint
);


ALTER TABLE public.datadimensionitem OWNER TO dhis;

--
-- Name: dataelement; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelement (
    dataelementid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    description text,
    formname character varying(230),
    style jsonb,
    valuetype character varying(50) NOT NULL,
    domaintype character varying(255) NOT NULL,
    aggregationtype character varying(50) NOT NULL,
    categorycomboid bigint NOT NULL,
    url character varying(255),
    zeroissignificant boolean NOT NULL,
    optionsetid bigint,
    commentoptionsetid bigint,
    userid bigint,
    publicaccess character varying(8),
    fieldmask character varying(255),
    translations jsonb
);


ALTER TABLE public.dataelement OWNER TO dhis;

--
-- Name: dataelementaggregationlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementaggregationlevels (
    dataelementid bigint NOT NULL,
    sort_order integer NOT NULL,
    aggregationlevel integer
);


ALTER TABLE public.dataelementaggregationlevels OWNER TO dhis;

--
-- Name: dataelementattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementattributevalues (
    dataelementid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.dataelementattributevalues OWNER TO dhis;

--
-- Name: dataelementcategory; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategory (
    categoryid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    datadimensiontype character varying(255) NOT NULL,
    datadimension boolean NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.dataelementcategory OWNER TO dhis;

--
-- Name: dataelementcategoryoption; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategoryoption (
    categoryoptionid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50),
    startdate date,
    enddate date,
    style jsonb,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.dataelementcategoryoption OWNER TO dhis;

--
-- Name: dataelementcategoryoptionattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategoryoptionattributevalues (
    categoryoptionid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.dataelementcategoryoptionattributevalues OWNER TO dhis;

--
-- Name: dataelementcategoryoptionuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategoryoptionuseraccesses (
    categoryoptionid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataelementcategoryoptionuseraccesses OWNER TO dhis;

--
-- Name: dataelementcategoryoptionusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategoryoptionusergroupaccesses (
    categoryoptionid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataelementcategoryoptionusergroupaccesses OWNER TO dhis;

--
-- Name: dataelementcategoryuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategoryuseraccesses (
    categoryid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataelementcategoryuseraccesses OWNER TO dhis;

--
-- Name: dataelementcategoryusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementcategoryusergroupaccesses (
    categoryid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataelementcategoryusergroupaccesses OWNER TO dhis;

--
-- Name: dataelementgroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroup (
    dataelementgroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.dataelementgroup OWNER TO dhis;

--
-- Name: dataelementgroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupattributevalues (
    dataelementgroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.dataelementgroupattributevalues OWNER TO dhis;

--
-- Name: dataelementgroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupmembers (
    dataelementid bigint NOT NULL,
    dataelementgroupid bigint NOT NULL
);


ALTER TABLE public.dataelementgroupmembers OWNER TO dhis;

--
-- Name: dataelementgroupset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupset (
    dataelementgroupsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    compulsory boolean,
    datadimension boolean NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.dataelementgroupset OWNER TO dhis;

--
-- Name: dataelementgroupsetattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupsetattributevalues (
    dataelementgroupsetid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.dataelementgroupsetattributevalues OWNER TO dhis;

--
-- Name: dataelementgroupsetdimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupsetdimension (
    dataelementgroupsetdimensionid integer NOT NULL,
    dataelementgroupsetid bigint
);


ALTER TABLE public.dataelementgroupsetdimension OWNER TO dhis;

--
-- Name: dataelementgroupsetdimension_items; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupsetdimension_items (
    dataelementgroupsetdimensionid integer NOT NULL,
    sort_order integer NOT NULL,
    dataelementgroupid bigint NOT NULL
);


ALTER TABLE public.dataelementgroupsetdimension_items OWNER TO dhis;

--
-- Name: dataelementgroupsetmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupsetmembers (
    dataelementgroupsetid bigint NOT NULL,
    sort_order integer NOT NULL,
    dataelementgroupid bigint NOT NULL
);


ALTER TABLE public.dataelementgroupsetmembers OWNER TO dhis;

--
-- Name: dataelementgroupsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupsetuseraccesses (
    dataelementgroupsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataelementgroupsetuseraccesses OWNER TO dhis;

--
-- Name: dataelementgroupsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupsetusergroupaccesses (
    dataelementgroupsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataelementgroupsetusergroupaccesses OWNER TO dhis;

--
-- Name: dataelementgroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupuseraccesses (
    dataelementgroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataelementgroupuseraccesses OWNER TO dhis;

--
-- Name: dataelementgroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementgroupusergroupaccesses (
    dataelementgroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataelementgroupusergroupaccesses OWNER TO dhis;

--
-- Name: dataelementlegendsets; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementlegendsets (
    dataelementid bigint NOT NULL,
    sort_order integer NOT NULL,
    legendsetid bigint NOT NULL
);


ALTER TABLE public.dataelementlegendsets OWNER TO dhis;

--
-- Name: dataelementoperand; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementoperand (
    dataelementoperandid bigint NOT NULL,
    dataelementid bigint,
    categoryoptioncomboid bigint
);


ALTER TABLE public.dataelementoperand OWNER TO dhis;

--
-- Name: dataelementuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementuseraccesses (
    dataelementid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.dataelementuseraccesses OWNER TO dhis;

--
-- Name: dataelementusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataelementusergroupaccesses (
    dataelementid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.dataelementusergroupaccesses OWNER TO dhis;

--
-- Name: dataentryform; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataentryform (
    dataentryformid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(160) NOT NULL,
    style character varying(40),
    htmlcode text,
    format integer,
    translations jsonb
);


ALTER TABLE public.dataentryform OWNER TO dhis;

--
-- Name: datainputperiod; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datainputperiod (
    datainputperiodid integer NOT NULL,
    periodid bigint NOT NULL,
    openingdate timestamp without time zone,
    closingdate timestamp without time zone,
    datasetid bigint
);


ALTER TABLE public.datainputperiod OWNER TO dhis;

--
-- Name: dataset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.dataset (
    datasetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50),
    description text,
    formname text,
    style jsonb,
    periodtypeid integer NOT NULL,
    categorycomboid bigint NOT NULL,
    mobile boolean NOT NULL,
    version integer,
    expirydays integer,
    timelydays integer,
    notifycompletinguser boolean,
    workflowid bigint,
    openfutureperiods integer,
    fieldcombinationrequired boolean,
    validcompleteonly boolean,
    novaluerequirescomment boolean,
    skipoffline boolean,
    dataelementdecoration boolean,
    renderastabs boolean,
    renderhorizontally boolean,
    compulsoryfieldscompleteonly boolean,
    userid bigint,
    publicaccess character varying(8),
    dataentryform bigint,
    notificationrecipients bigint,
    translations jsonb
);


ALTER TABLE public.dataset OWNER TO dhis;

--
-- Name: datasetattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetattributevalues (
    datasetid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.datasetattributevalues OWNER TO dhis;

--
-- Name: datasetelement; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetelement (
    datasetelementid integer NOT NULL,
    datasetid bigint,
    dataelementid bigint NOT NULL,
    categorycomboid bigint
);


ALTER TABLE public.datasetelement OWNER TO dhis;

--
-- Name: datasetindicators; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetindicators (
    indicatorid bigint NOT NULL,
    datasetid bigint NOT NULL
);


ALTER TABLE public.datasetindicators OWNER TO dhis;

--
-- Name: datasetlegendsets; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetlegendsets (
    datasetid bigint NOT NULL,
    sort_order integer NOT NULL,
    legendsetid bigint NOT NULL
);


ALTER TABLE public.datasetlegendsets OWNER TO dhis;

--
-- Name: datasetnotification_datasets; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetnotification_datasets (
    datasetnotificationtemplateid bigint NOT NULL,
    datasetid bigint NOT NULL
);


ALTER TABLE public.datasetnotification_datasets OWNER TO dhis;

--
-- Name: datasetnotificationtemplate; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetnotificationtemplate (
    datasetnotificationtemplateid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    subjecttemplate character varying(100),
    messagetemplate text NOT NULL,
    relativescheduleddays integer,
    notifyparentorganisationunitonly boolean,
    notifyusersinhierarchyonly boolean,
    sendstrategy character varying(50),
    usergroupid bigint,
    datasetnotificationtrigger character varying(255),
    notificationrecipienttype character varying(255)
);


ALTER TABLE public.datasetnotificationtemplate OWNER TO dhis;

--
-- Name: datasetnotificationtemplate_deliverychannel; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetnotificationtemplate_deliverychannel (
    datasetnotificationtemplateid bigint NOT NULL,
    deliverychannel character varying(255)
);


ALTER TABLE public.datasetnotificationtemplate_deliverychannel OWNER TO dhis;

--
-- Name: datasetoperands; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetoperands (
    datasetid bigint NOT NULL,
    dataelementoperandid bigint NOT NULL
);


ALTER TABLE public.datasetoperands OWNER TO dhis;

--
-- Name: datasetsource; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetsource (
    sourceid bigint NOT NULL,
    datasetid bigint NOT NULL
);


ALTER TABLE public.datasetsource OWNER TO dhis;

--
-- Name: datasetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetuseraccesses (
    datasetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.datasetuseraccesses OWNER TO dhis;

--
-- Name: datasetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datasetusergroupaccesses (
    datasetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.datasetusergroupaccesses OWNER TO dhis;

--
-- Name: datastatistics; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datastatistics (
    statisticsid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    chartviews double precision,
    mapviews double precision,
    reporttableviews double precision,
    eventreportviews double precision,
    eventchartviews double precision,
    dashboardviews double precision,
    datasetreportviews double precision,
    active_users integer,
    totalviews double precision,
    charts double precision,
    maps double precision,
    reporttables double precision,
    eventreports double precision,
    eventcharts double precision,
    dashboards double precision,
    indicators double precision,
    datavalues double precision,
    users integer
);


ALTER TABLE public.datastatistics OWNER TO dhis;

--
-- Name: datastatisticsevent; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datastatisticsevent (
    eventid integer NOT NULL,
    eventtype character varying,
    "timestamp" timestamp without time zone,
    username character varying(255),
    favoriteuid character varying(255)
);


ALTER TABLE public.datastatisticsevent OWNER TO dhis;

--
-- Name: datavalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datavalue (
    dataelementid bigint NOT NULL,
    periodid bigint NOT NULL,
    sourceid bigint NOT NULL,
    categoryoptioncomboid bigint NOT NULL,
    attributeoptioncomboid bigint NOT NULL,
    value character varying(50000),
    storedby character varying(255),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    comment character varying(50000),
    followup boolean,
    deleted boolean NOT NULL
);


ALTER TABLE public.datavalue OWNER TO dhis;

--
-- Name: datavalueaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.datavalueaudit (
    datavalueauditid bigint NOT NULL,
    dataelementid bigint NOT NULL,
    periodid bigint NOT NULL,
    organisationunitid bigint NOT NULL,
    categoryoptioncomboid bigint NOT NULL,
    attributeoptioncomboid bigint NOT NULL,
    value character varying(50000),
    created timestamp without time zone,
    modifiedby character varying(100),
    audittype character varying(100) NOT NULL
);


ALTER TABLE public.datavalueaudit OWNER TO dhis;

--
-- Name: datavalueaudit_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.datavalueaudit_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datavalueaudit_sequence OWNER TO dhis;

--
-- Name: deletedobject; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.deletedobject (
    deletedobjectid bigint NOT NULL,
    klass character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    code character varying(255),
    deleted_at timestamp without time zone NOT NULL,
    deleted_by character varying(255)
);


ALTER TABLE public.deletedobject OWNER TO dhis;

--
-- Name: deletedobject_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.deletedobject_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deletedobject_sequence OWNER TO dhis;

--
-- Name: document; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.document (
    documentid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    url text NOT NULL,
    fileresource bigint,
    external boolean NOT NULL,
    contenttype character varying(255),
    attachment boolean,
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.document OWNER TO dhis;

--
-- Name: documentattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.documentattributevalues (
    documentid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.documentattributevalues OWNER TO dhis;

--
-- Name: documentuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.documentuseraccesses (
    documentid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.documentuseraccesses OWNER TO dhis;

--
-- Name: documentusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.documentusergroupaccesses (
    documentid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.documentusergroupaccesses OWNER TO dhis;

--
-- Name: eventchart; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart (
    eventchartid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    relativeperiodsid integer,
    userorganisationunit boolean,
    userorganisationunitchildren boolean,
    userorganisationunitgrandchildren boolean,
    programid bigint NOT NULL,
    programstageid bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    dataelementvaluedimensionid bigint,
    attributevaluedimensionid bigint,
    aggregationtype character varying(40),
    completedonly boolean,
    timefield character varying(255),
    title character varying(255),
    subtitle character varying(255),
    hidetitle boolean,
    hidesubtitle boolean,
    type character varying(40) NOT NULL,
    showdata boolean,
    hideemptyrowitems character varying(40),
    hidenadata boolean,
    programstatus character varying(40),
    eventstatus character varying(40),
    percentstackedvalues boolean,
    cumulativevalues boolean,
    rangeaxismaxvalue double precision,
    rangeaxisminvalue double precision,
    rangeaxissteps integer,
    rangeaxisdecimals integer,
    outputtype character varying(30),
    collapsedatadimensions boolean,
    domainaxislabel character varying(255),
    rangeaxislabel character varying(255),
    hidelegend boolean,
    nospacebetweencolumns boolean,
    regressiontype character varying(40) NOT NULL,
    targetlinevalue double precision,
    targetlinelabel character varying(255),
    baselinevalue double precision,
    baselinelabel character varying(255),
    sortorder integer,
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    favorites jsonb,
    subscribers jsonb,
    translations jsonb,
    orgunitfield character varying(255)
);


ALTER TABLE public.eventchart OWNER TO dhis;

--
-- Name: eventchart_attributedimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_attributedimensions (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentityattributedimensionid integer NOT NULL
);


ALTER TABLE public.eventchart_attributedimensions OWNER TO dhis;

--
-- Name: eventchart_categorydimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_categorydimensions (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    categorydimensionid integer NOT NULL
);


ALTER TABLE public.eventchart_categorydimensions OWNER TO dhis;

--
-- Name: eventchart_categoryoptiongroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_categoryoptiongroupsetdimensions (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    categoryoptiongroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.eventchart_categoryoptiongroupsetdimensions OWNER TO dhis;

--
-- Name: eventchart_columns; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_columns (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.eventchart_columns OWNER TO dhis;

--
-- Name: eventchart_dataelementdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_dataelementdimensions (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentitydataelementdimensionid integer NOT NULL
);


ALTER TABLE public.eventchart_dataelementdimensions OWNER TO dhis;

--
-- Name: eventchart_filters; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_filters (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.eventchart_filters OWNER TO dhis;

--
-- Name: eventchart_itemorgunitgroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_itemorgunitgroups (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.eventchart_itemorgunitgroups OWNER TO dhis;

--
-- Name: eventchart_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_organisationunits (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.eventchart_organisationunits OWNER TO dhis;

--
-- Name: eventchart_orgunitgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_orgunitgroupsetdimensions (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.eventchart_orgunitgroupsetdimensions OWNER TO dhis;

--
-- Name: eventchart_orgunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_orgunitlevels (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitlevel integer
);


ALTER TABLE public.eventchart_orgunitlevels OWNER TO dhis;

--
-- Name: eventchart_periods; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_periods (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    periodid bigint NOT NULL
);


ALTER TABLE public.eventchart_periods OWNER TO dhis;

--
-- Name: eventchart_programindicatordimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_programindicatordimensions (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentityprogramindicatordimensionid integer NOT NULL
);


ALTER TABLE public.eventchart_programindicatordimensions OWNER TO dhis;

--
-- Name: eventchart_rows; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchart_rows (
    eventchartid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.eventchart_rows OWNER TO dhis;

--
-- Name: eventchartuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchartuseraccesses (
    eventchartid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.eventchartuseraccesses OWNER TO dhis;

--
-- Name: eventchartusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventchartusergroupaccesses (
    eventchartid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.eventchartusergroupaccesses OWNER TO dhis;

--
-- Name: eventreport; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport (
    eventreportid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    relativeperiodsid integer,
    userorganisationunit boolean,
    userorganisationunitchildren boolean,
    userorganisationunitgrandchildren boolean,
    programid bigint NOT NULL,
    programstageid bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    dataelementvaluedimensionid bigint,
    attributevaluedimensionid bigint,
    aggregationtype character varying(40),
    completedonly boolean,
    timefield character varying(255),
    title character varying(255),
    subtitle character varying(255),
    hidetitle boolean,
    hidesubtitle boolean,
    datatype character varying(40),
    rowtotals boolean,
    coltotals boolean,
    rowsubtotals boolean,
    colsubtotals boolean,
    hideemptyrows boolean,
    hidenadata boolean,
    showhierarchy boolean,
    outputtype character varying(30),
    collapsedatadimensions boolean,
    showdimensionlabels boolean,
    digitgroupseparator character varying(40),
    displaydensity character varying(40),
    fontsize character varying(40),
    programstatus character varying(40),
    eventstatus character varying(40),
    sortorder integer,
    toplimit integer,
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    favorites jsonb,
    subscribers jsonb,
    translations jsonb,
    orgunitfield character varying(255)
);


ALTER TABLE public.eventreport OWNER TO dhis;

--
-- Name: eventreport_attributedimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_attributedimensions (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentityattributedimensionid integer NOT NULL
);


ALTER TABLE public.eventreport_attributedimensions OWNER TO dhis;

--
-- Name: eventreport_categorydimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_categorydimensions (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    categorydimensionid integer NOT NULL
);


ALTER TABLE public.eventreport_categorydimensions OWNER TO dhis;

--
-- Name: eventreport_categoryoptiongroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_categoryoptiongroupsetdimensions (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    categoryoptiongroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.eventreport_categoryoptiongroupsetdimensions OWNER TO dhis;

--
-- Name: eventreport_columns; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_columns (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.eventreport_columns OWNER TO dhis;

--
-- Name: eventreport_dataelementdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_dataelementdimensions (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentitydataelementdimensionid integer NOT NULL
);


ALTER TABLE public.eventreport_dataelementdimensions OWNER TO dhis;

--
-- Name: eventreport_filters; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_filters (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.eventreport_filters OWNER TO dhis;

--
-- Name: eventreport_itemorgunitgroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_itemorgunitgroups (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.eventreport_itemorgunitgroups OWNER TO dhis;

--
-- Name: eventreport_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_organisationunits (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.eventreport_organisationunits OWNER TO dhis;

--
-- Name: eventreport_orgunitgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_orgunitgroupsetdimensions (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.eventreport_orgunitgroupsetdimensions OWNER TO dhis;

--
-- Name: eventreport_orgunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_orgunitlevels (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitlevel integer
);


ALTER TABLE public.eventreport_orgunitlevels OWNER TO dhis;

--
-- Name: eventreport_periods; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_periods (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    periodid bigint NOT NULL
);


ALTER TABLE public.eventreport_periods OWNER TO dhis;

--
-- Name: eventreport_programindicatordimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_programindicatordimensions (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentityprogramindicatordimensionid integer NOT NULL
);


ALTER TABLE public.eventreport_programindicatordimensions OWNER TO dhis;

--
-- Name: eventreport_rows; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreport_rows (
    eventreportid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.eventreport_rows OWNER TO dhis;

--
-- Name: eventreportuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreportuseraccesses (
    eventreportid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.eventreportuseraccesses OWNER TO dhis;

--
-- Name: eventreportusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.eventreportusergroupaccesses (
    eventreportid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.eventreportusergroupaccesses OWNER TO dhis;

--
-- Name: expression; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.expression (
    expressionid bigint NOT NULL,
    description character varying(255),
    expression text,
    slidingwindow boolean,
    missingvaluestrategy character varying(100) NOT NULL
);


ALTER TABLE public.expression OWNER TO dhis;

--
-- Name: externalfileresource; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.externalfileresource (
    externalfileresourceid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    accesstoken character varying(255),
    expires timestamp without time zone,
    fileresourceid bigint NOT NULL
);


ALTER TABLE public.externalfileresource OWNER TO dhis;

--
-- Name: externalmaplayer; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.externalmaplayer (
    externalmaplayerid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    attribution text,
    url text NOT NULL,
    legendseturl text,
    maplayerposition bytea NOT NULL,
    layers text,
    imageformat bytea NOT NULL,
    mapservice bytea NOT NULL,
    legendsetid bigint,
    userid bigint,
    publicaccess character varying(8)
);


ALTER TABLE public.externalmaplayer OWNER TO dhis;

--
-- Name: externalmaplayeruseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.externalmaplayeruseraccesses (
    externalmaplayerid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.externalmaplayeruseraccesses OWNER TO dhis;

--
-- Name: externalmaplayerusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.externalmaplayerusergroupaccesses (
    externalmaplayerid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.externalmaplayerusergroupaccesses OWNER TO dhis;

--
-- Name: externalnotificationlogentry; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.externalnotificationlogentry (
    externalnotificationlogentryid bigint NOT NULL,
    uid character varying(11),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastsentat timestamp without time zone,
    retries integer,
    key text NOT NULL,
    templateuid text NOT NULL,
    allowmultiple boolean,
    triggerby character varying(255)
);


ALTER TABLE public.externalnotificationlogentry OWNER TO dhis;

--
-- Name: fileresource; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.fileresource (
    fileresourceid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    contenttype character varying(255) NOT NULL,
    contentlength bigint NOT NULL,
    contentmd5 character varying(32) NOT NULL,
    storagekey character varying(1024) NOT NULL,
    isassigned boolean NOT NULL,
    domain character varying(40),
    userid bigint
);


ALTER TABLE public.fileresource OWNER TO dhis;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO dhis;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO dhis;

--
-- Name: i18nlocale; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.i18nlocale (
    i18nlocaleid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(250) NOT NULL,
    locale character varying(15) NOT NULL
);


ALTER TABLE public.i18nlocale OWNER TO dhis;

--
-- Name: incomingsms; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.incomingsms (
    id integer NOT NULL,
    originator character varying(255) NOT NULL,
    encoding integer NOT NULL,
    sentdate timestamp without time zone NOT NULL,
    receiveddate timestamp without time zone NOT NULL,
    text character varying(255),
    gatewayid character varying(255) NOT NULL,
    status integer NOT NULL,
    parsed boolean,
    statusmessage character varying(255),
    userid bigint
);


ALTER TABLE public.incomingsms OWNER TO dhis;

--
-- Name: indicator; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicator (
    indicatorid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    description text,
    formname text,
    annualized boolean NOT NULL,
    decimals integer,
    indicatortypeid bigint NOT NULL,
    numerator text NOT NULL,
    numeratordescription text,
    denominator text NOT NULL,
    denominatordescription text,
    url character varying(255),
    style jsonb,
    aggregateexportcategoryoptioncombo character varying(255),
    aggregateexportattributeoptioncombo character varying(255),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.indicator OWNER TO dhis;

--
-- Name: indicatorattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorattributevalues (
    indicatorid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.indicatorattributevalues OWNER TO dhis;

--
-- Name: indicatorgroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroup (
    indicatorgroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.indicatorgroup OWNER TO dhis;

--
-- Name: indicatorgroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupattributevalues (
    indicatorgroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.indicatorgroupattributevalues OWNER TO dhis;

--
-- Name: indicatorgroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupmembers (
    indicatorid bigint NOT NULL,
    indicatorgroupid bigint NOT NULL
);


ALTER TABLE public.indicatorgroupmembers OWNER TO dhis;

--
-- Name: indicatorgroupset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupset (
    indicatorgroupsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    compulsory boolean,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.indicatorgroupset OWNER TO dhis;

--
-- Name: indicatorgroupsetmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupsetmembers (
    indicatorgroupid bigint NOT NULL,
    indicatorgroupsetid bigint NOT NULL,
    sort_order integer NOT NULL
);


ALTER TABLE public.indicatorgroupsetmembers OWNER TO dhis;

--
-- Name: indicatorgroupsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupsetuseraccesses (
    indicatorgroupsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.indicatorgroupsetuseraccesses OWNER TO dhis;

--
-- Name: indicatorgroupsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupsetusergroupaccesses (
    indicatorgroupsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.indicatorgroupsetusergroupaccesses OWNER TO dhis;

--
-- Name: indicatorgroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupuseraccesses (
    indicatorgroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.indicatorgroupuseraccesses OWNER TO dhis;

--
-- Name: indicatorgroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorgroupusergroupaccesses (
    indicatorgroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.indicatorgroupusergroupaccesses OWNER TO dhis;

--
-- Name: indicatorlegendsets; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorlegendsets (
    indicatorid bigint NOT NULL,
    sort_order integer NOT NULL,
    legendsetid bigint NOT NULL
);


ALTER TABLE public.indicatorlegendsets OWNER TO dhis;

--
-- Name: indicatortype; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatortype (
    indicatortypeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    indicatorfactor integer NOT NULL,
    indicatornumber boolean,
    translations jsonb
);


ALTER TABLE public.indicatortype OWNER TO dhis;

--
-- Name: indicatoruseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatoruseraccesses (
    indicatorid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.indicatoruseraccesses OWNER TO dhis;

--
-- Name: indicatorusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.indicatorusergroupaccesses (
    indicatorid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.indicatorusergroupaccesses OWNER TO dhis;

--
-- Name: intepretation_likedby; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.intepretation_likedby (
    interpretationid bigint NOT NULL,
    userid bigint NOT NULL
);


ALTER TABLE public.intepretation_likedby OWNER TO dhis;

--
-- Name: interpretation; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.interpretation (
    interpretationid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    reporttableid bigint,
    chartid bigint,
    mapid bigint,
    eventreportid bigint,
    eventchartid bigint,
    datasetid bigint,
    periodid bigint,
    organisationunitid bigint,
    interpretationtext text,
    created timestamp without time zone NOT NULL,
    likes integer,
    userid bigint,
    publicaccess character varying(8),
    mentions jsonb
);


ALTER TABLE public.interpretation OWNER TO dhis;

--
-- Name: interpretation_comments; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.interpretation_comments (
    interpretationid bigint NOT NULL,
    sort_order integer NOT NULL,
    interpretationcommentid bigint NOT NULL
);


ALTER TABLE public.interpretation_comments OWNER TO dhis;

--
-- Name: interpretationcomment; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.interpretationcomment (
    interpretationcommentid bigint NOT NULL,
    uid character varying(11),
    lastupdated timestamp without time zone NOT NULL,
    commenttext text,
    mentions jsonb,
    userid bigint NOT NULL,
    created timestamp without time zone NOT NULL
);


ALTER TABLE public.interpretationcomment OWNER TO dhis;

--
-- Name: interpretationuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.interpretationuseraccesses (
    interpretationid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.interpretationuseraccesses OWNER TO dhis;

--
-- Name: interpretationusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.interpretationusergroupaccesses (
    interpretationid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.interpretationusergroupaccesses OWNER TO dhis;

--
-- Name: jobconfiguration; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.jobconfiguration (
    jobconfigurationid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    cronexpression character varying(255) NOT NULL,
    jobtype bytea NOT NULL,
    jobstatus bytea NOT NULL,
    lastexecutedstatus bytea,
    lastexecuted timestamp without time zone,
    lastruntimeexecution text,
    nextexecutiontime timestamp without time zone,
    continuousexecution boolean NOT NULL,
    enabled boolean NOT NULL,
    leaderonlyjob boolean DEFAULT false NOT NULL,
    jsonbjobparameters jsonb
);


ALTER TABLE public.jobconfiguration OWNER TO dhis;

--
-- Name: keyjsonvalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.keyjsonvalue (
    keyjsonvalueid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    namespace character varying(255) NOT NULL,
    namespacekey character varying(255) NOT NULL,
    encrypted_value character varying(255),
    encrypted boolean,
    userid bigint,
    publicaccess character varying(8),
    jbvalue jsonb
);


ALTER TABLE public.keyjsonvalue OWNER TO dhis;

--
-- Name: keyjsonvalueuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.keyjsonvalueuseraccesses (
    keyjsonvalueid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.keyjsonvalueuseraccesses OWNER TO dhis;

--
-- Name: keyjsonvalueusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.keyjsonvalueusergroupaccesses (
    keyjsonvalueid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.keyjsonvalueusergroupaccesses OWNER TO dhis;

--
-- Name: legendsetattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.legendsetattributevalues (
    legendsetid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.legendsetattributevalues OWNER TO dhis;

--
-- Name: legendsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.legendsetuseraccesses (
    maplegendsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.legendsetuseraccesses OWNER TO dhis;

--
-- Name: legendsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.legendsetusergroupaccesses (
    maplegendsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.legendsetusergroupaccesses OWNER TO dhis;

--
-- Name: lockexception; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.lockexception (
    lockexceptionid bigint NOT NULL,
    organisationunitid bigint,
    periodid bigint,
    datasetid bigint
);


ALTER TABLE public.lockexception OWNER TO dhis;

--
-- Name: map; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.map (
    mapid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    longitude double precision,
    latitude double precision,
    zoom integer,
    basemap character varying(255),
    title character varying(255),
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    favorites jsonb,
    subscribers jsonb,
    translations jsonb
);


ALTER TABLE public.map OWNER TO dhis;

--
-- Name: maplegend; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.maplegend (
    maplegendid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    startvalue double precision NOT NULL,
    endvalue double precision NOT NULL,
    color character varying(255),
    image character varying(255),
    maplegendsetid bigint,
    translations jsonb
);


ALTER TABLE public.maplegend OWNER TO dhis;

--
-- Name: maplegendset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.maplegendset (
    maplegendsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    symbolizer character varying(255),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.maplegendset OWNER TO dhis;

--
-- Name: mapmapviews; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapmapviews (
    mapid bigint NOT NULL,
    sort_order integer NOT NULL,
    mapviewid bigint NOT NULL
);


ALTER TABLE public.mapmapviews OWNER TO dhis;

--
-- Name: mapuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapuseraccesses (
    mapid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.mapuseraccesses OWNER TO dhis;

--
-- Name: mapusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapusergroupaccesses (
    mapid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.mapusergroupaccesses OWNER TO dhis;

--
-- Name: mapview; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview (
    mapviewid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    description text,
    layer character varying(255) NOT NULL,
    relativeperiodsid integer,
    userorganisationunit boolean,
    userorganisationunitchildren boolean,
    userorganisationunitgrandchildren boolean,
    aggregationtype character varying(40),
    programid bigint,
    programstageid bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    trackedentitytypeid bigint,
    programstatus character varying(40),
    followup boolean,
    organisationunitselectionmode character varying(40),
    method integer,
    classes integer,
    colorlow character varying(255),
    colorhigh character varying(255),
    colorscale character varying(255),
    legendsetid bigint,
    radiuslow integer,
    radiushigh integer,
    opacity double precision,
    orgunitgroupsetid bigint,
    arearadius integer,
    hidden boolean,
    labels boolean,
    labelfontsize character varying(255),
    labelfontweight character varying(255),
    labelfontstyle character varying(255),
    labelfontcolor character varying(255),
    eventclustering boolean,
    eventcoordinatefield character varying(255),
    eventpointcolor character varying(255),
    eventpointradius integer,
    config text,
    styledataitem jsonb,
    translations jsonb
);


ALTER TABLE public.mapview OWNER TO dhis;

--
-- Name: mapview_attributedimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_attributedimensions (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentityattributedimensionid integer NOT NULL
);


ALTER TABLE public.mapview_attributedimensions OWNER TO dhis;

--
-- Name: mapview_categorydimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_categorydimensions (
    mapviewid bigint NOT NULL,
    categorydimensionid integer NOT NULL,
    sort_order integer NOT NULL
);


ALTER TABLE public.mapview_categorydimensions OWNER TO dhis;

--
-- Name: mapview_categoryoptiongroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_categoryoptiongroupsetdimensions (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    categoryoptiongroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.mapview_categoryoptiongroupsetdimensions OWNER TO dhis;

--
-- Name: mapview_columns; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_columns (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.mapview_columns OWNER TO dhis;

--
-- Name: mapview_datadimensionitems; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_datadimensionitems (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    datadimensionitemid integer NOT NULL
);


ALTER TABLE public.mapview_datadimensionitems OWNER TO dhis;

--
-- Name: mapview_dataelementdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_dataelementdimensions (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentitydataelementdimensionid integer NOT NULL
);


ALTER TABLE public.mapview_dataelementdimensions OWNER TO dhis;

--
-- Name: mapview_filters; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_filters (
    mapviewid bigint NOT NULL,
    dimension character varying(255),
    sort_order integer NOT NULL
);


ALTER TABLE public.mapview_filters OWNER TO dhis;

--
-- Name: mapview_itemorgunitgroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_itemorgunitgroups (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.mapview_itemorgunitgroups OWNER TO dhis;

--
-- Name: mapview_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_organisationunits (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.mapview_organisationunits OWNER TO dhis;

--
-- Name: mapview_orgunitgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_orgunitgroupsetdimensions (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.mapview_orgunitgroupsetdimensions OWNER TO dhis;

--
-- Name: mapview_orgunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_orgunitlevels (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitlevel integer
);


ALTER TABLE public.mapview_orgunitlevels OWNER TO dhis;

--
-- Name: mapview_periods; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.mapview_periods (
    mapviewid bigint NOT NULL,
    sort_order integer NOT NULL,
    periodid bigint NOT NULL
);


ALTER TABLE public.mapview_periods OWNER TO dhis;

--
-- Name: message; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.message (
    messageid bigint NOT NULL,
    uid character varying(11),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    messagetext text,
    internal boolean,
    metadata character varying(255),
    userid bigint
);


ALTER TABLE public.message OWNER TO dhis;

--
-- Name: message_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.message_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_sequence OWNER TO dhis;

--
-- Name: messageattachments; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.messageattachments (
    messageid bigint NOT NULL,
    fileresourceid bigint NOT NULL
);


ALTER TABLE public.messageattachments OWNER TO dhis;

--
-- Name: messageconversation; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.messageconversation (
    messageconversationid bigint NOT NULL,
    uid character varying(11),
    messagecount integer,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    subject character varying(255) NOT NULL,
    messagetype character varying(255) NOT NULL,
    priority character varying(255),
    status character varying(255),
    user_assigned bigint,
    lastsenderid bigint,
    lastmessage timestamp without time zone,
    userid bigint
);


ALTER TABLE public.messageconversation OWNER TO dhis;

--
-- Name: messageconversation_messages; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.messageconversation_messages (
    messageconversationid bigint NOT NULL,
    sort_order integer NOT NULL,
    messageid bigint NOT NULL
);


ALTER TABLE public.messageconversation_messages OWNER TO dhis;

--
-- Name: messageconversation_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.messageconversation_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messageconversation_sequence OWNER TO dhis;

--
-- Name: messageconversation_usermessages; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.messageconversation_usermessages (
    messageconversationid bigint NOT NULL,
    usermessageid integer NOT NULL
);


ALTER TABLE public.messageconversation_usermessages OWNER TO dhis;

--
-- Name: metadataaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.metadataaudit (
    metadataauditid integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by character varying(255) NOT NULL,
    klass character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    code character varying(255),
    type character varying(50) NOT NULL,
    value text
);


ALTER TABLE public.metadataaudit OWNER TO dhis;

--
-- Name: metadataversion; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.metadataversion (
    versionid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    versiontype character varying(50),
    importdate timestamp without time zone,
    hashcode character varying(50) NOT NULL
);


ALTER TABLE public.metadataversion OWNER TO dhis;

--
-- Name: minmaxdataelement; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.minmaxdataelement (
    minmaxdataelementid bigint NOT NULL,
    sourceid bigint,
    dataelementid bigint,
    categoryoptioncomboid bigint,
    minimumvalue integer NOT NULL,
    maximumvalue integer NOT NULL,
    generatedvalue boolean NOT NULL
);


ALTER TABLE public.minmaxdataelement OWNER TO dhis;

--
-- Name: oauth2client; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.oauth2client (
    oauth2clientid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    cid character varying(230) NOT NULL,
    secret character varying(512) NOT NULL
);


ALTER TABLE public.oauth2client OWNER TO dhis;

--
-- Name: oauth2clientgranttypes; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.oauth2clientgranttypes (
    oauth2clientid bigint NOT NULL,
    sort_order integer NOT NULL,
    granttype character varying(255)
);


ALTER TABLE public.oauth2clientgranttypes OWNER TO dhis;

--
-- Name: oauth2clientredirecturis; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.oauth2clientredirecturis (
    oauth2clientid bigint NOT NULL,
    sort_order integer NOT NULL,
    redirecturi character varying(255)
);


ALTER TABLE public.oauth2clientredirecturis OWNER TO dhis;

--
-- Name: oauth_access_token; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.oauth_access_token (
    token_id character varying(256),
    token bytea,
    authentication_id character varying(256) NOT NULL,
    user_name character varying(256),
    client_id character varying(256),
    authentication bytea,
    refresh_token character varying(256)
);


ALTER TABLE public.oauth_access_token OWNER TO dhis;

--
-- Name: oauth_code; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.oauth_code (
    code character varying(256),
    authentication bytea
);


ALTER TABLE public.oauth_code OWNER TO dhis;

--
-- Name: oauth_refresh_token; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.oauth_refresh_token (
    token_id character varying(256),
    token bytea,
    authentication bytea
);


ALTER TABLE public.oauth_refresh_token OWNER TO dhis;

--
-- Name: objecttranslation; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.objecttranslation (
    objecttranslationid integer NOT NULL,
    locale character varying(15) NOT NULL,
    property character varying(50) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.objecttranslation OWNER TO dhis;

--
-- Name: optionattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optionattributevalues (
    optionvalueid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.optionattributevalues OWNER TO dhis;

--
-- Name: optiongroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroup (
    optiongroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    optionsetid bigint,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.optiongroup OWNER TO dhis;

--
-- Name: optiongroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupattributevalues (
    optiongroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.optiongroupattributevalues OWNER TO dhis;

--
-- Name: optiongroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupmembers (
    optiongroupid bigint NOT NULL,
    optionid bigint NOT NULL
);


ALTER TABLE public.optiongroupmembers OWNER TO dhis;

--
-- Name: optiongroupset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupset (
    optiongroupsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    datadimension boolean NOT NULL,
    optionsetid bigint,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.optiongroupset OWNER TO dhis;

--
-- Name: optiongroupsetmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupsetmembers (
    optiongroupsetid bigint NOT NULL,
    sort_order integer NOT NULL,
    optiongroupid bigint NOT NULL
);


ALTER TABLE public.optiongroupsetmembers OWNER TO dhis;

--
-- Name: optiongroupsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupsetuseraccesses (
    optiongroupsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.optiongroupsetuseraccesses OWNER TO dhis;

--
-- Name: optiongroupsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupsetusergroupaccesses (
    optiongroupsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.optiongroupsetusergroupaccesses OWNER TO dhis;

--
-- Name: optiongroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupuseraccesses (
    optiongroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.optiongroupuseraccesses OWNER TO dhis;

--
-- Name: optiongroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optiongroupusergroupaccesses (
    optiongroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.optiongroupusergroupaccesses OWNER TO dhis;

--
-- Name: optionset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optionset (
    optionsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    valuetype character varying(50) NOT NULL,
    version integer,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.optionset OWNER TO dhis;

--
-- Name: optionsetattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optionsetattributevalues (
    optionsetid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.optionsetattributevalues OWNER TO dhis;

--
-- Name: optionsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optionsetuseraccesses (
    optionsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.optionsetuseraccesses OWNER TO dhis;

--
-- Name: optionsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optionsetusergroupaccesses (
    optionsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.optionsetusergroupaccesses OWNER TO dhis;

--
-- Name: optionvalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.optionvalue (
    optionvalueid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(230) NOT NULL,
    name character varying(230) NOT NULL,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    sort_order integer,
    description text,
    formname text,
    style jsonb,
    optionsetid bigint,
    translations jsonb
);


ALTER TABLE public.optionvalue OWNER TO dhis;

--
-- Name: organisationunit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.organisationunit (
    organisationunitid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    parentid bigint,
    path character varying(255),
    hierarchylevel integer,
    description text,
    openingdate date NOT NULL,
    closeddate date,
    comment text,
    url character varying(255),
    contactperson character varying(255),
    address character varying(255),
    email character varying(150),
    phonenumber character varying(150),
    userid bigint,
    translations jsonb,
    geometry public.geometry(Geometry,4326)
);


ALTER TABLE public.organisationunit OWNER TO dhis;

--
-- Name: organisationunitattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.organisationunitattributevalues (
    organisationunitid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.organisationunitattributevalues OWNER TO dhis;

--
-- Name: orgunitgroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroup (
    orgunitgroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50),
    symbol character varying(255),
    color character varying(255),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb,
    geometry public.geometry(Geometry,4326)
);


ALTER TABLE public.orgunitgroup OWNER TO dhis;

--
-- Name: orgunitgroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupattributevalues (
    orgunitgroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.orgunitgroupattributevalues OWNER TO dhis;

--
-- Name: orgunitgroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupmembers (
    organisationunitid bigint NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.orgunitgroupmembers OWNER TO dhis;

--
-- Name: orgunitgroupset; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupset (
    orgunitgroupsetid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    compulsory boolean NOT NULL,
    includesubhierarchyinanalytics boolean,
    datadimension boolean NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.orgunitgroupset OWNER TO dhis;

--
-- Name: orgunitgroupsetattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupsetattributevalues (
    orgunitgroupsetid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.orgunitgroupsetattributevalues OWNER TO dhis;

--
-- Name: orgunitgroupsetdimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupsetdimension (
    orgunitgroupsetdimensionid integer NOT NULL,
    orgunitgroupsetid bigint
);


ALTER TABLE public.orgunitgroupsetdimension OWNER TO dhis;

--
-- Name: orgunitgroupsetdimension_items; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupsetdimension_items (
    orgunitgroupsetdimensionid integer NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.orgunitgroupsetdimension_items OWNER TO dhis;

--
-- Name: orgunitgroupsetmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupsetmembers (
    orgunitgroupsetid bigint NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.orgunitgroupsetmembers OWNER TO dhis;

--
-- Name: orgunitgroupsetuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupsetuseraccesses (
    orgunitgroupsetid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.orgunitgroupsetuseraccesses OWNER TO dhis;

--
-- Name: orgunitgroupsetusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupsetusergroupaccesses (
    orgunitgroupsetid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.orgunitgroupsetusergroupaccesses OWNER TO dhis;

--
-- Name: orgunitgroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupuseraccesses (
    orgunitgroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.orgunitgroupuseraccesses OWNER TO dhis;

--
-- Name: orgunitgroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitgroupusergroupaccesses (
    orgunitgroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.orgunitgroupusergroupaccesses OWNER TO dhis;

--
-- Name: orgunitlevel; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.orgunitlevel (
    orgunitlevelid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    level integer NOT NULL,
    offlinelevels integer,
    translations jsonb
);


ALTER TABLE public.orgunitlevel OWNER TO dhis;

--
-- Name: outbound_sms; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.outbound_sms (
    id bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    message character varying(500),
    status integer NOT NULL,
    sender character varying(255)
);


ALTER TABLE public.outbound_sms OWNER TO dhis;

--
-- Name: outbound_sms_recipients; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.outbound_sms_recipients (
    outbound_sms_id bigint NOT NULL,
    elt text
);


ALTER TABLE public.outbound_sms_recipients OWNER TO dhis;

--
-- Name: period; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.period (
    periodid bigint NOT NULL,
    periodtypeid integer,
    startdate date NOT NULL,
    enddate date NOT NULL
);


ALTER TABLE public.period OWNER TO dhis;

--
-- Name: periodboundary; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.periodboundary (
    periodboundaryid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    boundarytarget character varying(50),
    analyticsperiodboundarytype character varying(50),
    offsetperiods integer,
    offsetperiodtypeid integer,
    programindicatorid bigint
);


ALTER TABLE public.periodboundary OWNER TO dhis;

--
-- Name: periodtype; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.periodtype (
    periodtypeid integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.periodtype OWNER TO dhis;

--
-- Name: potentialduplicate; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.potentialduplicate (
    potentialduplicateid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint NOT NULL,
    teia character varying(11) NOT NULL,
    teib character varying(11),
    status character varying(255) NOT NULL
);


ALTER TABLE public.potentialduplicate OWNER TO dhis;

--
-- Name: potentialduplicatesequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.potentialduplicatesequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.potentialduplicatesequence OWNER TO dhis;

--
-- Name: predictor; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.predictor (
    predictorid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    generatorexpressionid bigint,
    generatoroutput bigint NOT NULL,
    generatoroutputcombo bigint,
    skiptestexpressionid bigint,
    periodtypeid integer NOT NULL,
    sequentialsamplecount integer NOT NULL,
    annualsamplecount integer NOT NULL,
    sequentialskipcount integer
);


ALTER TABLE public.predictor OWNER TO dhis;

--
-- Name: predictorgroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.predictorgroup (
    predictorgroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.predictorgroup OWNER TO dhis;

--
-- Name: predictorgroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.predictorgroupmembers (
    predictorid bigint NOT NULL,
    predictorgroupid bigint NOT NULL
);


ALTER TABLE public.predictorgroupmembers OWNER TO dhis;

--
-- Name: predictorgroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.predictorgroupuseraccesses (
    predictorgroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.predictorgroupuseraccesses OWNER TO dhis;

--
-- Name: predictorgroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.predictorgroupusergroupaccesses (
    predictorgroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.predictorgroupusergroupaccesses OWNER TO dhis;

--
-- Name: predictororgunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.predictororgunitlevels (
    predictorid bigint NOT NULL,
    orgunitlevelid bigint NOT NULL
);


ALTER TABLE public.predictororgunitlevels OWNER TO dhis;

--
-- Name: previouspasswords; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.previouspasswords (
    userid bigint NOT NULL,
    list_index integer NOT NULL,
    previouspassword text
);


ALTER TABLE public.previouspasswords OWNER TO dhis;

--
-- Name: program; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.program (
    programid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    description text,
    formname text,
    version integer,
    enrollmentdatelabel text,
    incidentdatelabel text,
    type character varying(255) NOT NULL,
    displayincidentdate boolean,
    onlyenrollonce boolean,
    skipoffline boolean NOT NULL,
    displayfrontpagelist boolean,
    usefirststageduringregistration boolean,
    capturecoordinates boolean,
    expirydays integer,
    completeeventsexpirydays integer,
    minattributesrequiredtosearch integer,
    maxteicounttoreturn integer,
    style jsonb,
    accesslevel character varying(100),
    expiryperiodtypeid integer,
    ignoreoverdueevents boolean,
    selectenrollmentdatesinfuture boolean,
    selectincidentdatesinfuture boolean,
    relatedprogramid bigint,
    categorycomboid bigint NOT NULL,
    trackedentitytypeid bigint,
    dataentryformid bigint,
    userid bigint,
    publicaccess character varying(8),
    featuretype character varying(255),
    translations jsonb
);


ALTER TABLE public.program OWNER TO dhis;

--
-- Name: program_attribute_group; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.program_attribute_group (
    programtrackedentityattributegroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(255),
    description text,
    uniqunessype bytea NOT NULL,
    translations jsonb
);


ALTER TABLE public.program_attribute_group OWNER TO dhis;

--
-- Name: program_attributes; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.program_attributes (
    programtrackedentityattributeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    programid bigint,
    trackedentityattributeid bigint,
    displayinlist boolean,
    mandatory boolean,
    sort_order integer,
    allowfuturedate boolean,
    renderoptionsasradio boolean,
    rendertype jsonb,
    searchable boolean
);


ALTER TABLE public.program_attributes OWNER TO dhis;

--
-- Name: program_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.program_organisationunits (
    organisationunitid bigint NOT NULL,
    programid bigint NOT NULL
);


ALTER TABLE public.program_organisationunits OWNER TO dhis;

--
-- Name: program_userroles; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.program_userroles (
    programid bigint,
    userroleid bigint NOT NULL
);


ALTER TABLE public.program_userroles OWNER TO dhis;

--
-- Name: programattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programattributevalues (
    programid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.programattributevalues OWNER TO dhis;

--
-- Name: programexpression; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programexpression (
    programexpressionid bigint NOT NULL,
    description character varying(255),
    expression text
);


ALTER TABLE public.programexpression OWNER TO dhis;

--
-- Name: programindicator; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicator (
    programindicatorid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    description text,
    formname text,
    style jsonb,
    programid bigint NOT NULL,
    expression text,
    filter text,
    aggregationtype character varying(40),
    decimals integer,
    aggregateexportcategoryoptioncombo character varying(255),
    aggregateexportattributeoptioncombo character varying(255),
    displayinform boolean,
    analyticstype character varying(15) NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.programindicator OWNER TO dhis;

--
-- Name: programindicatorattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorattributevalues (
    programindicatorid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.programindicatorattributevalues OWNER TO dhis;

--
-- Name: programindicatorgroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorgroup (
    programindicatorgroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.programindicatorgroup OWNER TO dhis;

--
-- Name: programindicatorgroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorgroupattributevalues (
    programindicatorgroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.programindicatorgroupattributevalues OWNER TO dhis;

--
-- Name: programindicatorgroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorgroupmembers (
    programindicatorid bigint NOT NULL,
    programindicatorgroupid bigint NOT NULL
);


ALTER TABLE public.programindicatorgroupmembers OWNER TO dhis;

--
-- Name: programindicatorgroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorgroupuseraccesses (
    programindicatorgroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.programindicatorgroupuseraccesses OWNER TO dhis;

--
-- Name: programindicatorgroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorgroupusergroupaccesses (
    programindicatorgroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.programindicatorgroupusergroupaccesses OWNER TO dhis;

--
-- Name: programindicatorlegendsets; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorlegendsets (
    programindicatorid bigint NOT NULL,
    sort_order integer NOT NULL,
    legendsetid bigint NOT NULL
);


ALTER TABLE public.programindicatorlegendsets OWNER TO dhis;

--
-- Name: programindicatoruseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatoruseraccesses (
    programindicatorid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.programindicatoruseraccesses OWNER TO dhis;

--
-- Name: programindicatorusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programindicatorusergroupaccesses (
    programindicatorid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.programindicatorusergroupaccesses OWNER TO dhis;

--
-- Name: programinstance; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programinstance (
    programinstanceid bigint NOT NULL,
    uid character varying(11),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    createdatclient timestamp without time zone,
    lastupdatedatclient timestamp without time zone,
    incidentdate timestamp without time zone,
    enrollmentdate timestamp without time zone NOT NULL,
    enddate timestamp without time zone,
    followup boolean,
    completedby character varying(255),
    deleted boolean NOT NULL,
    storedby character varying(255),
    status character varying(50),
    trackedentityinstanceid bigint,
    programid bigint NOT NULL,
    organisationunitid bigint,
    geometry public.geometry
);


ALTER TABLE public.programinstance OWNER TO dhis;

--
-- Name: programinstance_messageconversation; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programinstance_messageconversation (
    programinstanceid bigint NOT NULL,
    sort_order integer NOT NULL,
    messageconversationid bigint NOT NULL
);


ALTER TABLE public.programinstance_messageconversation OWNER TO dhis;

--
-- Name: programinstance_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.programinstance_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.programinstance_sequence OWNER TO dhis;

--
-- Name: programinstanceaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programinstanceaudit (
    programinstanceauditid integer NOT NULL,
    programinstanceid bigint,
    created timestamp without time zone,
    accessedby character varying(255),
    audittype character varying(100) NOT NULL,
    comment character varying(50000)
);


ALTER TABLE public.programinstanceaudit OWNER TO dhis;

--
-- Name: programinstancecomments; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programinstancecomments (
    programinstanceid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentitycommentid bigint NOT NULL
);


ALTER TABLE public.programinstancecomments OWNER TO dhis;

--
-- Name: programmessage; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programmessage (
    id bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    text character varying(500) NOT NULL,
    subject character varying(200),
    processeddate timestamp without time zone,
    messagestatus character varying(50),
    trackedentityinstanceid bigint,
    organisationunitid bigint,
    programinstanceid bigint,
    programstageinstanceid bigint,
    translations jsonb
);


ALTER TABLE public.programmessage OWNER TO dhis;

--
-- Name: programmessage_deliverychannels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programmessage_deliverychannels (
    programmessagedeliverychannelsid bigint NOT NULL,
    deliverychannel character varying(255)
);


ALTER TABLE public.programmessage_deliverychannels OWNER TO dhis;

--
-- Name: programmessage_emailaddresses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programmessage_emailaddresses (
    programmessageemailaddressid bigint NOT NULL,
    email text
);


ALTER TABLE public.programmessage_emailaddresses OWNER TO dhis;

--
-- Name: programmessage_phonenumbers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programmessage_phonenumbers (
    programmessagephonenumberid bigint NOT NULL,
    phonenumber text
);


ALTER TABLE public.programmessage_phonenumbers OWNER TO dhis;

--
-- Name: programnotificationinstance; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programnotificationinstance (
    programnotificationinstanceid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    programinstanceid bigint,
    programstageinstanceid bigint,
    programnotificationtemplateid bigint NOT NULL,
    scheduledat timestamp without time zone,
    sentat timestamp without time zone
);


ALTER TABLE public.programnotificationinstance OWNER TO dhis;

--
-- Name: programnotificationtemplate; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programnotificationtemplate (
    programnotificationtemplateid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    relativescheduleddays integer,
    usergroupid bigint,
    trackedentityattributeid bigint,
    dataelementid bigint,
    subjecttemplate character varying(100),
    messagetemplate text NOT NULL,
    notifyparentorganisationunitonly boolean,
    notifyusersinhierarchyonly boolean,
    notificationtrigger character varying(255),
    notificationrecipienttype character varying(255),
    programstageid bigint,
    programid bigint
);


ALTER TABLE public.programnotificationtemplate OWNER TO dhis;

--
-- Name: programnotificationtemplate_deliverychannel; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programnotificationtemplate_deliverychannel (
    programnotificationtemplatedeliverychannelid bigint NOT NULL,
    deliverychannel character varying(255)
);


ALTER TABLE public.programnotificationtemplate_deliverychannel OWNER TO dhis;

--
-- Name: programownershiphistory; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programownershiphistory (
    programownershiphistoryid integer NOT NULL,
    programid bigint,
    trackedentityinstanceid bigint,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    createdby character varying(255)
);


ALTER TABLE public.programownershiphistory OWNER TO dhis;

--
-- Name: programrule; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programrule (
    programruleid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description character varying(255),
    programid bigint NOT NULL,
    programstageid bigint,
    rulecondition text,
    priority integer,
    translations jsonb
);


ALTER TABLE public.programrule OWNER TO dhis;

--
-- Name: programruleaction; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programruleaction (
    programruleactionid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    programruleid bigint,
    actiontype character varying(255) NOT NULL,
    dataelementid bigint,
    trackedentityattributeid bigint,
    programindicatorid bigint,
    programstagesectionid bigint,
    programstageid bigint,
    optionid bigint,
    optiongroupid bigint,
    location character varying(255),
    content text,
    data text,
    templateuid text
);


ALTER TABLE public.programruleaction OWNER TO dhis;

--
-- Name: programrulevariable; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programrulevariable (
    programrulevariableid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    programid bigint NOT NULL,
    sourcetype character varying(255) NOT NULL,
    trackedentityattributeid bigint,
    dataelementid bigint,
    usecodeforoptionset boolean,
    programstageid bigint
);


ALTER TABLE public.programrulevariable OWNER TO dhis;

--
-- Name: programsection; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programsection (
    programsectionid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    formname text,
    style jsonb,
    rendertype jsonb,
    programid bigint,
    sortorder integer NOT NULL,
    translations jsonb
);


ALTER TABLE public.programsection OWNER TO dhis;

--
-- Name: programsection_attributes; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programsection_attributes (
    programsectionid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentityattributeid bigint NOT NULL
);


ALTER TABLE public.programsection_attributes OWNER TO dhis;

--
-- Name: programstage; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstage (
    programstageid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230),
    description text,
    formname text,
    mindaysfromstart integer NOT NULL,
    programid bigint,
    repeatable boolean NOT NULL,
    dataentryformid bigint,
    standardinterval integer,
    executiondatelabel character varying(255),
    duedatelabel character varying(255),
    autogenerateevent boolean,
    displaygenerateeventbox boolean,
    generatedbyenrollmentdate boolean,
    blockentryform boolean,
    remindcompleted boolean,
    allowgeneratenextvisit boolean,
    openafterenrollment boolean,
    reportdatetouse character varying(255),
    pregenerateuid boolean,
    style jsonb,
    hideduedate boolean,
    sort_order integer,
    featuretype character varying(255),
    periodtypeid integer,
    userid bigint,
    publicaccess character varying(8),
    validationstrategy character varying(32) NOT NULL,
    translations jsonb,
    enableuserassignment boolean NOT NULL
);


ALTER TABLE public.programstage OWNER TO dhis;

--
-- Name: programstageattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageattributevalues (
    programstageid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.programstageattributevalues OWNER TO dhis;

--
-- Name: programstagedataelement; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstagedataelement (
    programstagedataelementid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    programstageid bigint,
    dataelementid bigint,
    compulsory boolean NOT NULL,
    allowprovidedelsewhere boolean,
    sort_order integer,
    displayinreports boolean,
    allowfuturedate boolean,
    renderoptionsasradio boolean,
    rendertype jsonb,
    skipsynchronization boolean NOT NULL
);


ALTER TABLE public.programstagedataelement OWNER TO dhis;

--
-- Name: programstageinstance; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageinstance (
    programstageinstanceid bigint NOT NULL,
    uid character varying(11),
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    createdatclient timestamp without time zone,
    lastupdatedatclient timestamp without time zone,
    lastsynchronized timestamp without time zone DEFAULT to_timestamp((0)::double precision) NOT NULL,
    programinstanceid bigint NOT NULL,
    programstageid bigint NOT NULL,
    attributeoptioncomboid bigint,
    deleted boolean NOT NULL,
    storedby character varying(255),
    duedate timestamp without time zone,
    executiondate timestamp without time zone,
    organisationunitid bigint,
    status character varying(25) NOT NULL,
    completedby character varying(255),
    completeddate timestamp without time zone,
    geometry public.geometry,
    eventdatavalues jsonb DEFAULT '{}'::jsonb NOT NULL,
    assigneduserid bigint
);


ALTER TABLE public.programstageinstance OWNER TO dhis;

--
-- Name: programstageinstance_messageconversation; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageinstance_messageconversation (
    programstageinstanceid bigint NOT NULL,
    sort_order integer NOT NULL,
    messageconversationid bigint NOT NULL
);


ALTER TABLE public.programstageinstance_messageconversation OWNER TO dhis;

--
-- Name: programstageinstance_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.programstageinstance_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.programstageinstance_sequence OWNER TO dhis;

--
-- Name: programstageinstancecomments; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageinstancecomments (
    programstageinstanceid bigint NOT NULL,
    sort_order integer NOT NULL,
    trackedentitycommentid bigint NOT NULL
);


ALTER TABLE public.programstageinstancecomments OWNER TO dhis;

--
-- Name: programstageinstancefilter; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageinstancefilter (
    programstageinstancefilterid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description character varying(255),
    program character varying(11) NOT NULL,
    programstage character varying(11),
    eventquerycriteria jsonb,
    userid bigint,
    publicaccess character varying(8)
);


ALTER TABLE public.programstageinstancefilter OWNER TO dhis;

--
-- Name: programstageinstancefilteruseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageinstancefilteruseraccesses (
    programstageinstancefilterid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.programstageinstancefilteruseraccesses OWNER TO dhis;

--
-- Name: programstageinstancefilterusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageinstancefilterusergroupaccesses (
    programstageinstancefilterid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.programstageinstancefilterusergroupaccesses OWNER TO dhis;

--
-- Name: programstagesection; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstagesection (
    programstagesectionid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    formname text,
    style jsonb,
    rendertype jsonb,
    programstageid bigint,
    sortorder integer NOT NULL,
    translations jsonb
);


ALTER TABLE public.programstagesection OWNER TO dhis;

--
-- Name: programstagesection_dataelements; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstagesection_dataelements (
    programstagesectionid bigint NOT NULL,
    sort_order integer NOT NULL,
    dataelementid bigint NOT NULL
);


ALTER TABLE public.programstagesection_dataelements OWNER TO dhis;

--
-- Name: programstagesection_programindicators; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstagesection_programindicators (
    programstagesectionid bigint NOT NULL,
    sort_order integer NOT NULL,
    programindicatorid bigint NOT NULL
);


ALTER TABLE public.programstagesection_programindicators OWNER TO dhis;

--
-- Name: programstageuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageuseraccesses (
    programstageid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.programstageuseraccesses OWNER TO dhis;

--
-- Name: programstageusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programstageusergroupaccesses (
    programid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.programstageusergroupaccesses OWNER TO dhis;

--
-- Name: programtempownershipaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programtempownershipaudit (
    programtempownershipauditid integer NOT NULL,
    programid bigint,
    trackedentityinstanceid bigint,
    created timestamp without time zone,
    accessedby character varying(255),
    reason character varying(50000)
);


ALTER TABLE public.programtempownershipaudit OWNER TO dhis;

--
-- Name: programtrackedentityattributegroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programtrackedentityattributegroupmembers (
    programtrackedentityattributeid bigint NOT NULL,
    programtrackedentityattributegroupid bigint NOT NULL
);


ALTER TABLE public.programtrackedentityattributegroupmembers OWNER TO dhis;

--
-- Name: programuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programuseraccesses (
    programid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.programuseraccesses OWNER TO dhis;

--
-- Name: programusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.programusergroupaccesses (
    programid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.programusergroupaccesses OWNER TO dhis;

--
-- Name: pushanalysis; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.pushanalysis (
    pushanalysisid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(255) NOT NULL,
    title character varying(255),
    message text,
    enabled boolean NOT NULL,
    schedulingdayoffrequency integer,
    schedulingfrequency bytea,
    dashboard bigint NOT NULL
);


ALTER TABLE public.pushanalysis OWNER TO dhis;

--
-- Name: pushanalysisrecipientusergroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.pushanalysisrecipientusergroups (
    usergroupid bigint NOT NULL,
    elt bigint NOT NULL
);


ALTER TABLE public.pushanalysisrecipientusergroups OWNER TO dhis;

--
-- Name: relationship; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relationship (
    relationshipid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    formname text,
    description text,
    style jsonb,
    relationshiptypeid bigint NOT NULL,
    from_relationshipitemid integer,
    to_relationshipitemid integer
);


ALTER TABLE public.relationship OWNER TO dhis;

--
-- Name: relationshipconstraint; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relationshipconstraint (
    relationshipconstraintid integer NOT NULL,
    entity character varying(255),
    trackedentitytypeid bigint,
    programid bigint,
    programstageid bigint
);


ALTER TABLE public.relationshipconstraint OWNER TO dhis;

--
-- Name: relationshipitem; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relationshipitem (
    relationshipitemid integer NOT NULL,
    relationshipid bigint,
    trackedentityinstanceid bigint,
    programinstanceid bigint,
    programstageinstanceid bigint
);


ALTER TABLE public.relationshipitem OWNER TO dhis;

--
-- Name: relationshiptype; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relationshiptype (
    relationshiptypeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description character varying(255),
    from_relationshipconstraintid integer,
    to_relationshipconstraintid integer,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb,
    bidirectional boolean NOT NULL,
    fromtoname character varying(255) NOT NULL,
    tofromname character varying(255)
);


ALTER TABLE public.relationshiptype OWNER TO dhis;

--
-- Name: relationshiptypeuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relationshiptypeuseraccesses (
    relationshiptypeid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.relationshiptypeuseraccesses OWNER TO dhis;

--
-- Name: relationshiptypeusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relationshiptypeusergroupaccesses (
    relationshiptypeid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.relationshiptypeusergroupaccesses OWNER TO dhis;

--
-- Name: relativeperiods; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.relativeperiods (
    relativeperiodsid integer NOT NULL,
    thisday boolean NOT NULL,
    yesterday boolean NOT NULL,
    last3days boolean NOT NULL,
    last7days boolean NOT NULL,
    last14days boolean NOT NULL,
    thismonth boolean NOT NULL,
    lastmonth boolean NOT NULL,
    thisbimonth boolean NOT NULL,
    lastbimonth boolean NOT NULL,
    thisquarter boolean NOT NULL,
    lastquarter boolean NOT NULL,
    thissixmonth boolean NOT NULL,
    lastsixmonth boolean NOT NULL,
    weeksthisyear boolean,
    monthsthisyear boolean NOT NULL,
    bimonthsthisyear boolean,
    quartersthisyear boolean NOT NULL,
    thisyear boolean NOT NULL,
    monthslastyear boolean NOT NULL,
    quarterslastyear boolean NOT NULL,
    lastyear boolean NOT NULL,
    last5years boolean NOT NULL,
    last12months boolean NOT NULL,
    last6months boolean NOT NULL,
    last3months boolean NOT NULL,
    last6bimonths boolean NOT NULL,
    last4quarters boolean NOT NULL,
    last2sixmonths boolean NOT NULL,
    thisfinancialyear boolean NOT NULL,
    lastfinancialyear boolean NOT NULL,
    last5financialyears boolean NOT NULL,
    thisweek boolean NOT NULL,
    lastweek boolean NOT NULL,
    thisbiweek boolean,
    lastbiweek boolean,
    last4weeks boolean NOT NULL,
    last4biweeks boolean,
    last12weeks boolean NOT NULL,
    last52weeks boolean NOT NULL
);


ALTER TABLE public.relativeperiods OWNER TO dhis;

--
-- Name: report; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.report (
    reportid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    type character varying(50),
    designcontent text,
    reporttableid bigint,
    relativeperiodsid integer,
    paramreportingmonth boolean,
    paramorganisationunit boolean,
    cachestrategy character varying(40),
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.report OWNER TO dhis;

--
-- Name: reporttable; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable (
    reporttableid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    measurecriteria character varying(255),
    regression boolean,
    cumulative boolean,
    relativeperiodsid integer,
    paramreportingmonth boolean,
    paramgrandparentorganisationunit boolean,
    paramparentorganisationunit boolean,
    paramorganisationunit boolean,
    sortorder integer,
    toplimit integer,
    rowtotals boolean,
    coltotals boolean,
    rowsubtotals boolean,
    colsubtotals boolean,
    hideemptyrows boolean,
    hideemptycolumns boolean,
    aggregationtype character varying(40),
    completedonly boolean,
    title character varying(255),
    subtitle character varying(255),
    hidetitle boolean,
    hidesubtitle boolean,
    digitgroupseparator character varying(40),
    displaydensity character varying(40),
    fontsize character varying(40),
    userorganisationunit boolean,
    userorganisationunitchildren boolean,
    userorganisationunitgrandchildren boolean,
    legendsetid bigint,
    legenddisplaystyle character varying(40),
    legenddisplaystrategy character varying(40),
    numbertype character varying(40),
    showhierarchy boolean,
    showdimensionlabels boolean,
    skiprounding boolean,
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8),
    favorites jsonb,
    subscribers jsonb,
    startdate timestamp without time zone,
    enddate timestamp without time zone,
    translations jsonb
);


ALTER TABLE public.reporttable OWNER TO dhis;

--
-- Name: reporttable_categorydimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_categorydimensions (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    categorydimensionid integer NOT NULL
);


ALTER TABLE public.reporttable_categorydimensions OWNER TO dhis;

--
-- Name: reporttable_categoryoptiongroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_categoryoptiongroupsetdimensions (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    categoryoptiongroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.reporttable_categoryoptiongroupsetdimensions OWNER TO dhis;

--
-- Name: reporttable_columns; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_columns (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.reporttable_columns OWNER TO dhis;

--
-- Name: reporttable_datadimensionitems; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_datadimensionitems (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    datadimensionitemid integer NOT NULL
);


ALTER TABLE public.reporttable_datadimensionitems OWNER TO dhis;

--
-- Name: reporttable_dataelementgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_dataelementgroupsetdimensions (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    dataelementgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.reporttable_dataelementgroupsetdimensions OWNER TO dhis;

--
-- Name: reporttable_filters; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_filters (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.reporttable_filters OWNER TO dhis;

--
-- Name: reporttable_itemorgunitgroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_itemorgunitgroups (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupid bigint NOT NULL
);


ALTER TABLE public.reporttable_itemorgunitgroups OWNER TO dhis;

--
-- Name: reporttable_organisationunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_organisationunits (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.reporttable_organisationunits OWNER TO dhis;

--
-- Name: reporttable_orgunitgroupsetdimensions; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_orgunitgroupsetdimensions (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitgroupsetdimensionid integer NOT NULL
);


ALTER TABLE public.reporttable_orgunitgroupsetdimensions OWNER TO dhis;

--
-- Name: reporttable_orgunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_orgunitlevels (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    orgunitlevel integer
);


ALTER TABLE public.reporttable_orgunitlevels OWNER TO dhis;

--
-- Name: reporttable_periods; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_periods (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    periodid bigint NOT NULL
);


ALTER TABLE public.reporttable_periods OWNER TO dhis;

--
-- Name: reporttable_rows; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttable_rows (
    reporttableid bigint NOT NULL,
    sort_order integer NOT NULL,
    dimension character varying(255)
);


ALTER TABLE public.reporttable_rows OWNER TO dhis;

--
-- Name: reporttableuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttableuseraccesses (
    reporttableid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.reporttableuseraccesses OWNER TO dhis;

--
-- Name: reporttableusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reporttableusergroupaccesses (
    reporttableid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.reporttableusergroupaccesses OWNER TO dhis;

--
-- Name: reportuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reportuseraccesses (
    reportid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.reportuseraccesses OWNER TO dhis;

--
-- Name: reportusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reportusergroupaccesses (
    reportid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.reportusergroupaccesses OWNER TO dhis;

--
-- Name: reservedvalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.reservedvalue (
    reservedvalueid integer NOT NULL,
    expirydate timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    ownerobject character varying(255),
    owneruid character varying(255),
    key character varying(255),
    value character varying(255)
);


ALTER TABLE public.reservedvalue OWNER TO dhis;

--
-- Name: reservedvalue_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.reservedvalue_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservedvalue_sequence OWNER TO dhis;

--
-- Name: section; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.section (
    sectionid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    datasetid bigint NOT NULL,
    sortorder integer NOT NULL,
    showrowtotals boolean,
    showcolumntotals boolean,
    translations jsonb
);


ALTER TABLE public.section OWNER TO dhis;

--
-- Name: sectionattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sectionattributevalues (
    sectionid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.sectionattributevalues OWNER TO dhis;

--
-- Name: sectiondataelements; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sectiondataelements (
    sectionid bigint NOT NULL,
    sort_order integer NOT NULL,
    dataelementid bigint NOT NULL
);


ALTER TABLE public.sectiondataelements OWNER TO dhis;

--
-- Name: sectiongreyedfields; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sectiongreyedfields (
    sectionid bigint NOT NULL,
    dataelementoperandid bigint NOT NULL
);


ALTER TABLE public.sectiongreyedfields OWNER TO dhis;

--
-- Name: sectionindicators; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sectionindicators (
    sectionid bigint NOT NULL,
    sort_order integer NOT NULL,
    indicatorid bigint NOT NULL
);


ALTER TABLE public.sectionindicators OWNER TO dhis;

--
-- Name: sequentialnumbercounter; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sequentialnumbercounter (
    id integer NOT NULL,
    owneruid character varying(255),
    key character varying(255),
    counter integer
);


ALTER TABLE public.sequentialnumbercounter OWNER TO dhis;

--
-- Name: series; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.series (
    seriesid bigint NOT NULL,
    series character varying(255) NOT NULL,
    axis integer NOT NULL
);


ALTER TABLE public.series OWNER TO dhis;

--
-- Name: smscodes; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.smscodes (
    smscodeid integer NOT NULL,
    code character varying(255),
    formula text,
    compulsory boolean,
    dataelementid bigint,
    trackedentityattributeid bigint,
    optionid integer
);


ALTER TABLE public.smscodes OWNER TO dhis;

--
-- Name: smscommandcodes; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.smscommandcodes (
    id bigint NOT NULL,
    codeid integer NOT NULL
);


ALTER TABLE public.smscommandcodes OWNER TO dhis;

--
-- Name: smscommands; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.smscommands (
    smscommandid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    name text,
    parsertype integer,
    separatorkey text,
    codeseparator text,
    defaultmessage text,
    receivedmessage text,
    wrongformatmessage text,
    nousermessage text,
    morethanoneorgunitmessage text,
    successmessage text,
    currentperiodusedforreporting boolean,
    completenessmethod text,
    datasetid bigint,
    usergroupid bigint,
    programid bigint,
    programstageid bigint
);


ALTER TABLE public.smscommands OWNER TO dhis;

--
-- Name: smscommandspecialcharacters; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.smscommandspecialcharacters (
    smscommandid bigint NOT NULL,
    specialcharacterid integer NOT NULL
);


ALTER TABLE public.smscommandspecialcharacters OWNER TO dhis;

--
-- Name: smsspecialcharacter; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.smsspecialcharacter (
    specialcharacterid integer NOT NULL,
    name text,
    value text
);


ALTER TABLE public.smsspecialcharacter OWNER TO dhis;

--
-- Name: sqlview; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sqlview (
    sqlviewid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    sqlquery text NOT NULL,
    type character varying(40),
    cachestrategy character varying(40),
    externalaccess boolean,
    userid bigint,
    publicaccess character varying(8)
);


ALTER TABLE public.sqlview OWNER TO dhis;

--
-- Name: sqlviewattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sqlviewattributevalues (
    sqlviewid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.sqlviewattributevalues OWNER TO dhis;

--
-- Name: sqlviewuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sqlviewuseraccesses (
    sqlviewid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.sqlviewuseraccesses OWNER TO dhis;

--
-- Name: sqlviewusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.sqlviewusergroupaccesses (
    sqlviewid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.sqlviewusergroupaccesses OWNER TO dhis;

--
-- Name: systemsetting; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.systemsetting (
    systemsettingid bigint NOT NULL,
    name character varying(255) NOT NULL,
    value bytea,
    translations jsonb
);


ALTER TABLE public.systemsetting OWNER TO dhis;

--
-- Name: tablehook; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.tablehook (
    analyticstablehookid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(255) NOT NULL,
    analyticstablephase character varying(50) NOT NULL,
    resourcetabletype character varying(50),
    analyticstabletype character varying(50),
    sql text NOT NULL
);


ALTER TABLE public.tablehook OWNER TO dhis;

--
-- Name: trackedentityattribute; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattribute (
    trackedentityattributeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    shortname character varying(50) NOT NULL,
    description text,
    formname text,
    valuetype character varying(36) NOT NULL,
    aggregationtype character varying(40) NOT NULL,
    optionsetid bigint,
    inherit boolean,
    expression character varying(255),
    displayonvisitschedule boolean,
    sortorderinvisitschedule integer,
    displayinlistnoprogram boolean,
    sortorderinlistnoprogram integer,
    confidential boolean,
    uniquefield boolean,
    generated boolean,
    pattern character varying(255),
    textpattern jsonb,
    style jsonb,
    orgunitscope boolean,
    programscope boolean,
    skipsynchronization boolean NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    fieldmask character varying(255),
    translations jsonb
);


ALTER TABLE public.trackedentityattribute OWNER TO dhis;

--
-- Name: trackedentityattributeattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributeattributevalues (
    trackedentityattributeid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.trackedentityattributeattributevalues OWNER TO dhis;

--
-- Name: trackedentityattributedimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributedimension (
    trackedentityattributedimensionid integer NOT NULL,
    trackedentityattributeid bigint,
    legendsetid bigint,
    filter text
);


ALTER TABLE public.trackedentityattributedimension OWNER TO dhis;

--
-- Name: trackedentityattributelegendsets; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributelegendsets (
    trackedentityattributeid bigint NOT NULL,
    sort_order integer NOT NULL,
    legendsetid bigint NOT NULL
);


ALTER TABLE public.trackedentityattributelegendsets OWNER TO dhis;

--
-- Name: trackedentityattributeuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributeuseraccesses (
    trackedentityattributeid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.trackedentityattributeuseraccesses OWNER TO dhis;

--
-- Name: trackedentityattributeusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributeusergroupaccesses (
    trackedentityattributeid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.trackedentityattributeusergroupaccesses OWNER TO dhis;

--
-- Name: trackedentityattributevalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributevalue (
    trackedentityinstanceid bigint NOT NULL,
    trackedentityattributeid bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    value character varying(50000),
    encryptedvalue character varying(50000),
    storedby character varying(255)
);


ALTER TABLE public.trackedentityattributevalue OWNER TO dhis;

--
-- Name: trackedentityattributevalueaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityattributevalueaudit (
    trackedentityattributevalueauditid integer NOT NULL,
    trackedentityinstanceid bigint,
    trackedentityattributeid bigint,
    value character varying(50000),
    encryptedvalue character varying(50000),
    created timestamp without time zone,
    modifiedby character varying(255),
    audittype character varying(100) NOT NULL
);


ALTER TABLE public.trackedentityattributevalueaudit OWNER TO dhis;

--
-- Name: trackedentitycomment; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitycomment (
    trackedentitycommentid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    commenttext text,
    creator character varying(255)
);


ALTER TABLE public.trackedentitycomment OWNER TO dhis;

--
-- Name: trackedentitydataelementdimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitydataelementdimension (
    trackedentitydataelementdimensionid integer NOT NULL,
    dataelementid bigint,
    legendsetid bigint,
    filter text
);


ALTER TABLE public.trackedentitydataelementdimension OWNER TO dhis;

--
-- Name: trackedentitydatavalueaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitydatavalueaudit (
    trackedentitydatavalueauditid bigint NOT NULL,
    programstageinstanceid bigint,
    dataelementid bigint,
    value character varying(50000),
    created timestamp without time zone,
    providedelsewhere boolean,
    modifiedby character varying(255),
    audittype character varying(100) NOT NULL
);


ALTER TABLE public.trackedentitydatavalueaudit OWNER TO dhis;

--
-- Name: trackedentitydatavalueaudit_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.trackedentitydatavalueaudit_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackedentitydatavalueaudit_sequence OWNER TO dhis;

--
-- Name: trackedentityinstance; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityinstance (
    trackedentityinstanceid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    createdatclient timestamp without time zone,
    lastupdatedatclient timestamp without time zone,
    inactive boolean,
    deleted boolean NOT NULL,
    lastsynchronized timestamp without time zone DEFAULT to_timestamp((0)::double precision) NOT NULL,
    featuretype character varying(50),
    coordinates text,
    organisationunitid bigint NOT NULL,
    trackedentitytypeid bigint,
    geometry public.geometry
);


ALTER TABLE public.trackedentityinstance OWNER TO dhis;

--
-- Name: trackedentityinstance_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.trackedentityinstance_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackedentityinstance_sequence OWNER TO dhis;

--
-- Name: trackedentityinstanceaudit; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityinstanceaudit (
    trackedentityinstanceauditid bigint NOT NULL,
    trackedentityinstance character varying(255),
    created timestamp without time zone,
    accessedby character varying(255),
    audittype character varying(100) NOT NULL,
    comment character varying(50000)
);


ALTER TABLE public.trackedentityinstanceaudit OWNER TO dhis;

--
-- Name: trackedentityinstanceaudit_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.trackedentityinstanceaudit_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trackedentityinstanceaudit_sequence OWNER TO dhis;

--
-- Name: trackedentityinstancefilter; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityinstancefilter (
    trackedentityinstancefilterid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description character varying(255),
    sortorder integer,
    style jsonb,
    programid bigint NOT NULL,
    enrollmentstatus character varying(50),
    followup boolean,
    enrollmentcreatedperiod jsonb,
    eventfilters jsonb
);


ALTER TABLE public.trackedentityinstancefilter OWNER TO dhis;

--
-- Name: trackedentityprogramindicatordimension; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityprogramindicatordimension (
    trackedentityprogramindicatordimensionid integer NOT NULL,
    programindicatorid bigint,
    legendsetid bigint,
    filter text
);


ALTER TABLE public.trackedentityprogramindicatordimension OWNER TO dhis;

--
-- Name: trackedentityprogramowner; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentityprogramowner (
    trackedentityprogramownerid integer NOT NULL,
    trackedentityinstanceid bigint,
    programid bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    organisationunitid bigint,
    createdby character varying(255) NOT NULL
);


ALTER TABLE public.trackedentityprogramowner OWNER TO dhis;

--
-- Name: trackedentitytype; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitytype (
    trackedentitytypeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    formname text,
    style jsonb,
    minattributesrequiredtosearch integer,
    maxteicounttoreturn integer,
    allowauditlog boolean,
    userid bigint,
    publicaccess character varying(8),
    featuretype character varying(255),
    translations jsonb
);


ALTER TABLE public.trackedentitytype OWNER TO dhis;

--
-- Name: trackedentitytypeattribute; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitytypeattribute (
    trackedentitytypeattributeid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    trackedentitytypeid bigint,
    trackedentityattributeid bigint,
    displayinlist boolean,
    mandatory boolean,
    searchable boolean,
    sort_order integer
);


ALTER TABLE public.trackedentitytypeattribute OWNER TO dhis;

--
-- Name: trackedentitytypeattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitytypeattributevalues (
    trackedentitytypeid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.trackedentitytypeattributevalues OWNER TO dhis;

--
-- Name: trackedentitytypeuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitytypeuseraccesses (
    trackedentitytypeid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.trackedentitytypeuseraccesses OWNER TO dhis;

--
-- Name: trackedentitytypeusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.trackedentitytypeusergroupaccesses (
    trackedentitytypeid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.trackedentitytypeusergroupaccesses OWNER TO dhis;

--
-- Name: useraccess; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.useraccess (
    useraccessid integer NOT NULL,
    access character varying(255),
    userid bigint
);


ALTER TABLE public.useraccess OWNER TO dhis;

--
-- Name: userapps; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userapps (
    userinfoid bigint NOT NULL,
    sort_order integer NOT NULL,
    app character varying(255)
);


ALTER TABLE public.userapps OWNER TO dhis;

--
-- Name: userattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userattributevalues (
    userinfoid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.userattributevalues OWNER TO dhis;

--
-- Name: userdatavieworgunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userdatavieworgunits (
    userinfoid bigint NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.userdatavieworgunits OWNER TO dhis;

--
-- Name: usergroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroup (
    usergroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.usergroup OWNER TO dhis;

--
-- Name: usergroupaccess; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroupaccess (
    usergroupaccessid integer NOT NULL,
    access character varying(255),
    usergroupid bigint
);


ALTER TABLE public.usergroupaccess OWNER TO dhis;

--
-- Name: usergroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroupattributevalues (
    usergroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.usergroupattributevalues OWNER TO dhis;

--
-- Name: usergroupmanaged; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroupmanaged (
    managedbygroupid bigint NOT NULL,
    managedgroupid bigint NOT NULL
);


ALTER TABLE public.usergroupmanaged OWNER TO dhis;

--
-- Name: usergroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroupmembers (
    userid bigint NOT NULL,
    usergroupid bigint NOT NULL
);


ALTER TABLE public.usergroupmembers OWNER TO dhis;

--
-- Name: usergroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroupuseraccesses (
    usergroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.usergroupuseraccesses OWNER TO dhis;

--
-- Name: usergroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usergroupusergroupaccesses (
    usergroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.usergroupusergroupaccesses OWNER TO dhis;

--
-- Name: userinfo; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userinfo (
    userinfoid bigint NOT NULL,
    uid character varying(11),
    code character varying(50),
    lastupdated timestamp without time zone NOT NULL,
    created timestamp without time zone NOT NULL,
    surname character varying(160) NOT NULL,
    firstname character varying(160) NOT NULL,
    email character varying(160),
    phonenumber character varying(80),
    jobtitle character varying(160),
    introduction text,
    gender character varying(50),
    birthday date,
    nationality character varying(160),
    employer character varying(160),
    education text,
    interests text,
    languages text,
    welcomemessage text,
    lastcheckedinterpretations timestamp without time zone,
    whatsapp character varying(255),
    skype character varying(255),
    facebookmessenger character varying(255),
    telegram character varying(255),
    twitter character varying(255),
    avatar bigint
);


ALTER TABLE public.userinfo OWNER TO dhis;

--
-- Name: userkeyjsonvalue; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userkeyjsonvalue (
    userkeyjsonvalueid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    userid bigint NOT NULL,
    namespace character varying(255) NOT NULL,
    userkey character varying(255) NOT NULL,
    encrypted_value character varying(255),
    encrypted boolean,
    jbvalue jsonb
);


ALTER TABLE public.userkeyjsonvalue OWNER TO dhis;

--
-- Name: usermembership; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usermembership (
    organisationunitid bigint NOT NULL,
    userinfoid bigint NOT NULL
);


ALTER TABLE public.usermembership OWNER TO dhis;

--
-- Name: usermessage; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usermessage (
    usermessageid integer NOT NULL,
    usermessagekey character varying(255),
    userid bigint NOT NULL,
    isread boolean NOT NULL,
    isfollowup boolean
);


ALTER TABLE public.usermessage OWNER TO dhis;

--
-- Name: usermessage_sequence; Type: SEQUENCE; Schema: public; Owner: dhis
--

CREATE SEQUENCE public.usermessage_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usermessage_sequence OWNER TO dhis;

--
-- Name: userrole; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userrole (
    userroleid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description character varying(255),
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.userrole OWNER TO dhis;

--
-- Name: userroleauthorities; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userroleauthorities (
    userroleid bigint NOT NULL,
    authority character varying(255)
);


ALTER TABLE public.userroleauthorities OWNER TO dhis;

--
-- Name: userrolemembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userrolemembers (
    userroleid bigint NOT NULL,
    userid bigint NOT NULL
);


ALTER TABLE public.userrolemembers OWNER TO dhis;

--
-- Name: userroleuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userroleuseraccesses (
    userroleid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.userroleuseraccesses OWNER TO dhis;

--
-- Name: userroleusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userroleusergroupaccesses (
    userroleid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.userroleusergroupaccesses OWNER TO dhis;

--
-- Name: users; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.users (
    userid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    creatoruserid bigint,
    username character varying(255) NOT NULL,
    password character varying(60),
    secret text NOT NULL,
    twofa boolean NOT NULL,
    externalauth boolean,
    openid text,
    ldapid text,
    passwordlastupdated timestamp without time zone,
    lastlogin timestamp without time zone,
    restoretoken character varying(255),
    restorecode character varying(255),
    restoreexpiry timestamp without time zone,
    selfregistered boolean,
    invitation boolean,
    disabled boolean
);


ALTER TABLE public.users OWNER TO dhis;

--
-- Name: users_catdimensionconstraints; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.users_catdimensionconstraints (
    userid bigint NOT NULL,
    dataelementcategoryid bigint NOT NULL
);


ALTER TABLE public.users_catdimensionconstraints OWNER TO dhis;

--
-- Name: users_cogsdimensionconstraints; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.users_cogsdimensionconstraints (
    userid bigint NOT NULL,
    categoryoptiongroupsetid bigint NOT NULL
);


ALTER TABLE public.users_cogsdimensionconstraints OWNER TO dhis;

--
-- Name: usersetting; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.usersetting (
    userinfoid bigint NOT NULL,
    name character varying(255) NOT NULL,
    value bytea
);


ALTER TABLE public.usersetting OWNER TO dhis;

--
-- Name: userteisearchorgunits; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.userteisearchorgunits (
    userinfoid bigint NOT NULL,
    organisationunitid bigint NOT NULL
);


ALTER TABLE public.userteisearchorgunits OWNER TO dhis;

--
-- Name: validationnotificationtemplate; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationnotificationtemplate (
    validationnotificationtemplateid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    subjecttemplate character varying(100),
    messagetemplate text,
    notifyusersinhierarchyonly boolean,
    sendstrategy character varying(50) NOT NULL
);


ALTER TABLE public.validationnotificationtemplate OWNER TO dhis;

--
-- Name: validationnotificationtemplate_recipientusergroups; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationnotificationtemplate_recipientusergroups (
    validationnotificationtemplateid bigint NOT NULL,
    usergroupid bigint NOT NULL
);


ALTER TABLE public.validationnotificationtemplate_recipientusergroups OWNER TO dhis;

--
-- Name: validationnotificationtemplatevalidationrules; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationnotificationtemplatevalidationrules (
    validationnotificationtemplateid bigint NOT NULL,
    validationruleid bigint NOT NULL
);


ALTER TABLE public.validationnotificationtemplatevalidationrules OWNER TO dhis;

--
-- Name: validationresult; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationresult (
    validationresultid bigint NOT NULL,
    created timestamp without time zone NOT NULL,
    leftsidevalue double precision,
    rightsidevalue double precision,
    validationruleid bigint,
    periodid bigint,
    organisationunitid bigint,
    attributeoptioncomboid bigint,
    dayinperiod integer,
    notificationsent boolean
);


ALTER TABLE public.validationresult OWNER TO dhis;

--
-- Name: validationrule; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationrule (
    validationruleid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    instruction text,
    importance character varying(50),
    operator character varying(255) NOT NULL,
    leftexpressionid bigint,
    rightexpressionid bigint,
    skipformvalidation boolean,
    periodtypeid integer NOT NULL,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.validationrule OWNER TO dhis;

--
-- Name: validationruleattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationruleattributevalues (
    validationruleid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.validationruleattributevalues OWNER TO dhis;

--
-- Name: validationrulegroup; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationrulegroup (
    validationrulegroupid bigint NOT NULL,
    uid character varying(11) NOT NULL,
    code character varying(50),
    created timestamp without time zone NOT NULL,
    lastupdated timestamp without time zone NOT NULL,
    lastupdatedby bigint,
    name character varying(230) NOT NULL,
    description text,
    userid bigint,
    publicaccess character varying(8),
    translations jsonb
);


ALTER TABLE public.validationrulegroup OWNER TO dhis;

--
-- Name: validationrulegroupattributevalues; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationrulegroupattributevalues (
    validationrulegroupid bigint NOT NULL,
    attributevalueid bigint NOT NULL
);


ALTER TABLE public.validationrulegroupattributevalues OWNER TO dhis;

--
-- Name: validationrulegroupmembers; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationrulegroupmembers (
    validationgroupid bigint NOT NULL,
    validationruleid bigint NOT NULL
);


ALTER TABLE public.validationrulegroupmembers OWNER TO dhis;

--
-- Name: validationrulegroupuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationrulegroupuseraccesses (
    validationrulegroupid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.validationrulegroupuseraccesses OWNER TO dhis;

--
-- Name: validationrulegroupusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationrulegroupusergroupaccesses (
    validationrulegroupid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.validationrulegroupusergroupaccesses OWNER TO dhis;

--
-- Name: validationruleorganisationunitlevels; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationruleorganisationunitlevels (
    validationruleid bigint NOT NULL,
    organisationunitlevel integer
);


ALTER TABLE public.validationruleorganisationunitlevels OWNER TO dhis;

--
-- Name: validationruleuseraccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationruleuseraccesses (
    validationruleid bigint NOT NULL,
    useraccessid integer NOT NULL
);


ALTER TABLE public.validationruleuseraccesses OWNER TO dhis;

--
-- Name: validationruleusergroupaccesses; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.validationruleusergroupaccesses (
    validationruleid bigint NOT NULL,
    usergroupaccessid integer NOT NULL
);


ALTER TABLE public.validationruleusergroupaccesses OWNER TO dhis;

--
-- Name: version; Type: TABLE; Schema: public; Owner: dhis
--

CREATE TABLE public.version (
    versionid bigint NOT NULL,
    versionkey character varying(230) NOT NULL,
    versionvalue character varying(255)
);


ALTER TABLE public.version OWNER TO dhis;

--
-- Data for Name: attribute; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.attribute (attributeid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, valuetype, mandatory, isunique, dataelementattribute, dataelementgroupattribute, indicatorattribute, indicatorgroupattribute, datasetattribute, organisationunitattribute, organisationunitgroupattribute, organisationunitgroupsetattribute, userattribute, usergroupattribute, programattribute, programstageattribute, trackedentitytypeattribute, trackedentityattributeattribute, categoryoptionattribute, categoryoptiongroupattribute, documentattribute, optionattribute, optionsetattribute, constantattribute, legendsetattribute, programindicatorattribute, sqlviewattribute, sectionattribute, categoryoptioncomboattribute, categoryoptiongroupsetattribute, dataelementgroupsetattribute, validationruleattribute, validationrulegroupattribute, categoryattribute, sortorder, optionsetid, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: attributeuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.attributeuseraccesses (attributeid, useraccessid) FROM stdin;
\.


--
-- Data for Name: attributeusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.attributeusergroupaccesses (attributeid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: attributevalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.attributevalue (attributevalueid, created, lastupdated, value, attributeid) FROM stdin;
\.


--
-- Data for Name: categories_categoryoptions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categories_categoryoptions (categoryid, sort_order, categoryoptionid) FROM stdin;
20	1	19
\.


--
-- Data for Name: categoryattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryattributevalues (categoryid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: categorycombo; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorycombo (categorycomboid, uid, code, created, lastupdated, lastupdatedby, name, datadimensiontype, skiptotal, userid, publicaccess, translations) FROM stdin;
21	bjDvmb4bfuf	default	2021-01-06 11:49:10.564	2021-01-06 11:49:10.58	\N	default	DISAGGREGATION	f	\N	rw------	[]
\.


--
-- Data for Name: categorycombos_categories; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorycombos_categories (categoryid, sort_order, categorycomboid) FROM stdin;
20	1	21
\.


--
-- Data for Name: categorycombos_optioncombos; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorycombos_optioncombos (categoryoptioncomboid, categorycomboid) FROM stdin;
22	21
\.


--
-- Data for Name: categorycombouseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorycombouseraccesses (categorycomboid, useraccessid) FROM stdin;
\.


--
-- Data for Name: categorycombousergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorycombousergroupaccesses (categorycomboid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: categorydimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorydimension (categorydimensionid, categoryid) FROM stdin;
\.


--
-- Data for Name: categorydimension_items; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categorydimension_items (categorydimensionid, sort_order, categoryoptionid) FROM stdin;
\.


--
-- Data for Name: categoryoption_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoption_organisationunits (organisationunitid, categoryoptionid) FROM stdin;
\.


--
-- Data for Name: categoryoptioncombo; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptioncombo (categoryoptioncomboid, uid, code, created, lastupdated, lastupdatedby, name, ignoreapproval, translations) FROM stdin;
22	HllvX50cXC0	default	2021-01-06 11:49:10.569	2021-01-06 11:49:10.579	\N	default	f	[]
\.


--
-- Data for Name: categoryoptioncomboattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptioncomboattributevalues (categoryoptioncomboid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: categoryoptioncombos_categoryoptions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptioncombos_categoryoptions (categoryoptioncomboid, categoryoptionid) FROM stdin;
22	19
\.


--
-- Data for Name: categoryoptiongroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroup (categoryoptiongroupid, uid, code, created, lastupdated, lastupdatedby, name, shortname, datadimensiontype, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupattributevalues (categoryoptiongroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupmembers (categoryoptiongroupid, categoryoptionid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupset (categoryoptiongroupsetid, uid, code, created, lastupdated, lastupdatedby, name, description, datadimension, datadimensiontype, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupsetattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupsetattributevalues (categoryoptiongroupsetid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupsetdimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupsetdimension (categoryoptiongroupsetdimensionid, categoryoptiongroupsetid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupsetdimension_items; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupsetdimension_items (categoryoptiongroupsetdimensionid, sort_order, categoryoptiongroupid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupsetmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupsetmembers (categoryoptiongroupid, categoryoptiongroupsetid, sort_order) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupsetuseraccesses (categoryoptiongroupsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupsetusergroupaccesses (categoryoptiongroupsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupuseraccesses (categoryoptiongroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: categoryoptiongroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.categoryoptiongroupusergroupaccesses (categoryoptiongroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: chart; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart (chartid, uid, code, created, lastupdated, lastupdatedby, name, description, domainaxislabel, rangeaxislabel, type, series, category, hidelegend, nospacebetweencolumns, regressiontype, title, subtitle, hidetitle, hidesubtitle, targetlinevalue, targetlinelabel, baselinevalue, baselinelabel, relativeperiodsid, userorganisationunit, userorganisationunitchildren, userorganisationunitgrandchildren, aggregationtype, completedonly, showdata, hideemptyrowitems, percentstackedvalues, cumulativevalues, rangeaxismaxvalue, rangeaxisminvalue, rangeaxissteps, rangeaxisdecimals, legendsetid, legenddisplaystrategy, colorsetid, sortorder, externalaccess, userid, publicaccess, favorites, subscribers, startdate, enddate, translations) FROM stdin;
\.


--
-- Data for Name: chart_categorydimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_categorydimensions (chartid, sort_order, categorydimensionid) FROM stdin;
\.


--
-- Data for Name: chart_categoryoptiongroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_categoryoptiongroupsetdimensions (chart, sort_order, categoryoptiongroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: chart_datadimensionitems; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_datadimensionitems (chartid, sort_order, datadimensionitemid) FROM stdin;
\.


--
-- Data for Name: chart_dataelementgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_dataelementgroupsetdimensions (chartid, sort_order, dataelementgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: chart_filters; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_filters (chartid, sort_order, filter) FROM stdin;
\.


--
-- Data for Name: chart_itemorgunitgroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_itemorgunitgroups (chartid, sort_order, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: chart_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_organisationunits (chartid, sort_order, organisationunitid) FROM stdin;
\.


--
-- Data for Name: chart_orgunitgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_orgunitgroupsetdimensions (chartid, sort_order, orgunitgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: chart_orgunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_orgunitlevels (chartid, sort_order, orgunitlevel) FROM stdin;
\.


--
-- Data for Name: chart_periods; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_periods (chartid, sort_order, periodid) FROM stdin;
\.


--
-- Data for Name: chart_seriesitems; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_seriesitems (chartid, sort_order, seriesid) FROM stdin;
\.


--
-- Data for Name: chart_yearlyseries; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chart_yearlyseries (chartid, sort_order, yearlyseries) FROM stdin;
\.


--
-- Data for Name: chartuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chartuseraccesses (chartid, useraccessid) FROM stdin;
\.


--
-- Data for Name: chartusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.chartusergroupaccesses (chartid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: color; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.color (colorid, uid, code, created, lastupdated, lastupdatedby, name, color, translations) FROM stdin;
\.


--
-- Data for Name: colorset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.colorset (colorsetid, uid, code, created, lastupdated, lastupdatedby, name, translations) FROM stdin;
\.


--
-- Data for Name: colorset_colors; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.colorset_colors (colorsetid, sort_order, colorid) FROM stdin;
\.


--
-- Data for Name: completedatasetregistration; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.completedatasetregistration (datasetid, periodid, sourceid, attributeoptioncomboid, date, storedby, lastupdatedby, lastupdated, completed) FROM stdin;
\.


--
-- Data for Name: configuration; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.configuration (configurationid, systemid, feedbackrecipientsid, offlineorgunitlevelid, infrastructuralindicatorsid, infrastructuraldataelementsid, infrastructuralperiodtypeid, selfregistrationrole, selfregistrationorgunit) FROM stdin;
23	0d772504-a899-4aeb-9789-97b83f3bba5e	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: configuration_corswhitelist; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.configuration_corswhitelist (configurationid, corswhitelist) FROM stdin;
\.


--
-- Data for Name: constant; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.constant (constantid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, value, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: constantattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.constantattributevalues (constantid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: constantuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.constantuseraccesses (constantid, useraccessid) FROM stdin;
\.


--
-- Data for Name: constantusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.constantusergroupaccesses (constantid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboard (dashboardid, uid, code, created, lastupdated, lastupdatedby, name, description, userid, externalaccess, publicaccess, favorites, translations) FROM stdin;
\.


--
-- Data for Name: dashboard_items; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboard_items (dashboardid, sort_order, dashboarditemid) FROM stdin;
\.


--
-- Data for Name: dashboarditem; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboarditem (dashboarditemid, uid, code, created, lastupdated, lastupdatedby, chartid, eventchartid, mapid, reporttable, textcontent, messages, appkey, shape, x, y, height, width, eventreport, translations) FROM stdin;
\.


--
-- Data for Name: dashboarditem_reports; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboarditem_reports (dashboarditemid, sort_order, reportid) FROM stdin;
\.


--
-- Data for Name: dashboarditem_resources; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboarditem_resources (dashboarditemid, sort_order, resourceid) FROM stdin;
\.


--
-- Data for Name: dashboarditem_users; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboarditem_users (dashboarditemid, sort_order, userid) FROM stdin;
\.


--
-- Data for Name: dashboarduseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboarduseraccesses (dashboardid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dashboardusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dashboardusergroupaccesses (dashboardid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataapproval; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapproval (dataapprovalid, dataapprovallevelid, workflowid, periodid, organisationunitid, attributeoptioncomboid, accepted, created, creator) FROM stdin;
\.


--
-- Data for Name: dataapprovalaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovalaudit (dataapprovalauditid, levelid, workflowid, periodid, organisationunitid, attributeoptioncomboid, action, created, creator) FROM stdin;
\.


--
-- Data for Name: dataapprovallevel; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovallevel (dataapprovallevelid, uid, code, created, lastupdated, lastupdatedby, name, level, orgunitlevel, categoryoptiongroupsetid, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: dataapprovalleveluseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovalleveluseraccesses (dataapprovallevelid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataapprovallevelusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovallevelusergroupaccesses (dataapprovallevelid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataapprovalworkflow; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovalworkflow (workflowid, uid, code, created, lastupdated, lastupdatedby, name, periodtypeid, categorycomboid, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: dataapprovalworkflowlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovalworkflowlevels (workflowid, dataapprovallevelid) FROM stdin;
\.


--
-- Data for Name: dataapprovalworkflowuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovalworkflowuseraccesses (workflowid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataapprovalworkflowusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataapprovalworkflowusergroupaccesses (workflowid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: datadimensionitem; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datadimensionitem (datadimensionitemid, indicatorid, dataelementid, dataelementoperand_dataelementid, dataelementoperand_categoryoptioncomboid, datasetid, metric, programindicatorid, programdataelement_programid, programdataelement_dataelementid, programattribute_programid, programattribute_attributeid) FROM stdin;
\.


--
-- Data for Name: dataelement; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelement (dataelementid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, formname, style, valuetype, domaintype, aggregationtype, categorycomboid, url, zeroissignificant, optionsetid, commentoptionsetid, userid, publicaccess, fieldmask, translations) FROM stdin;
\.


--
-- Data for Name: dataelementaggregationlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementaggregationlevels (dataelementid, sort_order, aggregationlevel) FROM stdin;
\.


--
-- Data for Name: dataelementattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementattributevalues (dataelementid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: dataelementcategory; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategory (categoryid, uid, code, created, lastupdated, lastupdatedby, name, datadimensiontype, datadimension, userid, publicaccess, translations) FROM stdin;
20	GLevLNI9wkl	default	2021-01-06 11:49:10.559	2021-01-06 11:49:10.708	\N	default	DISAGGREGATION	f	\N	rw------	[]
\.


--
-- Data for Name: dataelementcategoryoption; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategoryoption (categoryoptionid, uid, code, created, lastupdated, lastupdatedby, name, shortname, startdate, enddate, style, userid, publicaccess, translations) FROM stdin;
19	xYerKDKCefk	default	2021-01-06 11:49:10.505	2021-01-06 11:49:10.58	\N	default	\N	\N	\N	\N	\N	rwrw----	[]
\.


--
-- Data for Name: dataelementcategoryoptionattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategoryoptionattributevalues (categoryoptionid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: dataelementcategoryoptionuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategoryoptionuseraccesses (categoryoptionid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataelementcategoryoptionusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategoryoptionusergroupaccesses (categoryoptionid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataelementcategoryuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategoryuseraccesses (categoryid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataelementcategoryusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementcategoryusergroupaccesses (categoryid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataelementgroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroup (dataelementgroupid, uid, code, created, lastupdated, lastupdatedby, name, shortname, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: dataelementgroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupattributevalues (dataelementgroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupmembers (dataelementid, dataelementgroupid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupset (dataelementgroupsetid, uid, code, created, lastupdated, lastupdatedby, name, description, compulsory, datadimension, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: dataelementgroupsetattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupsetattributevalues (dataelementgroupsetid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupsetdimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupsetdimension (dataelementgroupsetdimensionid, dataelementgroupsetid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupsetdimension_items; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupsetdimension_items (dataelementgroupsetdimensionid, sort_order, dataelementgroupid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupsetmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupsetmembers (dataelementgroupsetid, sort_order, dataelementgroupid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupsetuseraccesses (dataelementgroupsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupsetusergroupaccesses (dataelementgroupsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupuseraccesses (dataelementgroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataelementgroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementgroupusergroupaccesses (dataelementgroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataelementlegendsets; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementlegendsets (dataelementid, sort_order, legendsetid) FROM stdin;
\.


--
-- Data for Name: dataelementoperand; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementoperand (dataelementoperandid, dataelementid, categoryoptioncomboid) FROM stdin;
\.


--
-- Data for Name: dataelementuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementuseraccesses (dataelementid, useraccessid) FROM stdin;
\.


--
-- Data for Name: dataelementusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataelementusergroupaccesses (dataelementid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: dataentryform; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataentryform (dataentryformid, uid, code, created, lastupdated, lastupdatedby, name, style, htmlcode, format, translations) FROM stdin;
\.


--
-- Data for Name: datainputperiod; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datainputperiod (datainputperiodid, periodid, openingdate, closingdate, datasetid) FROM stdin;
\.


--
-- Data for Name: dataset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.dataset (datasetid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, formname, style, periodtypeid, categorycomboid, mobile, version, expirydays, timelydays, notifycompletinguser, workflowid, openfutureperiods, fieldcombinationrequired, validcompleteonly, novaluerequirescomment, skipoffline, dataelementdecoration, renderastabs, renderhorizontally, compulsoryfieldscompleteonly, userid, publicaccess, dataentryform, notificationrecipients, translations) FROM stdin;
\.


--
-- Data for Name: datasetattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetattributevalues (datasetid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: datasetelement; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetelement (datasetelementid, datasetid, dataelementid, categorycomboid) FROM stdin;
\.


--
-- Data for Name: datasetindicators; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetindicators (indicatorid, datasetid) FROM stdin;
\.


--
-- Data for Name: datasetlegendsets; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetlegendsets (datasetid, sort_order, legendsetid) FROM stdin;
\.


--
-- Data for Name: datasetnotification_datasets; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetnotification_datasets (datasetnotificationtemplateid, datasetid) FROM stdin;
\.


--
-- Data for Name: datasetnotificationtemplate; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetnotificationtemplate (datasetnotificationtemplateid, uid, code, created, lastupdated, lastupdatedby, name, subjecttemplate, messagetemplate, relativescheduleddays, notifyparentorganisationunitonly, notifyusersinhierarchyonly, sendstrategy, usergroupid, datasetnotificationtrigger, notificationrecipienttype) FROM stdin;
\.


--
-- Data for Name: datasetnotificationtemplate_deliverychannel; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetnotificationtemplate_deliverychannel (datasetnotificationtemplateid, deliverychannel) FROM stdin;
\.


--
-- Data for Name: datasetoperands; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetoperands (datasetid, dataelementoperandid) FROM stdin;
\.


--
-- Data for Name: datasetsource; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetsource (sourceid, datasetid) FROM stdin;
\.


--
-- Data for Name: datasetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetuseraccesses (datasetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: datasetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datasetusergroupaccesses (datasetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: datastatistics; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datastatistics (statisticsid, uid, code, created, lastupdated, lastupdatedby, chartviews, mapviews, reporttableviews, eventreportviews, eventchartviews, dashboardviews, datasetreportviews, active_users, totalviews, charts, maps, reporttables, eventreports, eventcharts, dashboards, indicators, datavalues, users) FROM stdin;
\.


--
-- Data for Name: datastatisticsevent; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datastatisticsevent (eventid, eventtype, "timestamp", username, favoriteuid) FROM stdin;
\.


--
-- Data for Name: datavalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datavalue (dataelementid, periodid, sourceid, categoryoptioncomboid, attributeoptioncomboid, value, storedby, created, lastupdated, comment, followup, deleted) FROM stdin;
\.


--
-- Data for Name: datavalueaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.datavalueaudit (datavalueauditid, dataelementid, periodid, organisationunitid, categoryoptioncomboid, attributeoptioncomboid, value, created, modifiedby, audittype) FROM stdin;
\.


--
-- Data for Name: deletedobject; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.deletedobject (deletedobjectid, klass, uid, code, deleted_at, deleted_by) FROM stdin;
\.


--
-- Data for Name: document; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.document (documentid, uid, code, created, lastupdated, lastupdatedby, name, url, fileresource, external, contenttype, attachment, externalaccess, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: documentattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.documentattributevalues (documentid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: documentuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.documentuseraccesses (documentid, useraccessid) FROM stdin;
\.


--
-- Data for Name: documentusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.documentusergroupaccesses (documentid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: eventchart; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart (eventchartid, uid, code, created, lastupdated, lastupdatedby, name, description, relativeperiodsid, userorganisationunit, userorganisationunitchildren, userorganisationunitgrandchildren, programid, programstageid, startdate, enddate, dataelementvaluedimensionid, attributevaluedimensionid, aggregationtype, completedonly, timefield, title, subtitle, hidetitle, hidesubtitle, type, showdata, hideemptyrowitems, hidenadata, programstatus, eventstatus, percentstackedvalues, cumulativevalues, rangeaxismaxvalue, rangeaxisminvalue, rangeaxissteps, rangeaxisdecimals, outputtype, collapsedatadimensions, domainaxislabel, rangeaxislabel, hidelegend, nospacebetweencolumns, regressiontype, targetlinevalue, targetlinelabel, baselinevalue, baselinelabel, sortorder, externalaccess, userid, publicaccess, favorites, subscribers, translations, orgunitfield) FROM stdin;
\.


--
-- Data for Name: eventchart_attributedimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_attributedimensions (eventchartid, sort_order, trackedentityattributedimensionid) FROM stdin;
\.


--
-- Data for Name: eventchart_categorydimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_categorydimensions (eventchartid, sort_order, categorydimensionid) FROM stdin;
\.


--
-- Data for Name: eventchart_categoryoptiongroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_categoryoptiongroupsetdimensions (eventchartid, sort_order, categoryoptiongroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: eventchart_columns; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_columns (eventchartid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: eventchart_dataelementdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_dataelementdimensions (eventchartid, sort_order, trackedentitydataelementdimensionid) FROM stdin;
\.


--
-- Data for Name: eventchart_filters; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_filters (eventchartid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: eventchart_itemorgunitgroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_itemorgunitgroups (eventchartid, sort_order, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: eventchart_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_organisationunits (eventchartid, sort_order, organisationunitid) FROM stdin;
\.


--
-- Data for Name: eventchart_orgunitgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_orgunitgroupsetdimensions (eventchartid, sort_order, orgunitgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: eventchart_orgunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_orgunitlevels (eventchartid, sort_order, orgunitlevel) FROM stdin;
\.


--
-- Data for Name: eventchart_periods; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_periods (eventchartid, sort_order, periodid) FROM stdin;
\.


--
-- Data for Name: eventchart_programindicatordimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_programindicatordimensions (eventchartid, sort_order, trackedentityprogramindicatordimensionid) FROM stdin;
\.


--
-- Data for Name: eventchart_rows; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchart_rows (eventchartid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: eventchartuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchartuseraccesses (eventchartid, useraccessid) FROM stdin;
\.


--
-- Data for Name: eventchartusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventchartusergroupaccesses (eventchartid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: eventreport; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport (eventreportid, uid, code, created, lastupdated, lastupdatedby, name, description, relativeperiodsid, userorganisationunit, userorganisationunitchildren, userorganisationunitgrandchildren, programid, programstageid, startdate, enddate, dataelementvaluedimensionid, attributevaluedimensionid, aggregationtype, completedonly, timefield, title, subtitle, hidetitle, hidesubtitle, datatype, rowtotals, coltotals, rowsubtotals, colsubtotals, hideemptyrows, hidenadata, showhierarchy, outputtype, collapsedatadimensions, showdimensionlabels, digitgroupseparator, displaydensity, fontsize, programstatus, eventstatus, sortorder, toplimit, externalaccess, userid, publicaccess, favorites, subscribers, translations, orgunitfield) FROM stdin;
\.


--
-- Data for Name: eventreport_attributedimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_attributedimensions (eventreportid, sort_order, trackedentityattributedimensionid) FROM stdin;
\.


--
-- Data for Name: eventreport_categorydimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_categorydimensions (eventreportid, sort_order, categorydimensionid) FROM stdin;
\.


--
-- Data for Name: eventreport_categoryoptiongroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_categoryoptiongroupsetdimensions (eventreportid, sort_order, categoryoptiongroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: eventreport_columns; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_columns (eventreportid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: eventreport_dataelementdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_dataelementdimensions (eventreportid, sort_order, trackedentitydataelementdimensionid) FROM stdin;
\.


--
-- Data for Name: eventreport_filters; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_filters (eventreportid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: eventreport_itemorgunitgroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_itemorgunitgroups (eventreportid, sort_order, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: eventreport_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_organisationunits (eventreportid, sort_order, organisationunitid) FROM stdin;
\.


--
-- Data for Name: eventreport_orgunitgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_orgunitgroupsetdimensions (eventreportid, sort_order, orgunitgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: eventreport_orgunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_orgunitlevels (eventreportid, sort_order, orgunitlevel) FROM stdin;
\.


--
-- Data for Name: eventreport_periods; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_periods (eventreportid, sort_order, periodid) FROM stdin;
\.


--
-- Data for Name: eventreport_programindicatordimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_programindicatordimensions (eventreportid, sort_order, trackedentityprogramindicatordimensionid) FROM stdin;
\.


--
-- Data for Name: eventreport_rows; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreport_rows (eventreportid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: eventreportuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreportuseraccesses (eventreportid, useraccessid) FROM stdin;
\.


--
-- Data for Name: eventreportusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.eventreportusergroupaccesses (eventreportid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: expression; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.expression (expressionid, description, expression, slidingwindow, missingvaluestrategy) FROM stdin;
\.


--
-- Data for Name: externalfileresource; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.externalfileresource (externalfileresourceid, uid, code, created, lastupdated, lastupdatedby, accesstoken, expires, fileresourceid) FROM stdin;
\.


--
-- Data for Name: externalmaplayer; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.externalmaplayer (externalmaplayerid, uid, code, created, lastupdated, lastupdatedby, name, attribution, url, legendseturl, maplayerposition, layers, imageformat, mapservice, legendsetid, userid, publicaccess) FROM stdin;
\.


--
-- Data for Name: externalmaplayeruseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.externalmaplayeruseraccesses (externalmaplayerid, useraccessid) FROM stdin;
\.


--
-- Data for Name: externalmaplayerusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.externalmaplayerusergroupaccesses (externalmaplayerid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: externalnotificationlogentry; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.externalnotificationlogentry (externalnotificationlogentryid, uid, created, lastupdated, lastsentat, retries, key, templateuid, allowmultiple, triggerby) FROM stdin;
\.


--
-- Data for Name: fileresource; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.fileresource (fileresourceid, uid, code, created, lastupdated, lastupdatedby, name, contenttype, contentlength, contentmd5, storagekey, isassigned, domain, userid) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	2.30.0	Populate dhis2 schema if empty database	JDBC	org.hisp.dhis.db.migration.base.V2_30_0__Populate_dhis2_schema_if_empty_database	\N	dhis	2021-01-06 11:48:35.298113	20	t
2	2.31.1	Migrations for release v31	SQL	2.31/V2_31_1__Migrations_for_release_v31.sql	-271885416	dhis	2021-01-06 11:48:35.298113	487	t
3	2.31.2	Job configuration param to jsonb	JDBC	org.hisp.dhis.db.migration.v31.V2_31_2__Job_configuration_param_to_jsonb	\N	dhis	2021-01-06 11:48:35.298113	165	t
4	2.31.3	Program notification template to templateid	JDBC	org.hisp.dhis.db.migration.v31.V2_31_3__Program_notification_template_to_templateid	\N	dhis	2021-01-06 11:48:35.298113	3	t
5	2.31.4	Add defaults for validationstrategy	JDBC	org.hisp.dhis.db.migration.v31.V2_31_4__Add_defaults_for_validationstrategy	\N	dhis	2021-01-06 11:48:35.298113	2	t
6	2.31.5	Add new user role for new capture app	JDBC	org.hisp.dhis.db.migration.v31.V2_31_5__Add_new_user_role_for_new_capture_app	\N	dhis	2021-01-06 11:48:35.298113	3	t
7	2.31.6	Update default program access level to OPEN	SQL	2.31/V2_31_6__Update_default_program_access_level_to_OPEN.sql	389837453	dhis	2021-01-06 11:48:35.298113	0	t
8	2.31.7	Delete code klass unique constraint in deleted object	SQL	2.31/V2_31_7__Delete_code_klass_unique_constraint_in_deleted_object.sql	1445061512	dhis	2021-01-06 11:48:35.298113	3	t
9	2.31.9	Add user permissions for new data viz app	JDBC	org.hisp.dhis.db.migration.v31.V2_31_9__Add_user_permissions_for_new_data_viz_app	\N	dhis	2021-01-06 11:48:35.298113	1	t
10	2.31.10	Remove storagestatus column from fileresource table	SQL	2.31/V2_31_10__Remove_storagestatus_column_from_fileresource_table.sql	-1096225816	dhis	2021-01-06 11:48:35.298113	2	t
11	2.32.1	Org unit fields	SQL	2.32/V2_32_1__Org_unit_fields.sql	-1792150736	dhis	2021-01-06 11:48:35.298113	5	t
12	2.32.2	Complete data set registration fields	SQL	2.32/V2_32_2__Complete_data_set_registration_fields.sql	-1660385962	dhis	2021-01-06 11:48:35.298113	3	t
13	2.32.3	Program rule variable option code	SQL	2.32/V2_32_3__Program_rule_variable_option_code.sql	1675218695	dhis	2021-01-06 11:48:35.298113	2	t
14	2.32.4	Remove KafkaJob	SQL	2.32/V2_32_4__Remove_KafkaJob.sql	448507296	dhis	2021-01-06 11:48:35.298113	0	t
15	2.32.5	Remove program shortname constraint	SQL	2.32/V2_32_5__Remove_program_shortname_constraint.sql	623557658	dhis	2021-01-06 11:48:35.298113	0	t
16	2.32.6	Remove program approval workflow	SQL	2.32/V2_32_6__Remove_program_approval_workflow.sql	-665392634	dhis	2021-01-06 11:48:35.298113	1	t
17	2.32.7	Introduce jsonb eventdatavalues column	SQL	2.32/V2_32_7__Introduce_jsonb_eventdatavalues_column.sql	-161817378	dhis	2021-01-06 11:48:35.298113	18	t
18	2.32.8	OrgUnit geometry field	SQL	2.32/V2_32_8__OrgUnit_geometry_field.sql	2141862134	dhis	2021-01-06 11:48:35.298113	3	t
19	2.32.9	OrgUnitGroup geometry field	SQL	2.32/V2_32_9__OrgUnitGroup_geometry_field.sql	135519777	dhis	2021-01-06 11:48:35.298113	4	t
20	2.32.10	Use bigint for id columns	SQL	2.32/V2_32_10__Use_bigint_for_id_columns.sql	1959122901	dhis	2021-01-06 11:48:35.298113	5773	t
21	2.32.11	Remove TEI representative	SQL	2.32/V2_32_11__Remove_TEI_representative.sql	1168727321	dhis	2021-01-06 11:48:35.298113	3	t
22	2.32.12	Copy timestamp values into lastupdated field	SQL	2.32/V2_32_12__Copy_timestamp_values_into_lastupdated_field.sql	-1999611754	dhis	2021-01-06 11:48:35.298113	10	t
23	2.32.13	Add UserAssignment for Events	SQL	2.32/V2_32_13__Add_UserAssignment_for_Events.sql	-1769784669	dhis	2021-01-06 11:48:35.298113	4	t
24	2.32.14	Update relationshiptype bidirectional	SQL	2.32/V2_32_14__Update_relationshiptype_bidirectional.sql	-9899667	dhis	2021-01-06 11:48:35.298113	3	t
25	2.32.15	Add chart series	SQL	2.32/V2_32_15__Add_chart_series.sql	-1373861876	dhis	2021-01-06 11:48:35.298113	5	t
26	2.32.16	Assign Job Configuration UID	SQL	2.32/V2_32_16__Assign_Job_Configuration_UID.sql	1847518055	dhis	2021-01-06 11:48:35.298113	7	t
27	2.32.17	Separate sequence generators for highly used tables	SQL	2.32/V2_32_17__Separate_sequence_generators_for_highly_used_tables.sql	-590911677	dhis	2021-01-06 11:48:35.298113	23	t
28	2.32.18	PotentialDuplicate table	SQL	2.32/V2_32_18__PotentialDuplicate_table.sql	-1711695320	dhis	2021-01-06 11:48:35.298113	6	t
29	2.32.19	Create programstageinstancefilter table	SQL	2.32/V2_32_19__Create_programstageinstancefilter_table.sql	-1655494731	dhis	2021-01-06 11:48:35.298113	14	t
30	2.32.20	Create populate mapview filter dimension tables	SQL	2.32/V2_32_20__Create_populate_mapview_filter_dimension_tables.sql	1822920300	dhis	2021-01-06 11:48:35.298113	12	t
31	2.32.21	Create categories categoryoptions index	SQL	2.32/V2_32_21__Create_categories_categoryoptions_index.sql	-127279840	dhis	2021-01-06 11:48:35.298113	4	t
32	2.32.22	Migrate pie charts new format	SQL	2.32/V2_32_22__Migrate_pie_charts_new_format.sql	694570142	dhis	2021-01-06 11:48:35.298113	2	t
33	2.32.23	Migrate gauge charts new format	SQL	2.32/V2_32_23__Migrate_gauge_charts_new_format.sql	-1159638519	dhis	2021-01-06 11:48:35.298113	0	t
34	2.32.24	Add translations for dataSet section	SQL	2.32/V2_32_24__Add_translations_for_dataSet_section.sql	-1792497106	dhis	2021-01-06 11:48:35.298113	0	t
35	2.32.25	Drop trackedentitydatavalue table	SQL	2.32/V2_32_25__Drop_trackedentitydatavalue_table.sql	1765234989	dhis	2021-01-06 11:48:35.298113	1	t
36	2.32.26	RemoveOrphanProgramStageInstances	SQL	2.32/V2_32_26__RemoveOrphanProgramStageInstances.sql	-801139725	dhis	2021-01-06 11:48:35.298113	1	t
37	2.32.28	Remove unused columns from attribute values	SQL	2.32/V2_32_28__Remove_unused_columns_from_attribute_values.sql	834057069	dhis	2021-01-06 11:48:35.298113	0	t
38	2.32.30	Set embedded expressions nullable and unique	SQL	2.32/V2_32_30__Set_embedded_expressions_nullable_and_unique.sql	1515537010	dhis	2021-01-06 11:48:35.298113	9	t
39	2.32.31	Add translations column into systemsetting table	SQL	2.32/V2_32_31__Add_translations_column_into_systemsetting_table.sql	932924626	dhis	2021-01-06 11:48:35.298113	0	t
40	2.32.32	Clean attribute values	SQL	2.32/V2_32_32__Clean_attribute_values.sql	-1218579520	dhis	2021-01-06 11:48:35.298113	1	t
41	2.32.33	Convert push analysis job parameters into list of string	JDBC	org.hisp.dhis.db.migration.v32.V2_32_33__Convert_push_analysis_job_parameters_into_list_of_string	\N	dhis	2021-01-06 11:48:35.298113	2	t
42	2.32.34	Fix encryption issue for TEI attributeValues	JDBC	org.hisp.dhis.db.migration.v32.V2_32_34__Fix_encryption_issue_for_TEI_attributeValues	\N	dhis	2021-01-06 11:48:35.298113	12	t
43	2.32.35	Add index for ou column on tei table	SQL	2.32/V2_32_35__Add_index_for_ou_column_on_tei_table.sql	-1430094831	dhis	2021-01-06 11:48:35.298113	2	t
44	2.32.36	Remove duplicate mappings from categoryoption to usergroups	JDBC	org.hisp.dhis.db.migration.v32.V2_32_36__Remove_duplicate_mappings_from_categoryoption_to_usergroups	\N	dhis	2021-01-06 11:48:35.298113	3	t
45	2.32.37	Remove duplicate mappings from programstage to usergroups	JDBC	org.hisp.dhis.db.migration.v32.V2_32_37__Remove_duplicate_mappings_from_programstage_to_usergroups	\N	dhis	2021-01-06 11:48:35.298113	1	t
\.


--
-- Data for Name: i18nlocale; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.i18nlocale (i18nlocaleid, uid, code, created, lastupdated, lastupdatedby, name, locale) FROM stdin;
24	gqoPleIssy3	\N	2021-01-06 11:49:10.937	2021-01-06 11:49:10.937	\N	Afrikaans	af
25	LShO10PJAYj	\N	2021-01-06 11:49:10.949	2021-01-06 11:49:10.949	\N	Arabic	ar
26	hY1q4tMwms7	\N	2021-01-06 11:49:10.953	2021-01-06 11:49:10.953	\N	Bislama	bi
27	zAvuX5POL4r	\N	2021-01-06 11:49:10.958	2021-01-06 11:49:10.958	\N	Amharic	am
28	IAd0VMnY698	\N	2021-01-06 11:49:10.962	2021-01-06 11:49:10.962	\N	German	de
29	w2ONUPDIyp6	\N	2021-01-06 11:49:10.966	2021-01-06 11:49:10.966	\N	Dzongkha	dz
30	HWfok30YTgW	\N	2021-01-06 11:49:10.968	2021-01-06 11:49:10.968	\N	English	en
31	Pm9prIaqCdZ	\N	2021-01-06 11:49:10.97	2021-01-06 11:49:10.97	\N	Spanish	es
32	h96UHzFR1yD	\N	2021-01-06 11:49:10.973	2021-01-06 11:49:10.973	\N	Persian	fa
33	CMWBzza8GoM	\N	2021-01-06 11:49:10.974	2021-01-06 11:49:10.974	\N	French	fr
34	z0GzTOCb4ZR	\N	2021-01-06 11:49:10.978	2021-01-06 11:49:10.978	\N	Gujarati	gu
35	FRbiQVU5X3c	\N	2021-01-06 11:49:10.985	2021-01-06 11:49:10.985	\N	Hindi	hi
36	dCna75ESXzp	\N	2021-01-06 11:49:11.002	2021-01-06 11:49:11.002	\N	Indonesian	in
37	ferMHcJtacY	\N	2021-01-06 11:49:11.005	2021-01-06 11:49:11.005	\N	Italian	it
38	UWaE7X3ItWb	\N	2021-01-06 11:49:11.008	2021-01-06 11:49:11.008	\N	Khmer	km
39	BXENZptYg0C	\N	2021-01-06 11:49:11.012	2021-01-06 11:49:11.012	\N	Lao	lo
40	YVQZhLXqvvB	\N	2021-01-06 11:49:11.016	2021-01-06 11:49:11.016	\N	Burmese	my
41	BKiTh7kmMtz	\N	2021-01-06 11:49:11.021	2021-01-06 11:49:11.021	\N	Nepali	ne
42	o7U6qdKmt27	\N	2021-01-06 11:49:11.025	2021-01-06 11:49:11.025	\N	Dutch	nl
43	nIxtIHMk50n	\N	2021-01-06 11:49:11.039	2021-01-06 11:49:11.039	\N	Norwegian	no
44	jyEbHnCF1ge	\N	2021-01-06 11:49:11.045	2021-01-06 11:49:11.045	\N	Pushto	ps
45	OFnTaQPv9df	\N	2021-01-06 11:49:11.05	2021-01-06 11:49:11.05	\N	Portuguese	pt
46	zhZN83Cf4Ke	\N	2021-01-06 11:49:11.054	2021-01-06 11:49:11.054	\N	Russian	ru
47	ZK14vKUYvsd	\N	2021-01-06 11:49:11.057	2021-01-06 11:49:11.057	\N	Kinyarwanda	rw
48	V3ZcSu5tCj9	\N	2021-01-06 11:49:11.059	2021-01-06 11:49:11.059	\N	Swahili	sw
49	cVsoYJ6VRMs	\N	2021-01-06 11:49:11.062	2021-01-06 11:49:11.062	\N	Tajik	tg
50	hKkX0YqkyzP	\N	2021-01-06 11:49:11.08	2021-01-06 11:49:11.08	\N	Vietnamese	vi
51	EHgb3p01mLg	\N	2021-01-06 11:49:11.083	2021-01-06 11:49:11.083	\N	Chinese	zh
\.


--
-- Data for Name: incomingsms; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.incomingsms (id, originator, encoding, sentdate, receiveddate, text, gatewayid, status, parsed, statusmessage, userid) FROM stdin;
\.


--
-- Data for Name: indicator; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicator (indicatorid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, formname, annualized, decimals, indicatortypeid, numerator, numeratordescription, denominator, denominatordescription, url, style, aggregateexportcategoryoptioncombo, aggregateexportattributeoptioncombo, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: indicatorattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorattributevalues (indicatorid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: indicatorgroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroup (indicatorgroupid, uid, code, created, lastupdated, lastupdatedby, name, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: indicatorgroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupattributevalues (indicatorgroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: indicatorgroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupmembers (indicatorid, indicatorgroupid) FROM stdin;
\.


--
-- Data for Name: indicatorgroupset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupset (indicatorgroupsetid, uid, code, created, lastupdated, lastupdatedby, name, description, compulsory, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: indicatorgroupsetmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupsetmembers (indicatorgroupid, indicatorgroupsetid, sort_order) FROM stdin;
\.


--
-- Data for Name: indicatorgroupsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupsetuseraccesses (indicatorgroupsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: indicatorgroupsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupsetusergroupaccesses (indicatorgroupsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: indicatorgroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupuseraccesses (indicatorgroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: indicatorgroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorgroupusergroupaccesses (indicatorgroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: indicatorlegendsets; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorlegendsets (indicatorid, sort_order, legendsetid) FROM stdin;
\.


--
-- Data for Name: indicatortype; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatortype (indicatortypeid, uid, code, created, lastupdated, lastupdatedby, name, indicatorfactor, indicatornumber, translations) FROM stdin;
\.


--
-- Data for Name: indicatoruseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatoruseraccesses (indicatorid, useraccessid) FROM stdin;
\.


--
-- Data for Name: indicatorusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.indicatorusergroupaccesses (indicatorid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: intepretation_likedby; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.intepretation_likedby (interpretationid, userid) FROM stdin;
\.


--
-- Data for Name: interpretation; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.interpretation (interpretationid, uid, lastupdated, reporttableid, chartid, mapid, eventreportid, eventchartid, datasetid, periodid, organisationunitid, interpretationtext, created, likes, userid, publicaccess, mentions) FROM stdin;
\.


--
-- Data for Name: interpretation_comments; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.interpretation_comments (interpretationid, sort_order, interpretationcommentid) FROM stdin;
\.


--
-- Data for Name: interpretationcomment; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.interpretationcomment (interpretationcommentid, uid, lastupdated, commenttext, mentions, userid, created) FROM stdin;
\.


--
-- Data for Name: interpretationuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.interpretationuseraccesses (interpretationid, useraccessid) FROM stdin;
\.


--
-- Data for Name: interpretationusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.interpretationusergroupaccesses (interpretationid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: jobconfiguration; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.jobconfiguration (jobconfigurationid, uid, code, created, lastupdated, lastupdatedby, name, cronexpression, jobtype, jobstatus, lastexecutedstatus, lastexecuted, lastruntimeexecution, nextexecutiontime, continuousexecution, enabled, leaderonlyjob, jsonbjobparameters) FROM stdin;
52	pd6O228pqr0	\N	2021-01-06 11:49:11.133	2021-01-06 11:49:11.133	\N	File resource clean up	0 0 2 ? * *	\\xaced00057e7200206f72672e686973702e646869732e7363686564756c696e672e4a6f625479706500000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074001546494c455f5245534f555243455f434c45414e5550	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400095343484544554c4544	\N	\N	\N	\N	f	t	t	\N
53	BFa3jDsbtdO	\N	2021-01-06 11:49:11.178	2021-01-06 11:49:11.178	\N	Data statistics	0 0 2 ? * *	\\xaced00057e7200206f72672e686973702e646869732e7363686564756c696e672e4a6f625479706500000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074000f444154415f53544154495354494353	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400095343484544554c4544	\N	\N	\N	\N	f	t	t	\N
54	Js3vHn2AVuG	\N	2021-01-06 11:49:11.191	2021-01-06 11:49:11.191	\N	Validation result notification	0 0 7 ? * *	\\xaced00057e7200206f72672e686973702e646869732e7363686564756c696e672e4a6f625479706500000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074001f56414c49444154494f4e5f524553554c54535f4e4f54494649434154494f4e	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400095343484544554c4544	\N	\N	\N	\N	f	t	t	\N
55	sHMedQF7VYa	\N	2021-01-06 11:49:11.217	2021-01-06 11:49:11.217	\N	Credentials expiry alert	0 0 2 ? * *	\\xaced00057e7200206f72672e686973702e646869732e7363686564756c696e672e4a6f625479706500000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074001843524544454e5449414c535f4558504952595f414c455254	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400095343484544554c4544	\N	\N	\N	\N	f	t	t	\N
56	YvAwAmrqAtN	\N	2021-01-06 11:49:11.23	2021-01-06 11:49:11.23	\N	Dataset notification	0 0 2 ? * *	\\xaced00057e7200206f72672e686973702e646869732e7363686564756c696e672e4a6f625479706500000000000000001200007872000e6a6176612e6c616e672e456e756d00000000000000001200007870740015444154415f5345545f4e4f54494649434154494f4e	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400095343484544554c4544	\N	\N	\N	\N	f	t	t	\N
57	uwWCT2BMmlq	\N	2021-01-06 11:49:11.241	2021-01-06 11:49:11.241	\N	Remove expired reserved values	0 0 * ? * *	\\xaced00057e7200206f72672e686973702e646869732e7363686564756c696e672e4a6f625479706500000000000000001200007872000e6a6176612e6c616e672e456e756d0000000000000000120000787074001e52454d4f56455f455850495245445f52455345525645445f56414c554553	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d000000000000000012000078707400095343484544554c4544	\\xaced00057e7200226f72672e686973702e646869732e7363686564756c696e672e4a6f6253746174757300000000000000001200007872000e6a6176612e6c616e672e456e756d00000000000000001200007870740009434f4d504c45544544	2021-01-07 13:00:00.007	00:00:00.006	2021-01-07 14:00:00	f	t	t	\N
\.


--
-- Data for Name: keyjsonvalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.keyjsonvalue (keyjsonvalueid, uid, code, created, lastupdated, lastupdatedby, namespace, namespacekey, encrypted_value, encrypted, userid, publicaccess, jbvalue) FROM stdin;
\.


--
-- Data for Name: keyjsonvalueuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.keyjsonvalueuseraccesses (keyjsonvalueid, useraccessid) FROM stdin;
\.


--
-- Data for Name: keyjsonvalueusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.keyjsonvalueusergroupaccesses (keyjsonvalueid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: legendsetattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.legendsetattributevalues (legendsetid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: legendsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.legendsetuseraccesses (maplegendsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: legendsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.legendsetusergroupaccesses (maplegendsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: lockexception; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.lockexception (lockexceptionid, organisationunitid, periodid, datasetid) FROM stdin;
\.


--
-- Data for Name: map; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.map (mapid, uid, code, created, lastupdated, lastupdatedby, name, description, longitude, latitude, zoom, basemap, title, externalaccess, userid, publicaccess, favorites, subscribers, translations) FROM stdin;
\.


--
-- Data for Name: maplegend; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.maplegend (maplegendid, uid, code, created, lastupdated, lastupdatedby, name, startvalue, endvalue, color, image, maplegendsetid, translations) FROM stdin;
\.


--
-- Data for Name: maplegendset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.maplegendset (maplegendsetid, uid, code, created, lastupdated, lastupdatedby, name, symbolizer, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: mapmapviews; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapmapviews (mapid, sort_order, mapviewid) FROM stdin;
\.


--
-- Data for Name: mapuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapuseraccesses (mapid, useraccessid) FROM stdin;
\.


--
-- Data for Name: mapusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapusergroupaccesses (mapid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: mapview; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview (mapviewid, uid, code, created, lastupdated, lastupdatedby, description, layer, relativeperiodsid, userorganisationunit, userorganisationunitchildren, userorganisationunitgrandchildren, aggregationtype, programid, programstageid, startdate, enddate, trackedentitytypeid, programstatus, followup, organisationunitselectionmode, method, classes, colorlow, colorhigh, colorscale, legendsetid, radiuslow, radiushigh, opacity, orgunitgroupsetid, arearadius, hidden, labels, labelfontsize, labelfontweight, labelfontstyle, labelfontcolor, eventclustering, eventcoordinatefield, eventpointcolor, eventpointradius, config, styledataitem, translations) FROM stdin;
\.


--
-- Data for Name: mapview_attributedimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_attributedimensions (mapviewid, sort_order, trackedentityattributedimensionid) FROM stdin;
\.


--
-- Data for Name: mapview_categorydimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_categorydimensions (mapviewid, categorydimensionid, sort_order) FROM stdin;
\.


--
-- Data for Name: mapview_categoryoptiongroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_categoryoptiongroupsetdimensions (mapviewid, sort_order, categoryoptiongroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: mapview_columns; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_columns (mapviewid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: mapview_datadimensionitems; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_datadimensionitems (mapviewid, sort_order, datadimensionitemid) FROM stdin;
\.


--
-- Data for Name: mapview_dataelementdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_dataelementdimensions (mapviewid, sort_order, trackedentitydataelementdimensionid) FROM stdin;
\.


--
-- Data for Name: mapview_filters; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_filters (mapviewid, dimension, sort_order) FROM stdin;
\.


--
-- Data for Name: mapview_itemorgunitgroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_itemorgunitgroups (mapviewid, sort_order, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: mapview_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_organisationunits (mapviewid, sort_order, organisationunitid) FROM stdin;
\.


--
-- Data for Name: mapview_orgunitgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_orgunitgroupsetdimensions (mapviewid, sort_order, orgunitgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: mapview_orgunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_orgunitlevels (mapviewid, sort_order, orgunitlevel) FROM stdin;
\.


--
-- Data for Name: mapview_periods; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.mapview_periods (mapviewid, sort_order, periodid) FROM stdin;
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.message (messageid, uid, created, lastupdated, messagetext, internal, metadata, userid) FROM stdin;
\.


--
-- Data for Name: messageattachments; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.messageattachments (messageid, fileresourceid) FROM stdin;
\.


--
-- Data for Name: messageconversation; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.messageconversation (messageconversationid, uid, messagecount, created, lastupdated, subject, messagetype, priority, status, user_assigned, lastsenderid, lastmessage, userid) FROM stdin;
\.


--
-- Data for Name: messageconversation_messages; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.messageconversation_messages (messageconversationid, sort_order, messageid) FROM stdin;
\.


--
-- Data for Name: messageconversation_usermessages; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.messageconversation_usermessages (messageconversationid, usermessageid) FROM stdin;
\.


--
-- Data for Name: metadataaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.metadataaudit (metadataauditid, created_at, created_by, klass, uid, code, type, value) FROM stdin;
\.


--
-- Data for Name: metadataversion; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.metadataversion (versionid, uid, code, created, lastupdated, lastupdatedby, name, versiontype, importdate, hashcode) FROM stdin;
\.


--
-- Data for Name: minmaxdataelement; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.minmaxdataelement (minmaxdataelementid, sourceid, dataelementid, categoryoptioncomboid, minimumvalue, maximumvalue, generatedvalue) FROM stdin;
\.


--
-- Data for Name: oauth2client; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.oauth2client (oauth2clientid, uid, code, created, lastupdated, lastupdatedby, name, cid, secret) FROM stdin;
\.


--
-- Data for Name: oauth2clientgranttypes; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.oauth2clientgranttypes (oauth2clientid, sort_order, granttype) FROM stdin;
\.


--
-- Data for Name: oauth2clientredirecturis; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.oauth2clientredirecturis (oauth2clientid, sort_order, redirecturi) FROM stdin;
\.


--
-- Data for Name: oauth_access_token; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.oauth_access_token (token_id, token, authentication_id, user_name, client_id, authentication, refresh_token) FROM stdin;
\.


--
-- Data for Name: oauth_code; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.oauth_code (code, authentication) FROM stdin;
\.


--
-- Data for Name: oauth_refresh_token; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.oauth_refresh_token (token_id, token, authentication) FROM stdin;
\.


--
-- Data for Name: objecttranslation; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.objecttranslation (objecttranslationid, locale, property, value) FROM stdin;
\.


--
-- Data for Name: optionattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optionattributevalues (optionvalueid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: optiongroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroup (optiongroupid, uid, code, created, lastupdated, lastupdatedby, name, shortname, optionsetid, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: optiongroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupattributevalues (optiongroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: optiongroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupmembers (optiongroupid, optionid) FROM stdin;
\.


--
-- Data for Name: optiongroupset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupset (optiongroupsetid, uid, code, created, lastupdated, lastupdatedby, name, description, datadimension, optionsetid, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: optiongroupsetmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupsetmembers (optiongroupsetid, sort_order, optiongroupid) FROM stdin;
\.


--
-- Data for Name: optiongroupsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupsetuseraccesses (optiongroupsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: optiongroupsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupsetusergroupaccesses (optiongroupsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: optiongroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupuseraccesses (optiongroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: optiongroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optiongroupusergroupaccesses (optiongroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: optionset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optionset (optionsetid, uid, code, created, lastupdated, lastupdatedby, name, valuetype, version, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: optionsetattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optionsetattributevalues (optionsetid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: optionsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optionsetuseraccesses (optionsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: optionsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optionsetusergroupaccesses (optionsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: optionvalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.optionvalue (optionvalueid, uid, code, name, created, lastupdated, sort_order, description, formname, style, optionsetid, translations) FROM stdin;
\.


--
-- Data for Name: organisationunit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.organisationunit (organisationunitid, uid, code, created, lastupdated, lastupdatedby, name, shortname, parentid, path, hierarchylevel, description, openingdate, closeddate, comment, url, contactperson, address, email, phonenumber, userid, translations, geometry) FROM stdin;
61	TUi1bxbtx5l	OUL1001	2021-01-06 12:07:19.069	2021-01-06 12:07:19.425	58	Niger	Niger	\N	/TUi1bxbtx5l	1	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
63	mw1nTYB0yzr	OUL2001	2021-01-06 12:08:30.975	2021-01-06 12:08:31.049	58	Agadez	Agadez	61	/TUi1bxbtx5l/mw1nTYB0yzr	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
66	bGVTqM64DWV	OUL2004	2021-01-06 12:11:43.202	2021-01-06 12:11:43.289	58	Maradi	Maradi	61	/TUi1bxbtx5l/bGVTqM64DWV	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
65	pv9ZhCx9yiE	OUL2003	2021-01-06 12:10:39.087	2021-01-06 12:11:52.785	58	Dosso	Dosso	61	/TUi1bxbtx5l/pv9ZhCx9yiE	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
64	ZXeIgItUzCo	OUL2002	2021-01-06 12:10:00.236	2021-01-06 12:12:05.627	58	Diffa	Diffa	61	/TUi1bxbtx5l/ZXeIgItUzCo	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
67	pjidTSwUAS9	OUL2005	2021-01-06 12:13:48.912	2021-01-06 12:13:48.968	58	Niamey	Niamey	61	/TUi1bxbtx5l/pjidTSwUAS9	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
68	J3hJbWACPkY	OUL2006	2021-01-06 12:14:25.485	2021-01-06 12:14:25.539	58	Tahoua	Tahoua	61	/TUi1bxbtx5l/J3hJbWACPkY	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
69	rAqvNC069uE	OUL2007	2021-01-06 12:15:24.327	2021-01-06 12:15:24.367	58	Tillaberi	Tillaberi	61	/TUi1bxbtx5l/rAqvNC069uE	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
70	rKJlspnwwfZ	OUL2008	2021-01-06 12:16:01.941	2021-01-06 12:16:01.987	58	Zinder	Zinder	61	/TUi1bxbtx5l/rKJlspnwwfZ	2	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
71	jF4TzPINffp	OUL3001	2021-01-06 12:37:17.869	2021-01-06 12:37:17.891	58	DS Aderbissinat	DS Aderbissinat	63	/TUi1bxbtx5l/mw1nTYB0yzr/jF4TzPINffp	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
72	KXMWFd61SbF	OUL3002	2021-01-06 12:37:46.941	2021-01-06 12:37:46.99	58	DS Agadez	DS Agadez	63	/TUi1bxbtx5l/mw1nTYB0yzr/KXMWFd61SbF	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
73	JsEaqQxEFbu	OUL3003	2021-01-06 12:38:21.518	2021-01-06 12:38:21.592	58	DS Arlit	DS Arlit	63	/TUi1bxbtx5l/mw1nTYB0yzr/JsEaqQxEFbu	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
74	K454yGF7uXV	OUL3004	2021-01-06 12:38:49.673	2021-01-06 12:38:49.702	58	DS Bilma	DS Bilma	63	/TUi1bxbtx5l/mw1nTYB0yzr/K454yGF7uXV	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
75	gcTFU1ii1hb	OUL3005	2021-01-06 12:39:15.452	2021-01-06 12:39:15.512	58	DS Iferouane	DS Iferouane	63	/TUi1bxbtx5l/mw1nTYB0yzr/gcTFU1ii1hb	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
76	pLDsj8RwJqQ	OUL3006	2021-01-06 12:51:18.825	2021-01-06 12:51:18.881	58	DS Ingall	DS Ingall	63	/TUi1bxbtx5l/mw1nTYB0yzr/pLDsj8RwJqQ	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
77	PsxAXkylLmU	OUL3007	2021-01-06 12:51:44.109	2021-01-06 12:51:44.133	58	DS Tchirozérine	DS Tchirozérine	63	/TUi1bxbtx5l/mw1nTYB0yzr/PsxAXkylLmU	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
78	ExcPjL2tkQA	OUL3008	2021-01-06 12:52:21.378	2021-01-06 12:52:21.403	58	DS Bosso	DS Bosso	64	/TUi1bxbtx5l/ZXeIgItUzCo/ExcPjL2tkQA	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
79	LAQZQj21fAh	OUL3009	2021-01-06 12:52:51.072	2021-01-06 12:52:51.09	58	DS Diffa	DS Diffa	64	/TUi1bxbtx5l/ZXeIgItUzCo/LAQZQj21fAh	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
80	Hgwh3GljZIh	OUL3010	2021-01-06 12:53:16.383	2021-01-06 12:53:16.404	58	DS Goudoumaria	DS Goudoumaria	64	/TUi1bxbtx5l/ZXeIgItUzCo/Hgwh3GljZIh	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
81	P6ctWkiMBE6	OUL3011	2021-01-06 12:53:38.757	2021-01-06 12:53:38.799	58	DS Mainé Soroa	DS Mainé Soroa	64	/TUi1bxbtx5l/ZXeIgItUzCo/P6ctWkiMBE6	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
82	PbJZG2IJbAS	OUL3012	2021-01-06 12:54:09.525	2021-01-06 12:54:09.548	58	DS N'Guigmi	DS N'Guigmi	64	/TUi1bxbtx5l/ZXeIgItUzCo/PbJZG2IJbAS	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
83	xcBg1HHBBho	OUL3013	2021-01-06 12:54:42.52	2021-01-06 12:54:42.553	58	DS Boboye	DS Boboye	65	/TUi1bxbtx5l/pv9ZhCx9yiE/xcBg1HHBBho	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
84	sSdfRFXpBGP	OUL3014	2021-01-06 12:56:15.813	2021-01-06 12:56:15.849	58	DS Dioundou	DS Dioundou	65	/TUi1bxbtx5l/pv9ZhCx9yiE/sSdfRFXpBGP	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
85	mbqh1ESEutB	OUL3015	2021-01-06 12:56:39.121	2021-01-06 12:56:39.162	58	DS Dogon Doutchi	DS Dogon Doutchi	65	/TUi1bxbtx5l/pv9ZhCx9yiE/mbqh1ESEutB	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
86	gJPdYsjMsyQ	OUL3016	2021-01-06 12:57:10.024	2021-01-06 12:57:10.048	58	DS Dosso	DS Dosso	65	/TUi1bxbtx5l/pv9ZhCx9yiE/gJPdYsjMsyQ	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
87	D7pkffdWvl5	OUL3017	2021-01-06 12:57:33.989	2021-01-06 12:57:34.025	58	DS Falmey	DS Falmey	65	/TUi1bxbtx5l/pv9ZhCx9yiE/D7pkffdWvl5	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
88	JLWkhshcZGC	OUL3018	2021-01-06 12:57:58.248	2021-01-06 12:57:58.296	58	DS Gaya	DS Gaya	65	/TUi1bxbtx5l/pv9ZhCx9yiE/JLWkhshcZGC	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
89	mSwSuRfsxoc	OUL3019	2021-01-06 12:58:20.491	2021-01-06 12:58:20.549	58	DS Loga	DS Loga	65	/TUi1bxbtx5l/pv9ZhCx9yiE/mSwSuRfsxoc	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
90	QjEDOUcAjE5	OUL3020	2021-01-06 12:58:47.484	2021-01-06 12:58:47.522	58	DS Tibiri	DS Tibiri	65	/TUi1bxbtx5l/pv9ZhCx9yiE/QjEDOUcAjE5	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
91	nSQGlZfPaP2	OUL3021	2021-01-06 13:26:16.741	2021-01-06 13:26:16.786	58	DS Aguié	DS Aguié	66	/TUi1bxbtx5l/bGVTqM64DWV/nSQGlZfPaP2	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
92	jYoKTaKwULu	OUL3022	2021-01-06 13:28:57.066	2021-01-06 13:28:57.096	58	DS Bermo	DS Bermo	66	/TUi1bxbtx5l/bGVTqM64DWV/jYoKTaKwULu	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
93	cWQDy7lFrXG	OUL3023	2021-01-06 13:29:33.365	2021-01-06 13:29:33.407	58	DS Dakoro	DS Dakoro	66	/TUi1bxbtx5l/bGVTqM64DWV/cWQDy7lFrXG	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
94	ysgUlpQjrXc	OUL3024	2021-01-06 13:34:43.172	2021-01-06 13:34:44.883	58	DS Gazaoua	DS Gazaoua	66	/TUi1bxbtx5l/bGVTqM64DWV/ysgUlpQjrXc	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
95	uG0XWazLn3o	OUL3025	2021-01-06 13:35:03.007	2021-01-06 13:35:03.036	58	DS Guidan Roumdji	DS Guidan Roumdji	66	/TUi1bxbtx5l/bGVTqM64DWV/uG0XWazLn3o	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
96	zWEyCK2b4B5	OUL3026	2021-01-06 13:35:24.385	2021-01-06 13:35:24.417	58	DS Madarounfa	DS Madarounfa	66	/TUi1bxbtx5l/bGVTqM64DWV/zWEyCK2b4B5	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
97	TuTplXpeNfz	OUL3027	2021-01-06 13:35:45.831	2021-01-06 13:35:45.854	58	DS Maradi Ville	DS Maradi Ville	66	/TUi1bxbtx5l/bGVTqM64DWV/TuTplXpeNfz	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
98	ue1BNYdGgUG	OUL3028	2021-01-06 13:36:06.224	2021-01-06 13:36:06.271	58	DS Mayahi	DS Mayahi	66	/TUi1bxbtx5l/bGVTqM64DWV/ue1BNYdGgUG	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
99	cLsheZnQ8FU	OUL3029	2021-01-06 13:36:26.968	2021-01-06 13:36:27	58	DS Tessaoua	DS Tessaoua	66	/TUi1bxbtx5l/bGVTqM64DWV/cLsheZnQ8FU	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
100	KfdKM4TfeQy	OUL3030	2021-01-06 13:40:44.062	2021-01-06 13:40:44.104	58	DS Niamey I	DS Niamey I	67	/TUi1bxbtx5l/pjidTSwUAS9/KfdKM4TfeQy	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
101	OPeukCFdqNJ	OUL3031	2021-01-06 13:41:58.565	2021-01-06 13:41:58.617	58	DS Niamey II	DS Niamey II	67	/TUi1bxbtx5l/pjidTSwUAS9/OPeukCFdqNJ	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
102	UHhGmjyqPBI	OUL3032	2021-01-06 13:42:22.013	2021-01-06 13:42:22.047	58	DS Niamey III	DS Niamey III	67	/TUi1bxbtx5l/pjidTSwUAS9/UHhGmjyqPBI	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
103	vd5CYL3BeK1	OUL3033	2021-01-06 13:43:08.723	2021-01-06 13:43:08.781	58	DS Niamey IV	DS Niamey IV	67	/TUi1bxbtx5l/pjidTSwUAS9/vd5CYL3BeK1	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
104	W5a1LCXaqn8	OUL3034	2021-01-06 13:44:02.975	2021-01-06 13:44:02.996	58	DS Niamey V	DS Niamey V	67	/TUi1bxbtx5l/pjidTSwUAS9/W5a1LCXaqn8	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
105	qAIrt3e78MT	OUL3035	2021-01-06 13:49:27.694	2021-01-06 13:49:27.728	58	DS Abalak	DS Abalak	68	/TUi1bxbtx5l/J3hJbWACPkY/qAIrt3e78MT	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
106	Sa4BBO0yMRz	OUL3036	2021-01-06 13:49:57.291	2021-01-06 13:49:57.336	58	DS Bagaroua	DS Bagaroua	68	/TUi1bxbtx5l/J3hJbWACPkY/Sa4BBO0yMRz	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
107	rM6ugmTXpKq	OUL3037	2021-01-06 13:54:48.382	2021-01-06 13:54:48.424	58	DS Birni Konni	DS Birni Konni	68	/TUi1bxbtx5l/J3hJbWACPkY/rM6ugmTXpKq	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
108	qkjdPqXRZOJ	OUL3038	2021-01-06 13:55:45.173	2021-01-06 13:55:45.21	58	DS Bouza	DS Bouza	68	/TUi1bxbtx5l/J3hJbWACPkY/qkjdPqXRZOJ	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
111	xjMoc2oDQ9n	OUL3041	2021-01-06 13:59:01.103	2021-01-06 13:59:01.124	58	DS Madaoua	DS Madaoua	68	/TUi1bxbtx5l/J3hJbWACPkY/xjMoc2oDQ9n	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
109	hlPaFF9KXLC	OUL3039	2021-01-06 13:56:13.534	2021-01-06 13:56:13.596	58	DS Illéla	DS Illéla	68	/TUi1bxbtx5l/J3hJbWACPkY/hlPaFF9KXLC	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
110	PBDrTNMqrv7	OUL3040	2021-01-06 13:57:35.646	2021-01-06 13:57:35.674	58	DS Keita	DS Keita	68	/TUi1bxbtx5l/J3hJbWACPkY/PBDrTNMqrv7	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
112	QIT4c4Piqze	OUL3042	2021-01-06 14:01:13.659	2021-01-06 14:01:13.739	58	DS Tahoua	DS Tahoua	68	/TUi1bxbtx5l/J3hJbWACPkY/QIT4c4Piqze	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
113	tuKeGt6H1hz	OUL3043	2021-01-06 14:01:48.32	2021-01-06 14:01:48.375	58	DS Tahoua Commune	DS Tahoua Commune	68	/TUi1bxbtx5l/J3hJbWACPkY/tuKeGt6H1hz	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
114	udsycngcKK8	OUL3044	2021-01-06 14:02:14.897	2021-01-06 14:02:14.948	58	DS Tassara	DS Tassara	68	/TUi1bxbtx5l/J3hJbWACPkY/udsycngcKK8	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
115	jxvqGRa7Aw0	OUL3045	2021-01-06 14:06:44.599	2021-01-06 14:06:44.663	58	DS Tchintabaraden	DS Tchintabaraden	68	/TUi1bxbtx5l/J3hJbWACPkY/jxvqGRa7Aw0	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
116	FdXfx73yKfH	OUL3046	2021-01-06 14:08:36.309	2021-01-06 14:08:36.362	58	DS Tillia	DS Tillia	68	/TUi1bxbtx5l/J3hJbWACPkY/FdXfx73yKfH	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
117	tQhXjUk0DT9	OUL3047	2021-01-06 14:10:35.77	2021-01-06 14:10:35.824	58	DS Abala	DS Abala	69	/TUi1bxbtx5l/rAqvNC069uE/tQhXjUk0DT9	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
118	pHqxuKruV0q	OUL3048	2021-01-06 14:11:07.114	2021-01-06 14:11:07.173	58	DS Ayorou	DS Ayorou	69	/TUi1bxbtx5l/rAqvNC069uE/pHqxuKruV0q	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
119	HK24IQZ7NOy	OUL3049	2021-01-06 14:12:20.031	2021-01-06 14:12:20.104	58	DS Balleyara	DS Balleyara	69	/TUi1bxbtx5l/rAqvNC069uE/HK24IQZ7NOy	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
120	Wy0OMJufp3m	OUL3050	2021-01-06 14:12:58.355	2021-01-06 14:12:58.406	58	DS Banibangou	DS Banibangou	69	/TUi1bxbtx5l/rAqvNC069uE/Wy0OMJufp3m	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
121	Lbri8XT4RW6	OUL3051	2021-01-06 14:14:03.77	2021-01-06 14:14:03.844	58	DS Bankilare	DS Bankilare	69	/TUi1bxbtx5l/rAqvNC069uE/Lbri8XT4RW6	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
122	Rl0hSaq9x7v	OUL3052	2021-01-06 14:14:31.334	2021-01-06 14:14:31.407	58	DS Fillingue	DS Fillingue	69	/TUi1bxbtx5l/rAqvNC069uE/Rl0hSaq9x7v	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
123	TYIYr1iRgXo	OUL3053	2021-01-06 14:15:07.844	2021-01-06 14:15:07.875	58	DS Gotheye	DS Gotheye	69	/TUi1bxbtx5l/rAqvNC069uE/TYIYr1iRgXo	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
124	k5fSYvpMB6U	OUL3054	2021-01-06 14:16:03.556	2021-01-06 14:16:03.594	58	DS Kollo	DS Kollo	69	/TUi1bxbtx5l/rAqvNC069uE/k5fSYvpMB6U	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
125	H9J0KpdUmvk	OUL3055	2021-01-06 14:17:05.793	2021-01-06 14:17:05.834	58	DS Ouallam	DS Ouallam	69	/TUi1bxbtx5l/rAqvNC069uE/H9J0KpdUmvk	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
126	n7rLjBQ3lDI	OUL3056	2021-01-06 14:17:38.836	2021-01-06 14:17:38.869	58	DS Say	DS Say	69	/TUi1bxbtx5l/rAqvNC069uE/n7rLjBQ3lDI	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
127	E3xbGHKUopY	OUL3057	2021-01-06 14:18:25.297	2021-01-06 14:18:25.346	58	DS Tera	DS Tera	69	/TUi1bxbtx5l/rAqvNC069uE/E3xbGHKUopY	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
128	iNPSht7mcSz	OUL3058	2021-01-06 14:19:47.358	2021-01-06 14:19:47.4	58	DS Tillabery	DS Tillabery	69	/TUi1bxbtx5l/rAqvNC069uE/iNPSht7mcSz	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
129	kqN20FEomCf	OUL3059	2021-01-06 14:20:40.47	2021-01-06 14:20:40.529	58	DS Torodi	DS Torodi	69	/TUi1bxbtx5l/rAqvNC069uE/kqN20FEomCf	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
130	FGTNzWpqPlA	OUL3060	2021-01-06 14:33:10.319	2021-01-06 14:33:10.359	58	DS Belbedji	DS Belbedji	70	/TUi1bxbtx5l/rKJlspnwwfZ/FGTNzWpqPlA	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
131	xHchXNvHHtD	OUL3061	2021-01-06 14:34:26.871	2021-01-06 14:34:26.92	58	DS Damgaram Takaya	DS Damgaram Takaya	70	/TUi1bxbtx5l/rKJlspnwwfZ/xHchXNvHHtD	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
132	YDKRB7fFCaR	OUL3062	2021-01-06 14:35:05.72	2021-01-06 14:35:05.751	58	DS Doungass	DS Doungass	70	/TUi1bxbtx5l/rKJlspnwwfZ/YDKRB7fFCaR	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
133	PWd0OyHYUmC	OUL3063	2021-01-06 14:36:25.265	2021-01-06 14:36:25.315	58	DS Goure	DS Goure	70	/TUi1bxbtx5l/rKJlspnwwfZ/PWd0OyHYUmC	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
134	yt5ToQxUg7u	OUL3064	2021-01-06 14:37:04.392	2021-01-06 14:37:04.438	58	DS Magaria	DS Magaria	70	/TUi1bxbtx5l/rKJlspnwwfZ/yt5ToQxUg7u	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
135	yiHhcbYT6OU	OUL3065	2021-01-06 14:38:47.85	2021-01-06 14:38:47.875	58	DS Matamèye	DS Matamèye	70	/TUi1bxbtx5l/rKJlspnwwfZ/yiHhcbYT6OU	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
136	dvqJM19Di9B	OUL3066	2021-01-06 14:39:08.413	2021-01-06 14:39:08.452	58	DS Mirriah	DS Mirriah	70	/TUi1bxbtx5l/rKJlspnwwfZ/dvqJM19Di9B	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
137	aJkRlvLjxEp	OUL3067	2021-01-06 14:39:26.858	2021-01-06 14:39:26.885	58	DS Takeita	DS Takeita	70	/TUi1bxbtx5l/rKJlspnwwfZ/aJkRlvLjxEp	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
138	YSAC7kgLjst	OUL3068	2021-01-06 14:39:47.14	2021-01-06 14:39:47.171	58	DS Tanout	DS Tanout	70	/TUi1bxbtx5l/rKJlspnwwfZ/YSAC7kgLjst	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
139	PeMrAlbBUx9	OUL3069	2021-01-06 14:40:10.987	2021-01-06 14:40:11.031	58	DS Tesker	DS Tesker	70	/TUi1bxbtx5l/rKJlspnwwfZ/PeMrAlbBUx9	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
140	cY5ovxlqZ1q	OUL3070	2021-01-06 14:40:34.003	2021-01-06 14:40:34.051	58	DS Zinder Ville	DS Zinder Ville	70	/TUi1bxbtx5l/rKJlspnwwfZ/cY5ovxlqZ1q	3	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
141	WniMOregyRB	OUL4001	2021-01-06 22:38:36.966	2021-01-06 22:38:37.314	58	CSI Abalama	CSI Abalama	71	/TUi1bxbtx5l/mw1nTYB0yzr/jF4TzPINffp/WniMOregyRB	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
142	zQdxkyB87XH	OUL4002	2021-01-06 22:38:58.891	2021-01-06 22:38:59.043	58	CSI Aderbissinat	CSI Aderbissinat	71	/TUi1bxbtx5l/mw1nTYB0yzr/jF4TzPINffp/zQdxkyB87XH	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
143	rZ9gqHQpcNG	OUL4003	2021-01-06 22:39:24.335	2021-01-06 22:39:24.438	58	CSI Alerces	CSI Alerces	72	/TUi1bxbtx5l/mw1nTYB0yzr/KXMWFd61SbF/rZ9gqHQpcNG	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
144	T6WnTwUrX1i	OUL4004	2021-01-06 22:39:51.484	2021-01-06 22:39:51.575	58	CSI Centre	CSI Centre	72	/TUi1bxbtx5l/mw1nTYB0yzr/KXMWFd61SbF/T6WnTwUrX1i	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
145	v0wEtTbczb4	OUL4005	2021-01-06 22:40:21.056	2021-01-06 22:40:21.236	58	CSI Dagmanet	CSI Dagmanet	72	/TUi1bxbtx5l/mw1nTYB0yzr/KXMWFd61SbF/v0wEtTbczb4	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
146	nbdFupPEJac	OUL4006	2021-01-06 22:45:43.565	2021-01-06 22:45:43.689	58	CSI Akokan	CSI Akokan	73	/TUi1bxbtx5l/mw1nTYB0yzr/JsEaqQxEFbu/nbdFupPEJac	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
147	gUY5CIBQan9	OUL4007	2021-01-06 22:46:29.642	2021-01-06 22:46:29.756	58	CSI Anoumakarane	CSI Anoumakarane	73	/TUi1bxbtx5l/mw1nTYB0yzr/JsEaqQxEFbu/gUY5CIBQan9	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
148	NJkGWwJZncR	OUL4008	2021-01-06 22:46:56.503	2021-01-06 22:46:56.607	58	CSI Arlit	CSI Arlit	73	/TUi1bxbtx5l/mw1nTYB0yzr/JsEaqQxEFbu/NJkGWwJZncR	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
149	lpjPXBB0pnM	OUL4009	2021-01-06 22:47:23.358	2021-01-06 22:47:23.527	58	CSI Achinouma	CSI Achinouma	74	/TUi1bxbtx5l/mw1nTYB0yzr/K454yGF7uXV/lpjPXBB0pnM	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
150	SKt0V9AZFCG	OUL4010	2021-01-06 22:48:50.893	2021-01-06 22:48:51.052	58	CSI Aneye	CSI Aneye	74	/TUi1bxbtx5l/mw1nTYB0yzr/K454yGF7uXV/SKt0V9AZFCG	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
151	aLKTIk5qWNn	OUL4011	2021-01-06 22:49:28.703	2021-01-06 22:49:28.874	58	HD Bilma	HD Bilma	74	/TUi1bxbtx5l/mw1nTYB0yzr/K454yGF7uXV/aLKTIk5qWNn	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
152	sEPqm2fYp9v	OUL4012	2021-01-06 22:50:07.705	2021-01-06 22:50:07.844	58	CSI Timia	CSI Timia	75	/TUi1bxbtx5l/mw1nTYB0yzr/gcTFU1ii1hb/sEPqm2fYp9v	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
156	NI9E4piobMO	OUL4016	2021-01-06 22:54:05.604	2021-01-06 22:54:05.706	58	CSI Agaya	CSI Agaya	76	/TUi1bxbtx5l/mw1nTYB0yzr/pLDsj8RwJqQ/NI9E4piobMO	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
159	uiePXdYxqVG	OUL4019	2021-01-06 22:59:51.26	2021-01-06 22:59:51.38	58	CSI Aouderass	CSI Aouderass	77	/TUi1bxbtx5l/mw1nTYB0yzr/PsxAXkylLmU/uiePXdYxqVG	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
153	hEDnXAEu1Y3	OUL4013	2021-01-06 22:50:55.098	2021-01-06 22:50:55.165	58	CSI Tintelloust	CSI Tintelloust	75	/TUi1bxbtx5l/mw1nTYB0yzr/gcTFU1ii1hb/hEDnXAEu1Y3	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
157	dWrO5Q4ORv4	OUL4017	2021-01-06 22:55:13.202	2021-01-06 22:55:13.319	58	CSI Amataltal	CSI Amataltal	76	/TUi1bxbtx5l/mw1nTYB0yzr/pLDsj8RwJqQ/dWrO5Q4ORv4	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
154	vxQltMultTj	OUL4014	2021-01-06 22:51:33.052	2021-01-06 22:51:33.194	58	CSI Zomo	CSI Zomo	75	/TUi1bxbtx5l/mw1nTYB0yzr/gcTFU1ii1hb/vxQltMultTj	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
161	B563g9WQW6M	OUL4021	2021-01-06 23:00:43.848	2021-01-06 23:00:43.943	58	CSI Tourayat	CSI Tourayat	77	/TUi1bxbtx5l/mw1nTYB0yzr/PsxAXkylLmU/B563g9WQW6M	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
162	wBBAUITVsb2	OUL4022	2021-01-06 23:05:28.786	2021-01-06 23:05:28.901	58	CSI Bandi	CSI Bandi	78	/TUi1bxbtx5l/ZXeIgItUzCo/ExcPjL2tkQA/wBBAUITVsb2	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
155	kEamVAXiiiF	OUL4015	2021-01-06 22:53:19.282	2021-01-06 22:53:19.39	58	CSI  Ingigrane	CSI  Ingigrane	76	/TUi1bxbtx5l/mw1nTYB0yzr/pLDsj8RwJqQ/kEamVAXiiiF	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
164	axHYp4O9yzF	OUL4024	2021-01-06 23:26:13.488	2021-01-06 23:26:13.602	58	CSI Sayam	CSI Sayam	79	/TUi1bxbtx5l/ZXeIgItUzCo/LAQZQj21fAh/axHYp4O9yzF	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
158	EeTTP0BskYG	OUL4018	2021-01-06 22:59:10.094	2021-01-06 22:59:10.192	58	CSI Affassas 	CSI Affassas 	77	/TUi1bxbtx5l/mw1nTYB0yzr/PsxAXkylLmU/EeTTP0BskYG	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
165	CcabDXmeGU7	OUL4025	2021-01-06 23:32:54.093	2021-01-06 23:32:54.199	58	CSI Sayam Forage	CSI Sayam Forage	79	/TUi1bxbtx5l/ZXeIgItUzCo/LAQZQj21fAh/CcabDXmeGU7	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
160	ncavpntFmOP	OUL4020	2021-01-06 23:00:14.93	2021-01-06 23:00:14.986	58	CSI Assada	CSI Assada	77	/TUi1bxbtx5l/mw1nTYB0yzr/PsxAXkylLmU/ncavpntFmOP	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
163	UrQ8yT3sAD5	OUL4023	2021-01-06 23:05:56.851	2021-01-06 23:05:56.909	58	CSI Bosso	CSI Bosso	78	/TUi1bxbtx5l/ZXeIgItUzCo/ExcPjL2tkQA/UrQ8yT3sAD5	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
166	WBnSHDyr2M0	OUL4026	2021-01-06 23:36:28.301	2021-01-06 23:36:28.4	58	CSI Zarwaram	CSI Zarwaram	79	/TUi1bxbtx5l/ZXeIgItUzCo/LAQZQj21fAh/WBnSHDyr2M0	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
167	DXtRRUuKzHn	OUL4027	2021-01-06 23:37:09.11	2021-01-06 23:37:09.172	58	CSI Boutti	CSI Boutti	80	/TUi1bxbtx5l/ZXeIgItUzCo/Hgwh3GljZIh/DXtRRUuKzHn	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
168	NP3g4w20QQ5	OUL4028	2021-01-06 23:37:44.869	2021-01-06 23:37:44.96	58	CSI Djadjiri	CSI Djadjiri	80	/TUi1bxbtx5l/ZXeIgItUzCo/Hgwh3GljZIh/NP3g4w20QQ5	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
169	juiGrbqc4VK	OUL4029	2021-01-06 23:38:35.18	2021-01-06 23:38:35.272	58	CSI Goudoumaria	CSI Goudoumaria	80	/TUi1bxbtx5l/ZXeIgItUzCo/Hgwh3GljZIh/juiGrbqc4VK	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
170	uwqsUqcwEVs	OUL4030	2021-01-06 23:39:01.574	2021-01-06 23:39:01.658	58	CSI N'Guel Kounama	CSI N'Guel Kounama	80	/TUi1bxbtx5l/ZXeIgItUzCo/Hgwh3GljZIh/uwqsUqcwEVs	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
171	ZGuhnegvdYv	OUL4031	2021-01-07 09:35:30.321	2021-01-07 09:35:30.575	58	CSI Tam	CSI Tam	81	/TUi1bxbtx5l/ZXeIgItUzCo/P6ctWkiMBE6/ZGuhnegvdYv	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
172	rdeK2b49VBf	OUL4032	2021-01-07 09:36:07.072	2021-01-07 09:36:07.342	58	CSI Toumboulam	CSI Toumboulam	81	/TUi1bxbtx5l/ZXeIgItUzCo/P6ctWkiMBE6/rdeK2b49VBf	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
173	FLWgDbf1V6y	OUL4033	2021-01-07 09:46:39.537	2021-01-07 09:46:39.608	58	HD Maine Soroa	HD Maine Soroa	81	/TUi1bxbtx5l/ZXeIgItUzCo/P6ctWkiMBE6/FLWgDbf1V6y	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
174	gzGIn62R5BX	OUL4034	2021-01-07 09:50:06.935	2021-01-07 09:50:07.059	58	CSI N'Galewa	CSI N'Galewa	82	/TUi1bxbtx5l/ZXeIgItUzCo/PbJZG2IJbAS/gzGIn62R5BX	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
175	eyyUoeSNuOH	OUL4035	2021-01-07 09:52:03.678	2021-01-07 09:52:03.83	58	CSI N'Guigmi	CSI N'Guigmi	82	/TUi1bxbtx5l/ZXeIgItUzCo/PbJZG2IJbAS/eyyUoeSNuOH	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
176	o0jNzyjXYLN	OUL4036	2021-01-07 09:52:51.068	2021-01-07 09:52:51.251	58	HD N'Guigmi	HD N'Guigmi	82	/TUi1bxbtx5l/ZXeIgItUzCo/PbJZG2IJbAS/o0jNzyjXYLN	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
177	W8y0fSoC1U0	OUL4037	2021-01-07 10:04:46.082	2021-01-07 10:04:46.169	58	CSI Zouzou Beri	CSI Zouzou Beri	83	/TUi1bxbtx5l/pv9ZhCx9yiE/xcBg1HHBBho/W8y0fSoC1U0	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
178	KttX1Ay8ter	OUL4038	2021-01-07 10:05:13.055	2021-01-07 10:05:13.231	58	CSI Zouzou Saney	CSI Zouzou Saney	83	/TUi1bxbtx5l/pv9ZhCx9yiE/xcBg1HHBBho/KttX1Ay8ter	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
179	qZ6ihWPGyHY	OUL4039	2021-01-07 10:05:41.457	2021-01-07 10:05:41.653	58	HD Boboye	HD Boboye	83	/TUi1bxbtx5l/pv9ZhCx9yiE/xcBg1HHBBho/qZ6ihWPGyHY	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
180	OKXbC1VUdeO	OUL4040	2021-01-07 10:06:12.821	2021-01-07 10:06:12.961	58	CSI Dioundiou	CSI Dioundiou	84	/TUi1bxbtx5l/pv9ZhCx9yiE/sSdfRFXpBGP/OKXbC1VUdeO	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
181	jUwNYHVxCts	OUL4041	2021-01-07 10:06:49.847	2021-01-07 10:06:49.984	58	CSI Dogon Dagi	CSI Dogon Dagi	84	/TUi1bxbtx5l/pv9ZhCx9yiE/sSdfRFXpBGP/jUwNYHVxCts	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
182	YyIwCJwFYmb	OUL4042	2021-01-07 10:07:35.884	2021-01-07 10:07:36.084	58	CSI Gawassa	CSI Gawassa	84	/TUi1bxbtx5l/pv9ZhCx9yiE/sSdfRFXpBGP/YyIwCJwFYmb	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
183	SYZfZkgupw3	OUL4043	2021-01-07 10:09:52.098	2021-01-07 10:09:52.33	58	CSI Bawada	CSI Bawada	85	/TUi1bxbtx5l/pv9ZhCx9yiE/mbqh1ESEutB/SYZfZkgupw3	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
184	r2fOzoBwVGb	OUL4044	2021-01-07 10:10:24.617	2021-01-07 10:10:30.646	58	CSI Birni Lokoyo	CSI Birni Lokoyo	85	/TUi1bxbtx5l/pv9ZhCx9yiE/mbqh1ESEutB/r2fOzoBwVGb	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
185	pvc8iXD0gY1	OUL4045	2021-01-07 10:11:04.903	2021-01-07 10:11:05.04	58	HD Dogon Doutchi	HD Dogon Doutchi	85	/TUi1bxbtx5l/pv9ZhCx9yiE/mbqh1ESEutB/pvc8iXD0gY1	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
186	q3rlXr4Ze1I	OUL4046	2021-01-07 10:11:29.412	2021-01-07 10:11:29.657	58	CSI Walio Koira	CSI Walio Koira	86	/TUi1bxbtx5l/pv9ZhCx9yiE/gJPdYsjMsyQ/q3rlXr4Ze1I	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
187	mzemB13MwLI	OUL4047	2021-01-07 10:12:54.428	2021-01-07 10:12:54.577	58	CSI Wangal Kaina	CSI Wangal Kaina	86	/TUi1bxbtx5l/pv9ZhCx9yiE/gJPdYsjMsyQ/mzemB13MwLI	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
188	kuxONlq1UBJ	OUL4048	2021-01-07 10:14:31.263	2021-01-07 10:14:31.372	58	CSI Yambaré	CSI Yambaré	86	/TUi1bxbtx5l/pv9ZhCx9yiE/gJPdYsjMsyQ/kuxONlq1UBJ	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
189	AiNre8yLAlX	OUL4049	2021-01-07 10:15:43.29	2021-01-07 10:15:43.444	58	CSI Saboula	CSI Saboula	87	/TUi1bxbtx5l/pv9ZhCx9yiE/D7pkffdWvl5/AiNre8yLAlX	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
190	CWAl7xRF7k8	OUL4050	2021-01-07 10:16:28.561	2021-01-07 10:16:28.746	58	CSI Tiguey	CSI Tiguey	87	/TUi1bxbtx5l/pv9ZhCx9yiE/D7pkffdWvl5/CWAl7xRF7k8	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
191	Q2X9BCaq6TV	OUL4051	2021-01-07 10:16:59.6	2021-01-07 10:16:59.676	58	CSI Tonkossarey	CSI Tonkossarey	87	/TUi1bxbtx5l/pv9ZhCx9yiE/D7pkffdWvl5/Q2X9BCaq6TV	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
192	eGX3fh4u4Vv	OUL4052	2021-01-07 10:17:57.329	2021-01-07 10:17:57.422	58	CSI Tounouga	CSI Tounouga	88	/TUi1bxbtx5l/pv9ZhCx9yiE/JLWkhshcZGC/eGX3fh4u4Vv	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
193	WErAjDfXUfY	OUL4053	2021-01-07 10:18:31.097	2021-01-07 10:18:31.171	58	CSI Yelou	CSI Yelou	88	/TUi1bxbtx5l/pv9ZhCx9yiE/JLWkhshcZGC/WErAjDfXUfY	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
194	sKIaHUZzcOx	OUL4054	2021-01-07 10:19:15.29	2021-01-07 10:19:15.422	58	HD Gaya	HD Gaya	88	/TUi1bxbtx5l/pv9ZhCx9yiE/JLWkhshcZGC/sKIaHUZzcOx	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
195	Z4w9FFYnqgn	OUL4055	2021-01-07 10:23:19.365	2021-01-07 10:23:19.537	58	CSI Tegueze koara	CSI Tegueze koara	89	/TUi1bxbtx5l/pv9ZhCx9yiE/mSwSuRfsxoc/Z4w9FFYnqgn	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
196	xDlt2WutHF7	OUL4056	2021-01-07 10:24:12.256	2021-01-07 10:24:12.377	58	CSI Toullou Maimassa	CSI Toullou Maimassa	89	/TUi1bxbtx5l/pv9ZhCx9yiE/mSwSuRfsxoc/xDlt2WutHF7	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
197	rbZDiZ3ma7x	OUL4057	2021-01-07 10:24:58.805	2021-01-07 10:24:58.953	58	HD Loga	HD Loga	89	/TUi1bxbtx5l/pv9ZhCx9yiE/mSwSuRfsxoc/rbZDiZ3ma7x	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
198	Td3aOot7vt3	OUL4058	2021-01-07 10:25:39.889	2021-01-07 10:25:39.951	58	CSI Afole	CSI Afole	90	/TUi1bxbtx5l/pv9ZhCx9yiE/QjEDOUcAjE5/Td3aOot7vt3	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
199	Wzfb13M8n0g	OUL4059	2021-01-07 10:27:20.253	2021-01-07 10:27:20.395	58	CSI Birni Falla	CSI Birni Falla	90	/TUi1bxbtx5l/pv9ZhCx9yiE/QjEDOUcAjE5/Wzfb13M8n0g	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
200	U5SG9kxtfjw	OUL4060	2021-01-07 10:27:50.864	2021-01-07 10:27:50.956	58	CSI Doumega	CSI Doumega	90	/TUi1bxbtx5l/pv9ZhCx9yiE/QjEDOUcAjE5/U5SG9kxtfjw	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
201	kwcadJI0F15	OUL4061	2021-01-07 10:31:51.894	2021-01-07 10:31:52.022	58	CSI Naki Karfi	CSI Naki Karfi	91	/TUi1bxbtx5l/bGVTqM64DWV/nSQGlZfPaP2/kwcadJI0F15	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
202	yeRXqiEABa5	OUL4062	2021-01-07 10:32:23.593	2021-01-07 10:32:23.757	58	CSI Tchadoua	CSI TchadouaCSI Tchadoua	91	/TUi1bxbtx5l/bGVTqM64DWV/nSQGlZfPaP2/yeRXqiEABa5	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
212	kSjeQ49G9sT	OUL4072	2021-01-07 10:45:55.822	2021-01-07 10:45:55.917	58	CSI Tibiri 1	CSI Tibiri 1	95	/TUi1bxbtx5l/bGVTqM64DWV/uG0XWazLn3o/kSjeQ49G9sT	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
214	fPoSL0F6yr2	OUL4074	2021-01-07 10:47:02.731	2021-01-07 10:47:02.842	58	CSI Tofa	CSI Tofa	96	/TUi1bxbtx5l/bGVTqM64DWV/zWEyCK2b4B5/fPoSL0F6yr2	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
221	YsBRguit9Yz	OUL4081	2021-01-07 10:54:46.153	2021-01-07 10:54:46.214	58	HD Tessaoua	HD Tessaoua	99	/TUi1bxbtx5l/bGVTqM64DWV/cLsheZnQ8FU/YsBRguit9Yz	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
203	HR0tJpm0CLI	OUL4063	2021-01-07 10:33:00.426	2021-01-07 10:33:00.582	58	HD Aguié	HD Aguié	91	/TUi1bxbtx5l/bGVTqM64DWV/nSQGlZfPaP2/HR0tJpm0CLI	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
210	Oi6TegVXTRF	OUL4070	2021-01-07 10:36:53.247	2021-01-07 10:36:53.419	58	CSI Aikaoua	CSI Aikaoua	94	/TUi1bxbtx5l/bGVTqM64DWV/ysgUlpQjrXc/Oi6TegVXTRF	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
211	l12AmN26uqc	OUL4071	2021-01-07 10:45:05.842	2021-01-07 10:45:05.916	58	CSI Birnin Gueza	CSI Birnin Gueza	94	/TUi1bxbtx5l/bGVTqM64DWV/ysgUlpQjrXc/l12AmN26uqc	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
204	WTTDLQDehCu	OUL4064	2021-01-07 10:33:56.659	2021-01-07 10:33:56.864	58	CSI Akadane	CSI Akadane	92	/TUi1bxbtx5l/bGVTqM64DWV/jYoKTaKwULu/WTTDLQDehCu	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
209	jLkYHNtEZ8L	OUL4069	2021-01-07 10:36:21.258	2021-01-07 10:36:21.361	58	HD Dakoro	HD Dakoro	93	/TUi1bxbtx5l/bGVTqM64DWV/cWQDy7lFrXG/jLkYHNtEZ8L	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
213	TNSTyAxnCCH	OUL4073	2021-01-07 10:46:27.037	2021-01-07 10:46:27.099	58	HD Guidan Roumdji	HD Guidan Roumdji	95	/TUi1bxbtx5l/bGVTqM64DWV/uG0XWazLn3o/TNSTyAxnCCH	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
215	vpVnXrrQOji	OUL4075	2021-01-07 10:47:44.199	2021-01-07 10:47:44.25	58	HD Madarounfa	HD Madarounfa	96	/TUi1bxbtx5l/bGVTqM64DWV/zWEyCK2b4B5/vpVnXrrQOji	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
216	nSzzx3NPb9Q	OUL4076	2021-01-07 10:50:00.494	2021-01-07 10:50:00.568	58	ANBEF	ANBEF	97	/TUi1bxbtx5l/bGVTqM64DWV/TuTplXpeNfz/nSzzx3NPb9Q	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
217	t72IkSKfkrV	OUL4077	2021-01-07 10:50:40.935	2021-01-07 10:50:41.026	58	CSI 17 Portes	CSI 17 Portes	97	/TUi1bxbtx5l/bGVTqM64DWV/TuTplXpeNfz/t72IkSKfkrV	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
220	bqbFopVzCKr	OUL4080	2021-01-07 10:54:01.107	2021-01-07 10:54:01.207	58	CSI Toki	CSI Toki	99	/TUi1bxbtx5l/bGVTqM64DWV/cLsheZnQ8FU/bqbFopVzCKr	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
205	VqfJ0hrY7nl	OUL4065	2021-01-07 10:34:23.223	2021-01-07 10:34:23.426	58	CSI Bermo	CSI Bermo	92	/TUi1bxbtx5l/bGVTqM64DWV/jYoKTaKwULu/VqfJ0hrY7nl	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
219	G7Mjpu437B3	OUL4079	2021-01-07 10:52:20.816	2021-01-07 10:52:20.86	58	HD Mayahi	HD Mayahi	98	/TUi1bxbtx5l/bGVTqM64DWV/ue1BNYdGgUG/G7Mjpu437B3	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
226	jvOHn0tfnEo	OUL4086	2021-01-07 12:04:32.991	2021-01-07 12:04:33.052	58	CSI Abidjan 	CSI Abidjan 	102	/TUi1bxbtx5l/pjidTSwUAS9/UHhGmjyqPBI/jvOHn0tfnEo	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
227	MuhQQupqStL	OUL4087	2021-01-07 12:05:02.432	2021-01-07 12:05:02.559	58	CSI Banifandou	CSI Banifandou	102	/TUi1bxbtx5l/pjidTSwUAS9/UHhGmjyqPBI/MuhQQupqStL	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
206	mpvKV7d5feY	OUL4066	2021-01-07 10:34:52.046	2021-01-07 10:34:52.143	58	CSI Gadabedji	CSI Gadabedji	92	/TUi1bxbtx5l/bGVTqM64DWV/jYoKTaKwULu/mpvKV7d5feY	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
207	wt3ZUCgbmYj	OUL4067	2021-01-07 10:35:28.499	2021-01-07 10:35:28.616	58	CSI Oly	CSI Oly	92	/TUi1bxbtx5l/bGVTqM64DWV/jYoKTaKwULu/wt3ZUCgbmYj	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
208	dSWNIKiU5hC	OUL4068	2021-01-07 10:35:57.333	2021-01-07 10:35:57.569	58	CSI Adjia	CSI Adjia	93	/TUi1bxbtx5l/bGVTqM64DWV/cWQDy7lFrXG/dSWNIKiU5hC	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
218	hV0vMN5LDHw	OUL4078	2021-01-07 10:51:23.339	2021-01-07 10:51:23.424	58	CSI Zongon Oumara	CSI Zongon Oumara	98	/TUi1bxbtx5l/bGVTqM64DWV/ue1BNYdGgUG/hV0vMN5LDHw	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
222	TYIxJxIXSMa	OUL4082	2021-01-07 11:58:09.866	2021-01-07 11:58:09.981	58	CSI Bobiel	CSI Bobiel	100	/TUi1bxbtx5l/pjidTSwUAS9/KfdKM4TfeQy/TYIxJxIXSMa	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
223	gdgWFvZLJHe	OUL4083	2021-01-07 11:58:38.802	2021-01-07 11:58:38.925	58	CSI Garde Nationale	CSI Garde Nationale	100	/TUi1bxbtx5l/pjidTSwUAS9/KfdKM4TfeQy/gdgWFvZLJHe	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
224	o7Fixh9tvy6	OUL4084	2021-01-07 12:02:35.619	2021-01-07 12:02:35.742	58	CSI ANBEF	CSI ANBEF	101	/TUi1bxbtx5l/pjidTSwUAS9/OPeukCFdqNJ/o7Fixh9tvy6	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
225	sKeIWFaXYEM	OUL4085	2021-01-07 12:03:47.124	2021-01-07 12:03:47.222	58	CSI Boukoki	CSI Boukoki	101	/TUi1bxbtx5l/pjidTSwUAS9/OPeukCFdqNJ/sKeIWFaXYEM	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
228	xs8uy0nx2Kf	OUL4088	2021-01-07 12:05:30.846	2021-01-07 12:05:30.984	58	CSI Aéroport 1	CSI Aéroport 1	103	/TUi1bxbtx5l/pjidTSwUAS9/vd5CYL3BeK1/xs8uy0nx2Kf	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
229	Qq4iAqIWn7Q	OUL4089	2021-01-07 12:05:55.251	2021-01-07 12:05:55.398	58	CSI Aéroport 2	CSI Aéroport 2	103	/TUi1bxbtx5l/pjidTSwUAS9/vd5CYL3BeK1/Qq4iAqIWn7Q	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
230	pKoHq7FTbKO	OUL4090	2021-01-07 12:07:32.112	2021-01-07 12:07:32.23	58	CSI  CCEJ ANBEF	CSI  CCEJ ANBEF	104	/TUi1bxbtx5l/pjidTSwUAS9/W5a1LCXaqn8/pKoHq7FTbKO	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
231	YuaQHZqAAhN	OUL4091	2021-01-07 12:07:57.902	2021-01-07 12:07:57.955	58	CSI Bangabana	CSI Bangabana	104	/TUi1bxbtx5l/pjidTSwUAS9/W5a1LCXaqn8/YuaQHZqAAhN	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
232	NV5K6TLN7Jv	OUL4092	2021-01-07 12:09:18.372	2021-01-07 12:09:18.464	58	CSI Tourouf	CSI Tourouf	105	/TUi1bxbtx5l/J3hJbWACPkY/qAIrt3e78MT/NV5K6TLN7Jv	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
233	T1RvqqT1Nw9	OUL4093	2021-01-07 12:09:51.3	2021-01-07 12:09:51.399	58	HD Abalak	HD Abalak	105	/TUi1bxbtx5l/J3hJbWACPkY/qAIrt3e78MT/T1RvqqT1Nw9	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
234	f2Rzz5xGWVx	OUL4094	2021-01-07 12:10:23.861	2021-01-07 12:10:23.972	58	CSI Bagaroua	CSI Bagaroua	106	/TUi1bxbtx5l/J3hJbWACPkY/Sa4BBO0yMRz/f2Rzz5xGWVx	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
235	kDZxFMoXA4n	OUL4095	2021-01-07 12:11:00.308	2021-01-07 12:11:00.435	58	CSI Samia	CSI Samia	106	/TUi1bxbtx5l/J3hJbWACPkY/Sa4BBO0yMRz/kDZxFMoXA4n	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
236	PIJ071sOxS1	OUL4096	2021-01-07 12:11:45.653	2021-01-07 12:11:45.713	58	CSI Allela	CSI Allela	107	/TUi1bxbtx5l/J3hJbWACPkY/rM6ugmTXpKq/PIJ071sOxS1	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
237	EbEJMEPosiu	OUL4097	2021-01-07 12:12:07.81	2021-01-07 12:12:07.901	58	CSI Bazaga	CSI Bazaga	107	/TUi1bxbtx5l/J3hJbWACPkY/rM6ugmTXpKq/EbEJMEPosiu	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
238	n1t8lRziTUV	OUL4098	2021-01-07 12:12:31.557	2021-01-07 12:12:31.637	58	HD Birni N'Konni	HD Birni N'Konni	107	/TUi1bxbtx5l/J3hJbWACPkY/rM6ugmTXpKq/n1t8lRziTUV	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
239	D2Ej4ZhSC2S	OUL4099	2021-01-07 12:13:01.993	2021-01-07 12:13:02.089	58	CSI Yagalalane	CSI Yagalalane	108	/TUi1bxbtx5l/J3hJbWACPkY/qkjdPqXRZOJ/D2Ej4ZhSC2S	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
240	t385Yg5pveg	OUL4100	2021-01-07 12:13:44.234	2021-01-07 12:13:44.318	58	HD Bouza	HD Bouza	108	/TUi1bxbtx5l/J3hJbWACPkY/qkjdPqXRZOJ/t385Yg5pveg	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
241	wkONT6mjpov	OUL4101	2021-01-07 12:14:11.422	2021-01-07 12:14:11.538	58	CSI Zouraré Chafa	CSI Zouraré Chafa	109	/TUi1bxbtx5l/J3hJbWACPkY/hlPaFF9KXLC/wkONT6mjpov	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
242	PBmPf0NMYjm	OUL4102	2021-01-07 12:14:32.454	2021-01-07 12:14:32.58	58	HD Illéla	HD Illéla	109	/TUi1bxbtx5l/J3hJbWACPkY/hlPaFF9KXLC/PBmPf0NMYjm	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
243	o2PInWDfmfk	OUL4103	2021-01-07 12:14:56.482	2021-01-07 12:14:56.549	58	CSI Doudoubeye	CSI Doudoubeye	110	/TUi1bxbtx5l/J3hJbWACPkY/PBDrTNMqrv7/o2PInWDfmfk	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
244	HKkl4k3bLTL	OUK4104	2021-01-07 12:29:54.436	2021-01-07 12:29:54.511	58	CSI Fararatt	CSI Fararatt	110	/TUi1bxbtx5l/J3hJbWACPkY/PBDrTNMqrv7/HKkl4k3bLTL	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
245	HfyKBQBIJgT	OUL4105	2021-01-07 12:30:31.758	2021-01-07 12:30:31.825	58	CSI Takorka	CSI Takorka	111	/TUi1bxbtx5l/J3hJbWACPkY/xjMoc2oDQ9n/HfyKBQBIJgT	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
246	xhcb7C5eIM0	OUL4106	2021-01-07 12:31:05.701	2021-01-07 12:31:05.797	58	HD Madaoua	HD Madaoua	111	/TUi1bxbtx5l/J3hJbWACPkY/xjMoc2oDQ9n/xhcb7C5eIM0	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
247	vPKCdWW0xTh	OUL4107	2021-01-07 12:32:08.619	2021-01-07 12:32:08.742	58	CSI Adouna	CSI Adouna	112	/TUi1bxbtx5l/J3hJbWACPkY/QIT4c4Piqze/vPKCdWW0xTh	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
248	gw8cD2LzJeA	OUL4108	2021-01-07 12:32:52.458	2021-01-07 12:32:52.522	58	CSI Affala	CSI Affala	112	/TUi1bxbtx5l/J3hJbWACPkY/QIT4c4Piqze/gw8cD2LzJeA	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
249	qR9uKmMiJhc	OUL4109	2021-01-07 12:33:20.605	2021-01-07 12:33:20.699	58	CSI Wadata	CSI Wadata	113	/TUi1bxbtx5l/J3hJbWACPkY/tuKeGt6H1hz/qR9uKmMiJhc	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
250	aMVNKfKV6bE	OUL4110	2021-01-07 12:33:49.966	2021-01-07 12:33:50.067	58	HD Tahoua	HD Tahoua	113	/TUi1bxbtx5l/J3hJbWACPkY/tuKeGt6H1hz/aMVNKfKV6bE	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
251	DqM0cquOI7X	OUL4111	2021-01-07 12:34:17.999	2021-01-07 12:34:18.084	58	CSI Algazarmakane	CSI Algazarmakane	114	/TUi1bxbtx5l/J3hJbWACPkY/udsycngcKK8/DqM0cquOI7X	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
252	RpgrK7J1k4c	OUL4112	2021-01-07 12:34:39.719	2021-01-07 12:34:39.858	58	CSI Azanag	CSI Azanag	114	/TUi1bxbtx5l/J3hJbWACPkY/udsycngcKK8/RpgrK7J1k4c	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
253	z9jO65Tqh9l	OUL4113	2021-01-07 12:35:02.663	2021-01-07 12:35:02.737	58	CSI Tchintabaraden	CSI Tchintabaraden	115	/TUi1bxbtx5l/J3hJbWACPkY/jxvqGRa7Aw0/z9jO65Tqh9l	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
254	sD0AhNg1yzB	OUL4114	2021-01-07 12:35:28.034	2021-01-07 12:35:28.097	58	HD Tchintabaraden	HD Tchintabaraden	115	/TUi1bxbtx5l/J3hJbWACPkY/jxvqGRa7Aw0/sD0AhNg1yzB	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
255	PIHb1DVPbBJ	OUL4115	2021-01-07 12:35:56.154	2021-01-07 12:35:56.212	58	CSI FAN Tillia	CSI FAN Tillia	116	/TUi1bxbtx5l/J3hJbWACPkY/FdXfx73yKfH/PIHb1DVPbBJ	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
256	EV887XhDJxk	OUL4116	2021-01-07 12:36:22.551	2021-01-07 12:36:22.654	58	CSI Gaweye	CSI Gaweye	116	/TUi1bxbtx5l/J3hJbWACPkY/FdXfx73yKfH/EV887XhDJxk	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
257	qlUSTnzoXIR	OUL4117	2021-01-07 12:36:47.725	2021-01-07 12:36:47.804	58	CSI Telemces	CSI Telemces	116	/TUi1bxbtx5l/J3hJbWACPkY/FdXfx73yKfH/qlUSTnzoXIR	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
258	alMYGv3uwMM	OUL4118	2021-01-07 12:37:11.912	2021-01-07 12:37:12.007	58	CSI Tillia	CSI Tillia	116	/TUi1bxbtx5l/J3hJbWACPkY/FdXfx73yKfH/alMYGv3uwMM	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
259	dBoZpABdgke	OUL4119	2021-01-07 12:45:48.139	2021-01-07 12:45:48.191	58	CSI Tchingnalga	CSI Tchingnalga	117	/TUi1bxbtx5l/rAqvNC069uE/tQhXjUk0DT9/dBoZpABdgke	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
262	zO6c8vEy8h9	OUL4122	2021-01-07 12:47:31.556	2021-01-07 12:47:31.625	58	CSI Firgoune	CSI Firgoune	118	/TUi1bxbtx5l/rAqvNC069uE/pHqxuKruV0q/zO6c8vEy8h9	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
288	TkAwyJlDrVL	OUL4148	2021-01-07 13:06:14.473	2021-01-07 13:06:14.519	58	CSI Intabanout	CSI Intabanout	130	/TUi1bxbtx5l/rKJlspnwwfZ/FGTNzWpqPlA/TkAwyJlDrVL	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
291	CrPL0JWGkYa	OUL4151	2021-01-07 13:08:43.191	2021-01-07 13:08:43.235	58	CSI Mallaoua	CSI Mallaoua	132	/TUi1bxbtx5l/rKJlspnwwfZ/YDKRB7fFCaR/CrPL0JWGkYa	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
260	Ky1DNgqODzW	OUL4120	2021-01-07 12:46:11.459	2021-01-07 12:46:11.503	58	CSI Wella	CSI Wella	117	/TUi1bxbtx5l/rAqvNC069uE/tQhXjUk0DT9/Ky1DNgqODzW	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
264	yadqTACPKES	OUL4124	2021-01-07 12:49:02.805	2021-01-07 12:49:02.845	58	CSI Taya Djerma	CSI Taya Djerma	119	/TUi1bxbtx5l/rAqvNC069uE/HK24IQZ7NOy/yadqTACPKES	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
265	C135cHoU8sN	OUL4125	2021-01-07 12:49:30.678	2021-01-07 12:49:30.728	58	CSI Tiloa	CSI Tiloa	120	/TUi1bxbtx5l/rAqvNC069uE/Wy0OMJufp3m/C135cHoU8sN	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
266	N7ooZ4WEbl1	OUL4126	2021-01-07 12:50:07.102	2021-01-07 12:50:07.221	58	CSI Tizegorou	CSI Tizegorou	120	/TUi1bxbtx5l/rAqvNC069uE/Wy0OMJufp3m/N7ooZ4WEbl1	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
286	hBuGX41rmiq	OUL4146	2021-01-07 13:04:00.629	2021-01-07 13:04:00.675	58	CSI Torodi	CSI Torodi	129	/TUi1bxbtx5l/rAqvNC069uE/kqN20FEomCf/hBuGX41rmiq	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
292	JaiwptIILn5	OUL4152	2021-01-07 13:09:13.406	2021-01-07 13:09:13.485	58	CSI Takaye	CSI Takaye	132	/TUi1bxbtx5l/rKJlspnwwfZ/YDKRB7fFCaR/JaiwptIILn5	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
261	PL09HmfZchh	OUL4121	2021-01-07 12:47:06.102	2021-01-07 12:47:06.149	58	CSI Ayerou	CSI Ayerou	118	/TUi1bxbtx5l/rAqvNC069uE/pHqxuKruV0q/PL09HmfZchh	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
270	aL2opmcmZBv	OUL4130	2021-01-07 12:52:27.637	2021-01-07 12:52:27.724	58	CSI Bakin Toulou	CSI Bakin Toulou	122	/TUi1bxbtx5l/rAqvNC069uE/Rl0hSaq9x7v/aL2opmcmZBv	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
274	hLGXSxm940X	OUL4134	2021-01-07 12:54:13.621	2021-01-07 12:54:13.66	58	HD Gothèye	HD Gothèye	123	/TUi1bxbtx5l/rAqvNC069uE/TYIYr1iRgXo/hLGXSxm940X	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
278	m566xh7wGyS	OUL4138	2021-01-07 12:56:43.338	2021-01-07 12:56:43.391	58	CSI Tondikwindi	CSI Tondikwindi	125	/TUi1bxbtx5l/rAqvNC069uE/H9J0KpdUmvk/m566xh7wGyS	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
279	RdDgvAIWFrt	OUL4139	2021-01-07 12:59:12.392	2021-01-07 12:59:12.438	58	CSI Tchintchargou	CSI Tchintchargou	126	/TUi1bxbtx5l/rAqvNC069uE/n7rLjBQ3lDI/RdDgvAIWFrt	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
282	nNWG0J3REeS	OUL4142	2021-01-07 13:02:04.409	2021-01-07 13:02:04.451	58	HD Téra	HD Téra	127	/TUi1bxbtx5l/rAqvNC069uE/E3xbGHKUopY/nNWG0J3REeS	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
263	h61lBKhJHDQ	OUL4123	2021-01-07 12:48:16.561	2021-01-07 12:48:16.634	58	CSI Tabla	CSI Tabla	119	/TUi1bxbtx5l/rAqvNC069uE/HK24IQZ7NOy/h61lBKhJHDQ	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
272	dc8B8RGJFUS	OUL4132	2021-01-07 12:53:21.995	2021-01-07 12:53:22.043	58	CSI Djoubourga	CSI Djoubourga	123	/TUi1bxbtx5l/rAqvNC069uE/TYIYr1iRgXo/dc8B8RGJFUS	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
284	Gj6ROLZrEXn	OUL4144	2021-01-07 13:03:01.796	2021-01-07 13:03:01.872	58	HD Tillabéri	HD Tillabéri	128	/TUi1bxbtx5l/rAqvNC069uE/iNPSht7mcSz/Gj6ROLZrEXn	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
290	R794hqHK50G	OUL4150	2021-01-07 13:08:11.646	2021-01-07 13:08:11.7	58	CSI Riga Peulh	CSI Riga Peulh	131	/TUi1bxbtx5l/rKJlspnwwfZ/xHchXNvHHtD/R794hqHK50G	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
293	KFfP3UGb2J0	OUL4153	2021-01-07 13:09:44.767	2021-01-07 13:09:44.843	58	CSI Zagari	CSI Zagari	133	/TUi1bxbtx5l/rKJlspnwwfZ/PWd0OyHYUmC/KFfP3UGb2J0	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
267	QQMu4NMtiiS	OUL4127	2021-01-07 12:51:13.642	2021-01-07 12:51:13.791	58	CSI Amarsingué	CSI Amarsingué	121	/TUi1bxbtx5l/rAqvNC069uE/Lbri8XT4RW6/QQMu4NMtiiS	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
268	xj6EziOCeMI	OUL4128	2021-01-07 12:51:35.905	2021-01-07 12:51:36.048	58	CSI Bankilaré	CSI Bankilaré	121	/TUi1bxbtx5l/rAqvNC069uE/Lbri8XT4RW6/xj6EziOCeMI	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
277	lDx8DCOfd30	OUL4137	2021-01-07 12:56:00.546	2021-01-07 12:56:00.595	58	CSI Tondikoirey	CSI Tondikoirey	125	/TUi1bxbtx5l/rAqvNC069uE/H9J0KpdUmvk/lDx8DCOfd30	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
283	bW03lM8Cmje	OUL4143	2021-01-07 13:02:32.16	2021-01-07 13:02:32.233	58	CSI Zibane	CSI Zibane	128	/TUi1bxbtx5l/rAqvNC069uE/iNPSht7mcSz/bW03lM8Cmje	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
269	LeTT8OXv8pK	OUL4129	2021-01-07 12:52:00.925	2021-01-07 12:52:01.058	58	CSI Attaloga	CSI Attaloga	122	/TUi1bxbtx5l/rAqvNC069uE/Rl0hSaq9x7v/LeTT8OXv8pK	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
289	Aq4lonsUVUe	OUL4149	2021-01-07 13:07:32.2	2021-01-07 13:07:32.279	58	CSI Rahin Zomo	CSI Rahin Zomo	131	/TUi1bxbtx5l/rKJlspnwwfZ/xHchXNvHHtD/Aq4lonsUVUe	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
294	mbfD3cazBjJ	OUL4154	2021-01-07 13:10:16.934	2021-01-07 13:10:16.996	58	HD Goure	HD Goure	133	/TUi1bxbtx5l/rKJlspnwwfZ/PWd0OyHYUmC/mbfD3cazBjJ	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
271	ujnAJzgSXNX	OUL4131	2021-01-07 12:52:49.774	2021-01-07 12:52:49.816	58	HD Filingué	HD Filingué	122	/TUi1bxbtx5l/rAqvNC069uE/Rl0hSaq9x7v/ujnAJzgSXNX	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
273	Aq2KXcP07Hy	OUL4133	2021-01-07 12:53:43.865	2021-01-07 12:53:43.927	58	CSI Gariel 	CSI Gariel 	123	/TUi1bxbtx5l/rAqvNC069uE/TYIYr1iRgXo/Aq2KXcP07Hy	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
275	Er0MwlsVsi3	OUL4135	2021-01-07 12:54:37.853	2021-01-07 12:54:37.897	58	CSI Toulouaré	CSI Toulouaré	124	/TUi1bxbtx5l/rAqvNC069uE/k5fSYvpMB6U/Er0MwlsVsi3	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
276	kal0vO47hlM	OUL4136	2021-01-07 12:55:31.652	2021-01-07 12:55:31.693	58	CSI Youri	CSI Youri	124	/TUi1bxbtx5l/rAqvNC069uE/k5fSYvpMB6U/kal0vO47hlM	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
280	F6sT128Gd9w	OUL4140	2021-01-07 12:59:48.311	2021-01-07 12:59:48.358	58	HD Say	HD Say	126	/TUi1bxbtx5l/rAqvNC069uE/n7rLjBQ3lDI/F6sT128Gd9w	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
281	HoWRx5jnNFT	OUL4141	2021-01-07 13:00:14.79	2021-01-07 13:00:14.861	58	CSI Zaney	CSI Zaney	127	/TUi1bxbtx5l/rAqvNC069uE/E3xbGHKUopY/HoWRx5jnNFT	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
285	gCYERVl8wJd	OUL4145	2021-01-07 13:03:31.241	2021-01-07 13:03:31.287	58	CSI Tombolé	CSI Tombolé	129	/TUi1bxbtx5l/rAqvNC069uE/kqN20FEomCf/gCYERVl8wJd	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
287	KW3zwWjBnsl	OUL4147	2021-01-07 13:05:50.391	2021-01-07 13:05:50.446	58	CSI Guidan Ango	CSI Guidan Ango	130	/TUi1bxbtx5l/rKJlspnwwfZ/FGTNzWpqPlA/KW3zwWjBnsl	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
295	Wc7Ytt9Ml0y	OUL4155	2021-01-07 13:14:22.233	2021-01-07 13:14:22.286	58	CSI Yékoua	CSI Yékoua	134	/TUi1bxbtx5l/rKJlspnwwfZ/yt5ToQxUg7u/Wc7Ytt9Ml0y	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
296	voNAwZ4mWyb	OUL4156	2021-01-07 13:15:13.816	2021-01-07 13:15:13.863	58	HD Magaria	HD Magaria	134	/TUi1bxbtx5l/rKJlspnwwfZ/yt5ToQxUg7u/voNAwZ4mWyb	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
297	IxibkhvgoXG	OUL4157	2021-01-07 13:15:46.148	2021-01-07 13:15:46.214	58	CSI Yaouri	CSI Yaouri	135	/TUi1bxbtx5l/rKJlspnwwfZ/yiHhcbYT6OU/IxibkhvgoXG	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
298	kgvnQOjUpUy	OUL4158	2021-01-07 13:16:55.513	2021-01-07 13:16:55.561	58	HD Matameye	HD Matameye	135	/TUi1bxbtx5l/rKJlspnwwfZ/yiHhcbYT6OU/kgvnQOjUpUy	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
299	OkavypmO6KP	OUL4159	2021-01-07 13:17:30.597	2021-01-07 13:17:30.64	58	CSI Zermou	CSI Zermou	136	/TUi1bxbtx5l/rKJlspnwwfZ/dvqJM19Di9B/OkavypmO6KP	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
300	MXH49zlz7ar	OUL4160	2021-01-07 13:18:03.252	2021-01-07 13:18:03.292	58	HD Mirriah	HD Mirriah	136	/TUi1bxbtx5l/rKJlspnwwfZ/dvqJM19Di9B/MXH49zlz7ar	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
301	qUqwtK2Pg0q	OUL4161	2021-01-07 13:19:08.078	2021-01-07 13:19:09.266	58	CSI Toumnia	CSI Toumnia	137	/TUi1bxbtx5l/rKJlspnwwfZ/aJkRlvLjxEp/qUqwtK2Pg0q	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
302	VQTS6Q7dFsB	OUL4162	2021-01-07 13:19:48.585	2021-01-07 13:19:48.628	58	CSI Zondon Dachi	CSI Zondon Dachi	137	/TUi1bxbtx5l/rKJlspnwwfZ/aJkRlvLjxEp/VQTS6Q7dFsB	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
303	Vnh34hG0hCc	OUL4163	2021-01-07 13:20:25.871	2021-01-07 13:20:25.92	58	CSI Zidiaram	CSI Zidiaram	138	/TUi1bxbtx5l/rKJlspnwwfZ/YSAC7kgLjst/Vnh34hG0hCc	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
304	OjVzMcJrcVo	OUL4164	2021-01-07 13:21:02.183	2021-01-07 13:21:02.239	58	HD Tanout	HD Tanout	138	/TUi1bxbtx5l/rKJlspnwwfZ/YSAC7kgLjst/OjVzMcJrcVo	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
305	AAsXyBy0AdA	OUL4165	2021-01-07 13:22:38.149	2021-01-07 13:22:38.196	58	CSI Tesker	CSI Tesker	139	/TUi1bxbtx5l/rKJlspnwwfZ/PeMrAlbBUx9/AAsXyBy0AdA	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
306	RZ0GxArzlKe	OUL4166	2021-01-07 13:23:08.492	2021-01-07 13:23:08.552	58	CSI Yougoum	CSI Yougoum	139	/TUi1bxbtx5l/rKJlspnwwfZ/PeMrAlbBUx9/RZ0GxArzlKe	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
307	cpf7SVon7Dw	OUL4167	2021-01-07 13:24:05.689	2021-01-07 13:24:05.738	58	CSI Zengou	CSI Zengou	140	/TUi1bxbtx5l/rKJlspnwwfZ/cY5ovxlqZ1q/cpf7SVon7Dw	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
308	gLIf49jLZRo	OUL4168	2021-01-07 13:24:46.849	2021-01-07 13:24:46.896	58	HD Zinder	HD Zinder	140	/TUi1bxbtx5l/rKJlspnwwfZ/cY5ovxlqZ1q/gLIf49jLZRo	4	\N	1990-01-01	\N	\N	\N	\N	\N	\N	\N	58	[]	\N
\.


--
-- Data for Name: organisationunitattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.organisationunitattributevalues (organisationunitid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: orgunitgroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroup (orgunitgroupid, uid, code, created, lastupdated, lastupdatedby, name, shortname, symbol, color, userid, publicaccess, translations, geometry) FROM stdin;
\.


--
-- Data for Name: orgunitgroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupattributevalues (orgunitgroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupmembers (organisationunitid, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupset; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupset (orgunitgroupsetid, uid, code, created, lastupdated, lastupdatedby, name, description, compulsory, includesubhierarchyinanalytics, datadimension, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: orgunitgroupsetattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupsetattributevalues (orgunitgroupsetid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupsetdimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupsetdimension (orgunitgroupsetdimensionid, orgunitgroupsetid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupsetdimension_items; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupsetdimension_items (orgunitgroupsetdimensionid, sort_order, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupsetmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupsetmembers (orgunitgroupsetid, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupsetuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupsetuseraccesses (orgunitgroupsetid, useraccessid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupsetusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupsetusergroupaccesses (orgunitgroupsetid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupuseraccesses (orgunitgroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: orgunitgroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitgroupusergroupaccesses (orgunitgroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: orgunitlevel; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.orgunitlevel (orgunitlevelid, uid, code, created, lastupdated, lastupdatedby, name, level, offlinelevels, translations) FROM stdin;
\.


--
-- Data for Name: outbound_sms; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.outbound_sms (id, date, message, status, sender) FROM stdin;
\.


--
-- Data for Name: outbound_sms_recipients; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.outbound_sms_recipients (outbound_sms_id, elt) FROM stdin;
\.


--
-- Data for Name: period; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.period (periodid, periodtypeid, startdate, enddate) FROM stdin;
\.


--
-- Data for Name: periodboundary; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.periodboundary (periodboundaryid, uid, code, created, lastupdated, lastupdatedby, boundarytarget, analyticsperiodboundarytype, offsetperiods, offsetperiodtypeid, programindicatorid) FROM stdin;
\.


--
-- Data for Name: periodtype; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.periodtype (periodtypeid, name) FROM stdin;
1	Daily
2	Weekly
3	WeeklyWednesday
4	WeeklyThursday
5	WeeklySaturday
6	WeeklySunday
7	BiWeekly
8	Monthly
9	BiMonthly
10	Quarterly
11	SixMonthly
12	SixMonthlyApril
13	SixMonthlyNov
14	Yearly
15	FinancialApril
16	FinancialJuly
17	FinancialOct
18	FinancialNov
\.


--
-- Data for Name: potentialduplicate; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.potentialduplicate (potentialduplicateid, uid, created, lastupdated, lastupdatedby, teia, teib, status) FROM stdin;
\.


--
-- Data for Name: predictor; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.predictor (predictorid, uid, code, created, lastupdated, lastupdatedby, name, description, generatorexpressionid, generatoroutput, generatoroutputcombo, skiptestexpressionid, periodtypeid, sequentialsamplecount, annualsamplecount, sequentialskipcount) FROM stdin;
\.


--
-- Data for Name: predictorgroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.predictorgroup (predictorgroupid, uid, code, created, lastupdated, lastupdatedby, name, description, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: predictorgroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.predictorgroupmembers (predictorid, predictorgroupid) FROM stdin;
\.


--
-- Data for Name: predictorgroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.predictorgroupuseraccesses (predictorgroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: predictorgroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.predictorgroupusergroupaccesses (predictorgroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: predictororgunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.predictororgunitlevels (predictorid, orgunitlevelid) FROM stdin;
\.


--
-- Data for Name: previouspasswords; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.previouspasswords (userid, list_index, previouspassword) FROM stdin;
58	0	$2a$10$Lb7TOXjRMnKapmfERwRN1ujtd7U33XDLS3O5wpszcDU46ANSKPxPW
\.


--
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.program (programid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, formname, version, enrollmentdatelabel, incidentdatelabel, type, displayincidentdate, onlyenrollonce, skipoffline, displayfrontpagelist, usefirststageduringregistration, capturecoordinates, expirydays, completeeventsexpirydays, minattributesrequiredtosearch, maxteicounttoreturn, style, accesslevel, expiryperiodtypeid, ignoreoverdueevents, selectenrollmentdatesinfuture, selectincidentdatesinfuture, relatedprogramid, categorycomboid, trackedentitytypeid, dataentryformid, userid, publicaccess, featuretype, translations) FROM stdin;
\.


--
-- Data for Name: program_attribute_group; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.program_attribute_group (programtrackedentityattributegroupid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, uniqunessype, translations) FROM stdin;
\.


--
-- Data for Name: program_attributes; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.program_attributes (programtrackedentityattributeid, uid, code, created, lastupdated, lastupdatedby, programid, trackedentityattributeid, displayinlist, mandatory, sort_order, allowfuturedate, renderoptionsasradio, rendertype, searchable) FROM stdin;
\.


--
-- Data for Name: program_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.program_organisationunits (organisationunitid, programid) FROM stdin;
\.


--
-- Data for Name: program_userroles; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.program_userroles (programid, userroleid) FROM stdin;
\.


--
-- Data for Name: programattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programattributevalues (programid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: programexpression; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programexpression (programexpressionid, description, expression) FROM stdin;
\.


--
-- Data for Name: programindicator; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicator (programindicatorid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, formname, style, programid, expression, filter, aggregationtype, decimals, aggregateexportcategoryoptioncombo, aggregateexportattributeoptioncombo, displayinform, analyticstype, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: programindicatorattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorattributevalues (programindicatorid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: programindicatorgroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorgroup (programindicatorgroupid, uid, code, created, lastupdated, lastupdatedby, name, description, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: programindicatorgroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorgroupattributevalues (programindicatorgroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: programindicatorgroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorgroupmembers (programindicatorid, programindicatorgroupid) FROM stdin;
\.


--
-- Data for Name: programindicatorgroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorgroupuseraccesses (programindicatorgroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: programindicatorgroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorgroupusergroupaccesses (programindicatorgroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: programindicatorlegendsets; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorlegendsets (programindicatorid, sort_order, legendsetid) FROM stdin;
\.


--
-- Data for Name: programindicatoruseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatoruseraccesses (programindicatorid, useraccessid) FROM stdin;
\.


--
-- Data for Name: programindicatorusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programindicatorusergroupaccesses (programindicatorid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: programinstance; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programinstance (programinstanceid, uid, created, lastupdated, createdatclient, lastupdatedatclient, incidentdate, enrollmentdate, enddate, followup, completedby, deleted, storedby, status, trackedentityinstanceid, programid, organisationunitid, geometry) FROM stdin;
\.


--
-- Data for Name: programinstance_messageconversation; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programinstance_messageconversation (programinstanceid, sort_order, messageconversationid) FROM stdin;
\.


--
-- Data for Name: programinstanceaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programinstanceaudit (programinstanceauditid, programinstanceid, created, accessedby, audittype, comment) FROM stdin;
\.


--
-- Data for Name: programinstancecomments; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programinstancecomments (programinstanceid, sort_order, trackedentitycommentid) FROM stdin;
\.


--
-- Data for Name: programmessage; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programmessage (id, uid, code, created, lastupdated, lastupdatedby, text, subject, processeddate, messagestatus, trackedentityinstanceid, organisationunitid, programinstanceid, programstageinstanceid, translations) FROM stdin;
\.


--
-- Data for Name: programmessage_deliverychannels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programmessage_deliverychannels (programmessagedeliverychannelsid, deliverychannel) FROM stdin;
\.


--
-- Data for Name: programmessage_emailaddresses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programmessage_emailaddresses (programmessageemailaddressid, email) FROM stdin;
\.


--
-- Data for Name: programmessage_phonenumbers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programmessage_phonenumbers (programmessagephonenumberid, phonenumber) FROM stdin;
\.


--
-- Data for Name: programnotificationinstance; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programnotificationinstance (programnotificationinstanceid, uid, code, created, lastupdated, lastupdatedby, name, programinstanceid, programstageinstanceid, programnotificationtemplateid, scheduledat, sentat) FROM stdin;
\.


--
-- Data for Name: programnotificationtemplate; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programnotificationtemplate (programnotificationtemplateid, uid, code, created, lastupdated, lastupdatedby, name, relativescheduleddays, usergroupid, trackedentityattributeid, dataelementid, subjecttemplate, messagetemplate, notifyparentorganisationunitonly, notifyusersinhierarchyonly, notificationtrigger, notificationrecipienttype, programstageid, programid) FROM stdin;
\.


--
-- Data for Name: programnotificationtemplate_deliverychannel; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programnotificationtemplate_deliverychannel (programnotificationtemplatedeliverychannelid, deliverychannel) FROM stdin;
\.


--
-- Data for Name: programownershiphistory; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programownershiphistory (programownershiphistoryid, programid, trackedentityinstanceid, startdate, enddate, createdby) FROM stdin;
\.


--
-- Data for Name: programrule; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programrule (programruleid, uid, code, created, lastupdated, lastupdatedby, name, description, programid, programstageid, rulecondition, priority, translations) FROM stdin;
\.


--
-- Data for Name: programruleaction; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programruleaction (programruleactionid, uid, code, created, lastupdated, lastupdatedby, programruleid, actiontype, dataelementid, trackedentityattributeid, programindicatorid, programstagesectionid, programstageid, optionid, optiongroupid, location, content, data, templateuid) FROM stdin;
\.


--
-- Data for Name: programrulevariable; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programrulevariable (programrulevariableid, uid, code, created, lastupdated, lastupdatedby, name, programid, sourcetype, trackedentityattributeid, dataelementid, usecodeforoptionset, programstageid) FROM stdin;
\.


--
-- Data for Name: programsection; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programsection (programsectionid, uid, code, created, lastupdated, lastupdatedby, name, description, formname, style, rendertype, programid, sortorder, translations) FROM stdin;
\.


--
-- Data for Name: programsection_attributes; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programsection_attributes (programsectionid, sort_order, trackedentityattributeid) FROM stdin;
\.


--
-- Data for Name: programstage; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstage (programstageid, uid, code, created, lastupdated, lastupdatedby, name, description, formname, mindaysfromstart, programid, repeatable, dataentryformid, standardinterval, executiondatelabel, duedatelabel, autogenerateevent, displaygenerateeventbox, generatedbyenrollmentdate, blockentryform, remindcompleted, allowgeneratenextvisit, openafterenrollment, reportdatetouse, pregenerateuid, style, hideduedate, sort_order, featuretype, periodtypeid, userid, publicaccess, validationstrategy, translations, enableuserassignment) FROM stdin;
\.


--
-- Data for Name: programstageattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageattributevalues (programstageid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: programstagedataelement; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstagedataelement (programstagedataelementid, uid, code, created, lastupdated, lastupdatedby, programstageid, dataelementid, compulsory, allowprovidedelsewhere, sort_order, displayinreports, allowfuturedate, renderoptionsasradio, rendertype, skipsynchronization) FROM stdin;
\.


--
-- Data for Name: programstageinstance; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageinstance (programstageinstanceid, uid, code, created, lastupdated, createdatclient, lastupdatedatclient, lastsynchronized, programinstanceid, programstageid, attributeoptioncomboid, deleted, storedby, duedate, executiondate, organisationunitid, status, completedby, completeddate, geometry, eventdatavalues, assigneduserid) FROM stdin;
\.


--
-- Data for Name: programstageinstance_messageconversation; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageinstance_messageconversation (programstageinstanceid, sort_order, messageconversationid) FROM stdin;
\.


--
-- Data for Name: programstageinstancecomments; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageinstancecomments (programstageinstanceid, sort_order, trackedentitycommentid) FROM stdin;
\.


--
-- Data for Name: programstageinstancefilter; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageinstancefilter (programstageinstancefilterid, uid, created, lastupdated, lastupdatedby, name, description, program, programstage, eventquerycriteria, userid, publicaccess) FROM stdin;
\.


--
-- Data for Name: programstageinstancefilteruseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageinstancefilteruseraccesses (programstageinstancefilterid, useraccessid) FROM stdin;
\.


--
-- Data for Name: programstageinstancefilterusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageinstancefilterusergroupaccesses (programstageinstancefilterid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: programstagesection; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstagesection (programstagesectionid, uid, code, created, lastupdated, lastupdatedby, name, description, formname, style, rendertype, programstageid, sortorder, translations) FROM stdin;
\.


--
-- Data for Name: programstagesection_dataelements; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstagesection_dataelements (programstagesectionid, sort_order, dataelementid) FROM stdin;
\.


--
-- Data for Name: programstagesection_programindicators; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstagesection_programindicators (programstagesectionid, sort_order, programindicatorid) FROM stdin;
\.


--
-- Data for Name: programstageuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageuseraccesses (programstageid, useraccessid) FROM stdin;
\.


--
-- Data for Name: programstageusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programstageusergroupaccesses (programid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: programtempownershipaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programtempownershipaudit (programtempownershipauditid, programid, trackedentityinstanceid, created, accessedby, reason) FROM stdin;
\.


--
-- Data for Name: programtrackedentityattributegroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programtrackedentityattributegroupmembers (programtrackedentityattributeid, programtrackedentityattributegroupid) FROM stdin;
\.


--
-- Data for Name: programuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programuseraccesses (programid, useraccessid) FROM stdin;
\.


--
-- Data for Name: programusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.programusergroupaccesses (programid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: pushanalysis; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.pushanalysis (pushanalysisid, uid, code, created, lastupdated, lastupdatedby, name, title, message, enabled, schedulingdayoffrequency, schedulingfrequency, dashboard) FROM stdin;
\.


--
-- Data for Name: pushanalysisrecipientusergroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.pushanalysisrecipientusergroups (usergroupid, elt) FROM stdin;
\.


--
-- Data for Name: relationship; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relationship (relationshipid, uid, code, created, lastupdated, lastupdatedby, formname, description, style, relationshiptypeid, from_relationshipitemid, to_relationshipitemid) FROM stdin;
\.


--
-- Data for Name: relationshipconstraint; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relationshipconstraint (relationshipconstraintid, entity, trackedentitytypeid, programid, programstageid) FROM stdin;
\.


--
-- Data for Name: relationshipitem; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relationshipitem (relationshipitemid, relationshipid, trackedentityinstanceid, programinstanceid, programstageinstanceid) FROM stdin;
\.


--
-- Data for Name: relationshiptype; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relationshiptype (relationshiptypeid, uid, code, created, lastupdated, lastupdatedby, name, description, from_relationshipconstraintid, to_relationshipconstraintid, userid, publicaccess, translations, bidirectional, fromtoname, tofromname) FROM stdin;
\.


--
-- Data for Name: relationshiptypeuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relationshiptypeuseraccesses (relationshiptypeid, useraccessid) FROM stdin;
\.


--
-- Data for Name: relationshiptypeusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relationshiptypeusergroupaccesses (relationshiptypeid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: relativeperiods; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.relativeperiods (relativeperiodsid, thisday, yesterday, last3days, last7days, last14days, thismonth, lastmonth, thisbimonth, lastbimonth, thisquarter, lastquarter, thissixmonth, lastsixmonth, weeksthisyear, monthsthisyear, bimonthsthisyear, quartersthisyear, thisyear, monthslastyear, quarterslastyear, lastyear, last5years, last12months, last6months, last3months, last6bimonths, last4quarters, last2sixmonths, thisfinancialyear, lastfinancialyear, last5financialyears, thisweek, lastweek, thisbiweek, lastbiweek, last4weeks, last4biweeks, last12weeks, last52weeks) FROM stdin;
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.report (reportid, uid, code, created, lastupdated, lastupdatedby, name, type, designcontent, reporttableid, relativeperiodsid, paramreportingmonth, paramorganisationunit, cachestrategy, externalaccess, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: reporttable; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable (reporttableid, uid, code, created, lastupdated, lastupdatedby, name, description, measurecriteria, regression, cumulative, relativeperiodsid, paramreportingmonth, paramgrandparentorganisationunit, paramparentorganisationunit, paramorganisationunit, sortorder, toplimit, rowtotals, coltotals, rowsubtotals, colsubtotals, hideemptyrows, hideemptycolumns, aggregationtype, completedonly, title, subtitle, hidetitle, hidesubtitle, digitgroupseparator, displaydensity, fontsize, userorganisationunit, userorganisationunitchildren, userorganisationunitgrandchildren, legendsetid, legenddisplaystyle, legenddisplaystrategy, numbertype, showhierarchy, showdimensionlabels, skiprounding, externalaccess, userid, publicaccess, favorites, subscribers, startdate, enddate, translations) FROM stdin;
\.


--
-- Data for Name: reporttable_categorydimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_categorydimensions (reporttableid, sort_order, categorydimensionid) FROM stdin;
\.


--
-- Data for Name: reporttable_categoryoptiongroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_categoryoptiongroupsetdimensions (reporttableid, sort_order, categoryoptiongroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: reporttable_columns; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_columns (reporttableid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: reporttable_datadimensionitems; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_datadimensionitems (reporttableid, sort_order, datadimensionitemid) FROM stdin;
\.


--
-- Data for Name: reporttable_dataelementgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_dataelementgroupsetdimensions (reporttableid, sort_order, dataelementgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: reporttable_filters; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_filters (reporttableid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: reporttable_itemorgunitgroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_itemorgunitgroups (reporttableid, sort_order, orgunitgroupid) FROM stdin;
\.


--
-- Data for Name: reporttable_organisationunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_organisationunits (reporttableid, sort_order, organisationunitid) FROM stdin;
\.


--
-- Data for Name: reporttable_orgunitgroupsetdimensions; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_orgunitgroupsetdimensions (reporttableid, sort_order, orgunitgroupsetdimensionid) FROM stdin;
\.


--
-- Data for Name: reporttable_orgunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_orgunitlevels (reporttableid, sort_order, orgunitlevel) FROM stdin;
\.


--
-- Data for Name: reporttable_periods; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_periods (reporttableid, sort_order, periodid) FROM stdin;
\.


--
-- Data for Name: reporttable_rows; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttable_rows (reporttableid, sort_order, dimension) FROM stdin;
\.


--
-- Data for Name: reporttableuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttableuseraccesses (reporttableid, useraccessid) FROM stdin;
\.


--
-- Data for Name: reporttableusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reporttableusergroupaccesses (reporttableid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: reportuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reportuseraccesses (reportid, useraccessid) FROM stdin;
\.


--
-- Data for Name: reportusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reportusergroupaccesses (reportid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: reservedvalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.reservedvalue (reservedvalueid, expirydate, created, ownerobject, owneruid, key, value) FROM stdin;
\.


--
-- Data for Name: section; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.section (sectionid, uid, code, created, lastupdated, lastupdatedby, name, description, datasetid, sortorder, showrowtotals, showcolumntotals, translations) FROM stdin;
\.


--
-- Data for Name: sectionattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sectionattributevalues (sectionid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: sectiondataelements; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sectiondataelements (sectionid, sort_order, dataelementid) FROM stdin;
\.


--
-- Data for Name: sectiongreyedfields; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sectiongreyedfields (sectionid, dataelementoperandid) FROM stdin;
\.


--
-- Data for Name: sectionindicators; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sectionindicators (sectionid, sort_order, indicatorid) FROM stdin;
\.


--
-- Data for Name: sequentialnumbercounter; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sequentialnumbercounter (id, owneruid, key, counter) FROM stdin;
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.series (seriesid, series, axis) FROM stdin;
\.


--
-- Data for Name: smscodes; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.smscodes (smscodeid, code, formula, compulsory, dataelementid, trackedentityattributeid, optionid) FROM stdin;
\.


--
-- Data for Name: smscommandcodes; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.smscommandcodes (id, codeid) FROM stdin;
\.


--
-- Data for Name: smscommands; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.smscommands (smscommandid, uid, created, lastupdated, name, parsertype, separatorkey, codeseparator, defaultmessage, receivedmessage, wrongformatmessage, nousermessage, morethanoneorgunitmessage, successmessage, currentperiodusedforreporting, completenessmethod, datasetid, usergroupid, programid, programstageid) FROM stdin;
\.


--
-- Data for Name: smscommandspecialcharacters; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.smscommandspecialcharacters (smscommandid, specialcharacterid) FROM stdin;
\.


--
-- Data for Name: smsspecialcharacter; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.smsspecialcharacter (specialcharacterid, name, value) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: sqlview; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sqlview (sqlviewid, uid, code, created, lastupdated, lastupdatedby, name, description, sqlquery, type, cachestrategy, externalaccess, userid, publicaccess) FROM stdin;
\.


--
-- Data for Name: sqlviewattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sqlviewattributevalues (sqlviewid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: sqlviewuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sqlviewuseraccesses (sqlviewid, useraccessid) FROM stdin;
\.


--
-- Data for Name: sqlviewusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.sqlviewusergroupaccesses (sqlviewid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: systemsetting; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.systemsetting (systemsettingid, name, value, translations) FROM stdin;
\.


--
-- Data for Name: tablehook; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.tablehook (analyticstablehookid, uid, code, created, lastupdated, lastupdatedby, name, analyticstablephase, resourcetabletype, analyticstabletype, sql) FROM stdin;
\.


--
-- Data for Name: trackedentityattribute; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattribute (trackedentityattributeid, uid, code, created, lastupdated, lastupdatedby, name, shortname, description, formname, valuetype, aggregationtype, optionsetid, inherit, expression, displayonvisitschedule, sortorderinvisitschedule, displayinlistnoprogram, sortorderinlistnoprogram, confidential, uniquefield, generated, pattern, textpattern, style, orgunitscope, programscope, skipsynchronization, userid, publicaccess, fieldmask, translations) FROM stdin;
\.


--
-- Data for Name: trackedentityattributeattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributeattributevalues (trackedentityattributeid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: trackedentityattributedimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributedimension (trackedentityattributedimensionid, trackedentityattributeid, legendsetid, filter) FROM stdin;
\.


--
-- Data for Name: trackedentityattributelegendsets; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributelegendsets (trackedentityattributeid, sort_order, legendsetid) FROM stdin;
\.


--
-- Data for Name: trackedentityattributeuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributeuseraccesses (trackedentityattributeid, useraccessid) FROM stdin;
\.


--
-- Data for Name: trackedentityattributeusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributeusergroupaccesses (trackedentityattributeid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: trackedentityattributevalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributevalue (trackedentityinstanceid, trackedentityattributeid, created, lastupdated, value, encryptedvalue, storedby) FROM stdin;
\.


--
-- Data for Name: trackedentityattributevalueaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityattributevalueaudit (trackedentityattributevalueauditid, trackedentityinstanceid, trackedentityattributeid, value, encryptedvalue, created, modifiedby, audittype) FROM stdin;
\.


--
-- Data for Name: trackedentitycomment; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitycomment (trackedentitycommentid, uid, code, created, lastupdated, lastupdatedby, commenttext, creator) FROM stdin;
\.


--
-- Data for Name: trackedentitydataelementdimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitydataelementdimension (trackedentitydataelementdimensionid, dataelementid, legendsetid, filter) FROM stdin;
\.


--
-- Data for Name: trackedentitydatavalueaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitydatavalueaudit (trackedentitydatavalueauditid, programstageinstanceid, dataelementid, value, created, providedelsewhere, modifiedby, audittype) FROM stdin;
\.


--
-- Data for Name: trackedentityinstance; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityinstance (trackedentityinstanceid, uid, code, created, lastupdated, lastupdatedby, createdatclient, lastupdatedatclient, inactive, deleted, lastsynchronized, featuretype, coordinates, organisationunitid, trackedentitytypeid, geometry) FROM stdin;
\.


--
-- Data for Name: trackedentityinstanceaudit; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityinstanceaudit (trackedentityinstanceauditid, trackedentityinstance, created, accessedby, audittype, comment) FROM stdin;
\.


--
-- Data for Name: trackedentityinstancefilter; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityinstancefilter (trackedentityinstancefilterid, uid, code, created, lastupdated, lastupdatedby, name, description, sortorder, style, programid, enrollmentstatus, followup, enrollmentcreatedperiod, eventfilters) FROM stdin;
\.


--
-- Data for Name: trackedentityprogramindicatordimension; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityprogramindicatordimension (trackedentityprogramindicatordimensionid, programindicatorid, legendsetid, filter) FROM stdin;
\.


--
-- Data for Name: trackedentityprogramowner; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentityprogramowner (trackedentityprogramownerid, trackedentityinstanceid, programid, created, lastupdated, organisationunitid, createdby) FROM stdin;
\.


--
-- Data for Name: trackedentitytype; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitytype (trackedentitytypeid, uid, code, created, lastupdated, lastupdatedby, name, description, formname, style, minattributesrequiredtosearch, maxteicounttoreturn, allowauditlog, userid, publicaccess, featuretype, translations) FROM stdin;
\.


--
-- Data for Name: trackedentitytypeattribute; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitytypeattribute (trackedentitytypeattributeid, uid, code, created, lastupdated, lastupdatedby, trackedentitytypeid, trackedentityattributeid, displayinlist, mandatory, searchable, sort_order) FROM stdin;
\.


--
-- Data for Name: trackedentitytypeattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitytypeattributevalues (trackedentitytypeid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: trackedentitytypeuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitytypeuseraccesses (trackedentitytypeid, useraccessid) FROM stdin;
\.


--
-- Data for Name: trackedentitytypeusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.trackedentitytypeusergroupaccesses (trackedentitytypeid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: useraccess; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.useraccess (useraccessid, access, userid) FROM stdin;
\.


--
-- Data for Name: userapps; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userapps (userinfoid, sort_order, app) FROM stdin;
\.


--
-- Data for Name: userattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userattributevalues (userinfoid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: userdatavieworgunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userdatavieworgunits (userinfoid, organisationunitid) FROM stdin;
\.


--
-- Data for Name: usergroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroup (usergroupid, uid, code, created, lastupdated, lastupdatedby, name, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: usergroupaccess; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroupaccess (usergroupaccessid, access, usergroupid) FROM stdin;
\.


--
-- Data for Name: usergroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroupattributevalues (usergroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: usergroupmanaged; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroupmanaged (managedbygroupid, managedgroupid) FROM stdin;
\.


--
-- Data for Name: usergroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroupmembers (userid, usergroupid) FROM stdin;
\.


--
-- Data for Name: usergroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroupuseraccesses (usergroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: usergroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usergroupusergroupaccesses (usergroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: userinfo; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userinfo (userinfoid, uid, code, lastupdated, created, surname, firstname, email, phonenumber, jobtitle, introduction, gender, birthday, nationality, employer, education, interests, languages, welcomemessage, lastcheckedinterpretations, whatsapp, skype, facebookmessenger, telegram, twitter, avatar) FROM stdin;
58	M5zQapPyTZI	admin	2021-01-06 11:49:19.385	2021-01-06 11:49:19.095	admin	admin	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: userkeyjsonvalue; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userkeyjsonvalue (userkeyjsonvalueid, uid, code, created, lastupdated, lastupdatedby, userid, namespace, userkey, encrypted_value, encrypted, jbvalue) FROM stdin;
60	t3tIHjQJe65	\N	2021-01-06 11:49:34.688	2021-01-06 11:49:34.688	58	58	dashboard	controlBarRows	\N	f	1
\.


--
-- Data for Name: usermembership; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usermembership (organisationunitid, userinfoid) FROM stdin;
\.


--
-- Data for Name: usermessage; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usermessage (usermessageid, usermessagekey, userid, isread, isfollowup) FROM stdin;
\.


--
-- Data for Name: userrole; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userrole (userroleid, uid, code, created, lastupdated, lastupdatedby, name, description, userid, publicaccess, translations) FROM stdin;
59	yrB6vc5Ip3r	Superuser	2021-01-06 11:49:19.121	2021-01-06 11:49:19.121	\N	Superuser	Superuser	\N	--------	[]
\.


--
-- Data for Name: userroleauthorities; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userroleauthorities (userroleid, authority) FROM stdin;
59	F_TRACKED_ENTITY_INSTANCE_SEARCH_IN_ALL_ORGUNITS
59	ALL
59	F_USERGROUP_MANAGING_RELATIONSHIPS_ADD
59	F_USER_VIEW
59	F_GENERATE_MIN_MAX_VALUES
59	F_ORGANISATIONUNIT_MOVE
59	F_USER_GROUPS_READ_ONLY_ADD_MEMBERS
59	F_PREDICTOR_RUN
59	F_IGNORE_TRACKER_REQUIRED_VALUE_VALIDATION
59	F_SKIP_DATA_IMPORT_AUDIT
59	F_RUN_VALIDATION
59	F_IMPORT_DATA
59	F_LOCALE_ADD
59	F_REPLICATE_USER
59	F_SEND_EMAIL
59	F_INSERT_CUSTOM_JS_CSS
59	F_ENROLLMENT_CASCADE_DELETE
59	F_METADATA_IMPORT
59	F_EXPORT_EVENTS
59	F_VIEW_EVENT_ANALYTICS
59	F_VIEW_UNAPPROVED_DATA
59	F_IMPORT_EVENTS
59	F_PERFORM_MAINTENANCE
59	F_USERGROUP_MANAGING_RELATIONSHIPS_VIEW
59	F_METADATA_EXPORT
59	F_TEI_CASCADE_DELETE
59	F_EXPORT_DATA
59	F_APPROVE_DATA
59	F_ACCEPT_DATA_LOWER_LEVELS
59	F_EDIT_EXPIRED
59	F_PROGRAM_DASHBOARD_CONFIG_ADMIN
59	F_APPROVE_DATA_LOWER_LEVELS
59	F_UNCOMPLETE_EVENT
\.


--
-- Data for Name: userrolemembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userrolemembers (userroleid, userid) FROM stdin;
59	58
\.


--
-- Data for Name: userroleuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userroleuseraccesses (userroleid, useraccessid) FROM stdin;
\.


--
-- Data for Name: userroleusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userroleusergroupaccesses (userroleid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.users (userid, uid, code, created, lastupdated, lastupdatedby, creatoruserid, username, password, secret, twofa, externalauth, openid, ldapid, passwordlastupdated, lastlogin, restoretoken, restorecode, restoreexpiry, selfregistered, invitation, disabled) FROM stdin;
58	KvMx6c1eoYo	admin	2021-01-06 11:49:19.149	2021-01-06 11:49:19.149	\N	\N	admin	$2a$10$IjdXLPMf/LTtcWrn0mh.Aeb4ip8nGwowxCSbeS7vM7/IXfWzrBzda	7YOLSUK7CYG4LML2	f	f	\N	\N	2021-01-06 11:49:19.15	2021-01-07 11:57:37.302	\N	\N	\N	f	f	f
\.


--
-- Data for Name: users_catdimensionconstraints; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.users_catdimensionconstraints (userid, dataelementcategoryid) FROM stdin;
\.


--
-- Data for Name: users_cogsdimensionconstraints; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.users_cogsdimensionconstraints (userid, categoryoptiongroupsetid) FROM stdin;
\.


--
-- Data for Name: usersetting; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.usersetting (userinfoid, name, value) FROM stdin;
\.


--
-- Data for Name: userteisearchorgunits; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.userteisearchorgunits (userinfoid, organisationunitid) FROM stdin;
\.


--
-- Data for Name: validationnotificationtemplate; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationnotificationtemplate (validationnotificationtemplateid, uid, code, created, lastupdated, lastupdatedby, name, subjecttemplate, messagetemplate, notifyusersinhierarchyonly, sendstrategy) FROM stdin;
\.


--
-- Data for Name: validationnotificationtemplate_recipientusergroups; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationnotificationtemplate_recipientusergroups (validationnotificationtemplateid, usergroupid) FROM stdin;
\.


--
-- Data for Name: validationnotificationtemplatevalidationrules; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationnotificationtemplatevalidationrules (validationnotificationtemplateid, validationruleid) FROM stdin;
\.


--
-- Data for Name: validationresult; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationresult (validationresultid, created, leftsidevalue, rightsidevalue, validationruleid, periodid, organisationunitid, attributeoptioncomboid, dayinperiod, notificationsent) FROM stdin;
\.


--
-- Data for Name: validationrule; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationrule (validationruleid, uid, code, created, lastupdated, lastupdatedby, name, description, instruction, importance, operator, leftexpressionid, rightexpressionid, skipformvalidation, periodtypeid, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: validationruleattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationruleattributevalues (validationruleid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: validationrulegroup; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationrulegroup (validationrulegroupid, uid, code, created, lastupdated, lastupdatedby, name, description, userid, publicaccess, translations) FROM stdin;
\.


--
-- Data for Name: validationrulegroupattributevalues; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationrulegroupattributevalues (validationrulegroupid, attributevalueid) FROM stdin;
\.


--
-- Data for Name: validationrulegroupmembers; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationrulegroupmembers (validationgroupid, validationruleid) FROM stdin;
\.


--
-- Data for Name: validationrulegroupuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationrulegroupuseraccesses (validationrulegroupid, useraccessid) FROM stdin;
\.


--
-- Data for Name: validationrulegroupusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationrulegroupusergroupaccesses (validationrulegroupid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: validationruleorganisationunitlevels; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationruleorganisationunitlevels (validationruleid, organisationunitlevel) FROM stdin;
\.


--
-- Data for Name: validationruleuseraccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationruleuseraccesses (validationruleid, useraccessid) FROM stdin;
\.


--
-- Data for Name: validationruleusergroupaccesses; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.validationruleusergroupaccesses (validationruleid, usergroupaccessid) FROM stdin;
\.


--
-- Data for Name: version; Type: TABLE DATA; Schema: public; Owner: dhis
--

COPY public.version (versionid, versionkey, versionvalue) FROM stdin;
62	organisationUnit	540ddbae-55d7-435a-971c-1eb2777b98e7
\.


--
-- Name: datavalueaudit_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.datavalueaudit_sequence', 1, false);


--
-- Name: deletedobject_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.deletedobject_sequence', 1, false);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.hibernate_sequence', 308, true);


--
-- Name: message_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.message_sequence', 1, false);


--
-- Name: messageconversation_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.messageconversation_sequence', 1, false);


--
-- Name: potentialduplicatesequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.potentialduplicatesequence', 1, false);


--
-- Name: programinstance_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.programinstance_sequence', 1, false);


--
-- Name: programstageinstance_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.programstageinstance_sequence', 1, false);


--
-- Name: reservedvalue_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.reservedvalue_sequence', 1, false);


--
-- Name: trackedentitydatavalueaudit_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.trackedentitydatavalueaudit_sequence', 1, false);


--
-- Name: trackedentityinstance_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.trackedentityinstance_sequence', 1, false);


--
-- Name: trackedentityinstanceaudit_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.trackedentityinstanceaudit_sequence', 1, false);


--
-- Name: usermessage_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhis
--

SELECT pg_catalog.setval('public.usermessage_sequence', 1, false);


--
-- Name: attribute attribute_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT attribute_pkey PRIMARY KEY (attributeid);


--
-- Name: attributeuseraccesses attributeuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeuseraccesses
    ADD CONSTRAINT attributeuseraccesses_pkey PRIMARY KEY (attributeid, useraccessid);


--
-- Name: attributeusergroupaccesses attributeusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeusergroupaccesses
    ADD CONSTRAINT attributeusergroupaccesses_pkey PRIMARY KEY (attributeid, usergroupaccessid);


--
-- Name: attributevalue attributevalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributevalue
    ADD CONSTRAINT attributevalue_pkey PRIMARY KEY (attributevalueid);


--
-- Name: categories_categoryoptions categories_categoryoptions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categories_categoryoptions
    ADD CONSTRAINT categories_categoryoptions_pkey PRIMARY KEY (categoryid, sort_order);


--
-- Name: categoryattributevalues categoryattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryattributevalues
    ADD CONSTRAINT categoryattributevalues_pkey PRIMARY KEY (categoryid, attributevalueid);


--
-- Name: categorycombo categorycombo_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombo
    ADD CONSTRAINT categorycombo_pkey PRIMARY KEY (categorycomboid);


--
-- Name: categorycombos_categories categorycombos_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombos_categories
    ADD CONSTRAINT categorycombos_categories_pkey PRIMARY KEY (categorycomboid, sort_order);


--
-- Name: categorycombos_optioncombos categorycombos_optioncombos_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombos_optioncombos
    ADD CONSTRAINT categorycombos_optioncombos_pkey PRIMARY KEY (categoryoptioncomboid);


--
-- Name: categorycombouseraccesses categorycombouseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombouseraccesses
    ADD CONSTRAINT categorycombouseraccesses_pkey PRIMARY KEY (categorycomboid, useraccessid);


--
-- Name: categorycombousergroupaccesses categorycombousergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombousergroupaccesses
    ADD CONSTRAINT categorycombousergroupaccesses_pkey PRIMARY KEY (categorycomboid, usergroupaccessid);


--
-- Name: categorydimension_items categorydimension_items_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorydimension_items
    ADD CONSTRAINT categorydimension_items_pkey PRIMARY KEY (categorydimensionid, sort_order);


--
-- Name: categorydimension categorydimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorydimension
    ADD CONSTRAINT categorydimension_pkey PRIMARY KEY (categorydimensionid);


--
-- Name: categoryoption_organisationunits categoryoption_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoption_organisationunits
    ADD CONSTRAINT categoryoption_organisationunits_pkey PRIMARY KEY (categoryoptionid, organisationunitid);


--
-- Name: categoryoptioncombo categoryoptioncombo_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombo
    ADD CONSTRAINT categoryoptioncombo_pkey PRIMARY KEY (categoryoptioncomboid);


--
-- Name: categoryoptioncomboattributevalues categoryoptioncomboattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncomboattributevalues
    ADD CONSTRAINT categoryoptioncomboattributevalues_pkey PRIMARY KEY (categoryoptioncomboid, attributevalueid);


--
-- Name: categoryoptioncombos_categoryoptions categoryoptioncombos_categoryoptions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombos_categoryoptions
    ADD CONSTRAINT categoryoptioncombos_categoryoptions_pkey PRIMARY KEY (categoryoptioncomboid, categoryoptionid);


--
-- Name: categoryoptiongroup categoryoptiongroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT categoryoptiongroup_pkey PRIMARY KEY (categoryoptiongroupid);


--
-- Name: categoryoptiongroupattributevalues categoryoptiongroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupattributevalues
    ADD CONSTRAINT categoryoptiongroupattributevalues_pkey PRIMARY KEY (categoryoptiongroupid, attributevalueid);


--
-- Name: categoryoptiongroupmembers categoryoptiongroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupmembers
    ADD CONSTRAINT categoryoptiongroupmembers_pkey PRIMARY KEY (categoryoptiongroupid, categoryoptionid);


--
-- Name: categoryoptiongroupset categoryoptiongroupset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupset
    ADD CONSTRAINT categoryoptiongroupset_pkey PRIMARY KEY (categoryoptiongroupsetid);


--
-- Name: categoryoptiongroupsetattributevalues categoryoptiongroupsetattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetattributevalues
    ADD CONSTRAINT categoryoptiongroupsetattributevalues_pkey PRIMARY KEY (categoryoptiongroupsetid, attributevalueid);


--
-- Name: categoryoptiongroupsetdimension_items categoryoptiongroupsetdimension_items_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetdimension_items
    ADD CONSTRAINT categoryoptiongroupsetdimension_items_pkey PRIMARY KEY (categoryoptiongroupsetdimensionid, sort_order);


--
-- Name: categoryoptiongroupsetdimension categoryoptiongroupsetdimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetdimension
    ADD CONSTRAINT categoryoptiongroupsetdimension_pkey PRIMARY KEY (categoryoptiongroupsetdimensionid);


--
-- Name: categoryoptiongroupsetmembers categoryoptiongroupsetmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetmembers
    ADD CONSTRAINT categoryoptiongroupsetmembers_pkey PRIMARY KEY (categoryoptiongroupsetid, sort_order);


--
-- Name: categoryoptiongroupsetuseraccesses categoryoptiongroupsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetuseraccesses
    ADD CONSTRAINT categoryoptiongroupsetuseraccesses_pkey PRIMARY KEY (categoryoptiongroupsetid, useraccessid);


--
-- Name: categoryoptiongroupsetusergroupaccesses categoryoptiongroupsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetusergroupaccesses
    ADD CONSTRAINT categoryoptiongroupsetusergroupaccesses_pkey PRIMARY KEY (categoryoptiongroupsetid, usergroupaccessid);


--
-- Name: categoryoptiongroupuseraccesses categoryoptiongroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupuseraccesses
    ADD CONSTRAINT categoryoptiongroupuseraccesses_pkey PRIMARY KEY (categoryoptiongroupid, useraccessid);


--
-- Name: categoryoptiongroupusergroupaccesses categoryoptiongroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupusergroupaccesses
    ADD CONSTRAINT categoryoptiongroupusergroupaccesses_pkey PRIMARY KEY (categoryoptiongroupid, usergroupaccessid);


--
-- Name: chart_categorydimensions chart_categorydimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_categorydimensions
    ADD CONSTRAINT chart_categorydimensions_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_categoryoptiongroupsetdimensions chart_categoryoptiongroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_categoryoptiongroupsetdimensions
    ADD CONSTRAINT chart_categoryoptiongroupsetdimensions_pkey PRIMARY KEY (chart, sort_order);


--
-- Name: chart_datadimensionitems chart_datadimensionitems_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_datadimensionitems
    ADD CONSTRAINT chart_datadimensionitems_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_dataelementgroupsetdimensions chart_dataelementgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_dataelementgroupsetdimensions
    ADD CONSTRAINT chart_dataelementgroupsetdimensions_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_filters chart_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_filters
    ADD CONSTRAINT chart_filters_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_itemorgunitgroups chart_itemorgunitgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_itemorgunitgroups
    ADD CONSTRAINT chart_itemorgunitgroups_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_organisationunits chart_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_organisationunits
    ADD CONSTRAINT chart_organisationunits_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_orgunitgroupsetdimensions chart_orgunitgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_orgunitgroupsetdimensions
    ADD CONSTRAINT chart_orgunitgroupsetdimensions_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_orgunitlevels chart_orgunitlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_orgunitlevels
    ADD CONSTRAINT chart_orgunitlevels_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_periods chart_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_periods
    ADD CONSTRAINT chart_periods_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart chart_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT chart_pkey PRIMARY KEY (chartid);


--
-- Name: chart_seriesitems chart_seriesitems_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_seriesitems
    ADD CONSTRAINT chart_seriesitems_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chart_yearlyseries chart_yearlyseries_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_yearlyseries
    ADD CONSTRAINT chart_yearlyseries_pkey PRIMARY KEY (chartid, sort_order);


--
-- Name: chartuseraccesses chartuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartuseraccesses
    ADD CONSTRAINT chartuseraccesses_pkey PRIMARY KEY (chartid, useraccessid);


--
-- Name: chartusergroupaccesses chartusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartusergroupaccesses
    ADD CONSTRAINT chartusergroupaccesses_pkey PRIMARY KEY (chartid, usergroupaccessid);


--
-- Name: color color_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.color
    ADD CONSTRAINT color_pkey PRIMARY KEY (colorid);


--
-- Name: colorset_colors colorset_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset_colors
    ADD CONSTRAINT colorset_colors_pkey PRIMARY KEY (colorsetid, sort_order);


--
-- Name: colorset colorset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset
    ADD CONSTRAINT colorset_pkey PRIMARY KEY (colorsetid);


--
-- Name: completedatasetregistration completedatasetregistration_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.completedatasetregistration
    ADD CONSTRAINT completedatasetregistration_pkey PRIMARY KEY (datasetid, periodid, sourceid, attributeoptioncomboid);


--
-- Name: configuration configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (configurationid);


--
-- Name: constant constant_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT constant_pkey PRIMARY KEY (constantid);


--
-- Name: constantattributevalues constantattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantattributevalues
    ADD CONSTRAINT constantattributevalues_pkey PRIMARY KEY (constantid, attributevalueid);


--
-- Name: constantuseraccesses constantuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantuseraccesses
    ADD CONSTRAINT constantuseraccesses_pkey PRIMARY KEY (constantid, useraccessid);


--
-- Name: constantusergroupaccesses constantusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantusergroupaccesses
    ADD CONSTRAINT constantusergroupaccesses_pkey PRIMARY KEY (constantid, usergroupaccessid);


--
-- Name: dashboard_items dashboard_items_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard_items
    ADD CONSTRAINT dashboard_items_pkey PRIMARY KEY (dashboardid, sort_order);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (dashboardid);


--
-- Name: dashboarditem dashboarditem_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT dashboarditem_pkey PRIMARY KEY (dashboarditemid);


--
-- Name: dashboarditem_reports dashboarditem_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_reports
    ADD CONSTRAINT dashboarditem_reports_pkey PRIMARY KEY (dashboarditemid, sort_order);


--
-- Name: dashboarditem_resources dashboarditem_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_resources
    ADD CONSTRAINT dashboarditem_resources_pkey PRIMARY KEY (dashboarditemid, sort_order);


--
-- Name: dashboarditem_users dashboarditem_users_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_users
    ADD CONSTRAINT dashboarditem_users_pkey PRIMARY KEY (dashboarditemid, sort_order);


--
-- Name: dashboarduseraccesses dashboarduseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarduseraccesses
    ADD CONSTRAINT dashboarduseraccesses_pkey PRIMARY KEY (dashboardid, useraccessid);


--
-- Name: dashboardusergroupaccesses dashboardusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboardusergroupaccesses
    ADD CONSTRAINT dashboardusergroupaccesses_pkey PRIMARY KEY (dashboardid, usergroupaccessid);


--
-- Name: dataapproval dataapproval_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT dataapproval_pkey PRIMARY KEY (dataapprovalid);


--
-- Name: dataapproval dataapproval_unique_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT dataapproval_unique_key UNIQUE (dataapprovallevelid, workflowid, periodid, organisationunitid, attributeoptioncomboid);


--
-- Name: dataapprovalaudit dataapprovalaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT dataapprovalaudit_pkey PRIMARY KEY (dataapprovalauditid);


--
-- Name: dataapprovallevel dataapprovallevel_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT dataapprovallevel_pkey PRIMARY KEY (dataapprovallevelid);


--
-- Name: dataapprovalleveluseraccesses dataapprovalleveluseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalleveluseraccesses
    ADD CONSTRAINT dataapprovalleveluseraccesses_pkey PRIMARY KEY (dataapprovallevelid, useraccessid);


--
-- Name: dataapprovallevelusergroupaccesses dataapprovallevelusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevelusergroupaccesses
    ADD CONSTRAINT dataapprovallevelusergroupaccesses_pkey PRIMARY KEY (dataapprovallevelid, usergroupaccessid);


--
-- Name: dataapprovalworkflow dataapprovalworkflow_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT dataapprovalworkflow_pkey PRIMARY KEY (workflowid);


--
-- Name: dataapprovalworkflowlevels dataapprovalworkflowlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowlevels
    ADD CONSTRAINT dataapprovalworkflowlevels_pkey PRIMARY KEY (workflowid, dataapprovallevelid);


--
-- Name: dataapprovalworkflowuseraccesses dataapprovalworkflowuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowuseraccesses
    ADD CONSTRAINT dataapprovalworkflowuseraccesses_pkey PRIMARY KEY (workflowid, useraccessid);


--
-- Name: dataapprovalworkflowusergroupaccesses dataapprovalworkflowusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowusergroupaccesses
    ADD CONSTRAINT dataapprovalworkflowusergroupaccesses_pkey PRIMARY KEY (workflowid, usergroupaccessid);


--
-- Name: datadimensionitem datadimensionitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT datadimensionitem_pkey PRIMARY KEY (datadimensionitemid);


--
-- Name: dataelement dataelement_code_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT dataelement_code_key UNIQUE (code);


--
-- Name: dataelement dataelement_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT dataelement_pkey PRIMARY KEY (dataelementid);


--
-- Name: dataelementaggregationlevels dataelementaggregationlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementaggregationlevels
    ADD CONSTRAINT dataelementaggregationlevels_pkey PRIMARY KEY (dataelementid, sort_order);


--
-- Name: dataelementattributevalues dataelementattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementattributevalues
    ADD CONSTRAINT dataelementattributevalues_pkey PRIMARY KEY (dataelementid, attributevalueid);


--
-- Name: dataelementcategory dataelementcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategory
    ADD CONSTRAINT dataelementcategory_pkey PRIMARY KEY (categoryid);


--
-- Name: dataelementcategoryoption dataelementcategoryoption_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT dataelementcategoryoption_pkey PRIMARY KEY (categoryoptionid);


--
-- Name: dataelementcategoryoptionattributevalues dataelementcategoryoptionattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionattributevalues
    ADD CONSTRAINT dataelementcategoryoptionattributevalues_pkey PRIMARY KEY (categoryoptionid, attributevalueid);


--
-- Name: dataelementcategoryoptionuseraccesses dataelementcategoryoptionuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionuseraccesses
    ADD CONSTRAINT dataelementcategoryoptionuseraccesses_pkey PRIMARY KEY (categoryoptionid, useraccessid);


--
-- Name: dataelementcategoryoptionusergroupaccesses dataelementcategoryoptionusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionusergroupaccesses
    ADD CONSTRAINT dataelementcategoryoptionusergroupaccesses_pkey PRIMARY KEY (categoryoptionid, usergroupaccessid);


--
-- Name: dataelementcategoryuseraccesses dataelementcategoryuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryuseraccesses
    ADD CONSTRAINT dataelementcategoryuseraccesses_pkey PRIMARY KEY (categoryid, useraccessid);


--
-- Name: dataelementcategoryusergroupaccesses dataelementcategoryusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryusergroupaccesses
    ADD CONSTRAINT dataelementcategoryusergroupaccesses_pkey PRIMARY KEY (categoryid, usergroupaccessid);


--
-- Name: dataelementgroup dataelementgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT dataelementgroup_pkey PRIMARY KEY (dataelementgroupid);


--
-- Name: dataelementgroupattributevalues dataelementgroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupattributevalues
    ADD CONSTRAINT dataelementgroupattributevalues_pkey PRIMARY KEY (dataelementgroupid, attributevalueid);


--
-- Name: dataelementgroupmembers dataelementgroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupmembers
    ADD CONSTRAINT dataelementgroupmembers_pkey PRIMARY KEY (dataelementgroupid, dataelementid);


--
-- Name: dataelementgroupset dataelementgroupset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupset
    ADD CONSTRAINT dataelementgroupset_pkey PRIMARY KEY (dataelementgroupsetid);


--
-- Name: dataelementgroupsetattributevalues dataelementgroupsetattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetattributevalues
    ADD CONSTRAINT dataelementgroupsetattributevalues_pkey PRIMARY KEY (dataelementgroupsetid, attributevalueid);


--
-- Name: dataelementgroupsetdimension_items dataelementgroupsetdimension_items_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetdimension_items
    ADD CONSTRAINT dataelementgroupsetdimension_items_pkey PRIMARY KEY (dataelementgroupsetdimensionid, sort_order);


--
-- Name: dataelementgroupsetdimension dataelementgroupsetdimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetdimension
    ADD CONSTRAINT dataelementgroupsetdimension_pkey PRIMARY KEY (dataelementgroupsetdimensionid);


--
-- Name: dataelementgroupsetmembers dataelementgroupsetmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetmembers
    ADD CONSTRAINT dataelementgroupsetmembers_pkey PRIMARY KEY (dataelementgroupsetid, sort_order);


--
-- Name: dataelementgroupsetuseraccesses dataelementgroupsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetuseraccesses
    ADD CONSTRAINT dataelementgroupsetuseraccesses_pkey PRIMARY KEY (dataelementgroupsetid, useraccessid);


--
-- Name: dataelementgroupsetusergroupaccesses dataelementgroupsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetusergroupaccesses
    ADD CONSTRAINT dataelementgroupsetusergroupaccesses_pkey PRIMARY KEY (dataelementgroupsetid, usergroupaccessid);


--
-- Name: dataelementgroupuseraccesses dataelementgroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupuseraccesses
    ADD CONSTRAINT dataelementgroupuseraccesses_pkey PRIMARY KEY (dataelementgroupid, useraccessid);


--
-- Name: dataelementgroupusergroupaccesses dataelementgroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupusergroupaccesses
    ADD CONSTRAINT dataelementgroupusergroupaccesses_pkey PRIMARY KEY (dataelementgroupid, usergroupaccessid);


--
-- Name: dataelementlegendsets dataelementlegendsets_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementlegendsets
    ADD CONSTRAINT dataelementlegendsets_pkey PRIMARY KEY (dataelementid, sort_order);


--
-- Name: dataelementoperand dataelementoperand_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementoperand
    ADD CONSTRAINT dataelementoperand_pkey PRIMARY KEY (dataelementoperandid);


--
-- Name: dataelementuseraccesses dataelementuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementuseraccesses
    ADD CONSTRAINT dataelementuseraccesses_pkey PRIMARY KEY (dataelementid, useraccessid);


--
-- Name: dataelementusergroupaccesses dataelementusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementusergroupaccesses
    ADD CONSTRAINT dataelementusergroupaccesses_pkey PRIMARY KEY (dataelementid, usergroupaccessid);


--
-- Name: dataentryform dataentryform_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataentryform
    ADD CONSTRAINT dataentryform_pkey PRIMARY KEY (dataentryformid);


--
-- Name: datainputperiod datainputperiod_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datainputperiod
    ADD CONSTRAINT datainputperiod_pkey PRIMARY KEY (datainputperiodid);


--
-- Name: dataset dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT dataset_pkey PRIMARY KEY (datasetid);


--
-- Name: datasetattributevalues datasetattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetattributevalues
    ADD CONSTRAINT datasetattributevalues_pkey PRIMARY KEY (datasetid, attributevalueid);


--
-- Name: datasetelement datasetelement_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetelement
    ADD CONSTRAINT datasetelement_pkey PRIMARY KEY (datasetelementid);


--
-- Name: datasetelement datasetelement_unique_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetelement
    ADD CONSTRAINT datasetelement_unique_key UNIQUE (datasetid, dataelementid);


--
-- Name: datasetindicators datasetindicators_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetindicators
    ADD CONSTRAINT datasetindicators_pkey PRIMARY KEY (datasetid, indicatorid);


--
-- Name: datasetlegendsets datasetlegendsets_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetlegendsets
    ADD CONSTRAINT datasetlegendsets_pkey PRIMARY KEY (datasetid, sort_order);


--
-- Name: datasetnotification_datasets datasetnotification_datasets_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotification_datasets
    ADD CONSTRAINT datasetnotification_datasets_pkey PRIMARY KEY (datasetnotificationtemplateid, datasetid);


--
-- Name: datasetnotificationtemplate datasetnotificationtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotificationtemplate
    ADD CONSTRAINT datasetnotificationtemplate_pkey PRIMARY KEY (datasetnotificationtemplateid);


--
-- Name: datasetoperands datasetoperands_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetoperands
    ADD CONSTRAINT datasetoperands_pkey PRIMARY KEY (datasetid, dataelementoperandid);


--
-- Name: datasetsource datasetsource_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetsource
    ADD CONSTRAINT datasetsource_pkey PRIMARY KEY (datasetid, sourceid);


--
-- Name: datasetuseraccesses datasetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetuseraccesses
    ADD CONSTRAINT datasetuseraccesses_pkey PRIMARY KEY (datasetid, useraccessid);


--
-- Name: datasetusergroupaccesses datasetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetusergroupaccesses
    ADD CONSTRAINT datasetusergroupaccesses_pkey PRIMARY KEY (datasetid, usergroupaccessid);


--
-- Name: datastatistics datastatistics_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datastatistics
    ADD CONSTRAINT datastatistics_pkey PRIMARY KEY (statisticsid);


--
-- Name: datastatisticsevent datastatisticsevent_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datastatisticsevent
    ADD CONSTRAINT datastatisticsevent_pkey PRIMARY KEY (eventid);


--
-- Name: datavalue datavalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalue
    ADD CONSTRAINT datavalue_pkey PRIMARY KEY (dataelementid, periodid, sourceid, categoryoptioncomboid, attributeoptioncomboid);


--
-- Name: datavalueaudit datavalueaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalueaudit
    ADD CONSTRAINT datavalueaudit_pkey PRIMARY KEY (datavalueauditid);


--
-- Name: deletedobject deletedobject_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.deletedobject
    ADD CONSTRAINT deletedobject_pkey PRIMARY KEY (deletedobjectid);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (documentid);


--
-- Name: documentattributevalues documentattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentattributevalues
    ADD CONSTRAINT documentattributevalues_pkey PRIMARY KEY (documentid, attributevalueid);


--
-- Name: documentuseraccesses documentuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentuseraccesses
    ADD CONSTRAINT documentuseraccesses_pkey PRIMARY KEY (documentid, useraccessid);


--
-- Name: documentusergroupaccesses documentusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentusergroupaccesses
    ADD CONSTRAINT documentusergroupaccesses_pkey PRIMARY KEY (documentid, usergroupaccessid);


--
-- Name: eventchart_attributedimensions eventchart_attributedimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_attributedimensions
    ADD CONSTRAINT eventchart_attributedimensions_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_categorydimensions eventchart_categorydimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_categorydimensions
    ADD CONSTRAINT eventchart_categorydimensions_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_categoryoptiongroupsetdimensions eventchart_categoryoptiongroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_categoryoptiongroupsetdimensions
    ADD CONSTRAINT eventchart_categoryoptiongroupsetdimensions_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_columns eventchart_columns_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_columns
    ADD CONSTRAINT eventchart_columns_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_dataelementdimensions eventchart_dataelementdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_dataelementdimensions
    ADD CONSTRAINT eventchart_dataelementdimensions_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_filters eventchart_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_filters
    ADD CONSTRAINT eventchart_filters_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_itemorgunitgroups eventchart_itemorgunitgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_itemorgunitgroups
    ADD CONSTRAINT eventchart_itemorgunitgroups_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_organisationunits eventchart_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_organisationunits
    ADD CONSTRAINT eventchart_organisationunits_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_orgunitgroupsetdimensions eventchart_orgunitgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_orgunitgroupsetdimensions
    ADD CONSTRAINT eventchart_orgunitgroupsetdimensions_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_orgunitlevels eventchart_orgunitlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_orgunitlevels
    ADD CONSTRAINT eventchart_orgunitlevels_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_periods eventchart_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_periods
    ADD CONSTRAINT eventchart_periods_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart eventchart_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT eventchart_pkey PRIMARY KEY (eventchartid);


--
-- Name: eventchart_programindicatordimensions eventchart_programindicatordimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_programindicatordimensions
    ADD CONSTRAINT eventchart_programindicatordimensions_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchart_rows eventchart_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_rows
    ADD CONSTRAINT eventchart_rows_pkey PRIMARY KEY (eventchartid, sort_order);


--
-- Name: eventchartuseraccesses eventchartuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartuseraccesses
    ADD CONSTRAINT eventchartuseraccesses_pkey PRIMARY KEY (eventchartid, useraccessid);


--
-- Name: eventchartusergroupaccesses eventchartusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartusergroupaccesses
    ADD CONSTRAINT eventchartusergroupaccesses_pkey PRIMARY KEY (eventchartid, usergroupaccessid);


--
-- Name: eventreport_attributedimensions eventreport_attributedimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_attributedimensions
    ADD CONSTRAINT eventreport_attributedimensions_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_categorydimensions eventreport_categorydimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_categorydimensions
    ADD CONSTRAINT eventreport_categorydimensions_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_categoryoptiongroupsetdimensions eventreport_categoryoptiongroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_categoryoptiongroupsetdimensions
    ADD CONSTRAINT eventreport_categoryoptiongroupsetdimensions_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_columns eventreport_columns_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_columns
    ADD CONSTRAINT eventreport_columns_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_dataelementdimensions eventreport_dataelementdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_dataelementdimensions
    ADD CONSTRAINT eventreport_dataelementdimensions_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_filters eventreport_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_filters
    ADD CONSTRAINT eventreport_filters_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_itemorgunitgroups eventreport_itemorgunitgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_itemorgunitgroups
    ADD CONSTRAINT eventreport_itemorgunitgroups_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_organisationunits eventreport_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_organisationunits
    ADD CONSTRAINT eventreport_organisationunits_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_orgunitgroupsetdimensions eventreport_orgunitgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_orgunitgroupsetdimensions
    ADD CONSTRAINT eventreport_orgunitgroupsetdimensions_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_orgunitlevels eventreport_orgunitlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_orgunitlevels
    ADD CONSTRAINT eventreport_orgunitlevels_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_periods eventreport_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_periods
    ADD CONSTRAINT eventreport_periods_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport eventreport_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT eventreport_pkey PRIMARY KEY (eventreportid);


--
-- Name: eventreport_programindicatordimensions eventreport_programindicatordimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_programindicatordimensions
    ADD CONSTRAINT eventreport_programindicatordimensions_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreport_rows eventreport_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_rows
    ADD CONSTRAINT eventreport_rows_pkey PRIMARY KEY (eventreportid, sort_order);


--
-- Name: eventreportuseraccesses eventreportuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportuseraccesses
    ADD CONSTRAINT eventreportuseraccesses_pkey PRIMARY KEY (eventreportid, useraccessid);


--
-- Name: eventreportusergroupaccesses eventreportusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportusergroupaccesses
    ADD CONSTRAINT eventreportusergroupaccesses_pkey PRIMARY KEY (eventreportid, usergroupaccessid);


--
-- Name: expression expression_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.expression
    ADD CONSTRAINT expression_pkey PRIMARY KEY (expressionid);


--
-- Name: externalfileresource externalfileresource_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalfileresource
    ADD CONSTRAINT externalfileresource_pkey PRIMARY KEY (externalfileresourceid);


--
-- Name: externalmaplayer externalmaplayer_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT externalmaplayer_pkey PRIMARY KEY (externalmaplayerid);


--
-- Name: externalmaplayeruseraccesses externalmaplayeruseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayeruseraccesses
    ADD CONSTRAINT externalmaplayeruseraccesses_pkey PRIMARY KEY (externalmaplayerid, useraccessid);


--
-- Name: externalmaplayerusergroupaccesses externalmaplayerusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayerusergroupaccesses
    ADD CONSTRAINT externalmaplayerusergroupaccesses_pkey PRIMARY KEY (externalmaplayerid, usergroupaccessid);


--
-- Name: externalnotificationlogentry externalnotificationlogentry_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalnotificationlogentry
    ADD CONSTRAINT externalnotificationlogentry_pkey PRIMARY KEY (externalnotificationlogentryid);


--
-- Name: fileresource fileresource_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.fileresource
    ADD CONSTRAINT fileresource_pkey PRIMARY KEY (fileresourceid);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: i18nlocale i18nlocale_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.i18nlocale
    ADD CONSTRAINT i18nlocale_pkey PRIMARY KEY (i18nlocaleid);


--
-- Name: incomingsms incomingsms_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.incomingsms
    ADD CONSTRAINT incomingsms_pkey PRIMARY KEY (id);


--
-- Name: indicator indicator_code_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT indicator_code_key UNIQUE (code);


--
-- Name: indicator indicator_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT indicator_pkey PRIMARY KEY (indicatorid);


--
-- Name: indicatorattributevalues indicatorattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorattributevalues
    ADD CONSTRAINT indicatorattributevalues_pkey PRIMARY KEY (indicatorid, attributevalueid);


--
-- Name: indicatorgroup indicatorgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroup
    ADD CONSTRAINT indicatorgroup_pkey PRIMARY KEY (indicatorgroupid);


--
-- Name: indicatorgroupattributevalues indicatorgroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupattributevalues
    ADD CONSTRAINT indicatorgroupattributevalues_pkey PRIMARY KEY (indicatorgroupid, attributevalueid);


--
-- Name: indicatorgroupmembers indicatorgroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupmembers
    ADD CONSTRAINT indicatorgroupmembers_pkey PRIMARY KEY (indicatorgroupid, indicatorid);


--
-- Name: indicatorgroupset indicatorgroupset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupset
    ADD CONSTRAINT indicatorgroupset_pkey PRIMARY KEY (indicatorgroupsetid);


--
-- Name: indicatorgroupsetmembers indicatorgroupsetmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetmembers
    ADD CONSTRAINT indicatorgroupsetmembers_pkey PRIMARY KEY (indicatorgroupsetid, sort_order);


--
-- Name: indicatorgroupsetuseraccesses indicatorgroupsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetuseraccesses
    ADD CONSTRAINT indicatorgroupsetuseraccesses_pkey PRIMARY KEY (indicatorgroupsetid, useraccessid);


--
-- Name: indicatorgroupsetusergroupaccesses indicatorgroupsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetusergroupaccesses
    ADD CONSTRAINT indicatorgroupsetusergroupaccesses_pkey PRIMARY KEY (indicatorgroupsetid, usergroupaccessid);


--
-- Name: indicatorgroupuseraccesses indicatorgroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupuseraccesses
    ADD CONSTRAINT indicatorgroupuseraccesses_pkey PRIMARY KEY (indicatorgroupid, useraccessid);


--
-- Name: indicatorgroupusergroupaccesses indicatorgroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupusergroupaccesses
    ADD CONSTRAINT indicatorgroupusergroupaccesses_pkey PRIMARY KEY (indicatorgroupid, usergroupaccessid);


--
-- Name: indicatorlegendsets indicatorlegendsets_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorlegendsets
    ADD CONSTRAINT indicatorlegendsets_pkey PRIMARY KEY (indicatorid, sort_order);


--
-- Name: indicatortype indicatortype_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatortype
    ADD CONSTRAINT indicatortype_pkey PRIMARY KEY (indicatortypeid);


--
-- Name: indicatoruseraccesses indicatoruseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatoruseraccesses
    ADD CONSTRAINT indicatoruseraccesses_pkey PRIMARY KEY (indicatorid, useraccessid);


--
-- Name: indicatorusergroupaccesses indicatorusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorusergroupaccesses
    ADD CONSTRAINT indicatorusergroupaccesses_pkey PRIMARY KEY (indicatorid, usergroupaccessid);


--
-- Name: intepretation_likedby intepretation_likedby_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.intepretation_likedby
    ADD CONSTRAINT intepretation_likedby_pkey PRIMARY KEY (interpretationid, userid);


--
-- Name: interpretation_comments interpretation_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation_comments
    ADD CONSTRAINT interpretation_comments_pkey PRIMARY KEY (interpretationid, sort_order);


--
-- Name: interpretation interpretation_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT interpretation_pkey PRIMARY KEY (interpretationid);


--
-- Name: interpretationcomment interpretationcomment_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationcomment
    ADD CONSTRAINT interpretationcomment_pkey PRIMARY KEY (interpretationcommentid);


--
-- Name: interpretationuseraccesses interpretationuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationuseraccesses
    ADD CONSTRAINT interpretationuseraccesses_pkey PRIMARY KEY (interpretationid, useraccessid);


--
-- Name: interpretationusergroupaccesses interpretationusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationusergroupaccesses
    ADD CONSTRAINT interpretationusergroupaccesses_pkey PRIMARY KEY (interpretationid, usergroupaccessid);


--
-- Name: jobconfiguration jobconfiguration_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.jobconfiguration
    ADD CONSTRAINT jobconfiguration_pkey PRIMARY KEY (jobconfigurationid);


--
-- Name: deletedobject key_deleted_object_klass_uid; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.deletedobject
    ADD CONSTRAINT key_deleted_object_klass_uid UNIQUE (klass, uid);


--
-- Name: section key_sectionnamedataset; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT key_sectionnamedataset UNIQUE (name, datasetid);


--
-- Name: keyjsonvalue keyjsonvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalue
    ADD CONSTRAINT keyjsonvalue_pkey PRIMARY KEY (keyjsonvalueid);


--
-- Name: keyjsonvalue keyjsonvalue_unique_key_in_namespace; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalue
    ADD CONSTRAINT keyjsonvalue_unique_key_in_namespace UNIQUE (namespace, namespacekey);


--
-- Name: keyjsonvalueuseraccesses keyjsonvalueuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalueuseraccesses
    ADD CONSTRAINT keyjsonvalueuseraccesses_pkey PRIMARY KEY (keyjsonvalueid, useraccessid);


--
-- Name: keyjsonvalueusergroupaccesses keyjsonvalueusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalueusergroupaccesses
    ADD CONSTRAINT keyjsonvalueusergroupaccesses_pkey PRIMARY KEY (keyjsonvalueid, usergroupaccessid);


--
-- Name: legendsetattributevalues legendsetattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetattributevalues
    ADD CONSTRAINT legendsetattributevalues_pkey PRIMARY KEY (legendsetid, attributevalueid);


--
-- Name: legendsetuseraccesses legendsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetuseraccesses
    ADD CONSTRAINT legendsetuseraccesses_pkey PRIMARY KEY (maplegendsetid, useraccessid);


--
-- Name: legendsetusergroupaccesses legendsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetusergroupaccesses
    ADD CONSTRAINT legendsetusergroupaccesses_pkey PRIMARY KEY (maplegendsetid, usergroupaccessid);


--
-- Name: lockexception lockexception_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.lockexception
    ADD CONSTRAINT lockexception_pkey PRIMARY KEY (lockexceptionid);


--
-- Name: map map_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.map
    ADD CONSTRAINT map_pkey PRIMARY KEY (mapid);


--
-- Name: maplegend maplegend_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegend
    ADD CONSTRAINT maplegend_pkey PRIMARY KEY (maplegendid);


--
-- Name: maplegendset maplegendset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegendset
    ADD CONSTRAINT maplegendset_pkey PRIMARY KEY (maplegendsetid);


--
-- Name: mapmapviews mapmapviews_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapmapviews
    ADD CONSTRAINT mapmapviews_pkey PRIMARY KEY (mapid, sort_order);


--
-- Name: mapuseraccesses mapuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapuseraccesses
    ADD CONSTRAINT mapuseraccesses_pkey PRIMARY KEY (mapid, useraccessid);


--
-- Name: mapusergroupaccesses mapusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapusergroupaccesses
    ADD CONSTRAINT mapusergroupaccesses_pkey PRIMARY KEY (mapid, usergroupaccessid);


--
-- Name: mapview_attributedimensions mapview_attributedimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_attributedimensions
    ADD CONSTRAINT mapview_attributedimensions_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_categorydimensions mapview_categorydimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_categorydimensions
    ADD CONSTRAINT mapview_categorydimensions_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_categoryoptiongroupsetdimensions mapview_categoryoptiongroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_categoryoptiongroupsetdimensions
    ADD CONSTRAINT mapview_categoryoptiongroupsetdimensions_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_columns mapview_columns_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_columns
    ADD CONSTRAINT mapview_columns_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_datadimensionitems mapview_datadimensionitems_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_datadimensionitems
    ADD CONSTRAINT mapview_datadimensionitems_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_dataelementdimensions mapview_dataelementdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_dataelementdimensions
    ADD CONSTRAINT mapview_dataelementdimensions_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_filters mapview_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_filters
    ADD CONSTRAINT mapview_filters_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_itemorgunitgroups mapview_itemorgunitgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_itemorgunitgroups
    ADD CONSTRAINT mapview_itemorgunitgroups_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_organisationunits mapview_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_organisationunits
    ADD CONSTRAINT mapview_organisationunits_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_orgunitgroupsetdimensions mapview_orgunitgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_orgunitgroupsetdimensions
    ADD CONSTRAINT mapview_orgunitgroupsetdimensions_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_orgunitlevels mapview_orgunitlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_orgunitlevels
    ADD CONSTRAINT mapview_orgunitlevels_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview_periods mapview_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_periods
    ADD CONSTRAINT mapview_periods_pkey PRIMARY KEY (mapviewid, sort_order);


--
-- Name: mapview mapview_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT mapview_pkey PRIMARY KEY (mapviewid);


--
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (messageid);


--
-- Name: messageattachments messageattachments_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageattachments
    ADD CONSTRAINT messageattachments_pkey PRIMARY KEY (messageid, fileresourceid);


--
-- Name: messageconversation_messages messageconversation_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_messages
    ADD CONSTRAINT messageconversation_messages_pkey PRIMARY KEY (messageconversationid, sort_order);


--
-- Name: messageconversation messageconversation_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation
    ADD CONSTRAINT messageconversation_pkey PRIMARY KEY (messageconversationid);


--
-- Name: messageconversation_usermessages messageconversation_usermessages_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_usermessages
    ADD CONSTRAINT messageconversation_usermessages_pkey PRIMARY KEY (messageconversationid, usermessageid);


--
-- Name: metadataaudit metadataaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataaudit
    ADD CONSTRAINT metadataaudit_pkey PRIMARY KEY (metadataauditid);


--
-- Name: metadataversion metadataversion_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataversion
    ADD CONSTRAINT metadataversion_pkey PRIMARY KEY (versionid);


--
-- Name: minmaxdataelement minmaxdataelement_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.minmaxdataelement
    ADD CONSTRAINT minmaxdataelement_pkey PRIMARY KEY (minmaxdataelementid);


--
-- Name: minmaxdataelement minmaxdataelement_unique_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.minmaxdataelement
    ADD CONSTRAINT minmaxdataelement_unique_key UNIQUE (sourceid, dataelementid, categoryoptioncomboid);


--
-- Name: oauth2client oauth2client_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT oauth2client_pkey PRIMARY KEY (oauth2clientid);


--
-- Name: oauth2clientgranttypes oauth2clientgranttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2clientgranttypes
    ADD CONSTRAINT oauth2clientgranttypes_pkey PRIMARY KEY (oauth2clientid, sort_order);


--
-- Name: oauth2clientredirecturis oauth2clientredirecturis_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2clientredirecturis
    ADD CONSTRAINT oauth2clientredirecturis_pkey PRIMARY KEY (oauth2clientid, sort_order);


--
-- Name: oauth_access_token oauth_access_token_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth_access_token
    ADD CONSTRAINT oauth_access_token_pkey PRIMARY KEY (authentication_id);


--
-- Name: objecttranslation objecttranslation_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.objecttranslation
    ADD CONSTRAINT objecttranslation_pkey PRIMARY KEY (objecttranslationid);


--
-- Name: optionattributevalues optionattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionattributevalues
    ADD CONSTRAINT optionattributevalues_pkey PRIMARY KEY (optionvalueid, attributevalueid);


--
-- Name: optiongroup optiongroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT optiongroup_pkey PRIMARY KEY (optiongroupid);


--
-- Name: optiongroupattributevalues optiongroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupattributevalues
    ADD CONSTRAINT optiongroupattributevalues_pkey PRIMARY KEY (optiongroupid, attributevalueid);


--
-- Name: optiongroupmembers optiongroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupmembers
    ADD CONSTRAINT optiongroupmembers_pkey PRIMARY KEY (optiongroupid, optionid);


--
-- Name: optiongroupset optiongroupset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT optiongroupset_pkey PRIMARY KEY (optiongroupsetid);


--
-- Name: optiongroupsetmembers optiongroupsetmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetmembers
    ADD CONSTRAINT optiongroupsetmembers_pkey PRIMARY KEY (optiongroupsetid, sort_order);


--
-- Name: optiongroupsetuseraccesses optiongroupsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetuseraccesses
    ADD CONSTRAINT optiongroupsetuseraccesses_pkey PRIMARY KEY (optiongroupsetid, useraccessid);


--
-- Name: optiongroupsetusergroupaccesses optiongroupsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetusergroupaccesses
    ADD CONSTRAINT optiongroupsetusergroupaccesses_pkey PRIMARY KEY (optiongroupsetid, usergroupaccessid);


--
-- Name: optiongroupuseraccesses optiongroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupuseraccesses
    ADD CONSTRAINT optiongroupuseraccesses_pkey PRIMARY KEY (optiongroupid, useraccessid);


--
-- Name: optiongroupusergroupaccesses optiongroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupusergroupaccesses
    ADD CONSTRAINT optiongroupusergroupaccesses_pkey PRIMARY KEY (optiongroupid, usergroupaccessid);


--
-- Name: optionset optionset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionset
    ADD CONSTRAINT optionset_pkey PRIMARY KEY (optionsetid);


--
-- Name: optionsetattributevalues optionsetattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetattributevalues
    ADD CONSTRAINT optionsetattributevalues_pkey PRIMARY KEY (optionsetid, attributevalueid);


--
-- Name: optionsetuseraccesses optionsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetuseraccesses
    ADD CONSTRAINT optionsetuseraccesses_pkey PRIMARY KEY (optionsetid, useraccessid);


--
-- Name: optionsetusergroupaccesses optionsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetusergroupaccesses
    ADD CONSTRAINT optionsetusergroupaccesses_pkey PRIMARY KEY (optionsetid, usergroupaccessid);


--
-- Name: optionvalue optionvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionvalue
    ADD CONSTRAINT optionvalue_pkey PRIMARY KEY (optionvalueid);


--
-- Name: organisationunit organisationunit_code_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT organisationunit_code_key UNIQUE (code);


--
-- Name: organisationunit organisationunit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT organisationunit_pkey PRIMARY KEY (organisationunitid);


--
-- Name: organisationunitattributevalues organisationunitattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunitattributevalues
    ADD CONSTRAINT organisationunitattributevalues_pkey PRIMARY KEY (organisationunitid, attributevalueid);


--
-- Name: orgunitgroup orgunitgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT orgunitgroup_name_key UNIQUE (name);


--
-- Name: orgunitgroup orgunitgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT orgunitgroup_pkey PRIMARY KEY (orgunitgroupid);


--
-- Name: orgunitgroupattributevalues orgunitgroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupattributevalues
    ADD CONSTRAINT orgunitgroupattributevalues_pkey PRIMARY KEY (orgunitgroupid, attributevalueid);


--
-- Name: orgunitgroupmembers orgunitgroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupmembers
    ADD CONSTRAINT orgunitgroupmembers_pkey PRIMARY KEY (orgunitgroupid, organisationunitid);


--
-- Name: orgunitgroupset orgunitgroupset_name_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT orgunitgroupset_name_key UNIQUE (name);


--
-- Name: orgunitgroupset orgunitgroupset_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT orgunitgroupset_pkey PRIMARY KEY (orgunitgroupsetid);


--
-- Name: orgunitgroupsetattributevalues orgunitgroupsetattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetattributevalues
    ADD CONSTRAINT orgunitgroupsetattributevalues_pkey PRIMARY KEY (orgunitgroupsetid, attributevalueid);


--
-- Name: orgunitgroupsetdimension_items orgunitgroupsetdimension_items_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetdimension_items
    ADD CONSTRAINT orgunitgroupsetdimension_items_pkey PRIMARY KEY (orgunitgroupsetdimensionid, sort_order);


--
-- Name: orgunitgroupsetdimension orgunitgroupsetdimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetdimension
    ADD CONSTRAINT orgunitgroupsetdimension_pkey PRIMARY KEY (orgunitgroupsetdimensionid);


--
-- Name: orgunitgroupsetmembers orgunitgroupsetmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetmembers
    ADD CONSTRAINT orgunitgroupsetmembers_pkey PRIMARY KEY (orgunitgroupsetid, orgunitgroupid);


--
-- Name: orgunitgroupsetuseraccesses orgunitgroupsetuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetuseraccesses
    ADD CONSTRAINT orgunitgroupsetuseraccesses_pkey PRIMARY KEY (orgunitgroupsetid, useraccessid);


--
-- Name: orgunitgroupsetusergroupaccesses orgunitgroupsetusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetusergroupaccesses
    ADD CONSTRAINT orgunitgroupsetusergroupaccesses_pkey PRIMARY KEY (orgunitgroupsetid, usergroupaccessid);


--
-- Name: orgunitgroupuseraccesses orgunitgroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupuseraccesses
    ADD CONSTRAINT orgunitgroupuseraccesses_pkey PRIMARY KEY (orgunitgroupid, useraccessid);


--
-- Name: orgunitgroupusergroupaccesses orgunitgroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupusergroupaccesses
    ADD CONSTRAINT orgunitgroupusergroupaccesses_pkey PRIMARY KEY (orgunitgroupid, usergroupaccessid);


--
-- Name: orgunitlevel orgunitlevel_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitlevel
    ADD CONSTRAINT orgunitlevel_pkey PRIMARY KEY (orgunitlevelid);


--
-- Name: outbound_sms outbound_sms_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.outbound_sms
    ADD CONSTRAINT outbound_sms_pkey PRIMARY KEY (id);


--
-- Name: period period_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.period
    ADD CONSTRAINT period_pkey PRIMARY KEY (periodid);


--
-- Name: periodboundary periodboundary_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodboundary
    ADD CONSTRAINT periodboundary_pkey PRIMARY KEY (periodboundaryid);


--
-- Name: periodtype periodtype_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodtype
    ADD CONSTRAINT periodtype_pkey PRIMARY KEY (periodtypeid);


--
-- Name: potentialduplicate potentialduplicate_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.potentialduplicate
    ADD CONSTRAINT potentialduplicate_pkey PRIMARY KEY (potentialduplicateid);


--
-- Name: potentialduplicate potentialduplicate_teia_teib; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.potentialduplicate
    ADD CONSTRAINT potentialduplicate_teia_teib UNIQUE (teia, teib);


--
-- Name: potentialduplicate potentialduplicate_uid_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.potentialduplicate
    ADD CONSTRAINT potentialduplicate_uid_key UNIQUE (uid);


--
-- Name: predictor predictor_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT predictor_pkey PRIMARY KEY (predictorid);


--
-- Name: predictorgroup predictorgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroup
    ADD CONSTRAINT predictorgroup_pkey PRIMARY KEY (predictorgroupid);


--
-- Name: predictorgroupmembers predictorgroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupmembers
    ADD CONSTRAINT predictorgroupmembers_pkey PRIMARY KEY (predictorgroupid, predictorid);


--
-- Name: predictorgroupuseraccesses predictorgroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupuseraccesses
    ADD CONSTRAINT predictorgroupuseraccesses_pkey PRIMARY KEY (predictorgroupid, useraccessid);


--
-- Name: predictorgroupusergroupaccesses predictorgroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupusergroupaccesses
    ADD CONSTRAINT predictorgroupusergroupaccesses_pkey PRIMARY KEY (predictorgroupid, usergroupaccessid);


--
-- Name: predictororgunitlevels predictororgunitlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictororgunitlevels
    ADD CONSTRAINT predictororgunitlevels_pkey PRIMARY KEY (predictorid, orgunitlevelid);


--
-- Name: previouspasswords previouspasswords_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.previouspasswords
    ADD CONSTRAINT previouspasswords_pkey PRIMARY KEY (userid, list_index);


--
-- Name: program_attribute_group program_attribute_group_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attribute_group
    ADD CONSTRAINT program_attribute_group_pkey PRIMARY KEY (programtrackedentityattributegroupid);


--
-- Name: program_attributes program_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT program_attributes_pkey PRIMARY KEY (programtrackedentityattributeid);


--
-- Name: program_organisationunits program_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_organisationunits
    ADD CONSTRAINT program_organisationunits_pkey PRIMARY KEY (programid, organisationunitid);


--
-- Name: program program_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (programid);


--
-- Name: programattributevalues programattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programattributevalues
    ADD CONSTRAINT programattributevalues_pkey PRIMARY KEY (programid, attributevalueid);


--
-- Name: programexpression programexpression_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programexpression
    ADD CONSTRAINT programexpression_pkey PRIMARY KEY (programexpressionid);


--
-- Name: programindicator programindicator_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT programindicator_pkey PRIMARY KEY (programindicatorid);


--
-- Name: programindicatorattributevalues programindicatorattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorattributevalues
    ADD CONSTRAINT programindicatorattributevalues_pkey PRIMARY KEY (programindicatorid, attributevalueid);


--
-- Name: programindicatorgroup programindicatorgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroup
    ADD CONSTRAINT programindicatorgroup_pkey PRIMARY KEY (programindicatorgroupid);


--
-- Name: programindicatorgroupattributevalues programindicatorgroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupattributevalues
    ADD CONSTRAINT programindicatorgroupattributevalues_pkey PRIMARY KEY (programindicatorgroupid, attributevalueid);


--
-- Name: programindicatorgroupmembers programindicatorgroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupmembers
    ADD CONSTRAINT programindicatorgroupmembers_pkey PRIMARY KEY (programindicatorgroupid, programindicatorid);


--
-- Name: programindicatorgroupuseraccesses programindicatorgroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupuseraccesses
    ADD CONSTRAINT programindicatorgroupuseraccesses_pkey PRIMARY KEY (programindicatorgroupid, useraccessid);


--
-- Name: programindicatorgroupusergroupaccesses programindicatorgroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupusergroupaccesses
    ADD CONSTRAINT programindicatorgroupusergroupaccesses_pkey PRIMARY KEY (programindicatorgroupid, usergroupaccessid);


--
-- Name: programindicatorlegendsets programindicatorlegendsets_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorlegendsets
    ADD CONSTRAINT programindicatorlegendsets_pkey PRIMARY KEY (programindicatorid, sort_order);


--
-- Name: programindicatoruseraccesses programindicatoruseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatoruseraccesses
    ADD CONSTRAINT programindicatoruseraccesses_pkey PRIMARY KEY (programindicatorid, useraccessid);


--
-- Name: programindicatorusergroupaccesses programindicatorusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorusergroupaccesses
    ADD CONSTRAINT programindicatorusergroupaccesses_pkey PRIMARY KEY (programindicatorid, usergroupaccessid);


--
-- Name: programinstance_messageconversation programinstance_messageconversation_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance_messageconversation
    ADD CONSTRAINT programinstance_messageconversation_pkey PRIMARY KEY (programinstanceid, sort_order);


--
-- Name: programinstance programinstance_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance
    ADD CONSTRAINT programinstance_pkey PRIMARY KEY (programinstanceid);


--
-- Name: programinstanceaudit programinstanceaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstanceaudit
    ADD CONSTRAINT programinstanceaudit_pkey PRIMARY KEY (programinstanceauditid);


--
-- Name: programinstancecomments programinstancecomments_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstancecomments
    ADD CONSTRAINT programinstancecomments_pkey PRIMARY KEY (programinstanceid, sort_order);


--
-- Name: programmessage programmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT programmessage_pkey PRIMARY KEY (id);


--
-- Name: programnotificationinstance programnotificationinstance_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT programnotificationinstance_pkey PRIMARY KEY (programnotificationinstanceid);


--
-- Name: programnotificationtemplate programnotificationtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT programnotificationtemplate_pkey PRIMARY KEY (programnotificationtemplateid);


--
-- Name: programownershiphistory programownershiphistory_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programownershiphistory
    ADD CONSTRAINT programownershiphistory_pkey PRIMARY KEY (programownershiphistoryid);


--
-- Name: programrule programrule_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrule
    ADD CONSTRAINT programrule_pkey PRIMARY KEY (programruleid);


--
-- Name: programruleaction programruleaction_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT programruleaction_pkey PRIMARY KEY (programruleactionid);


--
-- Name: programrulevariable programrulevariable_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT programrulevariable_pkey PRIMARY KEY (programrulevariableid);


--
-- Name: programsection_attributes programsection_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection_attributes
    ADD CONSTRAINT programsection_attributes_pkey PRIMARY KEY (programsectionid, sort_order);


--
-- Name: programsection programsection_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection
    ADD CONSTRAINT programsection_pkey PRIMARY KEY (programsectionid);


--
-- Name: programstage programstage_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT programstage_pkey PRIMARY KEY (programstageid);


--
-- Name: programstageattributevalues programstageattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageattributevalues
    ADD CONSTRAINT programstageattributevalues_pkey PRIMARY KEY (programstageid, attributevalueid);


--
-- Name: programstagedataelement programstagedataelement_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT programstagedataelement_pkey PRIMARY KEY (programstagedataelementid);


--
-- Name: programstagedataelement programstagedataelement_unique_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT programstagedataelement_unique_key UNIQUE (programstageid, dataelementid);


--
-- Name: programstageinstance_messageconversation programstageinstance_messageconversation_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance_messageconversation
    ADD CONSTRAINT programstageinstance_messageconversation_pkey PRIMARY KEY (programstageinstanceid, sort_order);


--
-- Name: programstageinstance programstageinstance_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT programstageinstance_pkey PRIMARY KEY (programstageinstanceid);


--
-- Name: programstageinstancecomments programstageinstancecomments_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancecomments
    ADD CONSTRAINT programstageinstancecomments_pkey PRIMARY KEY (programstageinstanceid, sort_order);


--
-- Name: programstageinstancefilter programstageinstancefilter_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilter
    ADD CONSTRAINT programstageinstancefilter_pkey PRIMARY KEY (programstageinstancefilterid);


--
-- Name: programstageinstancefilteruseraccesses programstageinstancefilteruseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilteruseraccesses
    ADD CONSTRAINT programstageinstancefilteruseraccesses_pkey PRIMARY KEY (programstageinstancefilterid, useraccessid);


--
-- Name: programstageinstancefilterusergroupaccesses programstageinstancefilterusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilterusergroupaccesses
    ADD CONSTRAINT programstageinstancefilterusergroupaccesses_pkey PRIMARY KEY (programstageinstancefilterid, usergroupaccessid);


--
-- Name: programstagesection_dataelements programstagesection_dataelements_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection_dataelements
    ADD CONSTRAINT programstagesection_dataelements_pkey PRIMARY KEY (programstagesectionid, sort_order);


--
-- Name: programstagesection programstagesection_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection
    ADD CONSTRAINT programstagesection_pkey PRIMARY KEY (programstagesectionid);


--
-- Name: programstagesection_programindicators programstagesection_programindicators_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection_programindicators
    ADD CONSTRAINT programstagesection_programindicators_pkey PRIMARY KEY (programstagesectionid, sort_order);


--
-- Name: programstageuseraccesses programstageuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageuseraccesses
    ADD CONSTRAINT programstageuseraccesses_pkey PRIMARY KEY (programstageid, useraccessid);


--
-- Name: programstageusergroupaccesses programstageusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageusergroupaccesses
    ADD CONSTRAINT programstageusergroupaccesses_pkey PRIMARY KEY (programid, usergroupaccessid);


--
-- Name: programtempownershipaudit programtempownershipaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programtempownershipaudit
    ADD CONSTRAINT programtempownershipaudit_pkey PRIMARY KEY (programtempownershipauditid);


--
-- Name: program_attributes programtrackedentityattribute_unique_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT programtrackedentityattribute_unique_key UNIQUE (programid, trackedentityattributeid);


--
-- Name: programtrackedentityattributegroupmembers programtrackedentityattributegroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programtrackedentityattributegroupmembers
    ADD CONSTRAINT programtrackedentityattributegroupmembers_pkey PRIMARY KEY (programtrackedentityattributeid, programtrackedentityattributegroupid);


--
-- Name: programuseraccesses programuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programuseraccesses
    ADD CONSTRAINT programuseraccesses_pkey PRIMARY KEY (programid, useraccessid);


--
-- Name: programusergroupaccesses programusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programusergroupaccesses
    ADD CONSTRAINT programusergroupaccesses_pkey PRIMARY KEY (programid, usergroupaccessid);


--
-- Name: pushanalysis pushanalysis_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysis
    ADD CONSTRAINT pushanalysis_pkey PRIMARY KEY (pushanalysisid);


--
-- Name: pushanalysisrecipientusergroups pushanalysisrecipientusergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysisrecipientusergroups
    ADD CONSTRAINT pushanalysisrecipientusergroups_pkey PRIMARY KEY (usergroupid, elt);


--
-- Name: relationship relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT relationship_pkey PRIMARY KEY (relationshipid);


--
-- Name: relationshipconstraint relationshipconstraint_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipconstraint
    ADD CONSTRAINT relationshipconstraint_pkey PRIMARY KEY (relationshipconstraintid);


--
-- Name: relationshipitem relationshipitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipitem
    ADD CONSTRAINT relationshipitem_pkey PRIMARY KEY (relationshipitemid);


--
-- Name: relationshiptype relationshiptype_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT relationshiptype_pkey PRIMARY KEY (relationshiptypeid);


--
-- Name: relationshiptypeuseraccesses relationshiptypeuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeuseraccesses
    ADD CONSTRAINT relationshiptypeuseraccesses_pkey PRIMARY KEY (relationshiptypeid, useraccessid);


--
-- Name: relationshiptypeusergroupaccesses relationshiptypeusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeusergroupaccesses
    ADD CONSTRAINT relationshiptypeusergroupaccesses_pkey PRIMARY KEY (relationshiptypeid, usergroupaccessid);


--
-- Name: relativeperiods relativeperiods_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relativeperiods
    ADD CONSTRAINT relativeperiods_pkey PRIMARY KEY (relativeperiodsid);


--
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (reportid);


--
-- Name: reporttable_categorydimensions reporttable_categorydimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_categorydimensions
    ADD CONSTRAINT reporttable_categorydimensions_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_categoryoptiongroupsetdimensions reporttable_categoryoptiongroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_categoryoptiongroupsetdimensions
    ADD CONSTRAINT reporttable_categoryoptiongroupsetdimensions_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_columns reporttable_columns_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_columns
    ADD CONSTRAINT reporttable_columns_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_datadimensionitems reporttable_datadimensionitems_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_datadimensionitems
    ADD CONSTRAINT reporttable_datadimensionitems_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_dataelementgroupsetdimensions reporttable_dataelementgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_dataelementgroupsetdimensions
    ADD CONSTRAINT reporttable_dataelementgroupsetdimensions_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_filters reporttable_filters_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_filters
    ADD CONSTRAINT reporttable_filters_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_itemorgunitgroups reporttable_itemorgunitgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_itemorgunitgroups
    ADD CONSTRAINT reporttable_itemorgunitgroups_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_organisationunits reporttable_organisationunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_organisationunits
    ADD CONSTRAINT reporttable_organisationunits_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_orgunitgroupsetdimensions reporttable_orgunitgroupsetdimensions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_orgunitgroupsetdimensions
    ADD CONSTRAINT reporttable_orgunitgroupsetdimensions_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_orgunitlevels reporttable_orgunitlevels_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_orgunitlevels
    ADD CONSTRAINT reporttable_orgunitlevels_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable_periods reporttable_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_periods
    ADD CONSTRAINT reporttable_periods_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttable reporttable_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT reporttable_pkey PRIMARY KEY (reporttableid);


--
-- Name: reporttable_rows reporttable_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_rows
    ADD CONSTRAINT reporttable_rows_pkey PRIMARY KEY (reporttableid, sort_order);


--
-- Name: reporttableuseraccesses reporttableuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableuseraccesses
    ADD CONSTRAINT reporttableuseraccesses_pkey PRIMARY KEY (reporttableid, useraccessid);


--
-- Name: reporttableusergroupaccesses reporttableusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableusergroupaccesses
    ADD CONSTRAINT reporttableusergroupaccesses_pkey PRIMARY KEY (reporttableid, usergroupaccessid);


--
-- Name: reportuseraccesses reportuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportuseraccesses
    ADD CONSTRAINT reportuseraccesses_pkey PRIMARY KEY (reportid, useraccessid);


--
-- Name: reportusergroupaccesses reportusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportusergroupaccesses
    ADD CONSTRAINT reportusergroupaccesses_pkey PRIMARY KEY (reportid, usergroupaccessid);


--
-- Name: reservedvalue reservedvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reservedvalue
    ADD CONSTRAINT reservedvalue_pkey PRIMARY KEY (reservedvalueid);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (sectionid);


--
-- Name: sectionattributevalues sectionattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionattributevalues
    ADD CONSTRAINT sectionattributevalues_pkey PRIMARY KEY (sectionid, attributevalueid);


--
-- Name: sectiondataelements sectiondataelements_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectiondataelements
    ADD CONSTRAINT sectiondataelements_pkey PRIMARY KEY (sectionid, sort_order);


--
-- Name: sectiongreyedfields sectiongreyedfields_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectiongreyedfields
    ADD CONSTRAINT sectiongreyedfields_pkey PRIMARY KEY (sectionid, dataelementoperandid);


--
-- Name: sectionindicators sectionindicators_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionindicators
    ADD CONSTRAINT sectionindicators_pkey PRIMARY KEY (sectionid, sort_order);


--
-- Name: sequentialnumbercounter sequentialnumbercounter_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sequentialnumbercounter
    ADD CONSTRAINT sequentialnumbercounter_pkey PRIMARY KEY (id);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (seriesid);


--
-- Name: smscodes smscodes_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscodes
    ADD CONSTRAINT smscodes_pkey PRIMARY KEY (smscodeid);


--
-- Name: smscommandcodes smscommandcodes_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandcodes
    ADD CONSTRAINT smscommandcodes_pkey PRIMARY KEY (id, codeid);


--
-- Name: smscommands smscommands_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommands
    ADD CONSTRAINT smscommands_pkey PRIMARY KEY (smscommandid);


--
-- Name: smscommandspecialcharacters smscommandspecialcharacters_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandspecialcharacters
    ADD CONSTRAINT smscommandspecialcharacters_pkey PRIMARY KEY (smscommandid, specialcharacterid);


--
-- Name: smsspecialcharacter smsspecialcharacter_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smsspecialcharacter
    ADD CONSTRAINT smsspecialcharacter_pkey PRIMARY KEY (specialcharacterid);


--
-- Name: sqlview sqlview_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlview
    ADD CONSTRAINT sqlview_pkey PRIMARY KEY (sqlviewid);


--
-- Name: sqlviewattributevalues sqlviewattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewattributevalues
    ADD CONSTRAINT sqlviewattributevalues_pkey PRIMARY KEY (sqlviewid, attributevalueid);


--
-- Name: sqlviewuseraccesses sqlviewuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewuseraccesses
    ADD CONSTRAINT sqlviewuseraccesses_pkey PRIMARY KEY (sqlviewid, useraccessid);


--
-- Name: sqlviewusergroupaccesses sqlviewusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewusergroupaccesses
    ADD CONSTRAINT sqlviewusergroupaccesses_pkey PRIMARY KEY (sqlviewid, usergroupaccessid);


--
-- Name: systemsetting systemsetting_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.systemsetting
    ADD CONSTRAINT systemsetting_pkey PRIMARY KEY (systemsettingid);


--
-- Name: tablehook tablehook_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.tablehook
    ADD CONSTRAINT tablehook_pkey PRIMARY KEY (analyticstablehookid);


--
-- Name: trackedentityattribute trackedentityattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT trackedentityattribute_pkey PRIMARY KEY (trackedentityattributeid);


--
-- Name: trackedentityattributeattributevalues trackedentityattributeattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeattributevalues
    ADD CONSTRAINT trackedentityattributeattributevalues_pkey PRIMARY KEY (trackedentityattributeid, attributevalueid);


--
-- Name: trackedentityattributedimension trackedentityattributedimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributedimension
    ADD CONSTRAINT trackedentityattributedimension_pkey PRIMARY KEY (trackedentityattributedimensionid);


--
-- Name: trackedentityattributelegendsets trackedentityattributelegendsets_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributelegendsets
    ADD CONSTRAINT trackedentityattributelegendsets_pkey PRIMARY KEY (trackedentityattributeid, sort_order);


--
-- Name: trackedentityattributeuseraccesses trackedentityattributeuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeuseraccesses
    ADD CONSTRAINT trackedentityattributeuseraccesses_pkey PRIMARY KEY (trackedentityattributeid, useraccessid);


--
-- Name: trackedentityattributeusergroupaccesses trackedentityattributeusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeusergroupaccesses
    ADD CONSTRAINT trackedentityattributeusergroupaccesses_pkey PRIMARY KEY (trackedentityattributeid, usergroupaccessid);


--
-- Name: trackedentityattributevalue trackedentityattributevalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributevalue
    ADD CONSTRAINT trackedentityattributevalue_pkey PRIMARY KEY (trackedentityinstanceid, trackedentityattributeid);


--
-- Name: trackedentityattributevalueaudit trackedentityattributevalueaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributevalueaudit
    ADD CONSTRAINT trackedentityattributevalueaudit_pkey PRIMARY KEY (trackedentityattributevalueauditid);


--
-- Name: trackedentitycomment trackedentitycomment_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitycomment
    ADD CONSTRAINT trackedentitycomment_pkey PRIMARY KEY (trackedentitycommentid);


--
-- Name: trackedentitydataelementdimension trackedentitydataelementdimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitydataelementdimension
    ADD CONSTRAINT trackedentitydataelementdimension_pkey PRIMARY KEY (trackedentitydataelementdimensionid);


--
-- Name: trackedentitydatavalueaudit trackedentitydatavalueaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitydatavalueaudit
    ADD CONSTRAINT trackedentitydatavalueaudit_pkey PRIMARY KEY (trackedentitydatavalueauditid);


--
-- Name: trackedentityinstance trackedentityinstance_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstance
    ADD CONSTRAINT trackedentityinstance_pkey PRIMARY KEY (trackedentityinstanceid);


--
-- Name: trackedentityinstanceaudit trackedentityinstanceaudit_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstanceaudit
    ADD CONSTRAINT trackedentityinstanceaudit_pkey PRIMARY KEY (trackedentityinstanceauditid);


--
-- Name: trackedentityinstancefilter trackedentityinstancefilter_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstancefilter
    ADD CONSTRAINT trackedentityinstancefilter_pkey PRIMARY KEY (trackedentityinstancefilterid);


--
-- Name: trackedentityprogramindicatordimension trackedentityprogramindicatordimension_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramindicatordimension
    ADD CONSTRAINT trackedentityprogramindicatordimension_pkey PRIMARY KEY (trackedentityprogramindicatordimensionid);


--
-- Name: trackedentityprogramowner trackedentityprogramowner_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramowner
    ADD CONSTRAINT trackedentityprogramowner_pkey PRIMARY KEY (trackedentityprogramownerid);


--
-- Name: trackedentitytype trackedentitytype_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytype
    ADD CONSTRAINT trackedentitytype_pkey PRIMARY KEY (trackedentitytypeid);


--
-- Name: trackedentitytypeattribute trackedentitytypeattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattribute
    ADD CONSTRAINT trackedentitytypeattribute_pkey PRIMARY KEY (trackedentitytypeattributeid);


--
-- Name: trackedentitytypeattributevalues trackedentitytypeattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattributevalues
    ADD CONSTRAINT trackedentitytypeattributevalues_pkey PRIMARY KEY (trackedentitytypeid, attributevalueid);


--
-- Name: trackedentitytypeuseraccesses trackedentitytypeuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeuseraccesses
    ADD CONSTRAINT trackedentitytypeuseraccesses_pkey PRIMARY KEY (trackedentitytypeid, useraccessid);


--
-- Name: trackedentitytypeusergroupaccesses trackedentitytypeusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeusergroupaccesses
    ADD CONSTRAINT trackedentitytypeusergroupaccesses_pkey PRIMARY KEY (trackedentitytypeid, usergroupaccessid);


--
-- Name: trackedentitytypeattribute uk_10sblshxcb7dd4qi3s879u35h; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattribute
    ADD CONSTRAINT uk_10sblshxcb7dd4qi3s879u35h UNIQUE (uid);


--
-- Name: validationrule uk_13x63e3skbl5qj4mc1qgq2xex; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT uk_13x63e3skbl5qj4mc1qgq2xex UNIQUE (code);


--
-- Name: attribute uk_1774shfid1uaopl9tu8am19fq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT uk_1774shfid1uaopl9tu8am19fq UNIQUE (code);


--
-- Name: optionvalue uk_18b68rcofdwt1sbr6rf55poog; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionvalue
    ADD CONSTRAINT uk_18b68rcofdwt1sbr6rf55poog UNIQUE (uid);


--
-- Name: chartusergroupaccesses uk_191y3j7pfufwrenbd2h9q3pek; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartusergroupaccesses
    ADD CONSTRAINT uk_191y3j7pfufwrenbd2h9q3pek UNIQUE (usergroupaccessid);


--
-- Name: optiongroupuseraccesses uk_1bfr83at04owfxcj0ihpju132; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupuseraccesses
    ADD CONSTRAINT uk_1bfr83at04owfxcj0ihpju132 UNIQUE (useraccessid);


--
-- Name: mapview uk_1dw8gju4leg7iud4gpsr5r1ng; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT uk_1dw8gju4leg7iud4gpsr5r1ng UNIQUE (uid);


--
-- Name: dataelementcategory uk_1ev6xqtcsfr4wv6rel0lkg44n; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategory
    ADD CONSTRAINT uk_1ev6xqtcsfr4wv6rel0lkg44n UNIQUE (uid);


--
-- Name: optiongroupsetmembers uk_1film7lsn5m1wyeku7yh5anfa; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetmembers
    ADD CONSTRAINT uk_1film7lsn5m1wyeku7yh5anfa UNIQUE (optiongroupid);


--
-- Name: report uk_1ie06vhy3begtwuuvrv0f71se; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT uk_1ie06vhy3begtwuuvrv0f71se UNIQUE (uid);


--
-- Name: validationrulegroup uk_1lvk8ftq028jrr28qouou9q3c; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroup
    ADD CONSTRAINT uk_1lvk8ftq028jrr28qouou9q3c UNIQUE (code);


--
-- Name: programstageinstancecomments uk_1n7xvxj0jupob5f2v86cv8qer; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancecomments
    ADD CONSTRAINT uk_1n7xvxj0jupob5f2v86cv8qer UNIQUE (trackedentitycommentid);


--
-- Name: programusergroupaccesses uk_1naq88t24viefq6h7lcx3lbx4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programusergroupaccesses
    ADD CONSTRAINT uk_1naq88t24viefq6h7lcx3lbx4 UNIQUE (usergroupaccessid);


--
-- Name: programmessage uk_1qlw3rts2pog96ye7r6fqd122; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT uk_1qlw3rts2pog96ye7r6fqd122 UNIQUE (uid);


--
-- Name: chart uk_1sp445tglu49hyfwokjqn5bf6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT uk_1sp445tglu49hyfwokjqn5bf6 UNIQUE (uid);


--
-- Name: dataelementgroupset uk_1xk8j7j0a3li8o0ukblanosky; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupset
    ADD CONSTRAINT uk_1xk8j7j0a3li8o0ukblanosky UNIQUE (name);


--
-- Name: programstagesection uk_22wt9yk9idujmywno44v9qf66; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection
    ADD CONSTRAINT uk_22wt9yk9idujmywno44v9qf66 UNIQUE (code);


--
-- Name: documentuseraccesses uk_284n4lyg7j1g56mab44dyikvx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentuseraccesses
    ADD CONSTRAINT uk_284n4lyg7j1g56mab44dyikvx UNIQUE (useraccessid);


--
-- Name: categoryoptiongroupattributevalues uk_287ampe6pn4aepyn14hv71907; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupattributevalues
    ADD CONSTRAINT uk_287ampe6pn4aepyn14hv71907 UNIQUE (attributevalueid);


--
-- Name: optiongroupset uk_2boebaetgus89t1k8nn4dac65; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT uk_2boebaetgus89t1k8nn4dac65 UNIQUE (uid);


--
-- Name: dataapprovalleveluseraccesses uk_2dhynycj6yhlt3p2a4lfnxi1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalleveluseraccesses
    ADD CONSTRAINT uk_2dhynycj6yhlt3p2a4lfnxi1 UNIQUE (useraccessid);


--
-- Name: programstagedataelement uk_2ejl9l5vm4rhtqj8eit31g0u6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT uk_2ejl9l5vm4rhtqj8eit31g0u6 UNIQUE (code);


--
-- Name: relationship uk_2gbm9ji77snuoll07yvpgj3o5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT uk_2gbm9ji77snuoll07yvpgj3o5 UNIQUE (to_relationshipitemid);


--
-- Name: i18nlocale uk_2l0ovv74pjtairmeyiwy4i2ui; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.i18nlocale
    ADD CONSTRAINT uk_2l0ovv74pjtairmeyiwy4i2ui UNIQUE (uid);


--
-- Name: dataelement uk_2nhc265rlfu3dlc3qouvjdprl; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT uk_2nhc265rlfu3dlc3qouvjdprl UNIQUE (name);


--
-- Name: programindicatorgroup uk_2p9x16ryxtek0g6bqwd49et0c; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroup
    ADD CONSTRAINT uk_2p9x16ryxtek0g6bqwd49et0c UNIQUE (uid);


--
-- Name: programnotificationtemplate uk_2pimmculf9ttu2dxquomb9ram; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT uk_2pimmculf9ttu2dxquomb9ram UNIQUE (uid);


--
-- Name: dataapprovallevel uk_2r18tvmbtksk69j35uxpwej44; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT uk_2r18tvmbtksk69j35uxpwej44 UNIQUE (code);


--
-- Name: indicatorgroupuseraccesses uk_2rwitpm8stv7hpn3jlyc2sagd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupuseraccesses
    ADD CONSTRAINT uk_2rwitpm8stv7hpn3jlyc2sagd UNIQUE (useraccessid);


--
-- Name: userkeyjsonvalue uk_2ubxwwtgyqd0h2mvy46u3prfq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userkeyjsonvalue
    ADD CONSTRAINT uk_2ubxwwtgyqd0h2mvy46u3prfq UNIQUE (code);


--
-- Name: reservedvalue uk_2utuk3clxif3qi4icy859kdrb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reservedvalue
    ADD CONSTRAINT uk_2utuk3clxif3qi4icy859kdrb UNIQUE (ownerobject, owneruid, key, value);


--
-- Name: legendsetattributevalues uk_35yuroxg610mvtf39u4atl2wv; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetattributevalues
    ADD CONSTRAINT uk_35yuroxg610mvtf39u4atl2wv UNIQUE (attributevalueid);


--
-- Name: map uk_37l2m3o1xfuagpki90gfh5kqb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.map
    ADD CONSTRAINT uk_37l2m3o1xfuagpki90gfh5kqb UNIQUE (code);


--
-- Name: categorycombo uk_3a4ee92kxafw85hsopq4qle47; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombo
    ADD CONSTRAINT uk_3a4ee92kxafw85hsopq4qle47 UNIQUE (code);


--
-- Name: programruleaction uk_3c2n8db21er764e4skh3qg57w; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT uk_3c2n8db21er764e4skh3qg57w UNIQUE (uid);


--
-- Name: validationrulegroup uk_3cl2o6ha8naw5w6my3q4el6gk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroup
    ADD CONSTRAINT uk_3cl2o6ha8naw5w6my3q4el6gk UNIQUE (name);


--
-- Name: dashboarditem uk_3idqsvkpmxpehxqv615s952vd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT uk_3idqsvkpmxpehxqv615s952vd UNIQUE (uid);


--
-- Name: orgunitgroup uk_3phvecdmy2msmcpitqifpcy3c; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT uk_3phvecdmy2msmcpitqifpcy3c UNIQUE (code);


--
-- Name: dataelement uk_3r6dr8m9qwa89afngtr43x9jh; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT uk_3r6dr8m9qwa89afngtr43x9jh UNIQUE (uid);


--
-- Name: dataapprovalworkflow uk_3svwn20y9qda34bmatesg5c0j; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT uk_3svwn20y9qda34bmatesg5c0j UNIQUE (code);


--
-- Name: categoryoptiongroupsetusergroupaccesses uk_3tn4w8rs68lpvrdaksbsalta7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetusergroupaccesses
    ADD CONSTRAINT uk_3tn4w8rs68lpvrdaksbsalta7 UNIQUE (usergroupaccessid);


--
-- Name: orgunitgroupsetusergroupaccesses uk_3uh2stfqjquour25m5gjfdroi; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetusergroupaccesses
    ADD CONSTRAINT uk_3uh2stfqjquour25m5gjfdroi UNIQUE (usergroupaccessid);


--
-- Name: trackedentityattributeusergroupaccesses uk_3va2lo93o5x8of9r244sb0ini; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeusergroupaccesses
    ADD CONSTRAINT uk_3va2lo93o5x8of9r244sb0ini UNIQUE (usergroupaccessid);


--
-- Name: programmessage uk_3vgkycs0lsgpxaqtytfijr1ji; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT uk_3vgkycs0lsgpxaqtytfijr1ji UNIQUE (code);


--
-- Name: reporttableuseraccesses uk_3wailhtvswifioim376gn0u9c; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableuseraccesses
    ADD CONSTRAINT uk_3wailhtvswifioim376gn0u9c UNIQUE (useraccessid);


--
-- Name: programindicator uk_4372w9f7asbu1ybpduj2xqjmt; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT uk_4372w9f7asbu1ybpduj2xqjmt UNIQUE (shortname);


--
-- Name: interpretationuseraccesses uk_46w0ywaj13n29eoi9767grqyc; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationuseraccesses
    ADD CONSTRAINT uk_46w0ywaj13n29eoi9767grqyc UNIQUE (useraccessid);


--
-- Name: report uk_478bg522jkn8460hkeshlw1j1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT uk_478bg522jkn8460hkeshlw1j1 UNIQUE (relativeperiodsid);


--
-- Name: program_attribute_group uk_48xfoqrfjnkuay28xeixjm0t0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attribute_group
    ADD CONSTRAINT uk_48xfoqrfjnkuay28xeixjm0t0 UNIQUE (code);


--
-- Name: predictor uk_4b97sdsm2p477cc05eody10lm; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT uk_4b97sdsm2p477cc05eody10lm UNIQUE (name);


--
-- Name: tablehook uk_4bcigh7ivtiraxnhqrg72tldo; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.tablehook
    ADD CONSTRAINT uk_4bcigh7ivtiraxnhqrg72tldo UNIQUE (code);


--
-- Name: fileresource uk_4dlqoc6s8ilws9yhacy5qkddb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.fileresource
    ADD CONSTRAINT uk_4dlqoc6s8ilws9yhacy5qkddb UNIQUE (code);


--
-- Name: periodboundary uk_4e9t02lypy6ynejqfegixx36k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodboundary
    ADD CONSTRAINT uk_4e9t02lypy6ynejqfegixx36k UNIQUE (uid);


--
-- Name: validationruleusergroupaccesses uk_4edmqjfna3lc6gyjkh1h2a5fo; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleusergroupaccesses
    ADD CONSTRAINT uk_4edmqjfna3lc6gyjkh1h2a5fo UNIQUE (usergroupaccessid);


--
-- Name: relationshiptypeuseraccesses uk_4fs8ej52e7hfl9wonyo553mvn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeuseraccesses
    ADD CONSTRAINT uk_4fs8ej52e7hfl9wonyo553mvn UNIQUE (useraccessid);


--
-- Name: trackedentitytype uk_4iylxmooa7ca562qvw4tjq5ys; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytype
    ADD CONSTRAINT uk_4iylxmooa7ca562qvw4tjq5ys UNIQUE (uid);


--
-- Name: userkeyjsonvalue uk_4k3a3mf7dgr4b2btftg5jkmt7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userkeyjsonvalue
    ADD CONSTRAINT uk_4k3a3mf7dgr4b2btftg5jkmt7 UNIQUE (uid);


--
-- Name: programnotificationinstance uk_4mi7q6tbreuo0hspppxyodibk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT uk_4mi7q6tbreuo0hspppxyodibk UNIQUE (code);


--
-- Name: program_attribute_group uk_4n6nev8dlydiyu5k8xyjtsasl; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attribute_group
    ADD CONSTRAINT uk_4n6nev8dlydiyu5k8xyjtsasl UNIQUE (name);


--
-- Name: programindicatorgroupattributevalues uk_4p7hvngancp6mtolp00nhgqy1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupattributevalues
    ADD CONSTRAINT uk_4p7hvngancp6mtolp00nhgqy1 UNIQUE (attributevalueid);


--
-- Name: dataelementcategoryoption uk_4pi5lfmisrt8un89dnb17xrdy; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT uk_4pi5lfmisrt8un89dnb17xrdy UNIQUE (uid);


--
-- Name: optionsetattributevalues uk_4sfn84gjcjre8ni3ofvhmkkvk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetattributevalues
    ADD CONSTRAINT uk_4sfn84gjcjre8ni3ofvhmkkvk UNIQUE (attributevalueid);


--
-- Name: indicatorgroupsetuseraccesses uk_4t108a6tjlba547s5i5j4vuhe; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetuseraccesses
    ADD CONSTRAINT uk_4t108a6tjlba547s5i5j4vuhe UNIQUE (useraccessid);


--
-- Name: indicatorgroupusergroupaccesses uk_4wluhhaibua3a52cts7jnrt5b; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupusergroupaccesses
    ADD CONSTRAINT uk_4wluhhaibua3a52cts7jnrt5b UNIQUE (usergroupaccessid);


--
-- Name: sqlview uk_50aqn6tun6lt4u3ablvdxgoi6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlview
    ADD CONSTRAINT uk_50aqn6tun6lt4u3ablvdxgoi6 UNIQUE (code);


--
-- Name: categoryoptiongroupsetuseraccesses uk_5159yqcajy9bc6urj5fqpg8q6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetuseraccesses
    ADD CONSTRAINT uk_5159yqcajy9bc6urj5fqpg8q6 UNIQUE (useraccessid);


--
-- Name: dataelementcategoryuseraccesses uk_579c6m0lb755obiwg8ahswans; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryuseraccesses
    ADD CONSTRAINT uk_579c6m0lb755obiwg8ahswans UNIQUE (useraccessid);


--
-- Name: externalmaplayer uk_581ayy658kxytmijcfd2rxnq0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT uk_581ayy658kxytmijcfd2rxnq0 UNIQUE (name);


--
-- Name: programindicator uk_59abitsfd3u0jx4ntrrblven0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT uk_59abitsfd3u0jx4ntrrblven0 UNIQUE (uid);


--
-- Name: userroleuseraccesses uk_5gnagy6dnux0xeucxi4phuyb2; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleuseraccesses
    ADD CONSTRAINT uk_5gnagy6dnux0xeucxi4phuyb2 UNIQUE (useraccessid);


--
-- Name: documentattributevalues uk_5iwcc2c18pxom1nom9sxvo22f; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentattributevalues
    ADD CONSTRAINT uk_5iwcc2c18pxom1nom9sxvo22f UNIQUE (attributevalueid);


--
-- Name: orgunitlevel uk_5km0xiwk0dg7pnoru5yfvqsdo; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitlevel
    ADD CONSTRAINT uk_5km0xiwk0dg7pnoru5yfvqsdo UNIQUE (uid);


--
-- Name: mapuseraccesses uk_5mg3p351cswnu4jy7avcoqoo5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapuseraccesses
    ADD CONSTRAINT uk_5mg3p351cswnu4jy7avcoqoo5 UNIQUE (useraccessid);


--
-- Name: dataapprovallevel uk_5mq4bmpyevmr1ddkkopweted1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT uk_5mq4bmpyevmr1ddkkopweted1 UNIQUE (name);


--
-- Name: constantattributevalues uk_5tawpr2nfe6985n4j6f72ic3d; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantattributevalues
    ADD CONSTRAINT uk_5tawpr2nfe6985n4j6f72ic3d UNIQUE (attributevalueid);


--
-- Name: categoryoptioncomboattributevalues uk_5umlmoegw88nokw32ya6aa7y7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncomboattributevalues
    ADD CONSTRAINT uk_5umlmoegw88nokw32ya6aa7y7 UNIQUE (attributevalueid);


--
-- Name: eventchart uk_5w429v9hdlvivan4a69x3ntx5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT uk_5w429v9hdlvivan4a69x3ntx5 UNIQUE (relativeperiodsid);


--
-- Name: categoryoptioncombo uk_60p9gh2un0pb7l9tctfd4o3b3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombo
    ADD CONSTRAINT uk_60p9gh2un0pb7l9tctfd4o3b3 UNIQUE (code);


--
-- Name: usergroupattributevalues uk_61yelmsucg67isxc2habccq57; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupattributevalues
    ADD CONSTRAINT uk_61yelmsucg67isxc2habccq57 UNIQUE (attributevalueid);


--
-- Name: externalmaplayer uk_64w4wa4oc3hkxo86hjo63cd1x; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT uk_64w4wa4oc3hkxo86hjo63cd1x UNIQUE (uid);


--
-- Name: tablehook uk_668dyd20363ufr44a805inegm; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.tablehook
    ADD CONSTRAINT uk_668dyd20363ufr44a805inegm UNIQUE (name);


--
-- Name: eventchart uk_679r4uoqpust6h694bed8nrh9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT uk_679r4uoqpust6h694bed8nrh9 UNIQUE (uid);


--
-- Name: validationruleattributevalues uk_67u5rhhpw3jxqws0uovnpakfq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleattributevalues
    ADD CONSTRAINT uk_67u5rhhpw3jxqws0uovnpakfq UNIQUE (attributevalueid);


--
-- Name: externalmaplayerusergroupaccesses uk_6d4hr4t1x8yyflsr8qo0addv0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayerusergroupaccesses
    ADD CONSTRAINT uk_6d4hr4t1x8yyflsr8qo0addv0 UNIQUE (usergroupaccessid);


--
-- Name: eventchart uk_6dyim42vl218i9e9waqrvw36k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT uk_6dyim42vl218i9e9waqrvw36k UNIQUE (code);


--
-- Name: indicatorusergroupaccesses uk_6gnwbmpissx2s1manr6bwxriu; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorusergroupaccesses
    ADD CONSTRAINT uk_6gnwbmpissx2s1manr6bwxriu UNIQUE (usergroupaccessid);


--
-- Name: dataapprovalworkflowusergroupaccesses uk_6hh8abnhp5bf53rgf2r2maxgb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowusergroupaccesses
    ADD CONSTRAINT uk_6hh8abnhp5bf53rgf2r2maxgb UNIQUE (usergroupaccessid);


--
-- Name: optiongroupsetusergroupaccesses uk_6ihtl75oib36uu3ga3k4ngg8p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetusergroupaccesses
    ADD CONSTRAINT uk_6ihtl75oib36uu3ga3k4ngg8p UNIQUE (usergroupaccessid);


--
-- Name: categoryoptiongroupset uk_6itpx2frqt3msln8p32rk7qta; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupset
    ADD CONSTRAINT uk_6itpx2frqt3msln8p32rk7qta UNIQUE (uid);


--
-- Name: trackedentitytypeattribute uk_6lycqfymeu4sdi4t3cdh6ul1k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattribute
    ADD CONSTRAINT uk_6lycqfymeu4sdi4t3cdh6ul1k UNIQUE (code);


--
-- Name: optiongroup uk_6ni8qsiimdcy626hwls002flo; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT uk_6ni8qsiimdcy626hwls002flo UNIQUE (name);


--
-- Name: mapview uk_6nm3ynkrtuj01bpo1uwcryq06; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT uk_6nm3ynkrtuj01bpo1uwcryq06 UNIQUE (code);


--
-- Name: indicatorattributevalues uk_6sq5y5hpb4kqf2fmas69rql3g; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorattributevalues
    ADD CONSTRAINT uk_6sq5y5hpb4kqf2fmas69rql3g UNIQUE (attributevalueid);


--
-- Name: dataelementgroup uk_6x37lph70r5mh15a71pf1tj17; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT uk_6x37lph70r5mh15a71pf1tj17 UNIQUE (shortname);


--
-- Name: users uk_71vrxovabe8x9tom8xwefi3e7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_71vrxovabe8x9tom8xwefi3e7 UNIQUE (code);


--
-- Name: relationship uk_74iy11sx99wxaut3skkphkvgi; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT uk_74iy11sx99wxaut3skkphkvgi UNIQUE (uid);


--
-- Name: dashboardusergroupaccesses uk_75d35u3n0i5wea6bevn7v6t3l; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboardusergroupaccesses
    ADD CONSTRAINT uk_75d35u3n0i5wea6bevn7v6t3l UNIQUE (usergroupaccessid);


--
-- Name: tablehook uk_78x5lua91w1j6upu02wh8pfx9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.tablehook
    ADD CONSTRAINT uk_78x5lua91w1j6upu02wh8pfx9 UNIQUE (uid);


--
-- Name: relationship uk_799tkjg7am2injr1dypaidt4p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT uk_799tkjg7am2injr1dypaidt4p UNIQUE (code);


--
-- Name: programindicatorgroup uk_7carnwjb5dtsk6i5dn43wy9ck; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroup
    ADD CONSTRAINT uk_7carnwjb5dtsk6i5dn43wy9ck UNIQUE (name);


--
-- Name: reporttable uk_7if26yibpw5hn2gjsrn2xst0m; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT uk_7if26yibpw5hn2gjsrn2xst0m UNIQUE (uid);


--
-- Name: programrule uk_7odx4uo6s5bg55kt1fxky4a8v; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrule
    ADD CONSTRAINT uk_7odx4uo6s5bg55kt1fxky4a8v UNIQUE (code);


--
-- Name: legendsetuseraccesses uk_7q3ox6ciav6meerfx8p810xq4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetuseraccesses
    ADD CONSTRAINT uk_7q3ox6ciav6meerfx8p810xq4 UNIQUE (useraccessid);


--
-- Name: relationshiptype uk_7rnfvkitq6l0kr5ju2slxopfi; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT uk_7rnfvkitq6l0kr5ju2slxopfi UNIQUE (uid);


--
-- Name: reportuseraccesses uk_7s9ykqwrxm1yj8gck13f3vusg; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportuseraccesses
    ADD CONSTRAINT uk_7s9ykqwrxm1yj8gck13f3vusg UNIQUE (useraccessid);


--
-- Name: programindicator uk_7udjng39j4ddafjn57r58v7oq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT uk_7udjng39j4ddafjn57r58v7oq UNIQUE (name);


--
-- Name: optionset uk_81gfx3yt7ngwmkk0t8qgcovhi; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionset
    ADD CONSTRAINT uk_81gfx3yt7ngwmkk0t8qgcovhi UNIQUE (uid);


--
-- Name: maplegendset uk_842ips1xb81udqc3dw5uax7u5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegendset
    ADD CONSTRAINT uk_842ips1xb81udqc3dw5uax7u5 UNIQUE (name);


--
-- Name: colorset_colors uk_84a9xamm9l60e6179ehh35pqj; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset_colors
    ADD CONSTRAINT uk_84a9xamm9l60e6179ehh35pqj UNIQUE (colorid);


--
-- Name: programsection uk_84abcabq3so8ktgt726o5du9d; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection
    ADD CONSTRAINT uk_84abcabq3so8ktgt726o5du9d UNIQUE (uid);


--
-- Name: validationnotificationtemplate uk_87wso1e1xtxsl34nxey6nr922; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate
    ADD CONSTRAINT uk_87wso1e1xtxsl34nxey6nr922 UNIQUE (code);


--
-- Name: validationrulegroup uk_8alvmsgu0onl4i0a0sqb6mqx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroup
    ADD CONSTRAINT uk_8alvmsgu0onl4i0a0sqb6mqx UNIQUE (uid);


--
-- Name: relationshiptype uk_8d4xrx2gygb4aivpcwrp613hj; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT uk_8d4xrx2gygb4aivpcwrp613hj UNIQUE (name);


--
-- Name: indicatortype uk_8dcmrupnoi7hiiom466aoa2y; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatortype
    ADD CONSTRAINT uk_8dcmrupnoi7hiiom466aoa2y UNIQUE (code);


--
-- Name: mapview uk_8eyremdx683wcd9owh1t5jufs; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT uk_8eyremdx683wcd9owh1t5jufs UNIQUE (relativeperiodsid);


--
-- Name: programindicatoruseraccesses uk_8tntx482dq1xv37o2nurja8el; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatoruseraccesses
    ADD CONSTRAINT uk_8tntx482dq1xv37o2nurja8el UNIQUE (useraccessid);


--
-- Name: trackedentitycomment uk_8ul0w6gi3mdnr0kficn5syigg; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitycomment
    ADD CONSTRAINT uk_8ul0w6gi3mdnr0kficn5syigg UNIQUE (code);


--
-- Name: externalfileresource uk_8v1lxgqdnnocvm9ah6clxmjf; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalfileresource
    ADD CONSTRAINT uk_8v1lxgqdnnocvm9ah6clxmjf UNIQUE (code);


--
-- Name: programindicatorattributevalues uk_90celfj5neh3vkjxvyrct48a8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorattributevalues
    ADD CONSTRAINT uk_90celfj5neh3vkjxvyrct48a8 UNIQUE (attributevalueid);


--
-- Name: dataelement uk_94srnunkibylfaxt4knxfn58e; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT uk_94srnunkibylfaxt4knxfn58e UNIQUE (code);


--
-- Name: constantusergroupaccesses uk_9a0eh0b7g9invjjs34nuvntkd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantusergroupaccesses
    ADD CONSTRAINT uk_9a0eh0b7g9invjjs34nuvntkd UNIQUE (usergroupaccessid);


--
-- Name: eventchartuseraccesses uk_9an2md6lmqpube8hr0u3hie8c; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartuseraccesses
    ADD CONSTRAINT uk_9an2md6lmqpube8hr0u3hie8c UNIQUE (useraccessid);


--
-- Name: optionsetusergroupaccesses uk_9bk8wrffte75y236jgv1pmp81; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetusergroupaccesses
    ADD CONSTRAINT uk_9bk8wrffte75y236jgv1pmp81 UNIQUE (usergroupaccessid);


--
-- Name: maplegend uk_9csrw908a1fvfwbhjwm0jfl4e; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegend
    ADD CONSTRAINT uk_9csrw908a1fvfwbhjwm0jfl4e UNIQUE (uid);


--
-- Name: section uk_9hvlbsw019hscf35xb5behfx9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT uk_9hvlbsw019hscf35xb5behfx9 UNIQUE (code);


--
-- Name: i18nlocale uk_9j6xjgegveyc0uqs506yy2wrp; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.i18nlocale
    ADD CONSTRAINT uk_9j6xjgegveyc0uqs506yy2wrp UNIQUE (locale);


--
-- Name: metadataversion uk_9k7bv5o2ut4t0unxcwfyf1ay0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataversion
    ADD CONSTRAINT uk_9k7bv5o2ut4t0unxcwfyf1ay0 UNIQUE (code);


--
-- Name: attribute uk_9mqbhximifdn1n8ru52lan3fw; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT uk_9mqbhximifdn1n8ru52lan3fw UNIQUE (uid);


--
-- Name: chart uk_9nbu5m63pd0n13liu13i3nvb5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT uk_9nbu5m63pd0n13liu13i3nvb5 UNIQUE (relativeperiodsid);


--
-- Name: dataelementuseraccesses uk_9up7rgxw54tb7oqm27geuwu5l; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementuseraccesses
    ADD CONSTRAINT uk_9up7rgxw54tb7oqm27geuwu5l UNIQUE (useraccessid);


--
-- Name: validationrule uk_9ut6k8m3216v5kjcryy7d2y9w; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT uk_9ut6k8m3216v5kjcryy7d2y9w UNIQUE (name);


--
-- Name: programstageinstance uk_9ydk6ypaj0xdjoyo1d5asap3m; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT uk_9ydk6ypaj0xdjoyo1d5asap3m UNIQUE (code);


--
-- Name: section uk_a50otc0l2chm0heii6scpit4k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT uk_a50otc0l2chm0heii6scpit4k UNIQUE (uid);


--
-- Name: programuseraccesses uk_a888yk2ttuq4bc23fegmew9l6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programuseraccesses
    ADD CONSTRAINT uk_a888yk2ttuq4bc23fegmew9l6 UNIQUE (useraccessid);


--
-- Name: indicatorgroupset uk_actuoxkkqulslxjpj5hagib9r; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupset
    ADD CONSTRAINT uk_actuoxkkqulslxjpj5hagib9r UNIQUE (code);


--
-- Name: trackedentityinstancefilter uk_acvg948kspicwqw3gmg4ehu8i; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstancefilter
    ADD CONSTRAINT uk_acvg948kspicwqw3gmg4ehu8i UNIQUE (code);


--
-- Name: optiongroupset uk_aee54nmg1ci2cpitnpiwa845p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT uk_aee54nmg1ci2cpitnpiwa845p UNIQUE (name);


--
-- Name: optiongroupattributevalues uk_akmuehu0mwreltpnwm1u3fhx9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupattributevalues
    ADD CONSTRAINT uk_akmuehu0mwreltpnwm1u3fhx9 UNIQUE (attributevalueid);


--
-- Name: dataelementgroup uk_aqbaj76r9qxmnylr6p8kj9g37; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT uk_aqbaj76r9qxmnylr6p8kj9g37 UNIQUE (name);


--
-- Name: reportusergroupaccesses uk_asp8ntgg2muwvqbs60qnm1vq7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportusergroupaccesses
    ADD CONSTRAINT uk_asp8ntgg2muwvqbs60qnm1vq7 UNIQUE (usergroupaccessid);


--
-- Name: optionsetuseraccesses uk_aukhdafc8vny241q4cbrs2wq6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetuseraccesses
    ADD CONSTRAINT uk_aukhdafc8vny241q4cbrs2wq6 UNIQUE (useraccessid);


--
-- Name: constant uk_aygjfui3fpgrsxbj6qj782h6f; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT uk_aygjfui3fpgrsxbj6qj782h6f UNIQUE (shortname);


--
-- Name: dataset uk_ayk5ey2r1fh1akknxtpcpyp9r; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT uk_ayk5ey2r1fh1akknxtpcpyp9r UNIQUE (uid);


--
-- Name: relationshiptype uk_aypbls80uca5qu23w4fbqns2f; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT uk_aypbls80uca5qu23w4fbqns2f UNIQUE (to_relationshipconstraintid);


--
-- Name: dataelementcategory uk_b0ii4jdfy88pffbapohsr2lor; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategory
    ADD CONSTRAINT uk_b0ii4jdfy88pffbapohsr2lor UNIQUE (name);


--
-- Name: reporttable uk_b39cpkfasrbt96274tbaedtmp; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT uk_b39cpkfasrbt96274tbaedtmp UNIQUE (relativeperiodsid);


--
-- Name: programstage uk_b3oan3noe4cj9dvyi0amofndv; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT uk_b3oan3noe4cj9dvyi0amofndv UNIQUE (uid);


--
-- Name: users uk_badofxhbq3oi2d4u7fj8w1kt8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_badofxhbq3oi2d4u7fj8w1kt8 UNIQUE (openid);


--
-- Name: predictorgroup uk_biaq93npnr9ho37lxo51sbt3b; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroup
    ADD CONSTRAINT uk_biaq93npnr9ho37lxo51sbt3b UNIQUE (code);


--
-- Name: categoryoptiongroupset uk_bjs0n874pj6eoag98jmeidy9a; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupset
    ADD CONSTRAINT uk_bjs0n874pj6eoag98jmeidy9a UNIQUE (code);


--
-- Name: programindicatorgroupusergroupaccesses uk_bth82tx85qdsby613om1tsnr9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupusergroupaccesses
    ADD CONSTRAINT uk_bth82tx85qdsby613om1tsnr9 UNIQUE (usergroupaccessid);


--
-- Name: externalmaplayeruseraccesses uk_btl6l2mbri9q1u35dwai97tt0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayeruseraccesses
    ADD CONSTRAINT uk_btl6l2mbri9q1u35dwai97tt0 UNIQUE (useraccessid);


--
-- Name: maplegendset uk_bv71u83esume24hp4gsaj5p4f; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegendset
    ADD CONSTRAINT uk_bv71u83esume24hp4gsaj5p4f UNIQUE (code);


--
-- Name: dataelementcategoryoptionuseraccesses uk_bwcqkilt9khfpt811w9htm1b4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionuseraccesses
    ADD CONSTRAINT uk_bwcqkilt9khfpt811w9htm1b4 UNIQUE (useraccessid);


--
-- Name: dataapprovalworkflow uk_by4pqq1ans00ffmrgqqh9ehog; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT uk_by4pqq1ans00ffmrgqqh9ehog UNIQUE (uid);


--
-- Name: organisationunitattributevalues uk_c7e1q9b728qh7iki2cvdbpfrb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunitattributevalues
    ADD CONSTRAINT uk_c7e1q9b728qh7iki2cvdbpfrb UNIQUE (attributevalueid);


--
-- Name: dashboarditem uk_c8bnosb06cchme5sig7b54uot; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT uk_c8bnosb06cchme5sig7b54uot UNIQUE (code);


--
-- Name: trackedentityattributeuseraccesses uk_c8uxqnygua12lrulfoquv3vd0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeuseraccesses
    ADD CONSTRAINT uk_c8uxqnygua12lrulfoquv3vd0 UNIQUE (useraccessid);


--
-- Name: color uk_cbnc5ktj6whhh690w32k8cyh8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.color
    ADD CONSTRAINT uk_cbnc5ktj6whhh690w32k8cyh8 UNIQUE (code);


--
-- Name: externalfileresource uk_ccwoighljmk4fy165ipnwl5n4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalfileresource
    ADD CONSTRAINT uk_ccwoighljmk4fy165ipnwl5n4 UNIQUE (uid);


--
-- Name: constantuseraccesses uk_cnegv6wpnnryw1xxn6mj8t6vn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantuseraccesses
    ADD CONSTRAINT uk_cnegv6wpnnryw1xxn6mj8t6vn UNIQUE (useraccessid);


--
-- Name: indicatoruseraccesses uk_cnl1kh7cridrd0qiq14vjxnn0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatoruseraccesses
    ADD CONSTRAINT uk_cnl1kh7cridrd0qiq14vjxnn0 UNIQUE (useraccessid);


--
-- Name: programindicatorgroupuseraccesses uk_cqq1qrt93p7ek1ux7j60y15nx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupuseraccesses
    ADD CONSTRAINT uk_cqq1qrt93p7ek1ux7j60y15nx UNIQUE (useraccessid);


--
-- Name: datastatistics uk_cswvqawieb2sfq5qsy5wpqp1k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datastatistics
    ADD CONSTRAINT uk_cswvqawieb2sfq5qsy5wpqp1k UNIQUE (code);


--
-- Name: programrulevariable uk_cto4jvd9q49voite13v0egy3i; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT uk_cto4jvd9q49voite13v0egy3i UNIQUE (code);


--
-- Name: sectionattributevalues uk_cx8oyq6i72uyvbx6qtjol9t33; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionattributevalues
    ADD CONSTRAINT uk_cx8oyq6i72uyvbx6qtjol9t33 UNIQUE (attributevalueid);


--
-- Name: programinstance uk_d3lsa2h8me94ksyp53l6rpe3g; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance
    ADD CONSTRAINT uk_d3lsa2h8me94ksyp53l6rpe3g UNIQUE (uid);


--
-- Name: metadataversion uk_d3qpxp187x8t4c1rsn64crgqu; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataversion
    ADD CONSTRAINT uk_d3qpxp187x8t4c1rsn64crgqu UNIQUE (hashcode);


--
-- Name: externalfileresource uk_d4gp8a84gn643g0r28hdnn4so; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalfileresource
    ADD CONSTRAINT uk_d4gp8a84gn643g0r28hdnn4so UNIQUE (fileresourceid);


--
-- Name: dataelementgroupusergroupaccesses uk_dfbmp0sfgkcpxtwrfw2rejumg; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupusergroupaccesses
    ADD CONSTRAINT uk_dfbmp0sfgkcpxtwrfw2rejumg UNIQUE (usergroupaccessid);


--
-- Name: dataentryform uk_dhl0qt8y7hht7krbiym1e9x3n; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataentryform
    ADD CONSTRAINT uk_dhl0qt8y7hht7krbiym1e9x3n UNIQUE (code);


--
-- Name: orgunitgroupuseraccesses uk_dkeswollqsyfxax1eo1yu8yn3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupuseraccesses
    ADD CONSTRAINT uk_dkeswollqsyfxax1eo1yu8yn3 UNIQUE (useraccessid);


--
-- Name: categorycombo uk_dlhi39gmt2e0dun73f04w7w7u; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombo
    ADD CONSTRAINT uk_dlhi39gmt2e0dun73f04w7w7u UNIQUE (uid);


--
-- Name: programindicator uk_do17h5nk71uvc3xjry6kgevj9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT uk_do17h5nk71uvc3xjry6kgevj9 UNIQUE (code);


--
-- Name: systemsetting uk_do99wgsyk5wflbhb937u5av8m; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.systemsetting
    ADD CONSTRAINT uk_do99wgsyk5wflbhb937u5av8m UNIQUE (name);


--
-- Name: dataelementusergroupaccesses uk_dq1cneyi4cgarkqaspifgmjqn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementusergroupaccesses
    ADD CONSTRAINT uk_dq1cneyi4cgarkqaspifgmjqn UNIQUE (usergroupaccessid);


--
-- Name: optiongroup uk_dt8m81o2pw5p9ttid369e92bg; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT uk_dt8m81o2pw5p9ttid369e92bg UNIQUE (code);


--
-- Name: programrulevariable uk_e5mhmtj1h7xdfiio2panhapgg; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT uk_e5mhmtj1h7xdfiio2panhapgg UNIQUE (uid);


--
-- Name: validationruleuseraccesses uk_e5my51xi9bhly2d21ra5w1ir6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleuseraccesses
    ADD CONSTRAINT uk_e5my51xi9bhly2d21ra5w1ir6 UNIQUE (useraccessid);


--
-- Name: programstage uk_e6s6o9jau6tx04m62t7ey4i81; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT uk_e6s6o9jau6tx04m62t7ey4i81 UNIQUE (code);


--
-- Name: trackedentityattributeattributevalues uk_eb7jbyiwhse2kd64y3ufee977; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeattributevalues
    ADD CONSTRAINT uk_eb7jbyiwhse2kd64y3ufee977 UNIQUE (attributevalueid);


--
-- Name: maplegendset uk_ec7ehyocpresxxhm7yjstdnwt; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegendset
    ADD CONSTRAINT uk_ec7ehyocpresxxhm7yjstdnwt UNIQUE (uid);


--
-- Name: constant uk_edy7cktu2fqg01r3n0fjyk1kk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT uk_edy7cktu2fqg01r3n0fjyk1kk UNIQUE (code);


--
-- Name: users uk_efqukogbk7i0poucwoy2qie74; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_efqukogbk7i0poucwoy2qie74 UNIQUE (uid);


--
-- Name: fileresource uk_eh2epuhchf9mci86ihl06i31g; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.fileresource
    ADD CONSTRAINT uk_eh2epuhchf9mci86ihl06i31g UNIQUE (uid);


--
-- Name: trackedentityattribute uk_eh4c3whbwi94nhh772q6l5t7m; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT uk_eh4c3whbwi94nhh772q6l5t7m UNIQUE (code);


--
-- Name: organisationunit uk_ehl4v33tq7hlkmc28vbno1b4n; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT uk_ehl4v33tq7hlkmc28vbno1b4n UNIQUE (code);


--
-- Name: usergroup uk_ekb018cvmpvll5dgtn97leerj; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT uk_ekb018cvmpvll5dgtn97leerj UNIQUE (uid);


--
-- Name: document uk_elt3kiqdmmm5fwqfxsxk9lvh0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT uk_elt3kiqdmmm5fwqfxsxk9lvh0 UNIQUE (code);


--
-- Name: keyjsonvalue uk_em6b7qxcas7dn6y506i3nd2x6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalue
    ADD CONSTRAINT uk_em6b7qxcas7dn6y506i3nd2x6 UNIQUE (uid);


--
-- Name: version uk_emoyyyy114ofh6cwo6do8xsi0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT uk_emoyyyy114ofh6cwo6do8xsi0 UNIQUE (versionkey);


--
-- Name: dashboard uk_emyh4fed0f1kknqhimmrhnek8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT uk_emyh4fed0f1kknqhimmrhnek8 UNIQUE (code);


--
-- Name: predictor uk_enhquk04unrpri78inaske3jq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT uk_enhquk04unrpri78inaske3jq UNIQUE (uid);


--
-- Name: dataapprovallevelusergroupaccesses uk_eol69wovoy6rdsf83affs376e; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevelusergroupaccesses
    ADD CONSTRAINT uk_eol69wovoy6rdsf83affs376e UNIQUE (usergroupaccessid);


--
-- Name: eventreport uk_eqd95mucf5pd856dqlwe6y36c; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT uk_eqd95mucf5pd856dqlwe6y36c UNIQUE (code);


--
-- Name: smscommandspecialcharacters uk_etm1elt7pbwyia8e0kfnrvqo3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandspecialcharacters
    ADD CONSTRAINT uk_etm1elt7pbwyia8e0kfnrvqo3 UNIQUE (specialcharacterid);


--
-- Name: trackedentityattribute uk_evp7d8obarxt3kewepigkwahc; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT uk_evp7d8obarxt3kewepigkwahc UNIQUE (name);


--
-- Name: chart uk_eyke73kujhkth5elabmkpy4ca; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT uk_eyke73kujhkth5elabmkpy4ca UNIQUE (code);


--
-- Name: programindicatorgroup uk_f7wfef3jx1yl73stqs7b45ewb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroup
    ADD CONSTRAINT uk_f7wfef3jx1yl73stqs7b45ewb UNIQUE (code);


--
-- Name: metadataversion uk_f93o7l4afmkassm3t4f2op9ps; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataversion
    ADD CONSTRAINT uk_f93o7l4afmkassm3t4f2op9ps UNIQUE (name);


--
-- Name: programruleaction uk_fbferisvig2o4f5owb5lnygf3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT uk_fbferisvig2o4f5owb5lnygf3 UNIQUE (code);


--
-- Name: userrole uk_ff1da38in40mg91rlgqhw02ff; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT uk_ff1da38in40mg91rlgqhw02ff UNIQUE (uid);


--
-- Name: dataelementcategoryoptionattributevalues uk_ficc46qh952uupa5o04svktv2; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionattributevalues
    ADD CONSTRAINT uk_ficc46qh952uupa5o04svktv2 UNIQUE (attributevalueid);


--
-- Name: dataelementgroupattributevalues uk_fokuy0yq9krttmqaf95ne7ql7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupattributevalues
    ADD CONSTRAINT uk_fokuy0yq9krttmqaf95ne7ql7 UNIQUE (attributevalueid);


--
-- Name: sqlview uk_fps2ja521pudngaitlp0805du; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlview
    ADD CONSTRAINT uk_fps2ja521pudngaitlp0805du UNIQUE (uid);


--
-- Name: orgunitgroupset uk_fuentbuhbbr0ix49td9jqlfe5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT uk_fuentbuhbbr0ix49td9jqlfe5 UNIQUE (uid);


--
-- Name: program uk_fuq6kda6folarp19oggaf02vb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT uk_fuq6kda6folarp19oggaf02vb UNIQUE (code);


--
-- Name: orgunitlevel uk_fvgc7isaflcan55g51ysm9df2; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitlevel
    ADD CONSTRAINT uk_fvgc7isaflcan55g51ysm9df2 UNIQUE (code);


--
-- Name: colorset uk_fwso2d10icu8j6720w82tywmq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset
    ADD CONSTRAINT uk_fwso2d10icu8j6720w82tywmq UNIQUE (code);


--
-- Name: oauth2client uk_fx3xx9xe0xpurjt6v5p7rv8da; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT uk_fx3xx9xe0xpurjt6v5p7rv8da UNIQUE (uid);


--
-- Name: organisationunit uk_g1nrfjv5x04ap1ceohiwah380; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT uk_g1nrfjv5x04ap1ceohiwah380 UNIQUE (uid);


--
-- Name: chartuseraccesses uk_g54lkp9a8q5qp4wsfwxg4c7xc; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartuseraccesses
    ADD CONSTRAINT uk_g54lkp9a8q5qp4wsfwxg4c7xc UNIQUE (useraccessid);


--
-- Name: dataelementgroupsetusergroupaccesses uk_g7l1v9ghhdmxbyagk6s61ym27; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetusergroupaccesses
    ADD CONSTRAINT uk_g7l1v9ghhdmxbyagk6s61ym27 UNIQUE (usergroupaccessid);


--
-- Name: sqlviewattributevalues uk_gaecdwlqfpvdu516lhl8pu6mk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewattributevalues
    ADD CONSTRAINT uk_gaecdwlqfpvdu516lhl8pu6mk UNIQUE (attributevalueid);


--
-- Name: dataelementcategoryoptionusergroupaccesses uk_gdawhakuh5sgetn8agy2y8iqs; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionusergroupaccesses
    ADD CONSTRAINT uk_gdawhakuh5sgetn8agy2y8iqs UNIQUE (usergroupaccessid);


--
-- Name: oauth2client uk_gdfuf3j66jxnvwwnksjxqysac; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT uk_gdfuf3j66jxnvwwnksjxqysac UNIQUE (code);


--
-- Name: categoryoptiongroup uk_ge3y4pf6qlne9p7rfmhlvg941; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT uk_ge3y4pf6qlne9p7rfmhlvg941 UNIQUE (code);


--
-- Name: trackedentityattribute uk_gg9gc0pyaqjuxi8mr4y93i03w; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT uk_gg9gc0pyaqjuxi8mr4y93i03w UNIQUE (shortname);


--
-- Name: dataelementcategoryusergroupaccesses uk_gi1od6nead01u7wxu6h10k76j; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryusergroupaccesses
    ADD CONSTRAINT uk_gi1od6nead01u7wxu6h10k76j UNIQUE (usergroupaccessid);


--
-- Name: relationshiptype uk_gio4nn8l23jikmebud3jwql43; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT uk_gio4nn8l23jikmebud3jwql43 UNIQUE (code);


--
-- Name: userinfo uk_gky85ptfkcumyuqhr5yvjxwsa; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT uk_gky85ptfkcumyuqhr5yvjxwsa UNIQUE (code);


--
-- Name: categoryoptiongroupuseraccesses uk_go48ntpyqbmgwa6k6h7756dwv; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupuseraccesses
    ADD CONSTRAINT uk_go48ntpyqbmgwa6k6h7756dwv UNIQUE (useraccessid);


--
-- Name: predictorgroupusergroupaccesses uk_gpm7rsrpqsfmelh7lpi58r64h; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupusergroupaccesses
    ADD CONSTRAINT uk_gpm7rsrpqsfmelh7lpi58r64h UNIQUE (usergroupaccessid);


--
-- Name: map uk_grp9b5jne53f806pc92sfd5s8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.map
    ADD CONSTRAINT uk_grp9b5jne53f806pc92sfd5s8 UNIQUE (uid);


--
-- Name: relationship uk_gsvll3t3tsda7kx38waqnegkw; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT uk_gsvll3t3tsda7kx38waqnegkw UNIQUE (from_relationshipitemid);


--
-- Name: programstageinstance uk_gy44hufdeduoma7eeh3j6abm7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT uk_gy44hufdeduoma7eeh3j6abm7 UNIQUE (uid);


--
-- Name: userroleusergroupaccesses uk_h3qgkg0gvi3c0ohs07y00c96p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleusergroupaccesses
    ADD CONSTRAINT uk_h3qgkg0gvi3c0ohs07y00c96p UNIQUE (usergroupaccessid);


--
-- Name: program uk_h4omjcs2ktifdrf2m36u886ae; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT uk_h4omjcs2ktifdrf2m36u886ae UNIQUE (uid);


--
-- Name: categorycombo uk_h97pko7n41oky8pfptkflp8l6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombo
    ADD CONSTRAINT uk_h97pko7n41oky8pfptkflp8l6 UNIQUE (name);


--
-- Name: dataelementattributevalues uk_hbpqcltj8paday3y0yystbw6p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementattributevalues
    ADD CONSTRAINT uk_hbpqcltj8paday3y0yystbw6p UNIQUE (attributevalueid);


--
-- Name: userrole uk_hebhkhm8gpwg9xsp8q4f7wlx1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT uk_hebhkhm8gpwg9xsp8q4f7wlx1 UNIQUE (code);


--
-- Name: userrole uk_hjocbvo9fla04bgj7ku32vwsn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT uk_hjocbvo9fla04bgj7ku32vwsn UNIQUE (name);


--
-- Name: attribute uk_hpwum0iq12fs4ej5d0tgy6wsn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT uk_hpwum0iq12fs4ej5d0tgy6wsn UNIQUE (name);


--
-- Name: dataapprovallevel uk_hqekpuhjg3g4k4t7xdnu10jy4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT uk_hqekpuhjg3g4k4t7xdnu10jy4 UNIQUE (orgunitlevel, categoryoptiongroupsetid);


--
-- Name: orgunitgroupset uk_hs57i9hma97ps6jpsrbb24lm9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT uk_hs57i9hma97ps6jpsrbb24lm9 UNIQUE (code);


--
-- Name: attributeusergroupaccesses uk_huqnx8f8tmew3v4c6k8r3krpa; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeusergroupaccesses
    ADD CONSTRAINT uk_huqnx8f8tmew3v4c6k8r3krpa UNIQUE (usergroupaccessid);


--
-- Name: dataapprovallevel uk_i1uhc0c8jgxkhlswl9fujsicf; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT uk_i1uhc0c8jgxkhlswl9fujsicf UNIQUE (uid);


--
-- Name: predictorgroup uk_i4dix5cj64521ivv59c0wgvfq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroup
    ADD CONSTRAINT uk_i4dix5cj64521ivv59c0wgvfq UNIQUE (uid);


--
-- Name: maplegend uk_id4stsb5slq35axmjeojnjnoa; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegend
    ADD CONSTRAINT uk_id4stsb5slq35axmjeojnjnoa UNIQUE (code);


--
-- Name: programindicatorusergroupaccesses uk_iedn1e511sbiosnic2nb8n6lk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorusergroupaccesses
    ADD CONSTRAINT uk_iedn1e511sbiosnic2nb8n6lk UNIQUE (usergroupaccessid);


--
-- Name: sqlview uk_iedy6hh42wl3gr3m87ntd6so8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlview
    ADD CONSTRAINT uk_iedy6hh42wl3gr3m87ntd6so8 UNIQUE (name);


--
-- Name: jobconfiguration uk_igo4gx1d74k7m93vxnn4n77jf; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.jobconfiguration
    ADD CONSTRAINT uk_igo4gx1d74k7m93vxnn4n77jf UNIQUE (code);


--
-- Name: validationrulegroupuseraccesses uk_imfu1rtsu3sh3o0rdkxv0ur6e; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupuseraccesses
    ADD CONSTRAINT uk_imfu1rtsu3sh3o0rdkxv0ur6e UNIQUE (useraccessid);


--
-- Name: messageconversation_usermessages uk_j5pi1qwi2m228qrsxql48o61s; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_usermessages
    ADD CONSTRAINT uk_j5pi1qwi2m228qrsxql48o61s UNIQUE (usermessageid);


--
-- Name: categoryoptiongroup uk_j9oya1t1tvj8yn5h8fega4ltr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT uk_j9oya1t1tvj8yn5h8fega4ltr UNIQUE (name);


--
-- Name: dataelement uk_jc27pe1xeptws5xprct7mgxrj; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT uk_jc27pe1xeptws5xprct7mgxrj UNIQUE (shortname);


--
-- Name: orgunitgroupattributevalues uk_jga8ebd6t2nkrfcapucx1wcbq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupattributevalues
    ADD CONSTRAINT uk_jga8ebd6t2nkrfcapucx1wcbq UNIQUE (attributevalueid);


--
-- Name: datasetnotificationtemplate uk_jjt6ctp2xi4d7vtv4pwkkdhh0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotificationtemplate
    ADD CONSTRAINT uk_jjt6ctp2xi4d7vtv4pwkkdhh0 UNIQUE (uid);


--
-- Name: users uk_jkg0r5akwcxtamstsq9kv4t4p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_jkg0r5akwcxtamstsq9kv4t4p UNIQUE (ldapid);


--
-- Name: categorycombouseraccesses uk_jo0xmsdymh9tk882hy994wbce; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombouseraccesses
    ADD CONSTRAINT uk_jo0xmsdymh9tk882hy994wbce UNIQUE (useraccessid);


--
-- Name: dataelementgroup uk_jo65jc3wyrxfekiu3upk80mtr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT uk_jo65jc3wyrxfekiu3upk80mtr UNIQUE (code);


--
-- Name: program_attribute_group uk_ju40npt2p0kglya4e5041b4qc; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attribute_group
    ADD CONSTRAINT uk_ju40npt2p0kglya4e5041b4qc UNIQUE (uid);


--
-- Name: sqlviewuseraccesses uk_ju4gh1mla6t217iucr66lx8xp; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewuseraccesses
    ADD CONSTRAINT uk_ju4gh1mla6t217iucr66lx8xp UNIQUE (useraccessid);


--
-- Name: document uk_jxodv1lvot26euasttk021jio; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT uk_jxodv1lvot26euasttk021jio UNIQUE (uid);


--
-- Name: fileresource uk_jxqj907hbrng860p6mypvl63k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.fileresource
    ADD CONSTRAINT uk_jxqj907hbrng860p6mypvl63k UNIQUE (storagekey);


--
-- Name: interpretation_comments uk_k48tayhxu52jiq782pikev9d9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation_comments
    ADD CONSTRAINT uk_k48tayhxu52jiq782pikev9d9 UNIQUE (interpretationcommentid);


--
-- Name: relationshiptypeusergroupaccesses uk_k5sfr6re69gto7j9tgcp1ngsx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeusergroupaccesses
    ADD CONSTRAINT uk_k5sfr6re69gto7j9tgcp1ngsx UNIQUE (usergroupaccessid);


--
-- Name: trackedentityattribute uk_kbqnrdakcjfooofmti30d4p8x; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT uk_kbqnrdakcjfooofmti30d4p8x UNIQUE (uid);


--
-- Name: report uk_kc1wmcky1ooleovi36oqcqmqe; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT uk_kc1wmcky1ooleovi36oqcqmqe UNIQUE (code);


--
-- Name: categoryoptiongroupset uk_ke8p30sy68dl7fggednkimdb6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupset
    ADD CONSTRAINT uk_ke8p30sy68dl7fggednkimdb6 UNIQUE (name);


--
-- Name: optiongroupsetuseraccesses uk_kjp8xjq10d0oknphxqmcmev7l; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetuseraccesses
    ADD CONSTRAINT uk_kjp8xjq10d0oknphxqmcmev7l UNIQUE (useraccessid);


--
-- Name: indicatorgroupsetusergroupaccesses uk_kk6o2c0eb5bex4sn1p5n7juu5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetusergroupaccesses
    ADD CONSTRAINT uk_kk6o2c0eb5bex4sn1p5n7juu5 UNIQUE (usergroupaccessid);


--
-- Name: validationrulegroupusergroupaccesses uk_klp41jyfuo6kfe8akt58fk1am; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupusergroupaccesses
    ADD CONSTRAINT uk_klp41jyfuo6kfe8akt58fk1am UNIQUE (usergroupaccessid);


--
-- Name: indicator uk_kmpefoaw81v4bxpoey6y1y3xl; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT uk_kmpefoaw81v4bxpoey6y1y3xl UNIQUE (code);


--
-- Name: indicatorgroup uk_kqbwxccoqctky1kdkimjya03s; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroup
    ADD CONSTRAINT uk_kqbwxccoqctky1kdkimjya03s UNIQUE (uid);


--
-- Name: eventchartusergroupaccesses uk_krfvmvcrf3agy0jlmbh7n2kvb; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartusergroupaccesses
    ADD CONSTRAINT uk_krfvmvcrf3agy0jlmbh7n2kvb UNIQUE (usergroupaccessid);


--
-- Name: i18nlocale uk_krm9w69donjqsejkmfw17jbcx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.i18nlocale
    ADD CONSTRAINT uk_krm9w69donjqsejkmfw17jbcx UNIQUE (code);


--
-- Name: metadataversion uk_ktwf16f728hce9ahtpmm7w5lx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataversion
    ADD CONSTRAINT uk_ktwf16f728hce9ahtpmm7w5lx UNIQUE (uid);


--
-- Name: categoryoptiongroupusergroupaccesses uk_kw8ong945syafd2310ahwfu9l; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupusergroupaccesses
    ADD CONSTRAINT uk_kw8ong945syafd2310ahwfu9l UNIQUE (usergroupaccessid);


--
-- Name: orgunitgroupsetattributevalues uk_l1cufoqirp2onveti3bpuyo92; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetattributevalues
    ADD CONSTRAINT uk_l1cufoqirp2onveti3bpuyo92 UNIQUE (attributevalueid);


--
-- Name: attributeuseraccesses uk_l78emlqkgkcw0fjtxr7qw3b2u; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeuseraccesses
    ADD CONSTRAINT uk_l78emlqkgkcw0fjtxr7qw3b2u UNIQUE (useraccessid);


--
-- Name: programattributevalues uk_ldbbgacwc69ab5tha0u7dhg82; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programattributevalues
    ADD CONSTRAINT uk_ldbbgacwc69ab5tha0u7dhg82 UNIQUE (attributevalueid);


--
-- Name: program_attributes uk_lgju00pi2jk7y6sl4dkhaykux; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT uk_lgju00pi2jk7y6sl4dkhaykux UNIQUE (uid);


--
-- Name: categoryattributevalues uk_ljt4m18vy284l3hhyq2esj3kr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryattributevalues
    ADD CONSTRAINT uk_ljt4m18vy284l3hhyq2esj3kr UNIQUE (attributevalueid);


--
-- Name: externalnotificationlogentry uk_lner1ovmrqr5qrwn8gwfuhhhn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalnotificationlogentry
    ADD CONSTRAINT uk_lner1ovmrqr5qrwn8gwfuhhhn UNIQUE (uid);


--
-- Name: eventreport uk_lnnx8vmalkhkmneryv1ytjq68; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT uk_lnnx8vmalkhkmneryv1ytjq68 UNIQUE (uid);


--
-- Name: categoryoptiongroup uk_lrnagoy2wi83nwmataolh7t6d; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT uk_lrnagoy2wi83nwmataolh7t6d UNIQUE (shortname);


--
-- Name: orgunitgroup uk_lswbn93sime7vmdqqe9lks7ge; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT uk_lswbn93sime7vmdqqe9lks7ge UNIQUE (uid);


--
-- Name: orgunitlevel uk_ltwhby0s0iwayxrcdu6yefeqt; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitlevel
    ADD CONSTRAINT uk_ltwhby0s0iwayxrcdu6yefeqt UNIQUE (level);


--
-- Name: dataelementgroupset uk_lu295rc1y01c7p7t76y6ajaas; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupset
    ADD CONSTRAINT uk_lu295rc1y01c7p7t76y6ajaas UNIQUE (uid);


--
-- Name: reporttable uk_lvk31hlxg4sl301nxyt1iupd6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT uk_lvk31hlxg4sl301nxyt1iupd6 UNIQUE (code);


--
-- Name: programinstancecomments uk_lwep604j10w1ey7vunqdmotx2; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstancecomments
    ADD CONSTRAINT uk_lwep604j10w1ey7vunqdmotx2 UNIQUE (trackedentitycommentid);


--
-- Name: programstagesection uk_lycal9jdw3cs0wwebxciswwgr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection
    ADD CONSTRAINT uk_lycal9jdw3cs0wwebxciswwgr UNIQUE (uid);


--
-- Name: trackedentityinstancefilter uk_m5k30j5e93n1no82gye7jgf25; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstancefilter
    ADD CONSTRAINT uk_m5k30j5e93n1no82gye7jgf25 UNIQUE (uid);


--
-- Name: validationnotificationtemplate uk_mbt1vxa5exs9cbqqs5px2mopx; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate
    ADD CONSTRAINT uk_mbt1vxa5exs9cbqqs5px2mopx UNIQUE (uid);


--
-- Name: externalnotificationlogentry uk_mcn0op3hsf5ajqg5k4oli4xkc; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalnotificationlogentry
    ADD CONSTRAINT uk_mcn0op3hsf5ajqg5k4oli4xkc UNIQUE (key);


--
-- Name: dataelementcategoryoption uk_mlop2afk26fwowa69lr9a138y; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT uk_mlop2afk26fwowa69lr9a138y UNIQUE (code);


--
-- Name: dataapprovalworkflowuseraccesses uk_mn4yowauiafr72rvtkc9kql0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowuseraccesses
    ADD CONSTRAINT uk_mn4yowauiafr72rvtkc9kql0 UNIQUE (useraccessid);


--
-- Name: datasetnotificationtemplate uk_mq0y6uuq2erprg2siebo2mk1o; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotificationtemplate
    ADD CONSTRAINT uk_mq0y6uuq2erprg2siebo2mk1o UNIQUE (code);


--
-- Name: trackedentitytypeattributevalues uk_mrxaf7d00g0p3onf48h0buu49; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattributevalues
    ADD CONSTRAINT uk_mrxaf7d00g0p3onf48h0buu49 UNIQUE (attributevalueid);


--
-- Name: dashboard uk_myox13mr8r27oxl7ts33ntpd5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT uk_myox13mr8r27oxl7ts33ntpd5 UNIQUE (uid);


--
-- Name: dataapprovalworkflow uk_n18s4feicujvngv2ajoesdgio; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT uk_n18s4feicujvngv2ajoesdgio UNIQUE (name);


--
-- Name: color uk_n3axgangk6yuxhrb2o7fk9oa7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.color
    ADD CONSTRAINT uk_n3axgangk6yuxhrb2o7fk9oa7 UNIQUE (name);


--
-- Name: legendsetusergroupaccesses uk_n3kddotvpw0biusai8obu86vn; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetusergroupaccesses
    ADD CONSTRAINT uk_n3kddotvpw0biusai8obu86vn UNIQUE (usergroupaccessid);


--
-- Name: indicatorgroupset uk_n4xputyk31femiaxls6lbl2rw; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupset
    ADD CONSTRAINT uk_n4xputyk31femiaxls6lbl2rw UNIQUE (uid);


--
-- Name: pushanalysis uk_n5ax669vkj63nx3rrvlushqdm; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysis
    ADD CONSTRAINT uk_n5ax669vkj63nx3rrvlushqdm UNIQUE (code);


--
-- Name: dataelementgroupsetattributevalues uk_n5pg3ur218o4bcvolueafxpf6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetattributevalues
    ADD CONSTRAINT uk_n5pg3ur218o4bcvolueafxpf6 UNIQUE (attributevalueid);


--
-- Name: indicatortype uk_n8mbmryeksa80ucyxj0vg6p9b; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatortype
    ADD CONSTRAINT uk_n8mbmryeksa80ucyxj0vg6p9b UNIQUE (name);


--
-- Name: usergroupuseraccesses uk_nbkvt8dj4ocmbv8okga2nvop2; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupuseraccesses
    ADD CONSTRAINT uk_nbkvt8dj4ocmbv8okga2nvop2 UNIQUE (useraccessid);


--
-- Name: oauth2client uk_ni7epmbxtn4jcax3ya324ff9w; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT uk_ni7epmbxtn4jcax3ya324ff9w UNIQUE (cid);


--
-- Name: optiongroup uk_nipo7t010a80osh7okxswav2g; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT uk_nipo7t010a80osh7okxswav2g UNIQUE (uid);


--
-- Name: dataelementgroupsetuseraccesses uk_nl4hw4ti986dje72b6csrmh3v; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetuseraccesses
    ADD CONSTRAINT uk_nl4hw4ti986dje72b6csrmh3v UNIQUE (useraccessid);


--
-- Name: messageconversation_messages uk_nqdtggpr548q0tnbu919puw0p; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_messages
    ADD CONSTRAINT uk_nqdtggpr548q0tnbu919puw0p UNIQUE (messageid);


--
-- Name: oauth2client uk_nwgvrevv2slj1bvc9m01p89lf; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT uk_nwgvrevv2slj1bvc9m01p89lf UNIQUE (name);


--
-- Name: optiongroup uk_nwq3y4xqct21tdl0l77bvmpoe; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT uk_nwq3y4xqct21tdl0l77bvmpoe UNIQUE (shortname);


--
-- Name: constant uk_nywvip5682tuvxrnwjomeyg6y; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT uk_nywvip5682tuvxrnwjomeyg6y UNIQUE (uid);


--
-- Name: predictor uk_o0v1fdqiyte40ffm9q3nhcj4v; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT uk_o0v1fdqiyte40ffm9q3nhcj4v UNIQUE (code);


--
-- Name: constant uk_o2xbcli806eba6dkdfco0o3kc; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT uk_o2xbcli806eba6dkdfco0o3kc UNIQUE (name);


--
-- Name: dataset uk_oeni5ndit5g033f1s1j08bdry; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT uk_oeni5ndit5g033f1s1j08bdry UNIQUE (code);


--
-- Name: colorset uk_ofc2a89rccimogdp9ownwcuy1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset
    ADD CONSTRAINT uk_ofc2a89rccimogdp9ownwcuy1 UNIQUE (name);


--
-- Name: categoryoptiongroupsetattributevalues uk_ofiijcq7e2uy7h1ak7h0wtlg; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetattributevalues
    ADD CONSTRAINT uk_ofiijcq7e2uy7h1ak7h0wtlg UNIQUE (attributevalueid);


--
-- Name: optionattributevalues uk_ofw2gg6ghv4rkqo24rm9yhpdt; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionattributevalues
    ADD CONSTRAINT uk_ofw2gg6ghv4rkqo24rm9yhpdt UNIQUE (attributevalueid);


--
-- Name: sqlviewusergroupaccesses uk_og1fdqhhylbk69fxpoth4bd36; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewusergroupaccesses
    ADD CONSTRAINT uk_og1fdqhhylbk69fxpoth4bd36 UNIQUE (usergroupaccessid);


--
-- Name: eventreportusergroupaccesses uk_oith7i266qbjggmij30psueoo; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportusergroupaccesses
    ADD CONSTRAINT uk_oith7i266qbjggmij30psueoo UNIQUE (usergroupaccessid);


--
-- Name: colorset uk_oj2bhkjfgcl9rcwlf579dl1d6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset
    ADD CONSTRAINT uk_oj2bhkjfgcl9rcwlf579dl1d6 UNIQUE (uid);


--
-- Name: categoryoptiongroup uk_ol8n7oq6clgxvqjedlpn85aqo; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT uk_ol8n7oq6clgxvqjedlpn85aqo UNIQUE (uid);


--
-- Name: dataelementgroupuseraccesses uk_opmqksrjv8o98p5bwfhhfapwr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupuseraccesses
    ADD CONSTRAINT uk_opmqksrjv8o98p5bwfhhfapwr UNIQUE (useraccessid);


--
-- Name: orgunitgroupsetuseraccesses uk_oqfck0kamahjps18dep2ogcw1; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetuseraccesses
    ADD CONSTRAINT uk_oqfck0kamahjps18dep2ogcw1 UNIQUE (useraccessid);


--
-- Name: trackedentityinstance uk_orq3pwtro2yu9yydh046bn40j; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstance
    ADD CONSTRAINT uk_orq3pwtro2yu9yydh046bn40j UNIQUE (code);


--
-- Name: programstagedataelement uk_os4r1umsvtmbuqm2bo25s5ej0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT uk_os4r1umsvtmbuqm2bo25s5ej0 UNIQUE (uid);


--
-- Name: datasetuseraccesses uk_oso7fghriw7yliyriqw5o9io3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetuseraccesses
    ADD CONSTRAINT uk_oso7fghriw7yliyriqw5o9io3 UNIQUE (useraccessid);


--
-- Name: programnotificationtemplate uk_ot8a05g9d4k5l67xi062xx5w6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT uk_ot8a05g9d4k5l67xi062xx5w6 UNIQUE (code);


--
-- Name: dataelementgroup uk_otvwcgv4bxjtqfj3flhrnmgf7; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT uk_otvwcgv4bxjtqfj3flhrnmgf7 UNIQUE (uid);


--
-- Name: dashboarduseraccesses uk_ow5b3iks1dgs1hqimo59fgegl; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarduseraccesses
    ADD CONSTRAINT uk_ow5b3iks1dgs1hqimo59fgegl UNIQUE (useraccessid);


--
-- Name: indicatortype uk_p0p3bwhgbsdemu14v23p47qne; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatortype
    ADD CONSTRAINT uk_p0p3bwhgbsdemu14v23p47qne UNIQUE (uid);


--
-- Name: optionset uk_p0rvldurcmk0x3mx39lt5uvsd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionset
    ADD CONSTRAINT uk_p0rvldurcmk0x3mx39lt5uvsd UNIQUE (name);


--
-- Name: programrule uk_p7arcbl58mmcrj2didtr0ruqh; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrule
    ADD CONSTRAINT uk_p7arcbl58mmcrj2didtr0ruqh UNIQUE (uid);


--
-- Name: dataelementgroupset uk_p7egnv3sj4ugyl23mk4vga40k; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupset
    ADD CONSTRAINT uk_p7egnv3sj4ugyl23mk4vga40k UNIQUE (code);


--
-- Name: dataentryform uk_p8tvo9tqrdn5tb45d0g5cko5o; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataentryform
    ADD CONSTRAINT uk_p8tvo9tqrdn5tb45d0g5cko5o UNIQUE (name);


--
-- Name: categorycombousergroupaccesses uk_p95o4dnytx8vxb7yugxlu2hhf; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombousergroupaccesses
    ADD CONSTRAINT uk_p95o4dnytx8vxb7yugxlu2hhf UNIQUE (usergroupaccessid);


--
-- Name: mapusergroupaccesses uk_pag45qp5gr17svxsntj5tjw66; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapusergroupaccesses
    ADD CONSTRAINT uk_pag45qp5gr17svxsntj5tjw66 UNIQUE (usergroupaccessid);


--
-- Name: dataelementcategoryoption uk_pbj3u1nk9vnuof8f47utvowmv; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT uk_pbj3u1nk9vnuof8f47utvowmv UNIQUE (name);


--
-- Name: datastatistics uk_ppi146eky8fodu97t1o21vkd8; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datastatistics
    ADD CONSTRAINT uk_ppi146eky8fodu97t1o21vkd8 UNIQUE (uid);


--
-- Name: programstageinstancefilter uk_programstageinstancefilter_uid; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilter
    ADD CONSTRAINT uk_programstageinstancefilter_uid UNIQUE (uid);


--
-- Name: organisationunit uk_pw2bgc9ykjad2obefeqha28t4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT uk_pw2bgc9ykjad2obefeqha28t4 UNIQUE (path);


--
-- Name: dataelementcategory uk_pw87bi64e3ev11k7dwrmljo78; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategory
    ADD CONSTRAINT uk_pw87bi64e3ev11k7dwrmljo78 UNIQUE (code);


--
-- Name: predictorgroup uk_pxnxtb4ywoh2m74vosk2httc3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroup
    ADD CONSTRAINT uk_pxnxtb4ywoh2m74vosk2httc3 UNIQUE (name);


--
-- Name: dataentryform uk_q0obvr5rvxhlnjs367y1f0bav; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataentryform
    ADD CONSTRAINT uk_q0obvr5rvxhlnjs367y1f0bav UNIQUE (uid);


--
-- Name: eventreport uk_q0oyainj1lis9c8kkh5sky2ri; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT uk_q0oyainj1lis9c8kkh5sky2ri UNIQUE (relativeperiodsid);


--
-- Name: usergroup uk_q20sh82vk885ooi7fekwtboej; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT uk_q20sh82vk885ooi7fekwtboej UNIQUE (code);


--
-- Name: userattributevalues uk_q2mhld3431cikld8ocnognnl3; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userattributevalues
    ADD CONSTRAINT uk_q2mhld3431cikld8ocnognnl3 UNIQUE (attributevalueid);


--
-- Name: optiongroupusergroupaccesses uk_q5kj01mnv9vystj3dax3a4vc0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupusergroupaccesses
    ADD CONSTRAINT uk_q5kj01mnv9vystj3dax3a4vc0 UNIQUE (usergroupaccessid);


--
-- Name: optiongroupset uk_q9jv2e3fy49hc1havuwnr0res; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT uk_q9jv2e3fy49hc1havuwnr0res UNIQUE (code);


--
-- Name: usergroupusergroupaccesses uk_qa5c4eva4rxafw5b7eyddp64m; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupusergroupaccesses
    ADD CONSTRAINT uk_qa5c4eva4rxafw5b7eyddp64m UNIQUE (usergroupaccessid);


--
-- Name: indicatorgroupattributevalues uk_qaqvbi3rmqrmsesdwr2dkltwd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupattributevalues
    ADD CONSTRAINT uk_qaqvbi3rmqrmsesdwr2dkltwd UNIQUE (attributevalueid);


--
-- Name: interpretationusergroupaccesses uk_qba465kdmkyxal2f05g3f1f94; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationusergroupaccesses
    ADD CONSTRAINT uk_qba465kdmkyxal2f05g3f1f94 UNIQUE (usergroupaccessid);


--
-- Name: categoryoptioncombo uk_qki43s9vdndg15c9tyv718u1j; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombo
    ADD CONSTRAINT uk_qki43s9vdndg15c9tyv718u1j UNIQUE (uid);


--
-- Name: i18nlocale uk_qogg9a7yy4qconomxt4j4upql; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.i18nlocale
    ADD CONSTRAINT uk_qogg9a7yy4qconomxt4j4upql UNIQUE (name);


--
-- Name: dataelementcategoryoption uk_qp9201a4m6jl53sei0huh4l6s; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT uk_qp9201a4m6jl53sei0huh4l6s UNIQUE (shortname);


--
-- Name: relationshiptype uk_qq5b8o288bhpe59e5ks3op8jy; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT uk_qq5b8o288bhpe59e5ks3op8jy UNIQUE (from_relationshipconstraintid);


--
-- Name: pushanalysis uk_qunv1hucv9wi5pt92tur929mr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysis
    ADD CONSTRAINT uk_qunv1hucv9wi5pt92tur929mr UNIQUE (uid);


--
-- Name: orgunitgroup uk_qwk9qdapql867enp5r7fa0uic; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT uk_qwk9qdapql867enp5r7fa0uic UNIQUE (name);


--
-- Name: trackedentitytypeuseraccesses uk_qxhx7vgarh0v2w1dxv211knmq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeuseraccesses
    ADD CONSTRAINT uk_qxhx7vgarh0v2w1dxv211knmq UNIQUE (useraccessid);


--
-- Name: orgunitgroupusergroupaccesses uk_r0njvkxgdxior87ay09qxvd4g; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupusergroupaccesses
    ADD CONSTRAINT uk_r0njvkxgdxior87ay09qxvd4g UNIQUE (usergroupaccessid);


--
-- Name: program_attributes uk_r2f9o8i6th2w8vqdexdfo72ui; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT uk_r2f9o8i6th2w8vqdexdfo72ui UNIQUE (code);


--
-- Name: externalmaplayer uk_r3ugbbibdsyn234isip3346v4; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT uk_r3ugbbibdsyn234isip3346v4 UNIQUE (code);


--
-- Name: users uk_r43af9ap4edm43mmtq01oddj6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uk_r43af9ap4edm43mmtq01oddj6 UNIQUE (username);


--
-- Name: validationresult uk_r6ebedjcac8c49c53aa1mpa8e; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationresult
    ADD CONSTRAINT uk_r6ebedjcac8c49c53aa1mpa8e UNIQUE (validationruleid, periodid, organisationunitid, attributeoptioncomboid, dayinperiod);


--
-- Name: programstageuseraccesses uk_r6o97x370i5t9lbcico61kxaf; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageuseraccesses
    ADD CONSTRAINT uk_r6o97x370i5t9lbcico61kxaf UNIQUE (useraccessid);


--
-- Name: trackedentityinstance uk_rbr4kyuk4s0kb4jo1r77cuaq9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstance
    ADD CONSTRAINT uk_rbr4kyuk4s0kb4jo1r77cuaq9 UNIQUE (uid);


--
-- Name: datasetattributevalues uk_rh1jwubao1t728iys0662k7go; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetattributevalues
    ADD CONSTRAINT uk_rh1jwubao1t728iys0662k7go UNIQUE (attributevalueid);


--
-- Name: jobconfiguration uk_rqkhk3ebvk1kflf7qigbaxeyp; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.jobconfiguration
    ADD CONSTRAINT uk_rqkhk3ebvk1kflf7qigbaxeyp UNIQUE (name);


--
-- Name: color uk_rrv70c7ej18sptdwj7h6ac5rv; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.color
    ADD CONSTRAINT uk_rrv70c7ej18sptdwj7h6ac5rv UNIQUE (uid);


--
-- Name: documentusergroupaccesses uk_rtty45gvm30id8sglrlmacatq; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentusergroupaccesses
    ADD CONSTRAINT uk_rtty45gvm30id8sglrlmacatq UNIQUE (usergroupaccessid);


--
-- Name: optionset uk_rvfiukug5ui7qidoiln3el3aa; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionset
    ADD CONSTRAINT uk_rvfiukug5ui7qidoiln3el3aa UNIQUE (code);


--
-- Name: trackedentitytypeusergroupaccesses uk_s0mt3w36ir8v1ikcmcn1lptxt; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeusergroupaccesses
    ADD CONSTRAINT uk_s0mt3w36ir8v1ikcmcn1lptxt UNIQUE (usergroupaccessid);


--
-- Name: periodboundary uk_sbipy5btkgy542bdbx7mxppdd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodboundary
    ADD CONSTRAINT uk_sbipy5btkgy542bdbx7mxppdd UNIQUE (code);


--
-- Name: datasetusergroupaccesses uk_sc8477b26totcch3j096m2n2y; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetusergroupaccesses
    ADD CONSTRAINT uk_sc8477b26totcch3j096m2n2y UNIQUE (usergroupaccessid);


--
-- Name: jobconfiguration uk_sdng31h9qjawcikcllry8a8a5; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.jobconfiguration
    ADD CONSTRAINT uk_sdng31h9qjawcikcllry8a8a5 UNIQUE (uid);


--
-- Name: eventreportuseraccesses uk_skg9d1lewqm1qjaduqb3ly1bk; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportuseraccesses
    ADD CONSTRAINT uk_skg9d1lewqm1qjaduqb3ly1bk UNIQUE (useraccessid);


--
-- Name: indicatorgroup uk_sspviu4m0l0lf7ef3t3cagfxd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroup
    ADD CONSTRAINT uk_sspviu4m0l0lf7ef3t3cagfxd UNIQUE (code);


--
-- Name: validationrulegroupattributevalues uk_sx94jderpd63be4saekxcbbqr; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupattributevalues
    ADD CONSTRAINT uk_sx94jderpd63be4saekxcbbqr UNIQUE (attributevalueid);


--
-- Name: validationrule uk_t0dg39dopew9f6y64ucsx7194; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT uk_t0dg39dopew9f6y64ucsx7194 UNIQUE (uid);


--
-- Name: orgunitgroup uk_t0srkng3akwg3pcp5qlwcx06n; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT uk_t0srkng3akwg3pcp5qlwcx06n UNIQUE (shortname);


--
-- Name: orgunitgroupset uk_t5lxvc1km3ylon5st1fuabsgl; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT uk_t5lxvc1km3ylon5st1fuabsgl UNIQUE (name);


--
-- Name: trackedentitycomment uk_t94h9p111tcydbm6je22tla52; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitycomment
    ADD CONSTRAINT uk_t94h9p111tcydbm6je22tla52 UNIQUE (uid);


--
-- Name: smscommandcodes uk_t9e1mnpydje0rsvinxq68q1i6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandcodes
    ADD CONSTRAINT uk_t9e1mnpydje0rsvinxq68q1i6 UNIQUE (codeid);


--
-- Name: indicator uk_ta80keoi67443tkvvmx8l872x; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT uk_ta80keoi67443tkvvmx8l872x UNIQUE (uid);


--
-- Name: programnotificationinstance uk_takpuhb2893t7bbbak9ym3kq9; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT uk_takpuhb2893t7bbbak9ym3kq9 UNIQUE (uid);


--
-- Name: period uk_tbkbjga8h4j5u33d7hbcuk66t; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.period
    ADD CONSTRAINT uk_tbkbjga8h4j5u33d7hbcuk66t UNIQUE (periodtypeid, startdate, enddate);


--
-- Name: reporttableusergroupaccesses uk_tbro727eo15qmn3ghlhoyifih; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableusergroupaccesses
    ADD CONSTRAINT uk_tbro727eo15qmn3ghlhoyifih UNIQUE (usergroupaccessid);


--
-- Name: programstageusergroupaccesses uk_tcggvcb1rsd9tlnd1ub7mt0e0; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageusergroupaccesses
    ADD CONSTRAINT uk_tcggvcb1rsd9tlnd1ub7mt0e0 UNIQUE (usergroupaccessid);


--
-- Name: programstageattributevalues uk_tcx1w0yoc6k0h8qnagg18eqs6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageattributevalues
    ADD CONSTRAINT uk_tcx1w0yoc6k0h8qnagg18eqs6 UNIQUE (attributevalueid);


--
-- Name: trackedentityprogramowner uk_tei_program; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramowner
    ADD CONSTRAINT uk_tei_program UNIQUE (trackedentityinstanceid, programid);


--
-- Name: programsection uk_tglbwfy1e3ubt5x5hab46qbh6; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection
    ADD CONSTRAINT uk_tglbwfy1e3ubt5x5hab46qbh6 UNIQUE (code);


--
-- Name: trackedentitytype uk_thb8irn2kmm7jay3vcogqxy3x; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytype
    ADD CONSTRAINT uk_thb8irn2kmm7jay3vcogqxy3x UNIQUE (name);


--
-- Name: keyjsonvalue uk_tikknlgl0im3w68yvlb0swrgd; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalue
    ADD CONSTRAINT uk_tikknlgl0im3w68yvlb0swrgd UNIQUE (code);


--
-- Name: predictorgroupuseraccesses uk_tlmeul8tsuy1ewbaw1bkwbq55; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupuseraccesses
    ADD CONSTRAINT uk_tlmeul8tsuy1ewbaw1bkwbq55 UNIQUE (useraccessid);


--
-- Name: trackedentitytype uk_to3d8d23u9behgh9acdu2wjvl; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytype
    ADD CONSTRAINT uk_to3d8d23u9behgh9acdu2wjvl UNIQUE (code);


--
-- Name: predictor unique_generator_expression; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT unique_generator_expression UNIQUE (generatorexpressionid);


--
-- Name: validationrule unique_left_expression; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT unique_left_expression UNIQUE (leftexpressionid);


--
-- Name: validationrule unique_right_expression; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT unique_right_expression UNIQUE (rightexpressionid);


--
-- Name: predictor unique_skip_test_expression; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT unique_skip_test_expression UNIQUE (skiptestexpressionid);


--
-- Name: useraccess useraccess_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.useraccess
    ADD CONSTRAINT useraccess_pkey PRIMARY KEY (useraccessid);


--
-- Name: userapps userapps_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userapps
    ADD CONSTRAINT userapps_pkey PRIMARY KEY (userinfoid, sort_order);


--
-- Name: userattributevalues userattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userattributevalues
    ADD CONSTRAINT userattributevalues_pkey PRIMARY KEY (userinfoid, attributevalueid);


--
-- Name: userdatavieworgunits userdatavieworgunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userdatavieworgunits
    ADD CONSTRAINT userdatavieworgunits_pkey PRIMARY KEY (userinfoid, organisationunitid);


--
-- Name: usergroup usergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT usergroup_pkey PRIMARY KEY (usergroupid);


--
-- Name: usergroupaccess usergroupaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupaccess
    ADD CONSTRAINT usergroupaccess_pkey PRIMARY KEY (usergroupaccessid);


--
-- Name: usergroupattributevalues usergroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupattributevalues
    ADD CONSTRAINT usergroupattributevalues_pkey PRIMARY KEY (usergroupid, attributevalueid);


--
-- Name: usergroupmanaged usergroupmanaged_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupmanaged
    ADD CONSTRAINT usergroupmanaged_pkey PRIMARY KEY (managedbygroupid, managedgroupid);


--
-- Name: usergroupmembers usergroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupmembers
    ADD CONSTRAINT usergroupmembers_pkey PRIMARY KEY (usergroupid, userid);


--
-- Name: usergroupuseraccesses usergroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupuseraccesses
    ADD CONSTRAINT usergroupuseraccesses_pkey PRIMARY KEY (usergroupid, useraccessid);


--
-- Name: usergroupusergroupaccesses usergroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupusergroupaccesses
    ADD CONSTRAINT usergroupusergroupaccesses_pkey PRIMARY KEY (usergroupid, usergroupaccessid);


--
-- Name: userinfo userinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT userinfo_pkey PRIMARY KEY (userinfoid);


--
-- Name: userkeyjsonvalue userkeyjsonvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userkeyjsonvalue
    ADD CONSTRAINT userkeyjsonvalue_pkey PRIMARY KEY (userkeyjsonvalueid);


--
-- Name: userkeyjsonvalue userkeyjsonvalue_unique_key_on_user_and_namespace; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userkeyjsonvalue
    ADD CONSTRAINT userkeyjsonvalue_unique_key_on_user_and_namespace UNIQUE (userid, namespace, userkey);


--
-- Name: usermembership usermembership_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usermembership
    ADD CONSTRAINT usermembership_pkey PRIMARY KEY (userinfoid, organisationunitid);


--
-- Name: usermessage usermessage_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usermessage
    ADD CONSTRAINT usermessage_pkey PRIMARY KEY (usermessageid);


--
-- Name: userrole userrole_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT userrole_pkey PRIMARY KEY (userroleid);


--
-- Name: userrolemembers userrolemembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrolemembers
    ADD CONSTRAINT userrolemembers_pkey PRIMARY KEY (userid, userroleid);


--
-- Name: userroleuseraccesses userroleuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleuseraccesses
    ADD CONSTRAINT userroleuseraccesses_pkey PRIMARY KEY (userroleid, useraccessid);


--
-- Name: userroleusergroupaccesses userroleusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleusergroupaccesses
    ADD CONSTRAINT userroleusergroupaccesses_pkey PRIMARY KEY (userroleid, usergroupaccessid);


--
-- Name: users_catdimensionconstraints users_catdimensionconstraints_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users_catdimensionconstraints
    ADD CONSTRAINT users_catdimensionconstraints_pkey PRIMARY KEY (userid, dataelementcategoryid);


--
-- Name: users_cogsdimensionconstraints users_cogsdimensionconstraints_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users_cogsdimensionconstraints
    ADD CONSTRAINT users_cogsdimensionconstraints_pkey PRIMARY KEY (userid, categoryoptiongroupsetid);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: usersetting usersetting_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usersetting
    ADD CONSTRAINT usersetting_pkey PRIMARY KEY (userinfoid, name);


--
-- Name: userteisearchorgunits userteisearchorgunits_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userteisearchorgunits
    ADD CONSTRAINT userteisearchorgunits_pkey PRIMARY KEY (userinfoid, organisationunitid);


--
-- Name: validationnotificationtemplate validationnotificationtemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate
    ADD CONSTRAINT validationnotificationtemplate_pkey PRIMARY KEY (validationnotificationtemplateid);


--
-- Name: validationnotificationtemplate_recipientusergroups validationnotificationtemplate_recipientusergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate_recipientusergroups
    ADD CONSTRAINT validationnotificationtemplate_recipientusergroups_pkey PRIMARY KEY (validationnotificationtemplateid, usergroupid);


--
-- Name: validationnotificationtemplatevalidationrules validationnotificationtemplatevalidationrules_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplatevalidationrules
    ADD CONSTRAINT validationnotificationtemplatevalidationrules_pkey PRIMARY KEY (validationnotificationtemplateid, validationruleid);


--
-- Name: validationresult validationresult_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationresult
    ADD CONSTRAINT validationresult_pkey PRIMARY KEY (validationresultid);


--
-- Name: validationrule validationrule_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT validationrule_pkey PRIMARY KEY (validationruleid);


--
-- Name: validationruleattributevalues validationruleattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleattributevalues
    ADD CONSTRAINT validationruleattributevalues_pkey PRIMARY KEY (validationruleid, attributevalueid);


--
-- Name: validationrulegroup validationrulegroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroup
    ADD CONSTRAINT validationrulegroup_pkey PRIMARY KEY (validationrulegroupid);


--
-- Name: validationrulegroupattributevalues validationrulegroupattributevalues_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupattributevalues
    ADD CONSTRAINT validationrulegroupattributevalues_pkey PRIMARY KEY (validationrulegroupid, attributevalueid);


--
-- Name: validationrulegroupmembers validationrulegroupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupmembers
    ADD CONSTRAINT validationrulegroupmembers_pkey PRIMARY KEY (validationgroupid, validationruleid);


--
-- Name: validationrulegroupuseraccesses validationrulegroupuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupuseraccesses
    ADD CONSTRAINT validationrulegroupuseraccesses_pkey PRIMARY KEY (validationrulegroupid, useraccessid);


--
-- Name: validationrulegroupusergroupaccesses validationrulegroupusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupusergroupaccesses
    ADD CONSTRAINT validationrulegroupusergroupaccesses_pkey PRIMARY KEY (validationrulegroupid, usergroupaccessid);


--
-- Name: validationruleuseraccesses validationruleuseraccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleuseraccesses
    ADD CONSTRAINT validationruleuseraccesses_pkey PRIMARY KEY (validationruleid, useraccessid);


--
-- Name: validationruleusergroupaccesses validationruleusergroupaccesses_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleusergroupaccesses
    ADD CONSTRAINT validationruleusergroupaccesses_pkey PRIMARY KEY (validationruleid, usergroupaccessid);


--
-- Name: version version_pkey; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_pkey PRIMARY KEY (versionid);


--
-- Name: version version_versionkey_key; Type: CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.version
    ADD CONSTRAINT version_versionkey_key UNIQUE (versionkey);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: id_datavalueaudit_created; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX id_datavalueaudit_created ON public.datavalueaudit USING btree (created);


--
-- Name: in_categories_categoryoptions_coid_bp; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_categories_categoryoptions_coid_bp ON public.categories_categoryoptions USING btree (categoryoptionid, categoryid DESC);


--
-- Name: in_categoryoptioncombo_name; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_categoryoptioncombo_name ON public.categoryoptioncombo USING btree (name);


--
-- Name: in_dataapprovallevel_level; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_dataapprovallevel_level ON public.dataapprovallevel USING btree (level);


--
-- Name: in_datavalue_deleted; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_datavalue_deleted ON public.datavalue USING btree (deleted);


--
-- Name: in_datavalue_lastupdated; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_datavalue_lastupdated ON public.datavalue USING btree (lastupdated);


--
-- Name: in_datavalueaudit; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_datavalueaudit ON public.datavalueaudit USING btree (dataelementid, periodid, organisationunitid, categoryoptioncomboid, attributeoptioncomboid);


--
-- Name: in_interpretation_mentions_username; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_interpretation_mentions_username ON public.interpretation USING gin (((mentions -> 'username'::text)) jsonb_path_ops);


--
-- Name: in_interpretationcomment_mentions_username; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_interpretationcomment_mentions_username ON public.interpretationcomment USING gin (((mentions -> 'username'::text)) jsonb_path_ops);


--
-- Name: in_organisationunit_hierarchylevel; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_organisationunit_hierarchylevel ON public.organisationunit USING btree (hierarchylevel);


--
-- Name: in_organisationunit_path; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_organisationunit_path ON public.organisationunit USING btree (path);


--
-- Name: in_parentid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_parentid ON public.organisationunit USING btree (parentid);


--
-- Name: in_programinstance_deleted; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_programinstance_deleted ON public.programinstance USING btree (deleted);


--
-- Name: in_trackedentityattributevalue_attributeid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_trackedentityattributevalue_attributeid ON public.trackedentityattributevalue USING btree (trackedentityattributeid);


--
-- Name: in_trackedentityinstance_deleted; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_trackedentityinstance_deleted ON public.trackedentityinstance USING btree (deleted);


--
-- Name: in_trackedentityinstance_organisationunitid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX in_trackedentityinstance_organisationunitid ON public.trackedentityinstance USING btree (organisationunitid);


--
-- Name: index_programinstance; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX index_programinstance ON public.programinstance USING btree (programinstanceid);


--
-- Name: index_trackedentitydatavalueaudit_programstageinstanceid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX index_trackedentitydatavalueaudit_programstageinstanceid ON public.trackedentitydatavalueaudit USING btree (programstageinstanceid);


--
-- Name: interpretation_lastupdated; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX interpretation_lastupdated ON public.interpretation USING btree (lastupdated);


--
-- Name: maplegend_endvalue; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX maplegend_endvalue ON public.maplegend USING btree (endvalue);


--
-- Name: maplegend_startvalue; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX maplegend_startvalue ON public.maplegend USING btree (startvalue);


--
-- Name: messageconversation_lastmessage; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX messageconversation_lastmessage ON public.messageconversation USING btree (lastmessage);


--
-- Name: outbound_sms_status_index; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX outbound_sms_status_index ON public.outbound_sms USING btree (status);


--
-- Name: programstageinstance_executiondate; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX programstageinstance_executiondate ON public.programstageinstance USING btree (executiondate);


--
-- Name: programstageinstance_organisationunitid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX programstageinstance_organisationunitid ON public.programstageinstance USING btree (organisationunitid);


--
-- Name: programstageinstance_programinstanceid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX programstageinstance_programinstanceid ON public.programstageinstance USING btree (programinstanceid);


--
-- Name: sms_originator_index; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX sms_originator_index ON public.incomingsms USING btree (originator);


--
-- Name: sms_status_index; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX sms_status_index ON public.incomingsms USING btree (status);


--
-- Name: userkeyjsonvalue_user; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX userkeyjsonvalue_user ON public.userkeyjsonvalue USING btree (userid);


--
-- Name: usermessage_isread; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX usermessage_isread ON public.usermessage USING btree (isread);


--
-- Name: usermessage_userid; Type: INDEX; Schema: public; Owner: dhis
--

CREATE INDEX usermessage_userid ON public.usermessage USING btree (userid);


--
-- Name: datasetattributevalues fk14vlc8tv4kna36p6qonceo8ma; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetattributevalues
    ADD CONSTRAINT fk14vlc8tv4kna36p6qonceo8ma FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: programstageuseraccesses fk169bwamdcwh0lg6aps61gvmlk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageuseraccesses
    ADD CONSTRAINT fk169bwamdcwh0lg6aps61gvmlk FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: externalmaplayeruseraccesses fk17dg8ly2uqt4ia9s9r2n3ujdw; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayeruseraccesses
    ADD CONSTRAINT fk17dg8ly2uqt4ia9s9r2n3ujdw FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataelementgroupusergroupaccesses fk1nlm1116kc90wbuo78notvb9v; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupusergroupaccesses
    ADD CONSTRAINT fk1nlm1116kc90wbuo78notvb9v FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: indicatorlegendsets fk1ps7mt73qi3wnt6f5g6w6flga; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorlegendsets
    ADD CONSTRAINT fk1ps7mt73qi3wnt6f5g6w6flga FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: programindicatorgroupattributevalues fk1ucfah0si2drvdg2k3j9nj2e9; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupattributevalues
    ADD CONSTRAINT fk1ucfah0si2drvdg2k3j9nj2e9 FOREIGN KEY (programindicatorgroupid) REFERENCES public.programindicatorgroup(programindicatorgroupid);


--
-- Name: usergroupattributevalues fk25i3g1nx0hyjsim5cybdi73ly; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupattributevalues
    ADD CONSTRAINT fk25i3g1nx0hyjsim5cybdi73ly FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: reporttableusergroupaccesses fk25krkr877ipngidd8k4qkpb38; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableusergroupaccesses
    ADD CONSTRAINT fk25krkr877ipngidd8k4qkpb38 FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reportuseraccesses fk261naj7ctjaktanyq0hv5j9ec; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportuseraccesses
    ADD CONSTRAINT fk261naj7ctjaktanyq0hv5j9ec FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: categoryoptiongroupsetuseraccesses fk27ph3jnjpt5qvqp5xy7adfehn; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetuseraccesses
    ADD CONSTRAINT fk27ph3jnjpt5qvqp5xy7adfehn FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataelementcategoryoptionuseraccesses fk2en3xn8maci4icitadrfn0paq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionuseraccesses
    ADD CONSTRAINT fk2en3xn8maci4icitadrfn0paq FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: programuseraccesses fk2hy76oam582siq2tjq2n1dyya; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programuseraccesses
    ADD CONSTRAINT fk2hy76oam582siq2tjq2n1dyya FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: sqlviewattributevalues fk2n7d98hdtlwjacpfd8f7bnpgy; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewattributevalues
    ADD CONSTRAINT fk2n7d98hdtlwjacpfd8f7bnpgy FOREIGN KEY (sqlviewid) REFERENCES public.sqlview(sqlviewid);


--
-- Name: programindicatorgroupusergroupaccesses fk2tjsnauyet9p1qwk3nnbo7tm3; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupusergroupaccesses
    ADD CONSTRAINT fk2tjsnauyet9p1qwk3nnbo7tm3 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: categorycombousergroupaccesses fk2vbi3ug5jo15ao7pql8ap283j; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombousergroupaccesses
    ADD CONSTRAINT fk2vbi3ug5jo15ao7pql8ap283j FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: optiongroupusergroupaccesses fk2wqhml4htbnncy911df1io95h; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupusergroupaccesses
    ADD CONSTRAINT fk2wqhml4htbnncy911df1io95h FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: categoryoptiongroupattributevalues fk2y3uap3vg76fuvmg2mit64y70; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupattributevalues
    ADD CONSTRAINT fk2y3uap3vg76fuvmg2mit64y70 FOREIGN KEY (categoryoptiongroupid) REFERENCES public.categoryoptiongroup(categoryoptiongroupid);


--
-- Name: programmessage_phonenumbers fk3408hwfswvwfqyfngk1tf5ju8; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage_phonenumbers
    ADD CONSTRAINT fk3408hwfswvwfqyfngk1tf5ju8 FOREIGN KEY (programmessagephonenumberid) REFERENCES public.programmessage(id);


--
-- Name: dataelementcategoryuseraccesses fk3b6oymmmc1kscrruinyqpdev8; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryuseraccesses
    ADD CONSTRAINT fk3b6oymmmc1kscrruinyqpdev8 FOREIGN KEY (categoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: datasetuseraccesses fk3knplmujf5s9xim8b0ji5krt7; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetuseraccesses
    ADD CONSTRAINT fk3knplmujf5s9xim8b0ji5krt7 FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: orgunitgroupuseraccesses fk3ko28qvx8nwkvmsvyijpswt6s; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupuseraccesses
    ADD CONSTRAINT fk3ko28qvx8nwkvmsvyijpswt6s FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: trackedentityattributeattributevalues fk3s1raibq34uci95vn5fqihjbs; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeattributevalues
    ADD CONSTRAINT fk3s1raibq34uci95vn5fqihjbs FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: trackedentityattributeusergroupaccesses fk3tej1kap633bf97p6qdrd7ivi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeusergroupaccesses
    ADD CONSTRAINT fk3tej1kap633bf97p6qdrd7ivi FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: orgunitgroupattributevalues fk3x7f8b9rivyb7mrc7nf2wgn6v; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupattributevalues
    ADD CONSTRAINT fk3x7f8b9rivyb7mrc7nf2wgn6v FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: optiongroupsetusergroupaccesses fk40ivchljqy3lak45vpxj1spvq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetusergroupaccesses
    ADD CONSTRAINT fk40ivchljqy3lak45vpxj1spvq FOREIGN KEY (optiongroupsetid) REFERENCES public.optiongroupset(optiongroupsetid);


--
-- Name: sqlviewattributevalues fk445gf30dsp88q10ukoktc675d; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewattributevalues
    ADD CONSTRAINT fk445gf30dsp88q10ukoktc675d FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: programnotificationtemplate_deliverychannel fk45uc7wfpi4u5gunpl127ehkn2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate_deliverychannel
    ADD CONSTRAINT fk45uc7wfpi4u5gunpl127ehkn2 FOREIGN KEY (programnotificationtemplatedeliverychannelid) REFERENCES public.programnotificationtemplate(programnotificationtemplateid);


--
-- Name: categoryattributevalues fk4cwq4ysgpr0omhroce0hhw40h; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryattributevalues
    ADD CONSTRAINT fk4cwq4ysgpr0omhroce0hhw40h FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: indicatorattributevalues fk4j6haj9rbsdi5mg4h2g9bp5f4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorattributevalues
    ADD CONSTRAINT fk4j6haj9rbsdi5mg4h2g9bp5f4 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: programnotificationtemplate fk4uq2bl31hdu2s4e07rltemk3d; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT fk4uq2bl31hdu2s4e07rltemk3d FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: relationshiptypeusergroupaccesses fk4vqjiri1ppjof75sjp3xjcasa; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeusergroupaccesses
    ADD CONSTRAINT fk4vqjiri1ppjof75sjp3xjcasa FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: externalmaplayeruseraccesses fk53xs445txmje6ydbb5lcsg3q2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayeruseraccesses
    ADD CONSTRAINT fk53xs445txmje6ydbb5lcsg3q2 FOREIGN KEY (externalmaplayerid) REFERENCES public.externalmaplayer(externalmaplayerid);


--
-- Name: optionattributevalues fk55kladmsl0xiqpe7b3kfus2kx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionattributevalues
    ADD CONSTRAINT fk55kladmsl0xiqpe7b3kfus2kx FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: interpretationusergroupaccesses fk57fqx6vjg8e4yxdr49rh4e2cg; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationusergroupaccesses
    ADD CONSTRAINT fk57fqx6vjg8e4yxdr49rh4e2cg FOREIGN KEY (interpretationid) REFERENCES public.interpretation(interpretationid);


--
-- Name: indicatorgroupuseraccesses fk58p9nvj8c68sjfsc0q27a2xit; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupuseraccesses
    ADD CONSTRAINT fk58p9nvj8c68sjfsc0q27a2xit FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataapprovallevelusergroupaccesses fk5lkioy2ni66gkhk1py1lg2ksk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevelusergroupaccesses
    ADD CONSTRAINT fk5lkioy2ni66gkhk1py1lg2ksk FOREIGN KEY (dataapprovallevelid) REFERENCES public.dataapprovallevel(dataapprovallevelid);


--
-- Name: categoryoptiongroupusergroupaccesses fk5mc47seuei76yjk4pne9xco4y; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupusergroupaccesses
    ADD CONSTRAINT fk5mc47seuei76yjk4pne9xco4y FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataapprovalworkflowusergroupaccesses fk5ueo0ouvw1w8ym3bl5a4gy7jb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowusergroupaccesses
    ADD CONSTRAINT fk5ueo0ouvw1w8ym3bl5a4gy7jb FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: orgunitgroupuseraccesses fk670e2rtv9vmfavfqhvew7sq1m; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupuseraccesses
    ADD CONSTRAINT fk670e2rtv9vmfavfqhvew7sq1m FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: trackedentitytypeattributevalues fk68hlhkbcb70p0241g1jb98iay; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattributevalues
    ADD CONSTRAINT fk68hlhkbcb70p0241g1jb98iay FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: orgunitgroupsetattributevalues fk6eqh97iasvtf9f786haw0fne; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetattributevalues
    ADD CONSTRAINT fk6eqh97iasvtf9f786haw0fne FOREIGN KEY (orgunitgroupsetid) REFERENCES public.orgunitgroupset(orgunitgroupsetid);


--
-- Name: programindicatorgroupuseraccesses fk6hw4ynygmiti256ythmeebnub; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupuseraccesses
    ADD CONSTRAINT fk6hw4ynygmiti256ythmeebnub FOREIGN KEY (programindicatorgroupid) REFERENCES public.programindicatorgroup(programindicatorgroupid);


--
-- Name: validationruleusergroupaccesses fk6irf8ungs18rk05t3whhoqsyn; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleusergroupaccesses
    ADD CONSTRAINT fk6irf8ungs18rk05t3whhoqsyn FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: programindicatoruseraccesses fk6l06lsyo0l0d2clfc32fv0n98; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatoruseraccesses
    ADD CONSTRAINT fk6l06lsyo0l0d2clfc32fv0n98 FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: relationshiptypeuseraccesses fk6mx7b04k8t40gm12182h1q58p; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeuseraccesses
    ADD CONSTRAINT fk6mx7b04k8t40gm12182h1q58p FOREIGN KEY (relationshiptypeid) REFERENCES public.relationshiptype(relationshiptypeid);


--
-- Name: validationnotificationtemplatevalidationrules fk6oepnl7prbw10034c5vot1jii; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplatevalidationrules
    ADD CONSTRAINT fk6oepnl7prbw10034c5vot1jii FOREIGN KEY (validationnotificationtemplateid) REFERENCES public.validationnotificationtemplate(validationnotificationtemplateid);


--
-- Name: legendsetusergroupaccesses fk6q6o2a3x04ku7vfng6c08dl6m; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetusergroupaccesses
    ADD CONSTRAINT fk6q6o2a3x04ku7vfng6c08dl6m FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: trackedentityattributeuseraccesses fk6uqjm4icdf9d4j2tjaj7qbkku; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeuseraccesses
    ADD CONSTRAINT fk6uqjm4icdf9d4j2tjaj7qbkku FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: mapuseraccesses fk6yw6wg9dpo1x48nh29ch85ipl; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapuseraccesses
    ADD CONSTRAINT fk6yw6wg9dpo1x48nh29ch85ipl FOREIGN KEY (mapid) REFERENCES public.map(mapid);


--
-- Name: orgunitgroupsetuseraccesses fk73nohma99yprhk24ffqvbxm4p; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetuseraccesses
    ADD CONSTRAINT fk73nohma99yprhk24ffqvbxm4p FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: programindicatorgroupuseraccesses fk73om9vfg9ar4dyb74g57g6uq8; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupuseraccesses
    ADD CONSTRAINT fk73om9vfg9ar4dyb74g57g6uq8 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: usergroupuseraccesses fk78yso1e1xehykrg7kunk5xhdr; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupuseraccesses
    ADD CONSTRAINT fk78yso1e1xehykrg7kunk5xhdr FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: indicatorgroupusergroupaccesses fk7a1b7xygd4kd7364syo7igha; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupusergroupaccesses
    ADD CONSTRAINT fk7a1b7xygd4kd7364syo7igha FOREIGN KEY (indicatorgroupid) REFERENCES public.indicatorgroup(indicatorgroupid);


--
-- Name: indicatorgroupattributevalues fk7aq28bhq2xnps53lpjrgchpoo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupattributevalues
    ADD CONSTRAINT fk7aq28bhq2xnps53lpjrgchpoo FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: programindicatorattributevalues fk7foo7k55ee6dko9a0a0jtxavx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorattributevalues
    ADD CONSTRAINT fk7foo7k55ee6dko9a0a0jtxavx FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: constantattributevalues fk7gxwqyqxq8cdxbwpl7unmmi9j; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantattributevalues
    ADD CONSTRAINT fk7gxwqyqxq8cdxbwpl7unmmi9j FOREIGN KEY (constantid) REFERENCES public.constant(constantid);


--
-- Name: dataapprovalworkflowuseraccesses fk7log6kkhhxdl8wbqirtw7rfbg; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowuseraccesses
    ADD CONSTRAINT fk7log6kkhhxdl8wbqirtw7rfbg FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataelementuseraccesses fk7onryyh9j4cl5xif3evbji9oo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementuseraccesses
    ADD CONSTRAINT fk7onryyh9j4cl5xif3evbji9oo FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: organisationunitattributevalues fk7utgogpv8n5r4yxm41lhd70i0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunitattributevalues
    ADD CONSTRAINT fk7utgogpv8n5r4yxm41lhd70i0 FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: validationnotificationtemplate_recipientusergroups fk804hp0os62rpdtroxhrrio76v; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate_recipientusergroups
    ADD CONSTRAINT fk804hp0os62rpdtroxhrrio76v FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: programattributevalues fk8eefwcsoitkehdl4qbpslnejb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programattributevalues
    ADD CONSTRAINT fk8eefwcsoitkehdl4qbpslnejb FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: dataelementcategoryoptionuseraccesses fk8o4ix9ywdk0gexesm549n4w2e; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionuseraccesses
    ADD CONSTRAINT fk8o4ix9ywdk0gexesm549n4w2e FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataelementcategoryusergroupaccesses fk8uk4v6qlon9hw0wlqsnrqj1wy; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryusergroupaccesses
    ADD CONSTRAINT fk8uk4v6qlon9hw0wlqsnrqj1wy FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataapprovalworkflowuseraccesses fk90tm9l2djy6bjuimlggl6p2x4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowuseraccesses
    ADD CONSTRAINT fk90tm9l2djy6bjuimlggl6p2x4 FOREIGN KEY (workflowid) REFERENCES public.dataapprovalworkflow(workflowid);


--
-- Name: legendsetusergroupaccesses fk99kbmh5vouduw7bf7sm6buvbm; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetusergroupaccesses
    ADD CONSTRAINT fk99kbmh5vouduw7bf7sm6buvbm FOREIGN KEY (maplegendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: validationrulegroupusergroupaccesses fk9bekfhcd0225ip2lu83ub6hb8; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupusergroupaccesses
    ADD CONSTRAINT fk9bekfhcd0225ip2lu83ub6hb8 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: datasetlegendsets fk9f6ich22mw6be835i07khg9ld; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetlegendsets
    ADD CONSTRAINT fk9f6ich22mw6be835i07khg9ld FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: validationrulegroupuseraccesses fk9guu2s1eedfk6du56ouxuvl6m; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupuseraccesses
    ADD CONSTRAINT fk9guu2s1eedfk6du56ouxuvl6m FOREIGN KEY (validationrulegroupid) REFERENCES public.validationrulegroup(validationrulegroupid);


--
-- Name: programuseraccesses fk9h3291piptvo283t9lblgnavo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programuseraccesses
    ADD CONSTRAINT fk9h3291piptvo283t9lblgnavo FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programstageattributevalues fk9jqvlhax7y8ea3i2q1qg4m08o; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageattributevalues
    ADD CONSTRAINT fk9jqvlhax7y8ea3i2q1qg4m08o FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: programattributevalues fk9tpnab44tsrxexa47qvr6dnq2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programattributevalues
    ADD CONSTRAINT fk9tpnab44tsrxexa47qvr6dnq2 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: programnotificationtemplate fk9whlsdwfojxbp8yclqolqwm9; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT fk9whlsdwfojxbp8yclqolqwm9 FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: eventchartusergroupaccesses fk9ylyd0xaehcn0gqr8d2stlr5q; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartusergroupaccesses
    ADD CONSTRAINT fk9ylyd0xaehcn0gqr8d2stlr5q FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: attribute fk_attribute_optionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT fk_attribute_optionsetid FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: attribute fk_attribute_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT fk_attribute_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: attributevalue fk_attributevalue_attributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributevalue
    ADD CONSTRAINT fk_attributevalue_attributeid FOREIGN KEY (attributeid) REFERENCES public.attribute(attributeid);


--
-- Name: trackedentityattributevalue fk_attributevalue_trackedentityattributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributevalue
    ADD CONSTRAINT fk_attributevalue_trackedentityattributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: trackedentityattributevalue fk_attributevalue_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributevalue
    ADD CONSTRAINT fk_attributevalue_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: trackedentityattributevalueaudit fk_attributevalueaudit_trackedentityattributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributevalueaudit
    ADD CONSTRAINT fk_attributevalueaudit_trackedentityattributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: trackedentityattributevalueaudit fk_attributevalueaudit_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributevalueaudit
    ADD CONSTRAINT fk_attributevalueaudit_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: categories_categoryoptions fk_categories_categoryoptions_categoryid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categories_categoryoptions
    ADD CONSTRAINT fk_categories_categoryoptions_categoryid FOREIGN KEY (categoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: categories_categoryoptions fk_category_categoryoptionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categories_categoryoptions
    ADD CONSTRAINT fk_category_categoryoptionid FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: categorycombos_categories fk_categorycombo_categoryid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombos_categories
    ADD CONSTRAINT fk_categorycombo_categoryid FOREIGN KEY (categoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: categorycombos_optioncombos fk_categorycombo_categoryoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombos_optioncombos
    ADD CONSTRAINT fk_categorycombo_categoryoptioncomboid FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: categorycombo fk_categorycombo_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombo
    ADD CONSTRAINT fk_categorycombo_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: categorycombos_categories fk_categorycombos_categories_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombos_categories
    ADD CONSTRAINT fk_categorycombos_categories_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: categorycombos_optioncombos fk_categorycombos_optioncombos_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombos_optioncombos
    ADD CONSTRAINT fk_categorycombos_optioncombos_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: categorydimension fk_categorydimension_category; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorydimension
    ADD CONSTRAINT fk_categorydimension_category FOREIGN KEY (categoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: categorydimension_items fk_categorydimension_items_categorydimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorydimension_items
    ADD CONSTRAINT fk_categorydimension_items_categorydimensionid FOREIGN KEY (categorydimensionid) REFERENCES public.categorydimension(categorydimensionid);


--
-- Name: categorydimension_items fk_categorydimension_items_categoryoptionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorydimension_items
    ADD CONSTRAINT fk_categorydimension_items_categoryoptionid FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: categoryoptioncombos_categoryoptions fk_categoryoption_categoryoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombos_categoryoptions
    ADD CONSTRAINT fk_categoryoption_categoryoptioncomboid FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: categoryoption_organisationunits fk_categoryoption_organisationunits_categoryoptionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoption_organisationunits
    ADD CONSTRAINT fk_categoryoption_organisationunits_categoryoptionid FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: categoryoption_organisationunits fk_categoryoption_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoption_organisationunits
    ADD CONSTRAINT fk_categoryoption_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: categoryoptioncombos_categoryoptions fk_categoryoptioncombos_categoryoptions_categoryoptionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombos_categoryoptions
    ADD CONSTRAINT fk_categoryoptioncombos_categoryoptions_categoryoptionid FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: categoryoptiongroup fk_categoryoptiongroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT fk_categoryoptiongroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: categoryoptiongroupmembers fk_categoryoptiongroupmembers_categoryoptiongroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupmembers
    ADD CONSTRAINT fk_categoryoptiongroupmembers_categoryoptiongroupid FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: categoryoptiongroupmembers fk_categoryoptiongroupmembers_categoryoptionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupmembers
    ADD CONSTRAINT fk_categoryoptiongroupmembers_categoryoptionid FOREIGN KEY (categoryoptiongroupid) REFERENCES public.categoryoptiongroup(categoryoptiongroupid);


--
-- Name: categoryoptiongroupset fk_categoryoptiongroupset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupset
    ADD CONSTRAINT fk_categoryoptiongroupset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: categoryoptiongroupsetmembers fk_categoryoptiongroupsetmembers_categoryoptiongroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetmembers
    ADD CONSTRAINT fk_categoryoptiongroupsetmembers_categoryoptiongroupid FOREIGN KEY (categoryoptiongroupid) REFERENCES public.categoryoptiongroup(categoryoptiongroupid);


--
-- Name: categoryoptiongroupsetmembers fk_categoryoptiongroupsetmembers_categoryoptiongroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetmembers
    ADD CONSTRAINT fk_categoryoptiongroupsetmembers_categoryoptiongroupsetid FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: chart_categorydimensions fk_chart_categorydimensions_categorydimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_categorydimensions
    ADD CONSTRAINT fk_chart_categorydimensions_categorydimensionid FOREIGN KEY (categorydimensionid) REFERENCES public.categorydimension(categorydimensionid);


--
-- Name: chart_categorydimensions fk_chart_categorydimensions_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_categorydimensions
    ADD CONSTRAINT fk_chart_categorydimensions_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_categoryoptiongroupsetdimensions fk_chart_catoptiongroupsetdimensions_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_chart_catoptiongroupsetdimensions_chartid FOREIGN KEY (chart) REFERENCES public.chart(chartid);


--
-- Name: chart fk_chart_colorsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT fk_chart_colorsetid FOREIGN KEY (colorsetid) REFERENCES public.colorset(colorsetid);


--
-- Name: chart_datadimensionitems fk_chart_datadimensionitems_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_datadimensionitems
    ADD CONSTRAINT fk_chart_datadimensionitems_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_datadimensionitems fk_chart_datadimensionitems_datadimensionitemid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_datadimensionitems
    ADD CONSTRAINT fk_chart_datadimensionitems_datadimensionitemid FOREIGN KEY (datadimensionitemid) REFERENCES public.datadimensionitem(datadimensionitemid);


--
-- Name: chart_categoryoptiongroupsetdimensions fk_chart_dimensions_catoptiongroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_chart_dimensions_catoptiongroupsetdimensionid FOREIGN KEY (categoryoptiongroupsetdimensionid) REFERENCES public.categoryoptiongroupsetdimension(categoryoptiongroupsetdimensionid);


--
-- Name: chart_dataelementgroupsetdimensions fk_chart_dimensions_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_dataelementgroupsetdimensions
    ADD CONSTRAINT fk_chart_dimensions_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_dataelementgroupsetdimensions fk_chart_dimensions_dataelementgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_dataelementgroupsetdimensions
    ADD CONSTRAINT fk_chart_dimensions_dataelementgroupsetdimensionid FOREIGN KEY (dataelementgroupsetdimensionid) REFERENCES public.dataelementgroupsetdimension(dataelementgroupsetdimensionid);


--
-- Name: chart_orgunitgroupsetdimensions fk_chart_dimensions_ogunitgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_chart_dimensions_ogunitgroupsetdimensionid FOREIGN KEY (orgunitgroupsetdimensionid) REFERENCES public.orgunitgroupsetdimension(orgunitgroupsetdimensionid);


--
-- Name: chart_itemorgunitgroups fk_chart_itemorgunitgroups_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_itemorgunitgroups
    ADD CONSTRAINT fk_chart_itemorgunitgroups_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: chart_itemorgunitgroups fk_chart_itemorgunitunitgroups_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_itemorgunitgroups
    ADD CONSTRAINT fk_chart_itemorgunitunitgroups_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart fk_chart_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT fk_chart_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: chart_organisationunits fk_chart_organisationunits_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_organisationunits
    ADD CONSTRAINT fk_chart_organisationunits_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_organisationunits fk_chart_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_organisationunits
    ADD CONSTRAINT fk_chart_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: chart_orgunitgroupsetdimensions fk_chart_orgunitgroupsetdimensions_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_chart_orgunitgroupsetdimensions_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_orgunitlevels fk_chart_orgunitlevels_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_orgunitlevels
    ADD CONSTRAINT fk_chart_orgunitlevels_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_periods fk_chart_periods_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_periods
    ADD CONSTRAINT fk_chart_periods_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_periods fk_chart_periods_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_periods
    ADD CONSTRAINT fk_chart_periods_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: chart fk_chart_relativeperiodsid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT fk_chart_relativeperiodsid FOREIGN KEY (relativeperiodsid) REFERENCES public.relativeperiods(relativeperiodsid);


--
-- Name: chart_seriesitems fk_chart_seriesitems_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_seriesitems
    ADD CONSTRAINT fk_chart_seriesitems_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: chart_seriesitems fk_chart_seriesitems_seriesid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_seriesitems
    ADD CONSTRAINT fk_chart_seriesitems_seriesid FOREIGN KEY (seriesid) REFERENCES public.series(seriesid);


--
-- Name: chart fk_chart_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT fk_chart_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: colorset_colors fk_colorset_colors_colorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset_colors
    ADD CONSTRAINT fk_colorset_colors_colorid FOREIGN KEY (colorid) REFERENCES public.color(colorid);


--
-- Name: colorset_colors fk_colorset_colors_colorsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset_colors
    ADD CONSTRAINT fk_colorset_colors_colorsetid FOREIGN KEY (colorsetid) REFERENCES public.colorset(colorsetid);


--
-- Name: completedatasetregistration fk_completedatasetregistration_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.completedatasetregistration
    ADD CONSTRAINT fk_completedatasetregistration_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: completedatasetregistration fk_completedatasetregistration_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.completedatasetregistration
    ADD CONSTRAINT fk_completedatasetregistration_organisationunitid FOREIGN KEY (sourceid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: configuration_corswhitelist fk_configuration_corswhitelist; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration_corswhitelist
    ADD CONSTRAINT fk_configuration_corswhitelist FOREIGN KEY (configurationid) REFERENCES public.configuration(configurationid);


--
-- Name: configuration fk_configuration_feedback_recipients; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_feedback_recipients FOREIGN KEY (feedbackrecipientsid) REFERENCES public.usergroup(usergroupid);


--
-- Name: configuration fk_configuration_infrastructural_dataelements; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_infrastructural_dataelements FOREIGN KEY (infrastructuraldataelementsid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: configuration fk_configuration_infrastructural_indicators; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_infrastructural_indicators FOREIGN KEY (infrastructuralindicatorsid) REFERENCES public.indicatorgroup(indicatorgroupid);


--
-- Name: configuration fk_configuration_infrastructural_periodtype; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_infrastructural_periodtype FOREIGN KEY (infrastructuralperiodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: configuration fk_configuration_offline_orgunit_level; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_offline_orgunit_level FOREIGN KEY (offlineorgunitlevelid) REFERENCES public.orgunitlevel(orgunitlevelid);


--
-- Name: configuration fk_configuration_selfregistrationorgunit; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_selfregistrationorgunit FOREIGN KEY (selfregistrationorgunit) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: configuration fk_configuration_selfregistrationrole; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT fk_configuration_selfregistrationrole FOREIGN KEY (selfregistrationrole) REFERENCES public.userrole(userroleid);


--
-- Name: constant fk_constant_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT fk_constant_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dashboard_items fk_dashboard_items_dashboardid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard_items
    ADD CONSTRAINT fk_dashboard_items_dashboardid FOREIGN KEY (dashboardid) REFERENCES public.dashboard(dashboardid);


--
-- Name: dashboard_items fk_dashboard_items_dashboarditemid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard_items
    ADD CONSTRAINT fk_dashboard_items_dashboarditemid FOREIGN KEY (dashboarditemid) REFERENCES public.dashboarditem(dashboarditemid);


--
-- Name: dashboard fk_dashboard_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT fk_dashboard_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dashboarditem fk_dashboarditem_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT fk_dashboarditem_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: dashboarditem fk_dashboarditem_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT fk_dashboarditem_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: dashboarditem fk_dashboarditem_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT fk_dashboarditem_eventreportid FOREIGN KEY (eventreport) REFERENCES public.eventreport(eventreportid);


--
-- Name: dashboarditem fk_dashboarditem_mapid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT fk_dashboarditem_mapid FOREIGN KEY (mapid) REFERENCES public.map(mapid);


--
-- Name: dashboarditem_reports fk_dashboarditem_reports_dashboardid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_reports
    ADD CONSTRAINT fk_dashboarditem_reports_dashboardid FOREIGN KEY (dashboarditemid) REFERENCES public.dashboarditem(dashboarditemid);


--
-- Name: dashboarditem_reports fk_dashboarditem_reports_reportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_reports
    ADD CONSTRAINT fk_dashboarditem_reports_reportid FOREIGN KEY (reportid) REFERENCES public.report(reportid);


--
-- Name: dashboarditem fk_dashboarditem_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT fk_dashboarditem_reporttableid FOREIGN KEY (reporttable) REFERENCES public.reporttable(reporttableid);


--
-- Name: dashboarditem_resources fk_dashboarditem_resources_dashboardid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_resources
    ADD CONSTRAINT fk_dashboarditem_resources_dashboardid FOREIGN KEY (dashboarditemid) REFERENCES public.dashboarditem(dashboarditemid);


--
-- Name: dashboarditem_resources fk_dashboarditem_resources_resourceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_resources
    ADD CONSTRAINT fk_dashboarditem_resources_resourceid FOREIGN KEY (resourceid) REFERENCES public.document(documentid);


--
-- Name: dashboarditem_users fk_dashboarditem_users_dashboardid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_users
    ADD CONSTRAINT fk_dashboarditem_users_dashboardid FOREIGN KEY (dashboarditemid) REFERENCES public.dashboarditem(dashboarditemid);


--
-- Name: dashboarditem_users fk_dashboarditem_users_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem_users
    ADD CONSTRAINT fk_dashboarditem_users_userinfoid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapproval fk_dataapproval_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT fk_dataapproval_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: dataapproval fk_dataapproval_creator; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT fk_dataapproval_creator FOREIGN KEY (creator) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapprovalaudit fk_dataapproval_creator; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT fk_dataapproval_creator FOREIGN KEY (creator) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapproval fk_dataapproval_dataapprovallevel; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT fk_dataapproval_dataapprovallevel FOREIGN KEY (dataapprovallevelid) REFERENCES public.dataapprovallevel(dataapprovallevelid);


--
-- Name: dataapproval fk_dataapproval_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT fk_dataapproval_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: dataapproval fk_dataapproval_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT fk_dataapproval_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: dataapproval fk_dataapproval_workflowid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapproval
    ADD CONSTRAINT fk_dataapproval_workflowid FOREIGN KEY (workflowid) REFERENCES public.dataapprovalworkflow(workflowid);


--
-- Name: dataapprovalaudit fk_dataapprovalaudit_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT fk_dataapprovalaudit_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: dataapprovalaudit fk_dataapprovalaudit_levelid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT fk_dataapprovalaudit_levelid FOREIGN KEY (levelid) REFERENCES public.dataapprovallevel(dataapprovallevelid);


--
-- Name: dataapprovalaudit fk_dataapprovalaudit_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT fk_dataapprovalaudit_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: dataapprovalaudit fk_dataapprovalaudit_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT fk_dataapprovalaudit_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: dataapprovalaudit fk_dataapprovalaudit_workflowid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalaudit
    ADD CONSTRAINT fk_dataapprovalaudit_workflowid FOREIGN KEY (workflowid) REFERENCES public.dataapprovalworkflow(workflowid);


--
-- Name: dataapprovallevel fk_dataapprovallevel_categoryoptiongroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT fk_dataapprovallevel_categoryoptiongroupsetid FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: dataapprovallevel fk_dataapprovallevel_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT fk_dataapprovallevel_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapprovalworkflow fk_dataapprovalworkflow_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT fk_dataapprovalworkflow_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: dataapprovalworkflow fk_dataapprovalworkflow_periodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT fk_dataapprovalworkflow_periodtypeid FOREIGN KEY (periodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: dataapprovalworkflow fk_dataapprovalworkflow_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT fk_dataapprovalworkflow_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapprovalworkflowlevels fk_dataapprovalworkflowlevels_levelid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowlevels
    ADD CONSTRAINT fk_dataapprovalworkflowlevels_levelid FOREIGN KEY (dataapprovallevelid) REFERENCES public.dataapprovallevel(dataapprovallevelid);


--
-- Name: dataapprovalworkflowlevels fk_dataapprovalworkflowlevels_workflowid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowlevels
    ADD CONSTRAINT fk_dataapprovalworkflowlevels_workflowid FOREIGN KEY (workflowid) REFERENCES public.dataapprovalworkflow(workflowid);


--
-- Name: datadimensionitem fk_datadimensionitem_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: datadimensionitem fk_datadimensionitem_dataelementoperand_categoryoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_dataelementoperand_categoryoptioncomboid FOREIGN KEY (dataelementoperand_categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: datadimensionitem fk_datadimensionitem_dataelementoperand_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_dataelementoperand_dataelementid FOREIGN KEY (dataelementoperand_dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: datadimensionitem fk_datadimensionitem_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datadimensionitem fk_datadimensionitem_indicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_indicatorid FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: datadimensionitem fk_datadimensionitem_programattribute_attributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_programattribute_attributeid FOREIGN KEY (programattribute_attributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: datadimensionitem fk_datadimensionitem_programattribute_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_programattribute_programid FOREIGN KEY (programattribute_programid) REFERENCES public.program(programid);


--
-- Name: datadimensionitem fk_datadimensionitem_programdataelement_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_programdataelement_dataelementid FOREIGN KEY (programdataelement_dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: datadimensionitem fk_datadimensionitem_programdataelement_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_programdataelement_programid FOREIGN KEY (programdataelement_programid) REFERENCES public.program(programid);


--
-- Name: datadimensionitem fk_datadimensionitem_programindicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datadimensionitem
    ADD CONSTRAINT fk_datadimensionitem_programindicatorid FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: dataelement fk_dataelement_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT fk_dataelement_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: dataelement fk_dataelement_commentoptionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT fk_dataelement_commentoptionsetid FOREIGN KEY (commentoptionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: smscodes fk_dataelement_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscodes
    ADD CONSTRAINT fk_dataelement_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: dataelementlegendsets fk_dataelement_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementlegendsets
    ADD CONSTRAINT fk_dataelement_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: dataelement fk_dataelement_optionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT fk_dataelement_optionsetid FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: dataelement fk_dataelement_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT fk_dataelement_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementaggregationlevels fk_dataelementaggregationlevels_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementaggregationlevels
    ADD CONSTRAINT fk_dataelementaggregationlevels_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: dataelementcategory fk_dataelementcategory_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategory
    ADD CONSTRAINT fk_dataelementcategory_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementcategoryoption fk_dataelementcategoryoption_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT fk_dataelementcategoryoption_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementgroupmembers fk_dataelementgroup_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupmembers
    ADD CONSTRAINT fk_dataelementgroup_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: dataelementgroup fk_dataelementgroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT fk_dataelementgroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementgroupmembers fk_dataelementgroupmembers_dataelementgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupmembers
    ADD CONSTRAINT fk_dataelementgroupmembers_dataelementgroupid FOREIGN KEY (dataelementgroupid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: dataelementgroupsetmembers fk_dataelementgroupset_dataelementgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetmembers
    ADD CONSTRAINT fk_dataelementgroupset_dataelementgroupid FOREIGN KEY (dataelementgroupid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: dataelementgroupset fk_dataelementgroupset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupset
    ADD CONSTRAINT fk_dataelementgroupset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementgroupsetmembers fk_dataelementgroupsetmembers_dataelementgroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetmembers
    ADD CONSTRAINT fk_dataelementgroupsetmembers_dataelementgroupsetid FOREIGN KEY (dataelementgroupsetid) REFERENCES public.dataelementgroupset(dataelementgroupsetid);


--
-- Name: dataelementoperand fk_dataelementoperand_dataelement; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementoperand
    ADD CONSTRAINT fk_dataelementoperand_dataelement FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: dataelementoperand fk_dataelementoperand_dataelementcategoryoptioncombo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementoperand
    ADD CONSTRAINT fk_dataelementoperand_dataelementcategoryoptioncombo FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: datainputperiod fk_datainputperiod_period; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datainputperiod
    ADD CONSTRAINT fk_datainputperiod_period FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: dataset fk_dataset_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: datasetoperands fk_dataset_dataelementoperandid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetoperands
    ADD CONSTRAINT fk_dataset_dataelementoperandid FOREIGN KEY (dataelementoperandid) REFERENCES public.dataelementoperand(dataelementoperandid);


--
-- Name: dataset fk_dataset_dataentryform; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_dataentryform FOREIGN KEY (dataentryform) REFERENCES public.dataentryform(dataentryformid);


--
-- Name: smscommands fk_dataset_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommands
    ADD CONSTRAINT fk_dataset_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datasetindicators fk_dataset_indicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetindicators
    ADD CONSTRAINT fk_dataset_indicatorid FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: datasetlegendsets fk_dataset_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetlegendsets
    ADD CONSTRAINT fk_dataset_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: dataset fk_dataset_notificationrecipients; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_notificationrecipients FOREIGN KEY (notificationrecipients) REFERENCES public.usergroup(usergroupid);


--
-- Name: datasetsource fk_dataset_organisationunit; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetsource
    ADD CONSTRAINT fk_dataset_organisationunit FOREIGN KEY (sourceid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: dataset fk_dataset_periodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_periodtypeid FOREIGN KEY (periodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: dataset fk_dataset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataset fk_dataset_workflowid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_workflowid FOREIGN KEY (workflowid) REFERENCES public.dataapprovalworkflow(workflowid);


--
-- Name: completedatasetregistration fk_datasetcompleteregistration_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.completedatasetregistration
    ADD CONSTRAINT fk_datasetcompleteregistration_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: completedatasetregistration fk_datasetcompleteregistration_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.completedatasetregistration
    ADD CONSTRAINT fk_datasetcompleteregistration_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: datainputperiod fk_datasetdatainputperiods_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datainputperiod
    ADD CONSTRAINT fk_datasetdatainputperiods_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datasetelement fk_datasetelement_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetelement
    ADD CONSTRAINT fk_datasetelement_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: datasetindicators fk_datasetindicators_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetindicators
    ADD CONSTRAINT fk_datasetindicators_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datasetelement fk_datasetmembers_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetelement
    ADD CONSTRAINT fk_datasetmembers_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: datasetelement fk_datasetmembers_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetelement
    ADD CONSTRAINT fk_datasetmembers_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datasetnotificationtemplate fk_datasetnotification_usergroup; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotificationtemplate
    ADD CONSTRAINT fk_datasetnotification_usergroup FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: datasetoperands fk_datasetoperands_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetoperands
    ADD CONSTRAINT fk_datasetoperands_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datasetnotification_datasets fk_datasets_datasetnotificationtemplateid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotification_datasets
    ADD CONSTRAINT fk_datasets_datasetnotificationtemplateid FOREIGN KEY (datasetnotificationtemplateid) REFERENCES public.datasetnotificationtemplate(datasetnotificationtemplateid);


--
-- Name: datasetsource fk_datasetsource_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetsource
    ADD CONSTRAINT fk_datasetsource_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: datavalue fk_datavalue_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalue
    ADD CONSTRAINT fk_datavalue_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: datavalue fk_datavalue_categoryoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalue
    ADD CONSTRAINT fk_datavalue_categoryoptioncomboid FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: datavalue fk_datavalue_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalue
    ADD CONSTRAINT fk_datavalue_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: datavalue fk_datavalue_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalue
    ADD CONSTRAINT fk_datavalue_organisationunitid FOREIGN KEY (sourceid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: datavalue fk_datavalue_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalue
    ADD CONSTRAINT fk_datavalue_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: datavalueaudit fk_datavalueaudit_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalueaudit
    ADD CONSTRAINT fk_datavalueaudit_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: datavalueaudit fk_datavalueaudit_categoryoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalueaudit
    ADD CONSTRAINT fk_datavalueaudit_categoryoptioncomboid FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: datavalueaudit fk_datavalueaudit_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalueaudit
    ADD CONSTRAINT fk_datavalueaudit_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: datavalueaudit fk_datavalueaudit_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalueaudit
    ADD CONSTRAINT fk_datavalueaudit_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: datavalueaudit fk_datavalueaudit_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datavalueaudit
    ADD CONSTRAINT fk_datavalueaudit_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: categoryoptiongroupsetdimension fk_dimension_categoryoptiongroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetdimension
    ADD CONSTRAINT fk_dimension_categoryoptiongroupsetid FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: dataelementgroupsetdimension fk_dimension_dataelementgroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetdimension
    ADD CONSTRAINT fk_dimension_dataelementgroupsetid FOREIGN KEY (dataelementgroupsetid) REFERENCES public.dataelementgroupset(dataelementgroupsetid);


--
-- Name: categoryoptiongroupsetdimension_items fk_dimension_items_categoryoptiongroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetdimension_items
    ADD CONSTRAINT fk_dimension_items_categoryoptiongroupid FOREIGN KEY (categoryoptiongroupid) REFERENCES public.categoryoptiongroup(categoryoptiongroupid);


--
-- Name: categoryoptiongroupsetdimension_items fk_dimension_items_categoryoptiongroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetdimension_items
    ADD CONSTRAINT fk_dimension_items_categoryoptiongroupsetdimensionid FOREIGN KEY (categoryoptiongroupsetdimensionid) REFERENCES public.categoryoptiongroupsetdimension(categoryoptiongroupsetdimensionid);


--
-- Name: dataelementgroupsetdimension_items fk_dimension_items_dataelementgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetdimension_items
    ADD CONSTRAINT fk_dimension_items_dataelementgroupid FOREIGN KEY (dataelementgroupid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: dataelementgroupsetdimension_items fk_dimension_items_dataelementgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetdimension_items
    ADD CONSTRAINT fk_dimension_items_dataelementgroupsetdimensionid FOREIGN KEY (dataelementgroupsetdimensionid) REFERENCES public.dataelementgroupsetdimension(dataelementgroupsetdimensionid);


--
-- Name: orgunitgroupsetdimension_items fk_dimension_items_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetdimension_items
    ADD CONSTRAINT fk_dimension_items_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: orgunitgroupsetdimension_items fk_dimension_items_orgunitgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetdimension_items
    ADD CONSTRAINT fk_dimension_items_orgunitgroupsetdimensionid FOREIGN KEY (orgunitgroupsetdimensionid) REFERENCES public.orgunitgroupsetdimension(orgunitgroupsetdimensionid);


--
-- Name: orgunitgroupsetdimension fk_dimension_orgunitgroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetdimension
    ADD CONSTRAINT fk_dimension_orgunitgroupsetid FOREIGN KEY (orgunitgroupsetid) REFERENCES public.orgunitgroupset(orgunitgroupsetid);


--
-- Name: document fk_document_fileresourceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT fk_document_fileresourceid FOREIGN KEY (fileresource) REFERENCES public.fileresource(fileresourceid);


--
-- Name: document fk_document_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT fk_document_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentitydatavalueaudit fk_entityinstancedatavalueaudit_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitydatavalueaudit
    ADD CONSTRAINT fk_entityinstancedatavalueaudit_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: trackedentitydatavalueaudit fk_entityinstancedatavalueaudit_programstageinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitydatavalueaudit
    ADD CONSTRAINT fk_entityinstancedatavalueaudit_programstageinstanceid FOREIGN KEY (programstageinstanceid) REFERENCES public.programstageinstance(programstageinstanceid);


--
-- Name: eventchart_attributedimensions fk_eventchart_attributedimensions_attributedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_attributedimensions
    ADD CONSTRAINT fk_eventchart_attributedimensions_attributedimensionid FOREIGN KEY (trackedentityattributedimensionid) REFERENCES public.trackedentityattributedimension(trackedentityattributedimensionid);


--
-- Name: eventchart_attributedimensions fk_eventchart_attributedimensions_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_attributedimensions
    ADD CONSTRAINT fk_eventchart_attributedimensions_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart fk_eventchart_attributevaluedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_eventchart_attributevaluedimensionid FOREIGN KEY (attributevaluedimensionid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: eventchart_categorydimensions fk_eventchart_categorydimensions_categorydimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_categorydimensions
    ADD CONSTRAINT fk_eventchart_categorydimensions_categorydimensionid FOREIGN KEY (categorydimensionid) REFERENCES public.categorydimension(categorydimensionid);


--
-- Name: eventchart_categorydimensions fk_eventchart_categorydimensions_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_categorydimensions
    ADD CONSTRAINT fk_eventchart_categorydimensions_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_categoryoptiongroupsetdimensions fk_eventchart_catoptiongroupsetdimensions_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_eventchart_catoptiongroupsetdimensions_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_columns fk_eventchart_columns_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_columns
    ADD CONSTRAINT fk_eventchart_columns_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_dataelementdimensions fk_eventchart_dataelementdimensions_dataelementdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_dataelementdimensions
    ADD CONSTRAINT fk_eventchart_dataelementdimensions_dataelementdimensionid FOREIGN KEY (trackedentitydataelementdimensionid) REFERENCES public.trackedentitydataelementdimension(trackedentitydataelementdimensionid);


--
-- Name: eventchart_dataelementdimensions fk_eventchart_dataelementdimensions_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_dataelementdimensions
    ADD CONSTRAINT fk_eventchart_dataelementdimensions_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart fk_eventchart_dataelementvaluedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_eventchart_dataelementvaluedimensionid FOREIGN KEY (dataelementvaluedimensionid) REFERENCES public.dataelement(dataelementid);


--
-- Name: eventchart_categoryoptiongroupsetdimensions fk_eventchart_dimensions_catoptiongroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_eventchart_dimensions_catoptiongroupsetdimensionid FOREIGN KEY (categoryoptiongroupsetdimensionid) REFERENCES public.categoryoptiongroupsetdimension(categoryoptiongroupsetdimensionid);


--
-- Name: eventchart_orgunitgroupsetdimensions fk_eventchart_dimensions_ogunitgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_eventchart_dimensions_ogunitgroupsetdimensionid FOREIGN KEY (orgunitgroupsetdimensionid) REFERENCES public.orgunitgroupsetdimension(orgunitgroupsetdimensionid);


--
-- Name: eventchart_filters fk_eventchart_filters_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_filters
    ADD CONSTRAINT fk_eventchart_filters_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_itemorgunitgroups fk_eventchart_itemorgunitgroups_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_itemorgunitgroups
    ADD CONSTRAINT fk_eventchart_itemorgunitgroups_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: eventchart_itemorgunitgroups fk_eventchart_itemorgunitunitgroups_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_itemorgunitgroups
    ADD CONSTRAINT fk_eventchart_itemorgunitunitgroups_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_organisationunits fk_eventchart_organisationunits_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_organisationunits
    ADD CONSTRAINT fk_eventchart_organisationunits_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_organisationunits fk_eventchart_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_organisationunits
    ADD CONSTRAINT fk_eventchart_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: eventchart_orgunitgroupsetdimensions fk_eventchart_orgunitgroupsetdimensions_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_eventchart_orgunitgroupsetdimensions_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_orgunitlevels fk_eventchart_orgunitlevels_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_orgunitlevels
    ADD CONSTRAINT fk_eventchart_orgunitlevels_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_periods fk_eventchart_periods_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_periods
    ADD CONSTRAINT fk_eventchart_periods_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart_periods fk_eventchart_periods_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_periods
    ADD CONSTRAINT fk_eventchart_periods_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: eventchart_programindicatordimensions fk_eventchart_prindicatordimensions_prindicatordimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_programindicatordimensions
    ADD CONSTRAINT fk_eventchart_prindicatordimensions_prindicatordimensionid FOREIGN KEY (trackedentityprogramindicatordimensionid) REFERENCES public.trackedentityprogramindicatordimension(trackedentityprogramindicatordimensionid);


--
-- Name: eventchart fk_eventchart_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_eventchart_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: eventchart_programindicatordimensions fk_eventchart_programindicatordimensions_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_programindicatordimensions
    ADD CONSTRAINT fk_eventchart_programindicatordimensions_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart fk_eventchart_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_eventchart_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: eventchart fk_eventchart_relativeperiodsid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_eventchart_relativeperiodsid FOREIGN KEY (relativeperiodsid) REFERENCES public.relativeperiods(relativeperiodsid);


--
-- Name: eventchart_rows fk_eventchart_rows_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart_rows
    ADD CONSTRAINT fk_eventchart_rows_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: eventchart fk_eventchart_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_eventchart_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: eventreport_attributedimensions fk_eventreport_attributedimensions_attributedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_attributedimensions
    ADD CONSTRAINT fk_eventreport_attributedimensions_attributedimensionid FOREIGN KEY (trackedentityattributedimensionid) REFERENCES public.trackedentityattributedimension(trackedentityattributedimensionid);


--
-- Name: eventreport_attributedimensions fk_eventreport_attributedimensions_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_attributedimensions
    ADD CONSTRAINT fk_eventreport_attributedimensions_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport fk_eventreport_attributevaluedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_eventreport_attributevaluedimensionid FOREIGN KEY (attributevaluedimensionid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: eventreport_categorydimensions fk_eventreport_categorydimensions_categorydimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_categorydimensions
    ADD CONSTRAINT fk_eventreport_categorydimensions_categorydimensionid FOREIGN KEY (categorydimensionid) REFERENCES public.categorydimension(categorydimensionid);


--
-- Name: eventreport_categorydimensions fk_eventreport_categorydimensions_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_categorydimensions
    ADD CONSTRAINT fk_eventreport_categorydimensions_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_categoryoptiongroupsetdimensions fk_eventreport_catoptiongroupsetdimensions_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_eventreport_catoptiongroupsetdimensions_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_columns fk_eventreport_columns_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_columns
    ADD CONSTRAINT fk_eventreport_columns_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_dataelementdimensions fk_eventreport_dataelementdimensions_dataelementdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_dataelementdimensions
    ADD CONSTRAINT fk_eventreport_dataelementdimensions_dataelementdimensionid FOREIGN KEY (trackedentitydataelementdimensionid) REFERENCES public.trackedentitydataelementdimension(trackedentitydataelementdimensionid);


--
-- Name: eventreport_dataelementdimensions fk_eventreport_dataelementdimensions_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_dataelementdimensions
    ADD CONSTRAINT fk_eventreport_dataelementdimensions_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport fk_eventreport_dataelementvaluedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_eventreport_dataelementvaluedimensionid FOREIGN KEY (dataelementvaluedimensionid) REFERENCES public.dataelement(dataelementid);


--
-- Name: eventreport_categoryoptiongroupsetdimensions fk_eventreport_dimensions_catoptiongroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_eventreport_dimensions_catoptiongroupsetdimensionid FOREIGN KEY (categoryoptiongroupsetdimensionid) REFERENCES public.categoryoptiongroupsetdimension(categoryoptiongroupsetdimensionid);


--
-- Name: eventreport_orgunitgroupsetdimensions fk_eventreport_dimensions_ogunitgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_eventreport_dimensions_ogunitgroupsetdimensionid FOREIGN KEY (orgunitgroupsetdimensionid) REFERENCES public.orgunitgroupsetdimension(orgunitgroupsetdimensionid);


--
-- Name: eventreport_filters fk_eventreport_filters_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_filters
    ADD CONSTRAINT fk_eventreport_filters_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_itemorgunitgroups fk_eventreport_itemorgunitgroups_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_itemorgunitgroups
    ADD CONSTRAINT fk_eventreport_itemorgunitgroups_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: eventreport_itemorgunitgroups fk_eventreport_itemorgunitunitgroups_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_itemorgunitgroups
    ADD CONSTRAINT fk_eventreport_itemorgunitunitgroups_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_organisationunits fk_eventreport_organisationunits_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_organisationunits
    ADD CONSTRAINT fk_eventreport_organisationunits_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_organisationunits fk_eventreport_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_organisationunits
    ADD CONSTRAINT fk_eventreport_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: eventreport_orgunitgroupsetdimensions fk_eventreport_orgunitgroupsetdimensions_eventreporteid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_eventreport_orgunitgroupsetdimensions_eventreporteid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_orgunitlevels fk_eventreport_orgunitlevels_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_orgunitlevels
    ADD CONSTRAINT fk_eventreport_orgunitlevels_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_periods fk_eventreport_periods_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_periods
    ADD CONSTRAINT fk_eventreport_periods_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport_periods fk_eventreport_periods_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_periods
    ADD CONSTRAINT fk_eventreport_periods_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: eventreport_programindicatordimensions fk_eventreport_prindicatordimensions_prindicatordimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_programindicatordimensions
    ADD CONSTRAINT fk_eventreport_prindicatordimensions_prindicatordimensionid FOREIGN KEY (trackedentityprogramindicatordimensionid) REFERENCES public.trackedentityprogramindicatordimension(trackedentityprogramindicatordimensionid);


--
-- Name: eventreport fk_eventreport_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_eventreport_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: eventreport_programindicatordimensions fk_eventreport_programindicatordimensions_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_programindicatordimensions
    ADD CONSTRAINT fk_eventreport_programindicatordimensions_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport fk_eventreport_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_eventreport_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: eventreport fk_eventreport_relativeperiodsid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_eventreport_relativeperiodsid FOREIGN KEY (relativeperiodsid) REFERENCES public.relativeperiods(relativeperiodsid);


--
-- Name: eventreport_rows fk_eventreport_rows_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport_rows
    ADD CONSTRAINT fk_eventreport_rows_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventreport fk_eventreport_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_eventreport_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: externalmaplayer fk_externalmaplayer_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT fk_externalmaplayer_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: externalmaplayer fk_externalmaplayer_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT fk_externalmaplayer_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: externalfileresource fk_fileresource_externalfileresource; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalfileresource
    ADD CONSTRAINT fk_fileresource_externalfileresource FOREIGN KEY (fileresourceid) REFERENCES public.fileresource(fileresourceid);


--
-- Name: fileresource fk_fileresource_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.fileresource
    ADD CONSTRAINT fk_fileresource_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: users_catdimensionconstraints fk_fk_users_catconstraints_dataelementcategoryid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users_catdimensionconstraints
    ADD CONSTRAINT fk_fk_users_catconstraints_dataelementcategoryid FOREIGN KEY (dataelementcategoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: users_cogsdimensionconstraints fk_fk_users_cogsconstraints_categoryoptiongroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users_cogsdimensionconstraints
    ADD CONSTRAINT fk_fk_users_cogsconstraints_categoryoptiongroupsetid FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: incomingsms fk_incomingsms_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.incomingsms
    ADD CONSTRAINT fk_incomingsms_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicator fk_indicator_indicatortypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT fk_indicator_indicatortypeid FOREIGN KEY (indicatortypeid) REFERENCES public.indicatortype(indicatortypeid);


--
-- Name: indicatorlegendsets fk_indicator_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorlegendsets
    ADD CONSTRAINT fk_indicator_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: indicator fk_indicator_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT fk_indicator_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatorgroupmembers fk_indicatorgroup_indicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupmembers
    ADD CONSTRAINT fk_indicatorgroup_indicatorid FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: indicatorgroup fk_indicatorgroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroup
    ADD CONSTRAINT fk_indicatorgroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatorgroupmembers fk_indicatorgroupmembers_indicatorgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupmembers
    ADD CONSTRAINT fk_indicatorgroupmembers_indicatorgroupid FOREIGN KEY (indicatorgroupid) REFERENCES public.indicatorgroup(indicatorgroupid);


--
-- Name: indicatorgroupsetmembers fk_indicatorgroupset_indicatorgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetmembers
    ADD CONSTRAINT fk_indicatorgroupset_indicatorgroupid FOREIGN KEY (indicatorgroupid) REFERENCES public.indicatorgroup(indicatorgroupid);


--
-- Name: indicatorgroupset fk_indicatorgroupset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupset
    ADD CONSTRAINT fk_indicatorgroupset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatorgroupsetmembers fk_indicatorgroupsetmembers_indicatorgroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetmembers
    ADD CONSTRAINT fk_indicatorgroupsetmembers_indicatorgroupsetid FOREIGN KEY (indicatorgroupsetid) REFERENCES public.indicatorgroupset(indicatorgroupsetid);


--
-- Name: intepretation_likedby fk_intepretation_likedby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.intepretation_likedby
    ADD CONSTRAINT fk_intepretation_likedby_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: interpretation fk_interpretation_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: interpretation_comments fk_interpretation_comments_interpretationcommentid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation_comments
    ADD CONSTRAINT fk_interpretation_comments_interpretationcommentid FOREIGN KEY (interpretationcommentid) REFERENCES public.interpretationcomment(interpretationcommentid);


--
-- Name: interpretation_comments fk_interpretation_comments_interpretationid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation_comments
    ADD CONSTRAINT fk_interpretation_comments_interpretationid FOREIGN KEY (interpretationid) REFERENCES public.interpretation(interpretationid);


--
-- Name: interpretation fk_interpretation_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: interpretation fk_interpretation_eventchartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_eventchartid FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: interpretation fk_interpretation_eventreportid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_eventreportid FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: intepretation_likedby fk_interpretation_likedby_interpretationid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.intepretation_likedby
    ADD CONSTRAINT fk_interpretation_likedby_interpretationid FOREIGN KEY (interpretationid) REFERENCES public.interpretation(interpretationid);


--
-- Name: interpretation fk_interpretation_mapid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_mapid FOREIGN KEY (mapid) REFERENCES public.map(mapid);


--
-- Name: interpretation fk_interpretation_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: interpretation fk_interpretation_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: interpretation fk_interpretation_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: interpretation fk_interpretation_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretation
    ADD CONSTRAINT fk_interpretation_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: interpretationcomment fk_interpretationcomment_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationcomment
    ADD CONSTRAINT fk_interpretationcomment_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: keyjsonvalueuseraccesses fk_keyjsonvalue_useraccessid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalueuseraccesses
    ADD CONSTRAINT fk_keyjsonvalue_useraccessid FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: keyjsonvalueusergroupaccesses fk_keyjsonvalue_usergroupaccessid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalueusergroupaccesses
    ADD CONSTRAINT fk_keyjsonvalue_usergroupaccessid FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: keyjsonvalue fk_keyjsonvalue_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalue
    ADD CONSTRAINT fk_keyjsonvalue_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: attribute fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attribute
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: categorycombo fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombo
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: categoryoptioncombo fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncombo
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: categoryoptiongroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: categoryoptiongroupset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: chart fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: color fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.color
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: colorset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.colorset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: constant fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constant
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dashboard fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dashboarditem fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarditem
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapprovallevel fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevel
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataapprovalworkflow fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflow
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelement fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelement
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementcategory fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategory
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementcategoryoption fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoption
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementgroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataelementgroupset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataentryform fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataentryform
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: dataset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: datasetnotificationtemplate fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotificationtemplate
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: datastatistics fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datastatistics
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: document fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: eventchart fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchart
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: eventreport fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreport
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: externalfileresource fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalfileresource
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: externalmaplayer fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayer
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: fileresource fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.fileresource
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: i18nlocale fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.i18nlocale
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicator fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicator
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatorgroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatorgroupset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatortype fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatortype
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: jobconfiguration fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.jobconfiguration
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: keyjsonvalue fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.keyjsonvalue
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: map fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.map
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: maplegend fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegend
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: maplegendset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegendset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: mapview fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: metadataversion fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.metadataversion
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: oauth2client fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2client
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: optiongroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: optiongroupset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: optionset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: organisationunit fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: orgunitgroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: orgunitgroupset fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: orgunitlevel fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitlevel
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: periodboundary fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodboundary
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: predictor fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: predictorgroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: program fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: program_attribute_group fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attribute_group
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: program_attributes fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programindicator fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programindicatorgroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programmessage fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programnotificationinstance fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programnotificationtemplate fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programrule fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrule
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programruleaction fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programrulevariable fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programsection fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programstage fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programstagedataelement fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programstagesection fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: pushanalysis fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysis
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: relationship fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: relationshiptype fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: report fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: reporttable fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: section fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: sqlview fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlview
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: tablehook fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.tablehook
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentityattribute fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentitycomment fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitycomment
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentityinstance fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstance
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentityinstancefilter fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstancefilter
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentitytype fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytype
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentitytypeattribute fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattribute
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: usergroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: userkeyjsonvalue fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userkeyjsonvalue
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: userrole fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: users fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationnotificationtemplate fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationrule fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationrulegroup fk_lastupdateby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroup
    ADD CONSTRAINT fk_lastupdateby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: programstageinstancefilter fk_lastupdatedby_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilter
    ADD CONSTRAINT fk_lastupdatedby_userid FOREIGN KEY (lastupdatedby) REFERENCES public.userinfo(userinfoid);


--
-- Name: maplegendset fk_legendset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegendset
    ADD CONSTRAINT fk_legendset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: lockexception fk_lockexception_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.lockexception
    ADD CONSTRAINT fk_lockexception_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: lockexception fk_lockexception_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.lockexception
    ADD CONSTRAINT fk_lockexception_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: lockexception fk_lockexception_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.lockexception
    ADD CONSTRAINT fk_lockexception_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: maplegend fk_maplegend_maplegendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.maplegend
    ADD CONSTRAINT fk_maplegend_maplegendsetid FOREIGN KEY (maplegendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: mapmapviews fk_mapmapview_mapid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapmapviews
    ADD CONSTRAINT fk_mapmapview_mapid FOREIGN KEY (mapid) REFERENCES public.map(mapid);


--
-- Name: mapmapviews fk_mapmapview_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapmapviews
    ADD CONSTRAINT fk_mapmapview_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_attributedimensions fk_mapview_attributedimensions_attributedimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_attributedimensions
    ADD CONSTRAINT fk_mapview_attributedimensions_attributedimensionid FOREIGN KEY (trackedentityattributedimensionid) REFERENCES public.trackedentityattributedimension(trackedentityattributedimensionid);


--
-- Name: mapview_attributedimensions fk_mapview_attributedimensions_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_attributedimensions
    ADD CONSTRAINT fk_mapview_attributedimensions_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_categorydimensions fk_mapview_categorydimensions_categorydimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_categorydimensions
    ADD CONSTRAINT fk_mapview_categorydimensions_categorydimensionid FOREIGN KEY (categorydimensionid) REFERENCES public.categorydimension(categorydimensionid);


--
-- Name: mapview_categorydimensions fk_mapview_categorydimensions_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_categorydimensions
    ADD CONSTRAINT fk_mapview_categorydimensions_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_categoryoptiongroupsetdimensions fk_mapview_catoptiongroupsetdimensions_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_mapview_catoptiongroupsetdimensions_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_columns fk_mapview_columns_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_columns
    ADD CONSTRAINT fk_mapview_columns_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_datadimensionitems fk_mapview_datadimensionitems_datadimensionitemid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_datadimensionitems
    ADD CONSTRAINT fk_mapview_datadimensionitems_datadimensionitemid FOREIGN KEY (datadimensionitemid) REFERENCES public.datadimensionitem(datadimensionitemid);


--
-- Name: mapview_datadimensionitems fk_mapview_datadimensionitems_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_datadimensionitems
    ADD CONSTRAINT fk_mapview_datadimensionitems_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_dataelementdimensions fk_mapview_dataelementdimensions_dataelementdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_dataelementdimensions
    ADD CONSTRAINT fk_mapview_dataelementdimensions_dataelementdimensionid FOREIGN KEY (trackedentitydataelementdimensionid) REFERENCES public.trackedentitydataelementdimension(trackedentitydataelementdimensionid);


--
-- Name: mapview_dataelementdimensions fk_mapview_dataelementdimensions_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_dataelementdimensions
    ADD CONSTRAINT fk_mapview_dataelementdimensions_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_categoryoptiongroupsetdimensions fk_mapview_dimensions_catoptiongroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_mapview_dimensions_catoptiongroupsetdimensionid FOREIGN KEY (categoryoptiongroupsetdimensionid) REFERENCES public.categoryoptiongroupsetdimension(categoryoptiongroupsetdimensionid);


--
-- Name: mapview_orgunitgroupsetdimensions fk_mapview_dimensions_orgunitgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_mapview_dimensions_orgunitgroupsetdimensionid FOREIGN KEY (orgunitgroupsetdimensionid) REFERENCES public.orgunitgroupsetdimension(orgunitgroupsetdimensionid);


--
-- Name: mapview_filters fk_mapview_filters_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_filters
    ADD CONSTRAINT fk_mapview_filters_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_itemorgunitgroups fk_mapview_itemorgunitgroups_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_itemorgunitgroups
    ADD CONSTRAINT fk_mapview_itemorgunitgroups_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: mapview_itemorgunitgroups fk_mapview_itemorgunitunitgroups_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_itemorgunitgroups
    ADD CONSTRAINT fk_mapview_itemorgunitunitgroups_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview fk_mapview_maplegendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_mapview_maplegendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: mapview_organisationunits fk_mapview_organisationunits_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_organisationunits
    ADD CONSTRAINT fk_mapview_organisationunits_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_organisationunits fk_mapview_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_organisationunits
    ADD CONSTRAINT fk_mapview_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: mapview_orgunitgroupsetdimensions fk_mapview_orgunitgroupsetdimensions_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_mapview_orgunitgroupsetdimensions_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview fk_mapview_orgunitgroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_mapview_orgunitgroupsetid FOREIGN KEY (orgunitgroupsetid) REFERENCES public.orgunitgroupset(orgunitgroupsetid);


--
-- Name: mapview_orgunitlevels fk_mapview_orgunitlevels_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_orgunitlevels
    ADD CONSTRAINT fk_mapview_orgunitlevels_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_periods fk_mapview_periods_mapviewid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_periods
    ADD CONSTRAINT fk_mapview_periods_mapviewid FOREIGN KEY (mapviewid) REFERENCES public.mapview(mapviewid);


--
-- Name: mapview_periods fk_mapview_periods_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview_periods
    ADD CONSTRAINT fk_mapview_periods_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: mapview fk_mapview_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_mapview_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: mapview fk_mapview_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_mapview_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: mapview fk_mapview_relativeperiodsid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_mapview_relativeperiodsid FOREIGN KEY (relativeperiodsid) REFERENCES public.relativeperiods(relativeperiodsid);


--
-- Name: mapview fk_mapview_trackedentitytypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapview
    ADD CONSTRAINT fk_mapview_trackedentitytypeid FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: map fk_mapview_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.map
    ADD CONSTRAINT fk_mapview_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: message fk_message_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT fk_message_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: messageattachments fk_messageattachments_fileresourceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageattachments
    ADD CONSTRAINT fk_messageattachments_fileresourceid FOREIGN KEY (fileresourceid) REFERENCES public.fileresource(fileresourceid);


--
-- Name: messageconversation fk_messageconversation_lastsender_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation
    ADD CONSTRAINT fk_messageconversation_lastsender_userid FOREIGN KEY (lastsenderid) REFERENCES public.userinfo(userinfoid);


--
-- Name: messageconversation_messages fk_messageconversation_messages_messageconversationid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_messages
    ADD CONSTRAINT fk_messageconversation_messages_messageconversationid FOREIGN KEY (messageconversationid) REFERENCES public.messageconversation(messageconversationid);


--
-- Name: messageconversation_messages fk_messageconversation_messages_messageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_messages
    ADD CONSTRAINT fk_messageconversation_messages_messageid FOREIGN KEY (messageid) REFERENCES public.message(messageid);


--
-- Name: messageconversation fk_messageconversation_user_user_assigned; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation
    ADD CONSTRAINT fk_messageconversation_user_user_assigned FOREIGN KEY (user_assigned) REFERENCES public.userinfo(userinfoid);


--
-- Name: messageconversation fk_messageconversation_user_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation
    ADD CONSTRAINT fk_messageconversation_user_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: messageconversation_usermessages fk_messageconversation_usermessages_messageconversationid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_usermessages
    ADD CONSTRAINT fk_messageconversation_usermessages_messageconversationid FOREIGN KEY (messageconversationid) REFERENCES public.messageconversation(messageconversationid);


--
-- Name: messageconversation_usermessages fk_messageconversation_usermessages_usermessageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.messageconversation_usermessages
    ADD CONSTRAINT fk_messageconversation_usermessages_usermessageid FOREIGN KEY (usermessageid) REFERENCES public.usermessage(usermessageid);


--
-- Name: minmaxdataelement fk_minmaxdataelement_categoryoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.minmaxdataelement
    ADD CONSTRAINT fk_minmaxdataelement_categoryoptioncomboid FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: minmaxdataelement fk_minmaxdataelement_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.minmaxdataelement
    ADD CONSTRAINT fk_minmaxdataelement_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: minmaxdataelement fk_minmaxdataelement_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.minmaxdataelement
    ADD CONSTRAINT fk_minmaxdataelement_organisationunitid FOREIGN KEY (sourceid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: oauth2clientgranttypes fk_oauth2clientgranttypes_oauth2clientid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2clientgranttypes
    ADD CONSTRAINT fk_oauth2clientgranttypes_oauth2clientid FOREIGN KEY (oauth2clientid) REFERENCES public.oauth2client(oauth2clientid);


--
-- Name: oauth2clientredirecturis fk_oauth2clientredirecturis_oauth2clientid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.oauth2clientredirecturis
    ADD CONSTRAINT fk_oauth2clientredirecturis_oauth2clientid FOREIGN KEY (oauth2clientid) REFERENCES public.oauth2client(oauth2clientid);


--
-- Name: optiongroup fk_optiongroup_optionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT fk_optiongroup_optionsetid FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: optiongroup fk_optiongroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroup
    ADD CONSTRAINT fk_optiongroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: optiongroupmembers fk_optiongroupmembers_optiongroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupmembers
    ADD CONSTRAINT fk_optiongroupmembers_optiongroupid FOREIGN KEY (optionid) REFERENCES public.optionvalue(optionvalueid);


--
-- Name: optiongroupmembers fk_optiongroupmembers_optionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupmembers
    ADD CONSTRAINT fk_optiongroupmembers_optionid FOREIGN KEY (optiongroupid) REFERENCES public.optiongroup(optiongroupid);


--
-- Name: optiongroupset fk_optiongroupset_optionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT fk_optiongroupset_optionsetid FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: optiongroupset fk_optiongroupset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupset
    ADD CONSTRAINT fk_optiongroupset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: optiongroupsetmembers fk_optiongroupsetmembers_optiongroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetmembers
    ADD CONSTRAINT fk_optiongroupsetmembers_optiongroupid FOREIGN KEY (optiongroupid) REFERENCES public.optiongroup(optiongroupid);


--
-- Name: optiongroupsetmembers fk_optiongroupsetmembers_optiongroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetmembers
    ADD CONSTRAINT fk_optiongroupsetmembers_optiongroupsetid FOREIGN KEY (optiongroupsetid) REFERENCES public.optiongroupset(optiongroupsetid);


--
-- Name: optionset fk_optionset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionset
    ADD CONSTRAINT fk_optionset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: optionvalue fk_optionsetmembers_optionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionvalue
    ADD CONSTRAINT fk_optionsetmembers_optionsetid FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: organisationunit fk_organisationunit_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT fk_organisationunit_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationruleorganisationunitlevels fk_organisationunitlevel_validationtuleid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleorganisationunitlevels
    ADD CONSTRAINT fk_organisationunitlevel_validationtuleid FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: orgunitgroupmembers fk_orgunitgroup_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupmembers
    ADD CONSTRAINT fk_orgunitgroup_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: orgunitgroup fk_orgunitgroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroup
    ADD CONSTRAINT fk_orgunitgroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: orgunitgroupmembers fk_orgunitgroupmembers_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupmembers
    ADD CONSTRAINT fk_orgunitgroupmembers_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: orgunitgroupsetmembers fk_orgunitgroupset_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetmembers
    ADD CONSTRAINT fk_orgunitgroupset_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: orgunitgroupset fk_orgunitgroupset_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupset
    ADD CONSTRAINT fk_orgunitgroupset_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: orgunitgroupsetmembers fk_orgunitgroupsetmembers_orgunitgroupsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetmembers
    ADD CONSTRAINT fk_orgunitgroupsetmembers_orgunitgroupsetid FOREIGN KEY (orgunitgroupsetid) REFERENCES public.orgunitgroupset(orgunitgroupsetid);


--
-- Name: organisationunit fk_parentid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunit
    ADD CONSTRAINT fk_parentid FOREIGN KEY (parentid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: period fk_period_periodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.period
    ADD CONSTRAINT fk_period_periodtypeid FOREIGN KEY (periodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: periodboundary fk_periodboundary_periodtype; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodboundary
    ADD CONSTRAINT fk_periodboundary_periodtype FOREIGN KEY (offsetperiodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: periodboundary fk_periodboundary_programindicator; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.periodboundary
    ADD CONSTRAINT fk_periodboundary_programindicator FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: predictor fk_predictor_generatorexpressionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT fk_predictor_generatorexpressionid FOREIGN KEY (generatorexpressionid) REFERENCES public.expression(expressionid);


--
-- Name: predictor fk_predictor_outputcomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT fk_predictor_outputcomboid FOREIGN KEY (generatoroutputcombo) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: predictor fk_predictor_outputdataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT fk_predictor_outputdataelementid FOREIGN KEY (generatoroutput) REFERENCES public.dataelement(dataelementid);


--
-- Name: predictorgroupmembers fk_predictorgroup_predictorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupmembers
    ADD CONSTRAINT fk_predictorgroup_predictorid FOREIGN KEY (predictorid) REFERENCES public.predictor(predictorid);


--
-- Name: predictorgroup fk_predictorgroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroup
    ADD CONSTRAINT fk_predictorgroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: predictorgroupmembers fk_predictorgroupmembers_predictorgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupmembers
    ADD CONSTRAINT fk_predictorgroupmembers_predictorgroupid FOREIGN KEY (predictorgroupid) REFERENCES public.predictorgroup(predictorgroupid);


--
-- Name: predictororgunitlevels fk_predictororgunitlevels_orgunitlevelid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictororgunitlevels
    ADD CONSTRAINT fk_predictororgunitlevels_orgunitlevelid FOREIGN KEY (orgunitlevelid) REFERENCES public.orgunitlevel(orgunitlevelid);


--
-- Name: predictororgunitlevels fk_predictororgunitlevels_predictorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictororgunitlevels
    ADD CONSTRAINT fk_predictororgunitlevels_predictorid FOREIGN KEY (predictorid) REFERENCES public.predictor(predictorid);


--
-- Name: program_attributes fk_program_attributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT fk_program_attributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: program fk_program_categorycomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_program_categorycomboid FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: program fk_program_dataentryformid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_program_dataentryformid FOREIGN KEY (dataentryformid) REFERENCES public.dataentryform(dataentryformid);


--
-- Name: program fk_program_expiryperiodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_program_expiryperiodtypeid FOREIGN KEY (expiryperiodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: program_organisationunits fk_program_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_organisationunits
    ADD CONSTRAINT fk_program_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: program_organisationunits fk_program_organisationunits_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_organisationunits
    ADD CONSTRAINT fk_program_organisationunits_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programsection fk_program_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection
    ADD CONSTRAINT fk_program_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programstagesection fk_program_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection
    ADD CONSTRAINT fk_program_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: program fk_program_relatedprogram; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_program_relatedprogram FOREIGN KEY (relatedprogramid) REFERENCES public.program(programid);


--
-- Name: program fk_program_trackedentitytypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_program_trackedentitytypeid FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: program fk_program_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT fk_program_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: programindicatorlegendsets fk_programindicator_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorlegendsets
    ADD CONSTRAINT fk_programindicator_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: programindicator fk_programindicator_program; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT fk_programindicator_program FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programindicator fk_programindicator_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicator
    ADD CONSTRAINT fk_programindicator_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: programindicatorgroupmembers fk_programindicatorgroup_programindicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupmembers
    ADD CONSTRAINT fk_programindicatorgroup_programindicatorid FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: programindicatorgroup fk_programindicatorgroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroup
    ADD CONSTRAINT fk_programindicatorgroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: programindicatorgroupmembers fk_programindicatorgroupmembers_programindicatorgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupmembers
    ADD CONSTRAINT fk_programindicatorgroupmembers_programindicatorgroupid FOREIGN KEY (programindicatorgroupid) REFERENCES public.programindicatorgroup(programindicatorgroupid);


--
-- Name: programinstance fk_programinstance_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance
    ADD CONSTRAINT fk_programinstance_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: programinstance fk_programinstance_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance
    ADD CONSTRAINT fk_programinstance_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programinstance fk_programinstance_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance
    ADD CONSTRAINT fk_programinstance_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: programinstanceaudit fk_programinstanceaudit_programinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstanceaudit
    ADD CONSTRAINT fk_programinstanceaudit_programinstanceid FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: programinstancecomments fk_programinstancecomments_programinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstancecomments
    ADD CONSTRAINT fk_programinstancecomments_programinstanceid FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: programinstancecomments fk_programinstancecomments_trackedentitycommentid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstancecomments
    ADD CONSTRAINT fk_programinstancecomments_trackedentitycommentid FOREIGN KEY (trackedentitycommentid) REFERENCES public.trackedentitycomment(trackedentitycommentid);


--
-- Name: programmessage fk_programmessage_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT fk_programmessage_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: programmessage fk_programmessage_programinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT fk_programmessage_programinstanceid FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: programmessage fk_programmessage_programstageinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT fk_programmessage_programstageinstanceid FOREIGN KEY (programstageinstanceid) REFERENCES public.programstageinstance(programstageinstanceid);


--
-- Name: programmessage fk_programmessage_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage
    ADD CONSTRAINT fk_programmessage_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: programownershiphistory fk_programownershiphistory_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programownershiphistory
    ADD CONSTRAINT fk_programownershiphistory_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programownershiphistory fk_programownershiphistory_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programownershiphistory
    ADD CONSTRAINT fk_programownershiphistory_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: programrule fk_programrule_program; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrule
    ADD CONSTRAINT fk_programrule_program FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programrule fk_programrule_programstage; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrule
    ADD CONSTRAINT fk_programrule_programstage FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: programruleaction fk_programruleaction_dataelement; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_dataelement FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: programruleaction fk_programruleaction_option; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_option FOREIGN KEY (optionid) REFERENCES public.optionvalue(optionvalueid);


--
-- Name: programruleaction fk_programruleaction_optiongroup; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_optiongroup FOREIGN KEY (optiongroupid) REFERENCES public.optiongroup(optiongroupid);


--
-- Name: programruleaction fk_programruleaction_programindicator; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_programindicator FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: programruleaction fk_programruleaction_programrule; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_programrule FOREIGN KEY (programruleid) REFERENCES public.programrule(programruleid);


--
-- Name: programruleaction fk_programruleaction_programstage; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_programstage FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: programruleaction fk_programruleaction_programstagesection; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_programstagesection FOREIGN KEY (programstagesectionid) REFERENCES public.programstagesection(programstagesectionid);


--
-- Name: programruleaction fk_programruleaction_trackedentityattribute; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programruleaction
    ADD CONSTRAINT fk_programruleaction_trackedentityattribute FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: programrulevariable fk_programrulevariable_dataelement; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT fk_programrulevariable_dataelement FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: programrulevariable fk_programrulevariable_program; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT fk_programrulevariable_program FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programrulevariable fk_programrulevariable_programstage; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT fk_programrulevariable_programstage FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: programrulevariable fk_programrulevariable_trackedentityattribute; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programrulevariable
    ADD CONSTRAINT fk_programrulevariable_trackedentityattribute FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: programsection_attributes fk_programsection_attributes_trackedentityattributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection_attributes
    ADD CONSTRAINT fk_programsection_attributes_trackedentityattributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: programsection_attributes fk_programsections_attributes_programsectionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programsection_attributes
    ADD CONSTRAINT fk_programsections_attributes_programsectionid FOREIGN KEY (programsectionid) REFERENCES public.programsection(programsectionid);


--
-- Name: programstage fk_programstage_dataentryform; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT fk_programstage_dataentryform FOREIGN KEY (dataentryformid) REFERENCES public.dataentryform(dataentryformid);


--
-- Name: programstage fk_programstage_periodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT fk_programstage_periodtypeid FOREIGN KEY (periodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: programstage fk_programstage_program; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT fk_programstage_program FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programstage fk_programstage_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstage
    ADD CONSTRAINT fk_programstage_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: programstagedataelement fk_programstagedataelement_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT fk_programstagedataelement_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: programstagedataelement fk_programstagedataelement_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagedataelement
    ADD CONSTRAINT fk_programstagedataelement_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: programstageinstance fk_programstageinstance_assigneduserid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT fk_programstageinstance_assigneduserid FOREIGN KEY (assigneduserid) REFERENCES public.users(userid);


--
-- Name: programstageinstance fk_programstageinstance_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT fk_programstageinstance_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: programstageinstance fk_programstageinstance_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT fk_programstageinstance_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: programstageinstance fk_programstageinstance_programinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT fk_programstageinstance_programinstanceid FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: programstageinstance fk_programstageinstance_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance
    ADD CONSTRAINT fk_programstageinstance_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: programstageinstancecomments fk_programstageinstancecomments_programstageinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancecomments
    ADD CONSTRAINT fk_programstageinstancecomments_programstageinstanceid FOREIGN KEY (programstageinstanceid) REFERENCES public.programstageinstance(programstageinstanceid);


--
-- Name: programstageinstancecomments fk_programstageinstancecomments_trackedentitycommentid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancecomments
    ADD CONSTRAINT fk_programstageinstancecomments_trackedentitycommentid FOREIGN KEY (trackedentitycommentid) REFERENCES public.trackedentitycomment(trackedentitycommentid);


--
-- Name: programstageinstancefilteruseraccesses fk_programstageinstancefilter_programstageinstancefilterid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilteruseraccesses
    ADD CONSTRAINT fk_programstageinstancefilter_programstageinstancefilterid FOREIGN KEY (programstageinstancefilterid) REFERENCES public.programstageinstancefilter(programstageinstancefilterid);


--
-- Name: programstageinstancefilterusergroupaccesses fk_programstageinstancefilter_programstageinstancefilterid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilterusergroupaccesses
    ADD CONSTRAINT fk_programstageinstancefilter_programstageinstancefilterid FOREIGN KEY (programstageinstancefilterid) REFERENCES public.programstageinstancefilter(programstageinstancefilterid);


--
-- Name: programstageinstancefilteruseraccesses fk_programstageinstancefilter_useraccessid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilteruseraccesses
    ADD CONSTRAINT fk_programstageinstancefilter_useraccessid FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: programstageinstancefilterusergroupaccesses fk_programstageinstancefilter_usergroupaccessid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilterusergroupaccesses
    ADD CONSTRAINT fk_programstageinstancefilter_usergroupaccessid FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: programstageinstancefilter fk_programstageinstancefilter_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstancefilter
    ADD CONSTRAINT fk_programstageinstancefilter_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: programnotificationtemplate fk_programstagenotification_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT fk_programstagenotification_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: programnotificationinstance fk_programstagenotification_pi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT fk_programstagenotification_pi FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: programnotificationinstance fk_programstagenotification_pnt; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT fk_programstagenotification_pnt FOREIGN KEY (programnotificationtemplateid) REFERENCES public.programnotificationtemplate(programnotificationtemplateid);


--
-- Name: programnotificationinstance fk_programstagenotification_psi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationinstance
    ADD CONSTRAINT fk_programstagenotification_psi FOREIGN KEY (programstageinstanceid) REFERENCES public.programstageinstance(programstageinstanceid);


--
-- Name: programnotificationtemplate fk_programstagenotification_trackedentityattributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT fk_programstagenotification_trackedentityattributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: programnotificationtemplate fk_programstagenotification_usergroup; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programnotificationtemplate
    ADD CONSTRAINT fk_programstagenotification_usergroup FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: programstagesection_dataelements fk_programstagesection_dataelements_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection_dataelements
    ADD CONSTRAINT fk_programstagesection_dataelements_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: programstagesection_dataelements fk_programstagesection_dataelements_programstagesectionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection_dataelements
    ADD CONSTRAINT fk_programstagesection_dataelements_programstagesectionid FOREIGN KEY (programstagesectionid) REFERENCES public.programstagesection(programstagesectionid);


--
-- Name: programstagesection_programindicators fk_programstagesection_programindicators_indicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection_programindicators
    ADD CONSTRAINT fk_programstagesection_programindicators_indicatorid FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: programstagesection_programindicators fk_programstagesection_programindicators_sectionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstagesection_programindicators
    ADD CONSTRAINT fk_programstagesection_programindicators_sectionid FOREIGN KEY (programstagesectionid) REFERENCES public.programstagesection(programstagesectionid);


--
-- Name: programtempownershipaudit fk_programtempownershipaudit_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programtempownershipaudit
    ADD CONSTRAINT fk_programtempownershipaudit_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programtempownershipaudit fk_programtempownershipaudit_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programtempownershipaudit
    ADD CONSTRAINT fk_programtempownershipaudit_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: program_attributes fk_programtrackedentityattribute_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_attributes
    ADD CONSTRAINT fk_programtrackedentityattribute_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: programtrackedentityattributegroupmembers fk_programtrackedentityattributegroup_attributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programtrackedentityattributegroupmembers
    ADD CONSTRAINT fk_programtrackedentityattributegroup_attributeid FOREIGN KEY (programtrackedentityattributeid) REFERENCES public.program_attributes(programtrackedentityattributeid);


--
-- Name: programtrackedentityattributegroupmembers fk_programtrackedentityattributegroupmembers_groupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programtrackedentityattributegroupmembers
    ADD CONSTRAINT fk_programtrackedentityattributegroupmembers_groupid FOREIGN KEY (programtrackedentityattributegroupid) REFERENCES public.program_attribute_group(programtrackedentityattributegroupid);


--
-- Name: pushanalysisrecipientusergroups fk_pushanalysis_recipientusergroups; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysisrecipientusergroups
    ADD CONSTRAINT fk_pushanalysis_recipientusergroups FOREIGN KEY (elt) REFERENCES public.usergroup(usergroupid);


--
-- Name: relationship fk_relationship_from_relationshipitemid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT fk_relationship_from_relationshipitemid FOREIGN KEY (from_relationshipitemid) REFERENCES public.relationshipitem(relationshipitemid);


--
-- Name: relationship fk_relationship_relationshiptypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT fk_relationship_relationshiptypeid FOREIGN KEY (relationshiptypeid) REFERENCES public.relationshiptype(relationshiptypeid);


--
-- Name: relationship fk_relationship_to_relationshipitemid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationship
    ADD CONSTRAINT fk_relationship_to_relationshipitemid FOREIGN KEY (to_relationshipitemid) REFERENCES public.relationshipitem(relationshipitemid);


--
-- Name: relationshipconstraint fk_relationshipconstraint_program_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipconstraint
    ADD CONSTRAINT fk_relationshipconstraint_program_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: relationshipconstraint fk_relationshipconstraint_programstage_programstageid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipconstraint
    ADD CONSTRAINT fk_relationshipconstraint_programstage_programstageid FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: relationshipconstraint fk_relationshipconstraint_trackedentitytype_trackedentitytypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipconstraint
    ADD CONSTRAINT fk_relationshipconstraint_trackedentitytype_trackedentitytypeid FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: relationshipitem fk_relationshipitem_programinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipitem
    ADD CONSTRAINT fk_relationshipitem_programinstanceid FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: relationshipitem fk_relationshipitem_programstageinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipitem
    ADD CONSTRAINT fk_relationshipitem_programstageinstanceid FOREIGN KEY (programstageinstanceid) REFERENCES public.programstageinstance(programstageinstanceid);


--
-- Name: relationshipitem fk_relationshipitem_relationshipid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipitem
    ADD CONSTRAINT fk_relationshipitem_relationshipid FOREIGN KEY (relationshipid) REFERENCES public.relationship(relationshipid);


--
-- Name: relationshipitem fk_relationshipitem_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshipitem
    ADD CONSTRAINT fk_relationshipitem_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: relationshiptype fk_relationshiptype_from_relationshipconstraintid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT fk_relationshiptype_from_relationshipconstraintid FOREIGN KEY (from_relationshipconstraintid) REFERENCES public.relationshipconstraint(relationshipconstraintid);


--
-- Name: relationshiptype fk_relationshiptype_to_relationshipconstraintid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT fk_relationshiptype_to_relationshipconstraintid FOREIGN KEY (to_relationshipconstraintid) REFERENCES public.relationshipconstraint(relationshipconstraintid);


--
-- Name: relationshiptype fk_relationshiptype_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptype
    ADD CONSTRAINT fk_relationshiptype_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: report fk_report_relativeperiodsid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT fk_report_relativeperiodsid FOREIGN KEY (relativeperiodsid) REFERENCES public.relativeperiods(relativeperiodsid);


--
-- Name: report fk_report_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT fk_report_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: report fk_report_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT fk_report_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: reporttable_categorydimensions fk_reporttable_categorydimensions_categorydimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_categorydimensions
    ADD CONSTRAINT fk_reporttable_categorydimensions_categorydimensionid FOREIGN KEY (categorydimensionid) REFERENCES public.categorydimension(categorydimensionid);


--
-- Name: reporttable_categorydimensions fk_reporttable_categorydimensions_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_categorydimensions
    ADD CONSTRAINT fk_reporttable_categorydimensions_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_categoryoptiongroupsetdimensions fk_reporttable_catoptiongroupsetdimensions_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_reporttable_catoptiongroupsetdimensions_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_columns fk_reporttable_columns_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_columns
    ADD CONSTRAINT fk_reporttable_columns_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_datadimensionitems fk_reporttable_datadimensionitems_datadimensionitemid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_datadimensionitems
    ADD CONSTRAINT fk_reporttable_datadimensionitems_datadimensionitemid FOREIGN KEY (datadimensionitemid) REFERENCES public.datadimensionitem(datadimensionitemid);


--
-- Name: reporttable_datadimensionitems fk_reporttable_datadimensionitems_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_datadimensionitems
    ADD CONSTRAINT fk_reporttable_datadimensionitems_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_dataelementgroupsetdimensions fk_reporttable_dataelememntgroupsetdimensions_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_dataelementgroupsetdimensions
    ADD CONSTRAINT fk_reporttable_dataelememntgroupsetdimensions_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_categoryoptiongroupsetdimensions fk_reporttable_dimensions_catoptiongroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_categoryoptiongroupsetdimensions
    ADD CONSTRAINT fk_reporttable_dimensions_catoptiongroupsetdimensionid FOREIGN KEY (categoryoptiongroupsetdimensionid) REFERENCES public.categoryoptiongroupsetdimension(categoryoptiongroupsetdimensionid);


--
-- Name: reporttable_dataelementgroupsetdimensions fk_reporttable_dimensions_dataelementgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_dataelementgroupsetdimensions
    ADD CONSTRAINT fk_reporttable_dimensions_dataelementgroupsetdimensionid FOREIGN KEY (dataelementgroupsetdimensionid) REFERENCES public.dataelementgroupsetdimension(dataelementgroupsetdimensionid);


--
-- Name: reporttable_orgunitgroupsetdimensions fk_reporttable_dimensions_orgunitgroupsetdimensionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_reporttable_dimensions_orgunitgroupsetdimensionid FOREIGN KEY (orgunitgroupsetdimensionid) REFERENCES public.orgunitgroupsetdimension(orgunitgroupsetdimensionid);


--
-- Name: reporttable_filters fk_reporttable_filters_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_filters
    ADD CONSTRAINT fk_reporttable_filters_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_itemorgunitgroups fk_reporttable_itemorgunitgroups_orgunitgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_itemorgunitgroups
    ADD CONSTRAINT fk_reporttable_itemorgunitgroups_orgunitgroupid FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: reporttable_itemorgunitgroups fk_reporttable_itemorgunitunitgroups_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_itemorgunitgroups
    ADD CONSTRAINT fk_reporttable_itemorgunitunitgroups_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable fk_reporttable_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT fk_reporttable_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: reporttable_organisationunits fk_reporttable_organisationunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_organisationunits
    ADD CONSTRAINT fk_reporttable_organisationunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: reporttable_organisationunits fk_reporttable_organisationunits_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_organisationunits
    ADD CONSTRAINT fk_reporttable_organisationunits_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_orgunitgroupsetdimensions fk_reporttable_orgunitgroupsetdimensions_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_orgunitgroupsetdimensions
    ADD CONSTRAINT fk_reporttable_orgunitgroupsetdimensions_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_orgunitlevels fk_reporttable_orgunitlevels_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_orgunitlevels
    ADD CONSTRAINT fk_reporttable_orgunitlevels_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable_periods fk_reporttable_periods_periodid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_periods
    ADD CONSTRAINT fk_reporttable_periods_periodid FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: reporttable_periods fk_reporttable_periods_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_periods
    ADD CONSTRAINT fk_reporttable_periods_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable fk_reporttable_relativeperiodsid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT fk_reporttable_relativeperiodsid FOREIGN KEY (relativeperiodsid) REFERENCES public.relativeperiods(relativeperiodsid);


--
-- Name: reporttable_rows fk_reporttable_rows_reporttableid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable_rows
    ADD CONSTRAINT fk_reporttable_rows_reporttableid FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: reporttable fk_reporttable_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttable
    ADD CONSTRAINT fk_reporttable_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: sectiondataelements fk_section_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectiondataelements
    ADD CONSTRAINT fk_section_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: sectiongreyedfields fk_section_dataelementoperandid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectiongreyedfields
    ADD CONSTRAINT fk_section_dataelementoperandid FOREIGN KEY (dataelementoperandid) REFERENCES public.dataelementoperand(dataelementoperandid);


--
-- Name: section fk_section_datasetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT fk_section_datasetid FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: sectionindicators fk_section_indicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionindicators
    ADD CONSTRAINT fk_section_indicatorid FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: sectiondataelements fk_sectiondataelements_sectionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectiondataelements
    ADD CONSTRAINT fk_sectiondataelements_sectionid FOREIGN KEY (sectionid) REFERENCES public.section(sectionid);


--
-- Name: sectiongreyedfields fk_sectiongreyedfields_sectionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectiongreyedfields
    ADD CONSTRAINT fk_sectiongreyedfields_sectionid FOREIGN KEY (sectionid) REFERENCES public.section(sectionid);


--
-- Name: sectionindicators fk_sectionindicators_sectionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionindicators
    ADD CONSTRAINT fk_sectionindicators_sectionid FOREIGN KEY (sectionid) REFERENCES public.section(sectionid);


--
-- Name: smscommands fk_smscommand_program; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommands
    ADD CONSTRAINT fk_smscommand_program FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: smscommands fk_smscommand_programstage; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommands
    ADD CONSTRAINT fk_smscommand_programstage FOREIGN KEY (programstageid) REFERENCES public.programstage(programstageid);


--
-- Name: smscommands fk_smscommand_usergroup; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommands
    ADD CONSTRAINT fk_smscommand_usergroup FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: sqlview fk_sqlview_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlview
    ADD CONSTRAINT fk_sqlview_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentityattributedimension fk_teattributedimension_attributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributedimension
    ADD CONSTRAINT fk_teattributedimension_attributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: trackedentityattributedimension fk_teattributedimension_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributedimension
    ADD CONSTRAINT fk_teattributedimension_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: trackedentitydataelementdimension fk_tedataelementdimension_dataelementid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitydataelementdimension
    ADD CONSTRAINT fk_tedataelementdimension_dataelementid FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: trackedentitydataelementdimension fk_tedataelementdimension_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitydataelementdimension
    ADD CONSTRAINT fk_tedataelementdimension_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: trackedentityprogramindicatordimension fk_teprogramindicatordimension_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramindicatordimension
    ADD CONSTRAINT fk_teprogramindicatordimension_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: trackedentityprogramindicatordimension fk_teprogramindicatordimension_programindicatorid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramindicatordimension
    ADD CONSTRAINT fk_teprogramindicatordimension_programindicatorid FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: trackedentityattributelegendsets fk_trackedentityattribute_legendsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributelegendsets
    ADD CONSTRAINT fk_trackedentityattribute_legendsetid FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: trackedentityattribute fk_trackedentityattribute_optionsetid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT fk_trackedentityattribute_optionsetid FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: smscodes fk_trackedentityattribute_trackedentityattributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscodes
    ADD CONSTRAINT fk_trackedentityattribute_trackedentityattributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: trackedentityattribute fk_trackedentityattribute_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattribute
    ADD CONSTRAINT fk_trackedentityattribute_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentityinstance fk_trackedentityinstance_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstance
    ADD CONSTRAINT fk_trackedentityinstance_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: trackedentityinstance fk_trackedentityinstance_trackedentitytypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstance
    ADD CONSTRAINT fk_trackedentityinstance_trackedentitytypeid FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: trackedentityinstancefilter fk_trackedentityinstancefilter_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityinstancefilter
    ADD CONSTRAINT fk_trackedentityinstancefilter_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: trackedentityprogramowner fk_trackedentityprogramowner_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramowner
    ADD CONSTRAINT fk_trackedentityprogramowner_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: trackedentityprogramowner fk_trackedentityprogramowner_programid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramowner
    ADD CONSTRAINT fk_trackedentityprogramowner_programid FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: trackedentityprogramowner fk_trackedentityprogramowner_trackedentityinstanceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityprogramowner
    ADD CONSTRAINT fk_trackedentityprogramowner_trackedentityinstanceid FOREIGN KEY (trackedentityinstanceid) REFERENCES public.trackedentityinstance(trackedentityinstanceid);


--
-- Name: trackedentitytype fk_trackedentitytype_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytype
    ADD CONSTRAINT fk_trackedentitytype_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: trackedentitytypeattribute fk_trackedentitytypeattribute_trackedentityattributeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattribute
    ADD CONSTRAINT fk_trackedentitytypeattribute_trackedentityattributeid FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: trackedentitytypeattribute fk_trackedentitytypeattribute_trackedentitytypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattribute
    ADD CONSTRAINT fk_trackedentitytypeattribute_trackedentitytypeid FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: userinfo fk_user_fileresourceid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userinfo
    ADD CONSTRAINT fk_user_fileresourceid FOREIGN KEY (avatar) REFERENCES public.fileresource(fileresourceid);


--
-- Name: users fk_user_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_user_userid FOREIGN KEY (creatoruserid) REFERENCES public.userinfo(userinfoid);


--
-- Name: users fk_user_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_user_userinfoid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: useraccess fk_useraccess_user; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.useraccess
    ADD CONSTRAINT fk_useraccess_user FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: userapps fk_userapps_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userapps
    ADD CONSTRAINT fk_userapps_userinfoid FOREIGN KEY (userinfoid) REFERENCES public.userinfo(userinfoid);


--
-- Name: userdatavieworgunits fk_userdatavieworgunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userdatavieworgunits
    ADD CONSTRAINT fk_userdatavieworgunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: userdatavieworgunits fk_userdatavieworgunits_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userdatavieworgunits
    ADD CONSTRAINT fk_userdatavieworgunits_userinfoid FOREIGN KEY (userinfoid) REFERENCES public.userinfo(userinfoid);


--
-- Name: usergroup fk_usergroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT fk_usergroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: usergroupaccess fk_usergroupaccess_usergroup; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupaccess
    ADD CONSTRAINT fk_usergroupaccess_usergroup FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: usergroupmanaged fk_usergroupmanaging_managedbygroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupmanaged
    ADD CONSTRAINT fk_usergroupmanaging_managedbygroupid FOREIGN KEY (managedbygroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: usergroupmanaged fk_usergroupmanaging_managedgroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupmanaged
    ADD CONSTRAINT fk_usergroupmanaging_managedgroupid FOREIGN KEY (managedgroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: usergroupmembers fk_usergroupmembers_usergroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupmembers
    ADD CONSTRAINT fk_usergroupmembers_usergroupid FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: usergroupmembers fk_usergroupmembers_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupmembers
    ADD CONSTRAINT fk_usergroupmembers_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: usermembership fk_userinfo_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usermembership
    ADD CONSTRAINT fk_userinfo_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: userkeyjsonvalue fk_userkeyjsonvalue_user; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userkeyjsonvalue
    ADD CONSTRAINT fk_userkeyjsonvalue_user FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: usermembership fk_usermembership_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usermembership
    ADD CONSTRAINT fk_usermembership_userinfoid FOREIGN KEY (userinfoid) REFERENCES public.userinfo(userinfoid);


--
-- Name: usermessage fk_usermessage_user; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usermessage
    ADD CONSTRAINT fk_usermessage_user FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: userrole fk_userrole_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrole
    ADD CONSTRAINT fk_userrole_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: userroleauthorities fk_userroleauthorities_userroleid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleauthorities
    ADD CONSTRAINT fk_userroleauthorities_userroleid FOREIGN KEY (userroleid) REFERENCES public.userrole(userroleid);


--
-- Name: userrolemembers fk_userrolemembers_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrolemembers
    ADD CONSTRAINT fk_userrolemembers_userid FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: userrolemembers fk_userrolemembers_userroleid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userrolemembers
    ADD CONSTRAINT fk_userrolemembers_userroleid FOREIGN KEY (userroleid) REFERENCES public.userrole(userroleid);


--
-- Name: users_catdimensionconstraints fk_users_catconstraints_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users_catdimensionconstraints
    ADD CONSTRAINT fk_users_catconstraints_userid FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: users_cogsdimensionconstraints fk_users_cogsconstraints_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.users_cogsdimensionconstraints
    ADD CONSTRAINT fk_users_cogsconstraints_userid FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: usersetting fk_usersetting_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usersetting
    ADD CONSTRAINT fk_usersetting_userinfoid FOREIGN KEY (userinfoid) REFERENCES public.userinfo(userinfoid);


--
-- Name: userteisearchorgunits fk_userteisearchorgunits_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userteisearchorgunits
    ADD CONSTRAINT fk_userteisearchorgunits_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: userteisearchorgunits fk_userteisearchorgunits_userinfoid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userteisearchorgunits
    ADD CONSTRAINT fk_userteisearchorgunits_userinfoid FOREIGN KEY (userinfoid) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationnotificationtemplate_recipientusergroups fk_validationnotificationtemplate_usergroup; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplate_recipientusergroups
    ADD CONSTRAINT fk_validationnotificationtemplate_usergroup FOREIGN KEY (validationnotificationtemplateid) REFERENCES public.validationnotificationtemplate(validationnotificationtemplateid);


--
-- Name: validationresult fk_validationresult_attributeoptioncomboid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationresult
    ADD CONSTRAINT fk_validationresult_attributeoptioncomboid FOREIGN KEY (attributeoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: validationresult fk_validationresult_organisationunitid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationresult
    ADD CONSTRAINT fk_validationresult_organisationunitid FOREIGN KEY (organisationunitid) REFERENCES public.organisationunit(organisationunitid);


--
-- Name: validationresult fk_validationresult_period; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationresult
    ADD CONSTRAINT fk_validationresult_period FOREIGN KEY (periodid) REFERENCES public.period(periodid);


--
-- Name: validationresult fk_validationresult_validationruleid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationresult
    ADD CONSTRAINT fk_validationresult_validationruleid FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: validationrule fk_validationrule_leftexpressionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT fk_validationrule_leftexpressionid FOREIGN KEY (leftexpressionid) REFERENCES public.expression(expressionid);


--
-- Name: predictor fk_validationrule_periodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT fk_validationrule_periodtypeid FOREIGN KEY (periodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: validationrule fk_validationrule_periodtypeid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT fk_validationrule_periodtypeid FOREIGN KEY (periodtypeid) REFERENCES public.periodtype(periodtypeid);


--
-- Name: validationrule fk_validationrule_rightexpressionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT fk_validationrule_rightexpressionid FOREIGN KEY (rightexpressionid) REFERENCES public.expression(expressionid);


--
-- Name: predictor fk_validationrule_skiptestexpressionid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictor
    ADD CONSTRAINT fk_validationrule_skiptestexpressionid FOREIGN KEY (skiptestexpressionid) REFERENCES public.expression(expressionid);


--
-- Name: validationrule fk_validationrule_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrule
    ADD CONSTRAINT fk_validationrule_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationnotificationtemplatevalidationrules fk_validationrule_validationnotificationtemplateid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationnotificationtemplatevalidationrules
    ADD CONSTRAINT fk_validationrule_validationnotificationtemplateid FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: validationrulegroup fk_validationrulegroup_userid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroup
    ADD CONSTRAINT fk_validationrulegroup_userid FOREIGN KEY (userid) REFERENCES public.userinfo(userinfoid);


--
-- Name: validationrulegroupmembers fk_validationrulegroup_validationruleid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupmembers
    ADD CONSTRAINT fk_validationrulegroup_validationruleid FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: validationrulegroupmembers fk_validationrulegroupmembers_validationrulegroupid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupmembers
    ADD CONSTRAINT fk_validationrulegroupmembers_validationrulegroupid FOREIGN KEY (validationgroupid) REFERENCES public.validationrulegroup(validationrulegroupid);


--
-- Name: chart_yearlyseries fk_yearlyseries_chartid; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_yearlyseries
    ADD CONSTRAINT fk_yearlyseries_chartid FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: constantattributevalues fka4dwo79bmu0cjtqeqgclj4d42; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantattributevalues
    ADD CONSTRAINT fka4dwo79bmu0cjtqeqgclj4d42 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: dataelementgroupsetusergroupaccesses fka5vwhm9044o3r2mlf7wmkvoka; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetusergroupaccesses
    ADD CONSTRAINT fka5vwhm9044o3r2mlf7wmkvoka FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: attributeuseraccesses fka8e7rdhv12fyvkl84wk5qs55q; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeuseraccesses
    ADD CONSTRAINT fka8e7rdhv12fyvkl84wk5qs55q FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: trackedentityattributeuseraccesses fkaena7oeseunp4n3lpltyirxy7; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeuseraccesses
    ADD CONSTRAINT fkaena7oeseunp4n3lpltyirxy7 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dashboarduseraccesses fkaew232hpstgwmojawelwlvejm; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarduseraccesses
    ADD CONSTRAINT fkaew232hpstgwmojawelwlvejm FOREIGN KEY (dashboardid) REFERENCES public.dashboard(dashboardid);


--
-- Name: optiongroupsetuseraccesses fkagpfc3qen3mlu9y8w187rnw8y; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetuseraccesses
    ADD CONSTRAINT fkagpfc3qen3mlu9y8w187rnw8y FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: relationshiptypeusergroupaccesses fkagy3n4akf491x4klgc6ts4554; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeusergroupaccesses
    ADD CONSTRAINT fkagy3n4akf491x4klgc6ts4554 FOREIGN KEY (relationshiptypeid) REFERENCES public.relationshiptype(relationshiptypeid);


--
-- Name: categoryoptiongroupusergroupaccesses fkamp4mkfqkkmhhmgjygkmtjpip; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupusergroupaccesses
    ADD CONSTRAINT fkamp4mkfqkkmhhmgjygkmtjpip FOREIGN KEY (categoryoptiongroupid) REFERENCES public.categoryoptiongroup(categoryoptiongroupid);


--
-- Name: sqlviewuseraccesses fkat5c51eye5gfdskvvvgjeyiw7; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewuseraccesses
    ADD CONSTRAINT fkat5c51eye5gfdskvvvgjeyiw7 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: categoryoptiongroupuseraccesses fkatcq92ev29vb7yoiut5vcbw0p; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupuseraccesses
    ADD CONSTRAINT fkatcq92ev29vb7yoiut5vcbw0p FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataelementcategoryusergroupaccesses fkaux0ab565allf4ria7i4yqe9o; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryusergroupaccesses
    ADD CONSTRAINT fkaux0ab565allf4ria7i4yqe9o FOREIGN KEY (categoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: dataapprovalleveluseraccesses fkb2kr43ae9gkca8whshqtucs19; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalleveluseraccesses
    ADD CONSTRAINT fkb2kr43ae9gkca8whshqtucs19 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataapprovalleveluseraccesses fkb2m7919n599yobujaf6sbwkos; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalleveluseraccesses
    ADD CONSTRAINT fkb2m7919n599yobujaf6sbwkos FOREIGN KEY (dataapprovallevelid) REFERENCES public.dataapprovallevel(dataapprovallevelid);


--
-- Name: sqlviewusergroupaccesses fkb3i0kpxkt0oyh0pori98xj6f; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewusergroupaccesses
    ADD CONSTRAINT fkb3i0kpxkt0oyh0pori98xj6f FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: trackedentityattributeattributevalues fkb8c0sfajb4r29mb76o4o59850; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeattributevalues
    ADD CONSTRAINT fkb8c0sfajb4r29mb76o4o59850 FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: sqlviewuseraccesses fkbarqjic704pntxy612aapkr53; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewuseraccesses
    ADD CONSTRAINT fkbarqjic704pntxy612aapkr53 FOREIGN KEY (sqlviewid) REFERENCES public.sqlview(sqlviewid);


--
-- Name: categorycombouseraccesses fkbfhtgn2aicjte21pj8qg6qqu4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombouseraccesses
    ADD CONSTRAINT fkbfhtgn2aicjte21pj8qg6qqu4 FOREIGN KEY (categorycomboid) REFERENCES public.categorycombo(categorycomboid);


--
-- Name: reporttableuseraccesses fkbgaeqkluhopo8umxl265vmun7; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableuseraccesses
    ADD CONSTRAINT fkbgaeqkluhopo8umxl265vmun7 FOREIGN KEY (reporttableid) REFERENCES public.reporttable(reporttableid);


--
-- Name: programstageusergroupaccesses fkbm0pqhdj9xudinnssoxjdgq6b; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageusergroupaccesses
    ADD CONSTRAINT fkbm0pqhdj9xudinnssoxjdgq6b FOREIGN KEY (programid) REFERENCES public.programstage(programstageid);


--
-- Name: dataelementattributevalues fkbmhr9ethpu50qckrga381i6cy; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementattributevalues
    ADD CONSTRAINT fkbmhr9ethpu50qckrga381i6cy FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: documentusergroupaccesses fkbqtw7paqqiuor7kenyjjjkiwv; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentusergroupaccesses
    ADD CONSTRAINT fkbqtw7paqqiuor7kenyjjjkiwv FOREIGN KEY (documentid) REFERENCES public.document(documentid);


--
-- Name: dataelementlegendsets fkbrsplevygf9yr4hvydhix39ug; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementlegendsets
    ADD CONSTRAINT fkbrsplevygf9yr4hvydhix39ug FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: dataelementcategoryoptionusergroupaccesses fkbvcollq94hbv2kkjvbjhbklxi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionusergroupaccesses
    ADD CONSTRAINT fkbvcollq94hbv2kkjvbjhbklxi FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: validationruleattributevalues fkbxihj807q91qcfrmwkflc2ngi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleattributevalues
    ADD CONSTRAINT fkbxihj807q91qcfrmwkflc2ngi FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: programmessage_emailaddresses fkbyaw75hj8du8w14hpuhxj762w; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage_emailaddresses
    ADD CONSTRAINT fkbyaw75hj8du8w14hpuhxj762w FOREIGN KEY (programmessageemailaddressid) REFERENCES public.programmessage(id);


--
-- Name: optiongroupuseraccesses fkc42pvyyurx18c7g8x1or92x6; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupuseraccesses
    ADD CONSTRAINT fkc42pvyyurx18c7g8x1or92x6 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: datasetusergroupaccesses fkc5hdg6ruv7glmp88j6ohkvxgu; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetusergroupaccesses
    ADD CONSTRAINT fkc5hdg6ruv7glmp88j6ohkvxgu FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: categoryoptiongroupsetusergroupaccesses fkc5w6s58ykqw8gf6h8oxinq1p1; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetusergroupaccesses
    ADD CONSTRAINT fkc5w6s58ykqw8gf6h8oxinq1p1 FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: categoryoptioncomboattributevalues fkc6ae9oxts83ohrx20gxjoo2o4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncomboattributevalues
    ADD CONSTRAINT fkc6ae9oxts83ohrx20gxjoo2o4 FOREIGN KEY (categoryoptioncomboid) REFERENCES public.categoryoptioncombo(categoryoptioncomboid);


--
-- Name: smscommandcodes fkc6ibwny8jp0hq6l6w0w2untt4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandcodes
    ADD CONSTRAINT fkc6ibwny8jp0hq6l6w0w2untt4 FOREIGN KEY (id) REFERENCES public.smscommands(smscommandid);


--
-- Name: categorycombouseraccesses fkc7eve8dbu1difp790efea7rs4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombouseraccesses
    ADD CONSTRAINT fkc7eve8dbu1difp790efea7rs4 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataapprovallevelusergroupaccesses fkccl4gw7l7hxrfgqa2hqnvxlkq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovallevelusergroupaccesses
    ADD CONSTRAINT fkccl4gw7l7hxrfgqa2hqnvxlkq FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataelementgroupsetusergroupaccesses fkcco3y9joqwitwh2mdrq2svakg; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetusergroupaccesses
    ADD CONSTRAINT fkcco3y9joqwitwh2mdrq2svakg FOREIGN KEY (dataelementgroupsetid) REFERENCES public.dataelementgroupset(dataelementgroupsetid);


--
-- Name: trackedentityattributelegendsets fkcdkajbb0rpnpwuo57i894s0dg; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributelegendsets
    ADD CONSTRAINT fkcdkajbb0rpnpwuo57i894s0dg FOREIGN KEY (trackedentityattributeid) REFERENCES public.trackedentityattribute(trackedentityattributeid);


--
-- Name: smscommandspecialcharacters fkch98ncn24f71dft102f7of537; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandspecialcharacters
    ADD CONSTRAINT fkch98ncn24f71dft102f7of537 FOREIGN KEY (smscommandid) REFERENCES public.smscommands(smscommandid);


--
-- Name: chartuseraccesses fkcljbikjrhndoo16muyolfar3n; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartuseraccesses
    ADD CONSTRAINT fkcljbikjrhndoo16muyolfar3n FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: organisationunitattributevalues fkcoo6svgtx8pre5fabnjuyhgpf; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.organisationunitattributevalues
    ADD CONSTRAINT fkcoo6svgtx8pre5fabnjuyhgpf FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: userroleuseraccesses fkctrs1ehqub6785ojlihki52eh; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleuseraccesses
    ADD CONSTRAINT fkctrs1ehqub6785ojlihki52eh FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: validationruleattributevalues fkcyno963lti18e1fcsyqehub57; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleattributevalues
    ADD CONSTRAINT fkcyno963lti18e1fcsyqehub57 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: documentusergroupaccesses fkd8f9hmgonr1f04lom1pwg2td5; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentusergroupaccesses
    ADD CONSTRAINT fkd8f9hmgonr1f04lom1pwg2td5 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: trackedentitytypeusergroupaccesses fkdaq0s179v2imf215hn3b7kpdp; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeusergroupaccesses
    ADD CONSTRAINT fkdaq0s179v2imf215hn3b7kpdp FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: indicatorattributevalues fkdba2e0q8kva3oiigmfjujmc09; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorattributevalues
    ADD CONSTRAINT fkdba2e0q8kva3oiigmfjujmc09 FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: dataapprovalworkflowusergroupaccesses fkdc4xtxb8tk28tg8gihya0f8t3; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataapprovalworkflowusergroupaccesses
    ADD CONSTRAINT fkdc4xtxb8tk28tg8gihya0f8t3 FOREIGN KEY (workflowid) REFERENCES public.dataapprovalworkflow(workflowid);


--
-- Name: dataelementusergroupaccesses fkdfoid1s8be97lj4d0dq0wn2h9; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementusergroupaccesses
    ADD CONSTRAINT fkdfoid1s8be97lj4d0dq0wn2h9 FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: dataelementgroupsetattributevalues fkdjw7x81vf652xov95hx212n66; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetattributevalues
    ADD CONSTRAINT fkdjw7x81vf652xov95hx212n66 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: trackedentitytypeuseraccesses fkdk6whdv75o0d1kwveyfm7fo0i; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeuseraccesses
    ADD CONSTRAINT fkdk6whdv75o0d1kwveyfm7fo0i FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: programstageinstance_messageconversation fkdmc46bnsqath7p6mrsrb89eml; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance_messageconversation
    ADD CONSTRAINT fkdmc46bnsqath7p6mrsrb89eml FOREIGN KEY (messageconversationid) REFERENCES public.messageconversation(messageconversationid);


--
-- Name: mapuseraccesses fkdmiv8bdyjs0sj5bgltqmync3q; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapuseraccesses
    ADD CONSTRAINT fkdmiv8bdyjs0sj5bgltqmync3q FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: reportuseraccesses fkdmqfyfhml5bjunjsvdur0trxy; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportuseraccesses
    ADD CONSTRAINT fkdmqfyfhml5bjunjsvdur0trxy FOREIGN KEY (reportid) REFERENCES public.report(reportid);


--
-- Name: dataelementcategoryoptionusergroupaccesses fkdudfflo1n7r4iuyqxba1b4ovi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionusergroupaccesses
    ADD CONSTRAINT fkdudfflo1n7r4iuyqxba1b4ovi FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: optionsetusergroupaccesses fkdx9fhldp5xt6quko76j4d8kk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetusergroupaccesses
    ADD CONSTRAINT fkdx9fhldp5xt6quko76j4d8kk FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: smscommandcodes fke1eymlpayuhawlo8pfuwue654; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandcodes
    ADD CONSTRAINT fke1eymlpayuhawlo8pfuwue654 FOREIGN KEY (codeid) REFERENCES public.smscodes(smscodeid);


--
-- Name: programindicatorgroupattributevalues fke2q9lkr609pqg1b0ydm0rowtm; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupattributevalues
    ADD CONSTRAINT fke2q9lkr609pqg1b0ydm0rowtm FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: reporttableusergroupaccesses fke9a9ot5uw06v8xysffntqn163; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableusergroupaccesses
    ADD CONSTRAINT fke9a9ot5uw06v8xysffntqn163 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: validationrulegroupuseraccesses fked5a3idn9xy17kqh044r4khnq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupuseraccesses
    ADD CONSTRAINT fked5a3idn9xy17kqh044r4khnq FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: programindicatorgroupusergroupaccesses fkehrkml89lh7kv1bmutotucsjm; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorgroupusergroupaccesses
    ADD CONSTRAINT fkehrkml89lh7kv1bmutotucsjm FOREIGN KEY (programindicatorgroupid) REFERENCES public.programindicatorgroup(programindicatorgroupid);


--
-- Name: datasetnotification_datasets fken6g44y648k1fembweltcao3e; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotification_datasets
    ADD CONSTRAINT fken6g44y648k1fembweltcao3e FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: documentuseraccesses fkeu7sin6er3x3kuhtbqys9bbqt; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentuseraccesses
    ADD CONSTRAINT fkeu7sin6er3x3kuhtbqys9bbqt FOREIGN KEY (documentid) REFERENCES public.document(documentid);


--
-- Name: reportusergroupaccesses fkeuett3yqyqms2edpep4g1etjd; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportusergroupaccesses
    ADD CONSTRAINT fkeuett3yqyqms2edpep4g1etjd FOREIGN KEY (reportid) REFERENCES public.report(reportid);


--
-- Name: relationshiptypeuseraccesses fkew8qgoqdrkbdgmuir3ualsp7m; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.relationshiptypeuseraccesses
    ADD CONSTRAINT fkew8qgoqdrkbdgmuir3ualsp7m FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: externalmaplayerusergroupaccesses fkf97c7k1pwvp39tdx1ehrwywxp; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayerusergroupaccesses
    ADD CONSTRAINT fkf97c7k1pwvp39tdx1ehrwywxp FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: optionsetusergroupaccesses fkfamquh0yxd74tj2thpnxll8qd; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetusergroupaccesses
    ADD CONSTRAINT fkfamquh0yxd74tj2thpnxll8qd FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: interpretationuseraccesses fkfgbg6qcks2bxagux2nqwl6mam; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationuseraccesses
    ADD CONSTRAINT fkfgbg6qcks2bxagux2nqwl6mam FOREIGN KEY (interpretationid) REFERENCES public.interpretation(interpretationid);


--
-- Name: datasetusergroupaccesses fkfju7l9tdk4vuit5y3mw3pmfdp; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetusergroupaccesses
    ADD CONSTRAINT fkfju7l9tdk4vuit5y3mw3pmfdp FOREIGN KEY (datasetid) REFERENCES public.dataset(datasetid);


--
-- Name: validationrulegroupattributevalues fkfruohf3cqsxqunqlbnl1i3ier; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupattributevalues
    ADD CONSTRAINT fkfruohf3cqsxqunqlbnl1i3ier FOREIGN KEY (validationrulegroupid) REFERENCES public.validationrulegroup(validationrulegroupid);


--
-- Name: dataelementgroupsetuseraccesses fkftog7iowqys99f34vxtwvhclx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetuseraccesses
    ADD CONSTRAINT fkftog7iowqys99f34vxtwvhclx FOREIGN KEY (dataelementgroupsetid) REFERENCES public.dataelementgroupset(dataelementgroupsetid);


--
-- Name: previouspasswords fkg6n5kwuhypwdvkn15ke824kpb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.previouspasswords
    ADD CONSTRAINT fkg6n5kwuhypwdvkn15ke824kpb FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: program_userroles fkgb55kdvtf92qykh2840inyhst; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.program_userroles
    ADD CONSTRAINT fkgb55kdvtf92qykh2840inyhst FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: categoryoptiongroupsetattributevalues fkgjrd8o33y63ely39hjm7afbcf; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetattributevalues
    ADD CONSTRAINT fkgjrd8o33y63ely39hjm7afbcf FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: validationruleuseraccesses fkgscric80wkt82kyxdc4gvv030; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleuseraccesses
    ADD CONSTRAINT fkgscric80wkt82kyxdc4gvv030 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: categoryoptioncomboattributevalues fkgvdx3u8ymbvq3mfr0qih7kbgl; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptioncomboattributevalues
    ADD CONSTRAINT fkgvdx3u8ymbvq3mfr0qih7kbgl FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: dataelementattributevalues fkh063grx17s8wbufgi6rmb2qj9; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementattributevalues
    ADD CONSTRAINT fkh063grx17s8wbufgi6rmb2qj9 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: optionsetattributevalues fkh7rgh9ccjygftu2um7bt8o15w; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetattributevalues
    ADD CONSTRAINT fkh7rgh9ccjygftu2um7bt8o15w FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: userroleusergroupaccesses fkh8a8f65qyvb9ht8218fbqif3r; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleusergroupaccesses
    ADD CONSTRAINT fkh8a8f65qyvb9ht8218fbqif3r FOREIGN KEY (userroleid) REFERENCES public.userrole(userroleid);


--
-- Name: categorycombousergroupaccesses fkhcb8xpki59p7up71arpcj6mgo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categorycombousergroupaccesses
    ADD CONSTRAINT fkhcb8xpki59p7up71arpcj6mgo FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: predictorgroupusergroupaccesses fkhk8xv9l2nyojqlcliodoio87h; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupusergroupaccesses
    ADD CONSTRAINT fkhk8xv9l2nyojqlcliodoio87h FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: eventreportusergroupaccesses fkhlhawnoj4iw21if6whyjhyuxx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportusergroupaccesses
    ADD CONSTRAINT fkhlhawnoj4iw21if6whyjhyuxx FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: validationruleusergroupaccesses fkhmb8frud8xu70up73bpnbfpf8; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleusergroupaccesses
    ADD CONSTRAINT fkhmb8frud8xu70up73bpnbfpf8 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataelementgroupuseraccesses fkhqi75xl3pvjqhvg2ffkapse5b; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupuseraccesses
    ADD CONSTRAINT fkhqi75xl3pvjqhvg2ffkapse5b FOREIGN KEY (dataelementgroupid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: programstageusergroupaccesses fkhrmc5b26i4fv714agdvwm2tly; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageusergroupaccesses
    ADD CONSTRAINT fkhrmc5b26i4fv714agdvwm2tly FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: attributeusergroupaccesses fkhsktcf5wolfqpbjum1h8mjlg0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeusergroupaccesses
    ADD CONSTRAINT fkhsktcf5wolfqpbjum1h8mjlg0 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: optionattributevalues fki0jsa3ibpqnmf9f6a079yvqg1; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionattributevalues
    ADD CONSTRAINT fki0jsa3ibpqnmf9f6a079yvqg1 FOREIGN KEY (optionvalueid) REFERENCES public.optionvalue(optionvalueid);


--
-- Name: legendsetuseraccesses fki3c4derc037s8706gc29tn72y; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetuseraccesses
    ADD CONSTRAINT fki3c4derc037s8706gc29tn72y FOREIGN KEY (maplegendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: pushanalysis fkibpy72i2p9nfkdtqqe6my34nr; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysis
    ADD CONSTRAINT fkibpy72i2p9nfkdtqqe6my34nr FOREIGN KEY (dashboard) REFERENCES public.dashboard(dashboardid);


--
-- Name: documentuseraccesses fkiev77xq3u50tnxter17midwpk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentuseraccesses
    ADD CONSTRAINT fkiev77xq3u50tnxter17midwpk FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: optiongroupattributevalues fkijpqu28mpafr0wbgu2p4qs2ys; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupattributevalues
    ADD CONSTRAINT fkijpqu28mpafr0wbgu2p4qs2ys FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: categoryoptiongroupattributevalues fkikavm35a9xngxxqnaonnmk7yw; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupattributevalues
    ADD CONSTRAINT fkikavm35a9xngxxqnaonnmk7yw FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: programindicatorattributevalues fkilna5etu4xlgyf93sguvt6e6s; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorattributevalues
    ADD CONSTRAINT fkilna5etu4xlgyf93sguvt6e6s FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: orgunitgroupsetattributevalues fkisircfmtwyf4f63ci19fi4i8l; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetattributevalues
    ADD CONSTRAINT fkisircfmtwyf4f63ci19fi4i8l FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: documentattributevalues fkj16b2115543s4odxcl034keuj; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentattributevalues
    ADD CONSTRAINT fkj16b2115543s4odxcl034keuj FOREIGN KEY (documentid) REFERENCES public.document(documentid);


--
-- Name: programinstance_messageconversation fkj3dr5vrqclcaodu7x4rm1qsbo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance_messageconversation
    ADD CONSTRAINT fkj3dr5vrqclcaodu7x4rm1qsbo FOREIGN KEY (programinstanceid) REFERENCES public.programinstance(programinstanceid);


--
-- Name: indicatoruseraccesses fkj5qrssmmg27bp6i8vb391kwin; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatoruseraccesses
    ADD CONSTRAINT fkj5qrssmmg27bp6i8vb391kwin FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: dataelementuseraccesses fkjdlf4yqax04d3krscjtucfjv0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementuseraccesses
    ADD CONSTRAINT fkjdlf4yqax04d3krscjtucfjv0 FOREIGN KEY (dataelementid) REFERENCES public.dataelement(dataelementid);


--
-- Name: indicatorgroupuseraccesses fkjl1fwmeghy7xswjxuin4bb5t9; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupuseraccesses
    ADD CONSTRAINT fkjl1fwmeghy7xswjxuin4bb5t9 FOREIGN KEY (indicatorgroupid) REFERENCES public.indicatorgroup(indicatorgroupid);


--
-- Name: dataelementcategoryoptionattributevalues fkjp6o40q5mb5a9fixiaqxf6dur; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionattributevalues
    ADD CONSTRAINT fkjp6o40q5mb5a9fixiaqxf6dur FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: indicatorgroupattributevalues fkjtpyr15khpfwyeljjblln3amh; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupattributevalues
    ADD CONSTRAINT fkjtpyr15khpfwyeljjblln3amh FOREIGN KEY (indicatorgroupid) REFERENCES public.indicatorgroup(indicatorgroupid);


--
-- Name: optiongroupsetusergroupaccesses fkjuv8jwcqjrp9u60ca0b9secwe; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetusergroupaccesses
    ADD CONSTRAINT fkjuv8jwcqjrp9u60ca0b9secwe FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: attributeuseraccesses fkjwscshsefl3u0p4e1829sgdyr; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeuseraccesses
    ADD CONSTRAINT fkjwscshsefl3u0p4e1829sgdyr FOREIGN KEY (attributeid) REFERENCES public.attribute(attributeid);


--
-- Name: programinstance_messageconversation fkjy8ap861np4x3c5glxv8l8719; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programinstance_messageconversation
    ADD CONSTRAINT fkjy8ap861np4x3c5glxv8l8719 FOREIGN KEY (messageconversationid) REFERENCES public.messageconversation(messageconversationid);


--
-- Name: constantuseraccesses fkk42gcgtiru8yc79d83vqap641; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantuseraccesses
    ADD CONSTRAINT fkk42gcgtiru8yc79d83vqap641 FOREIGN KEY (constantid) REFERENCES public.constant(constantid);


--
-- Name: indicatorusergroupaccesses fkk53fwmr0vsgh3pbfw1u5i7kxd; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorusergroupaccesses
    ADD CONSTRAINT fkk53fwmr0vsgh3pbfw1u5i7kxd FOREIGN KEY (indicatorid) REFERENCES public.indicator(indicatorid);


--
-- Name: datasetuseraccesses fkk6vnjbcq5ypgh3xllicm8rg53; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetuseraccesses
    ADD CONSTRAINT fkk6vnjbcq5ypgh3xllicm8rg53 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: trackedentitytypeuseraccesses fkkao3e3ujv7mb1y45j6f31su7l; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeuseraccesses
    ADD CONSTRAINT fkkao3e3ujv7mb1y45j6f31su7l FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: programindicatorlegendsets fkkbd9rqv83w4nwogj5fchtxj9y; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorlegendsets
    ADD CONSTRAINT fkkbd9rqv83w4nwogj5fchtxj9y FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: indicatorgroupsetuseraccesses fkkbjtmc65moywxl2yr4rkg91dc; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetuseraccesses
    ADD CONSTRAINT fkkbjtmc65moywxl2yr4rkg91dc FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: programusergroupaccesses fkkca6l1aa5y714267lpm03f6k1; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programusergroupaccesses
    ADD CONSTRAINT fkkca6l1aa5y714267lpm03f6k1 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: programindicatorusergroupaccesses fkkcioj9orjwbcwmdam6pj6d9o2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorusergroupaccesses
    ADD CONSTRAINT fkkcioj9orjwbcwmdam6pj6d9o2 FOREIGN KEY (programindicatorid) REFERENCES public.programindicator(programindicatorid);


--
-- Name: predictorgroupuseraccesses fkkili7t45u71869fl6nd4pf2r2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupuseraccesses
    ADD CONSTRAINT fkkili7t45u71869fl6nd4pf2r2 FOREIGN KEY (predictorgroupid) REFERENCES public.predictorgroup(predictorgroupid);


--
-- Name: categoryattributevalues fkkjg0yhi1ge3wteghq6f1n0m9x; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryattributevalues
    ADD CONSTRAINT fkkjg0yhi1ge3wteghq6f1n0m9x FOREIGN KEY (categoryid) REFERENCES public.dataelementcategory(categoryid);


--
-- Name: optionsetuseraccesses fkkml1la4fwlysih8lrwhkvx0du; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetuseraccesses
    ADD CONSTRAINT fkkml1la4fwlysih8lrwhkvx0du FOREIGN KEY (optionsetid) REFERENCES public.optionset(optionsetid);


--
-- Name: indicatorgroupsetuseraccesses fkkrew00svu3k1mj9dopscffp55; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetuseraccesses
    ADD CONSTRAINT fkkrew00svu3k1mj9dopscffp55 FOREIGN KEY (indicatorgroupsetid) REFERENCES public.indicatorgroupset(indicatorgroupsetid);


--
-- Name: legendsetuseraccesses fkkrh34fj5dp5gvkiokhkmwlqw4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetuseraccesses
    ADD CONSTRAINT fkkrh34fj5dp5gvkiokhkmwlqw4 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: optionsetattributevalues fkkrhc4bbmf9jnaxj545a004fb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetattributevalues
    ADD CONSTRAINT fkkrhc4bbmf9jnaxj545a004fb FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: chartusergroupaccesses fkkrroom2rcrf3a83abq969085u; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartusergroupaccesses
    ADD CONSTRAINT fkkrroom2rcrf3a83abq969085u FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: programstageinstance_messageconversation fkks9i10v8xg7d22hlhmesia51l; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageinstance_messageconversation
    ADD CONSTRAINT fkks9i10v8xg7d22hlhmesia51l FOREIGN KEY (programstageinstanceid) REFERENCES public.programstageinstance(programstageinstanceid);


--
-- Name: outbound_sms_recipients fkktmkxjuo5b3v1q2jqk7lymh0p; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.outbound_sms_recipients
    ADD CONSTRAINT fkktmkxjuo5b3v1q2jqk7lymh0p FOREIGN KEY (outbound_sms_id) REFERENCES public.outbound_sms(id);


--
-- Name: reportusergroupaccesses fkkyhyiwi48ogtjvtvltk506eeh; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reportusergroupaccesses
    ADD CONSTRAINT fkkyhyiwi48ogtjvtvltk506eeh FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataelementgroupsetuseraccesses fkl0m801gevx2jxc3tv4uh917wd; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetuseraccesses
    ADD CONSTRAINT fkl0m801gevx2jxc3tv4uh917wd FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: orgunitgroupsetusergroupaccesses fkl0xk38e01qsghc0kkbykbbodo; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetusergroupaccesses
    ADD CONSTRAINT fkl0xk38e01qsghc0kkbykbbodo FOREIGN KEY (orgunitgroupsetid) REFERENCES public.orgunitgroupset(orgunitgroupsetid);


--
-- Name: constantusergroupaccesses fkl8cxqyb3s8c31qbaqehu71u9e; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantusergroupaccesses
    ADD CONSTRAINT fkl8cxqyb3s8c31qbaqehu71u9e FOREIGN KEY (constantid) REFERENCES public.constant(constantid);


--
-- Name: dataelementgroupsetattributevalues fkl8h8ty5ii42v1ioad1ocacvqi; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupsetattributevalues
    ADD CONSTRAINT fkl8h8ty5ii42v1ioad1ocacvqi FOREIGN KEY (dataelementgroupsetid) REFERENCES public.dataelementgroupset(dataelementgroupsetid);


--
-- Name: programindicatorusergroupaccesses fklcvyf20urcrk3k1grq17u5yxa; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatorusergroupaccesses
    ADD CONSTRAINT fklcvyf20urcrk3k1grq17u5yxa FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: documentattributevalues fkleuiq3mib4iq5q840n80cv993; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.documentattributevalues
    ADD CONSTRAINT fkleuiq3mib4iq5q840n80cv993 FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: dataelementusergroupaccesses fkljaoalw4iomchlahjcmijy41n; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementusergroupaccesses
    ADD CONSTRAINT fkljaoalw4iomchlahjcmijy41n FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: programmessage_deliverychannels fkljv6vp4ro5l6stx7dclnkenen; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programmessage_deliverychannels
    ADD CONSTRAINT fkljv6vp4ro5l6stx7dclnkenen FOREIGN KEY (programmessagedeliverychannelsid) REFERENCES public.programmessage(id);


--
-- Name: pushanalysisrecipientusergroups fklllvhilfsouycft98q82ph66q; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.pushanalysisrecipientusergroups
    ADD CONSTRAINT fklllvhilfsouycft98q82ph66q FOREIGN KEY (usergroupid) REFERENCES public.pushanalysis(pushanalysisid);


--
-- Name: eventreportusergroupaccesses fklq73q1u6q1w6uilvg8xjvqpkq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportusergroupaccesses
    ADD CONSTRAINT fklq73q1u6q1w6uilvg8xjvqpkq FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: eventreportuseraccesses fklxmc2s4f0e2a318ab6vda0n6p; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportuseraccesses
    ADD CONSTRAINT fklxmc2s4f0e2a318ab6vda0n6p FOREIGN KEY (eventreportid) REFERENCES public.eventreport(eventreportid);


--
-- Name: eventchartuseraccesses fklxqwf9ghutdfxongiorp2jpef; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartuseraccesses
    ADD CONSTRAINT fklxqwf9ghutdfxongiorp2jpef FOREIGN KEY (eventchartid) REFERENCES public.eventchart(eventchartid);


--
-- Name: programstageattributevalues fkly81qo12mmdwo1nuxqvdvw07d; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageattributevalues
    ADD CONSTRAINT fkly81qo12mmdwo1nuxqvdvw07d FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: eventchartusergroupaccesses fkm5h5tkbbogqelay0io9qm74o0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartusergroupaccesses
    ADD CONSTRAINT fkm5h5tkbbogqelay0io9qm74o0 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: interpretationusergroupaccesses fkmfeihksbnauk0swgve0o96ewr; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationusergroupaccesses
    ADD CONSTRAINT fkmfeihksbnauk0swgve0o96ewr FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: validationruleuseraccesses fkmk0h5ph7j0ep4nxjj2q5ga9r0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationruleuseraccesses
    ADD CONSTRAINT fkmk0h5ph7j0ep4nxjj2q5ga9r0 FOREIGN KEY (validationruleid) REFERENCES public.validationrule(validationruleid);


--
-- Name: externalmaplayerusergroupaccesses fkmmdfsq1s9g437k0wsshbivaht; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.externalmaplayerusergroupaccesses
    ADD CONSTRAINT fkmmdfsq1s9g437k0wsshbivaht FOREIGN KEY (externalmaplayerid) REFERENCES public.externalmaplayer(externalmaplayerid);


--
-- Name: dashboardusergroupaccesses fkmrvj9l6sv7su7wehohc9wipdu; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboardusergroupaccesses
    ADD CONSTRAINT fkmrvj9l6sv7su7wehohc9wipdu FOREIGN KEY (dashboardid) REFERENCES public.dashboard(dashboardid);


--
-- Name: programindicatoruseraccesses fkms3h2rvf98325h17u60hnpfdx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programindicatoruseraccesses
    ADD CONSTRAINT fkms3h2rvf98325h17u60hnpfdx FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: categoryoptiongroupsetusergroupaccesses fkmumx7i7wqjn3jh4mt4r4x1eqe; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetusergroupaccesses
    ADD CONSTRAINT fkmumx7i7wqjn3jh4mt4r4x1eqe FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dashboardusergroupaccesses fkmw5yn4ptnpkve2lsvxiopdp6; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboardusergroupaccesses
    ADD CONSTRAINT fkmw5yn4ptnpkve2lsvxiopdp6 FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: userroleusergroupaccesses fkmwadbe8twmr8ordbjjlrloxnp; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleusergroupaccesses
    ADD CONSTRAINT fkmwadbe8twmr8ordbjjlrloxnp FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: orgunitgroupsetusergroupaccesses fkn5mp5cao30al69clovpwwe6mk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetusergroupaccesses
    ADD CONSTRAINT fkn5mp5cao30al69clovpwwe6mk FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: usergroupusergroupaccesses fkn8cff8o99v6tnpgl2fgugjwpf; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupusergroupaccesses
    ADD CONSTRAINT fkn8cff8o99v6tnpgl2fgugjwpf FOREIGN KEY (usergroupid) REFERENCES public.usergroup(usergroupid);


--
-- Name: optiongroupusergroupaccesses fkne0hjh5lknlabbotmbpm9ynwx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupusergroupaccesses
    ADD CONSTRAINT fkne0hjh5lknlabbotmbpm9ynwx FOREIGN KEY (optiongroupid) REFERENCES public.optiongroup(optiongroupid);


--
-- Name: categoryoptiongroupsetuseraccesses fkneu0r5aaxns3msvu5r7cpvjhk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetuseraccesses
    ADD CONSTRAINT fkneu0r5aaxns3msvu5r7cpvjhk FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: indicatorgroupusergroupaccesses fknfwv4dnc90au8jvtt3ra2scbl; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupusergroupaccesses
    ADD CONSTRAINT fknfwv4dnc90au8jvtt3ra2scbl FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: indicatoruseraccesses fkngn9j2oevi4k05245lqfhuyh4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatoruseraccesses
    ADD CONSTRAINT fkngn9j2oevi4k05245lqfhuyh4 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: orgunitgroupusergroupaccesses fknimjjjq6ww7vcnjbxw9qo3daa; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupusergroupaccesses
    ADD CONSTRAINT fknimjjjq6ww7vcnjbxw9qo3daa FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: trackedentityattributeusergroupaccesses fknqghxxgrlh1dyluj9fgh1x6pn; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentityattributeusergroupaccesses
    ADD CONSTRAINT fknqghxxgrlh1dyluj9fgh1x6pn FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: legendsetattributevalues fknthmdh7yci1po66i02ssldxod; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetattributevalues
    ADD CONSTRAINT fknthmdh7yci1po66i02ssldxod FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: orgunitgroupsetuseraccesses fknyh2e7xbcnv2iw3wvtk2ng8h9; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupsetuseraccesses
    ADD CONSTRAINT fknyh2e7xbcnv2iw3wvtk2ng8h9 FOREIGN KEY (orgunitgroupsetid) REFERENCES public.orgunitgroupset(orgunitgroupsetid);


--
-- Name: optionsetuseraccesses fko7bqom2xom9t71509y9cxvh7f; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optionsetuseraccesses
    ADD CONSTRAINT fko7bqom2xom9t71509y9cxvh7f FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: mapusergroupaccesses fko975uxx8n7sspdysehujj8e7t; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapusergroupaccesses
    ADD CONSTRAINT fko975uxx8n7sspdysehujj8e7t FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: sqlviewusergroupaccesses fkoccxpdljjjbxr1vrwfp9d25dt; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sqlviewusergroupaccesses
    ADD CONSTRAINT fkoccxpdljjjbxr1vrwfp9d25dt FOREIGN KEY (sqlviewid) REFERENCES public.sqlview(sqlviewid);


--
-- Name: mapusergroupaccesses fkokgalu75pd2e1no2x53cxe8ik; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.mapusergroupaccesses
    ADD CONSTRAINT fkokgalu75pd2e1no2x53cxe8ik FOREIGN KEY (mapid) REFERENCES public.map(mapid);


--
-- Name: chartusergroupaccesses fkou5go53l80o7omb2dqcpp7wjh; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartusergroupaccesses
    ADD CONSTRAINT fkou5go53l80o7omb2dqcpp7wjh FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: interpretationuseraccesses fkp6b2s2prdt8o77hncyiyoc3w0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.interpretationuseraccesses
    ADD CONSTRAINT fkp6b2s2prdt8o77hncyiyoc3w0 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: orgunitgroupattributevalues fkp7of94t57djd0buqsc46xs32u; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupattributevalues
    ADD CONSTRAINT fkp7of94t57djd0buqsc46xs32u FOREIGN KEY (orgunitgroupid) REFERENCES public.orgunitgroup(orgunitgroupid);


--
-- Name: dataelementgroupattributevalues fkp8i8mavj9jd5q2lyqag2rhi03; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupattributevalues
    ADD CONSTRAINT fkp8i8mavj9jd5q2lyqag2rhi03 FOREIGN KEY (dataelementgroupid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: dataelementgroupuseraccesses fkpe7wkmr4j7aury8bwntn2jd0k; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupuseraccesses
    ADD CONSTRAINT fkpe7wkmr4j7aury8bwntn2jd0k FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: usergroupuseraccesses fkperhr810jcqprtiija9b5a4tj; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupuseraccesses
    ADD CONSTRAINT fkperhr810jcqprtiija9b5a4tj FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: datasetnotificationtemplate_deliverychannel fkpmebskggkjfjfwxw7u43twmg2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetnotificationtemplate_deliverychannel
    ADD CONSTRAINT fkpmebskggkjfjfwxw7u43twmg2 FOREIGN KEY (datasetnotificationtemplateid) REFERENCES public.datasetnotificationtemplate(datasetnotificationtemplateid);


--
-- Name: categoryoptiongroupuseraccesses fkq1mwh4ffdsnhwn7v097eayid5; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupuseraccesses
    ADD CONSTRAINT fkq1mwh4ffdsnhwn7v097eayid5 FOREIGN KEY (categoryoptiongroupid) REFERENCES public.categoryoptiongroup(categoryoptiongroupid);


--
-- Name: attributeusergroupaccesses fkq35si1aa88tk4o4ygpn8my54q; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.attributeusergroupaccesses
    ADD CONSTRAINT fkq35si1aa88tk4o4ygpn8my54q FOREIGN KEY (attributeid) REFERENCES public.attribute(attributeid);


--
-- Name: userattributevalues fkq6f4o8i51dngmiimuj3wctes3; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userattributevalues
    ADD CONSTRAINT fkq6f4o8i51dngmiimuj3wctes3 FOREIGN KEY (userinfoid) REFERENCES public.userinfo(userinfoid);


--
-- Name: indicatorgroupsetusergroupaccesses fkq80dj8d4slnw9lna5jrsdxxou; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetusergroupaccesses
    ADD CONSTRAINT fkq80dj8d4slnw9lna5jrsdxxou FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: userroleuseraccesses fkqf598s5kghjesta6ibgiepbnp; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userroleuseraccesses
    ADD CONSTRAINT fkqf598s5kghjesta6ibgiepbnp FOREIGN KEY (userroleid) REFERENCES public.userrole(userroleid);


--
-- Name: optiongroupuseraccesses fkqit4l4bglf1xnh7jo7i3x11e7; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupuseraccesses
    ADD CONSTRAINT fkqit4l4bglf1xnh7jo7i3x11e7 FOREIGN KEY (optiongroupid) REFERENCES public.optiongroup(optiongroupid);


--
-- Name: usergroupusergroupaccesses fkqky1rnn3ulqpc6j0mpjrm7elm; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupusergroupaccesses
    ADD CONSTRAINT fkqky1rnn3ulqpc6j0mpjrm7elm FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: trackedentitytypeusergroupaccesses fkql75bu38n82o2bha8qt65nk2p; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeusergroupaccesses
    ADD CONSTRAINT fkql75bu38n82o2bha8qt65nk2p FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: datasetattributevalues fkqsfp938c3hscdt0l85kakwtxr; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.datasetattributevalues
    ADD CONSTRAINT fkqsfp938c3hscdt0l85kakwtxr FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: constantusergroupaccesses fkqv5w8d50v5bhcsvwahlwfslqu; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantusergroupaccesses
    ADD CONSTRAINT fkqv5w8d50v5bhcsvwahlwfslqu FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: eventreportuseraccesses fkr7hn20ublmb237x85sj6imdbf; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventreportuseraccesses
    ADD CONSTRAINT fkr7hn20ublmb237x85sj6imdbf FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: categoryoptiongroupsetattributevalues fkrhpy67336uj4qhrbgjfre0nvq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.categoryoptiongroupsetattributevalues
    ADD CONSTRAINT fkrhpy67336uj4qhrbgjfre0nvq FOREIGN KEY (categoryoptiongroupsetid) REFERENCES public.categoryoptiongroupset(categoryoptiongroupsetid);


--
-- Name: eventchartuseraccesses fkrj07bbr93ggi7te3wclxftolp; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.eventchartuseraccesses
    ADD CONSTRAINT fkrj07bbr93ggi7te3wclxftolp FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: trackedentitytypeattributevalues fkrjv6nocvx88v1l9ygtbf5p5sb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.trackedentitytypeattributevalues
    ADD CONSTRAINT fkrjv6nocvx88v1l9ygtbf5p5sb FOREIGN KEY (trackedentitytypeid) REFERENCES public.trackedentitytype(trackedentitytypeid);


--
-- Name: reporttableuseraccesses fkrk1nime7qkj74qk8bvl71nnu0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.reporttableuseraccesses
    ADD CONSTRAINT fkrk1nime7qkj74qk8bvl71nnu0 FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: chartuseraccesses fkrlanjumcue8qe8csk47invf0m; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chartuseraccesses
    ADD CONSTRAINT fkrlanjumcue8qe8csk47invf0m FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: chart_filters fks04qh58fxmsf5601n9cvpdtc8; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.chart_filters
    ADD CONSTRAINT fks04qh58fxmsf5601n9cvpdtc8 FOREIGN KEY (chartid) REFERENCES public.chart(chartid);


--
-- Name: indicatorusergroupaccesses fks1k3a2f1c1isq1ujtwwqwfonx; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorusergroupaccesses
    ADD CONSTRAINT fks1k3a2f1c1isq1ujtwwqwfonx FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataelementgroupusergroupaccesses fks24flr8pd794omx6xusmkeboe; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupusergroupaccesses
    ADD CONSTRAINT fks24flr8pd794omx6xusmkeboe FOREIGN KEY (dataelementgroupid) REFERENCES public.dataelementgroup(dataelementgroupid);


--
-- Name: dataelementgroupattributevalues fks2olf101iiehl4ekaw0ytbmpg; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementgroupattributevalues
    ADD CONSTRAINT fks2olf101iiehl4ekaw0ytbmpg FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: userattributevalues fks2timamyiijrioyi2nd5ysxjc; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.userattributevalues
    ADD CONSTRAINT fks2timamyiijrioyi2nd5ysxjc FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: sectionattributevalues fks3en52yvnu8nfdbcbsqdealwu; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionattributevalues
    ADD CONSTRAINT fks3en52yvnu8nfdbcbsqdealwu FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: sectionattributevalues fks5roynmoahk5mqu1j019ym7; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.sectionattributevalues
    ADD CONSTRAINT fks5roynmoahk5mqu1j019ym7 FOREIGN KEY (sectionid) REFERENCES public.section(sectionid);


--
-- Name: validationrulegroupusergroupaccesses fks6crbtws3n0g2os9894uyb0c4; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupusergroupaccesses
    ADD CONSTRAINT fks6crbtws3n0g2os9894uyb0c4 FOREIGN KEY (validationrulegroupid) REFERENCES public.validationrulegroup(validationrulegroupid);


--
-- Name: validationrulegroupattributevalues fks829kubdxtwph3etm4nyqptnm; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.validationrulegroupattributevalues
    ADD CONSTRAINT fks829kubdxtwph3etm4nyqptnm FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: optiongroupattributevalues fksmifkdbg5bgp66c2yl203lqrn; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupattributevalues
    ADD CONSTRAINT fksmifkdbg5bgp66c2yl203lqrn FOREIGN KEY (optiongroupid) REFERENCES public.optiongroup(optiongroupid);


--
-- Name: predictorgroupusergroupaccesses fksmxapkpmjnus9afsypqp8flgb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupusergroupaccesses
    ADD CONSTRAINT fksmxapkpmjnus9afsypqp8flgb FOREIGN KEY (predictorgroupid) REFERENCES public.predictorgroup(predictorgroupid);


--
-- Name: orgunitgroupusergroupaccesses fksn12ea6xcfweyp0bob6tssdcg; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.orgunitgroupusergroupaccesses
    ADD CONSTRAINT fksn12ea6xcfweyp0bob6tssdcg FOREIGN KEY (usergroupaccessid) REFERENCES public.usergroupaccess(usergroupaccessid);


--
-- Name: dataelementcategoryuseraccesses fksr8r9m97g9uc7b2nnbfp394hb; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryuseraccesses
    ADD CONSTRAINT fksr8r9m97g9uc7b2nnbfp394hb FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: programstageuseraccesses fksxqbj4uf6wwv2aqx2c9ay1ulk; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programstageuseraccesses
    ADD CONSTRAINT fksxqbj4uf6wwv2aqx2c9ay1ulk FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: indicatorgroupsetusergroupaccesses fkt66m7wsp2phes81tx37l4sn4b; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.indicatorgroupsetusergroupaccesses
    ADD CONSTRAINT fkt66m7wsp2phes81tx37l4sn4b FOREIGN KEY (indicatorgroupsetid) REFERENCES public.indicatorgroupset(indicatorgroupsetid);


--
-- Name: legendsetattributevalues fkt7cgg1phqdlubtcwekr6jd785; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.legendsetattributevalues
    ADD CONSTRAINT fkt7cgg1phqdlubtcwekr6jd785 FOREIGN KEY (legendsetid) REFERENCES public.maplegendset(maplegendsetid);


--
-- Name: optiongroupsetuseraccesses fktisxi0u191gvem3n2twyvni4y; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.optiongroupsetuseraccesses
    ADD CONSTRAINT fktisxi0u191gvem3n2twyvni4y FOREIGN KEY (optiongroupsetid) REFERENCES public.optiongroupset(optiongroupsetid);


--
-- Name: smscommandspecialcharacters fktl0s6blarqvbvjhnoa94drtb2; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.smscommandspecialcharacters
    ADD CONSTRAINT fktl0s6blarqvbvjhnoa94drtb2 FOREIGN KEY (specialcharacterid) REFERENCES public.smsspecialcharacter(specialcharacterid);


--
-- Name: dashboarduseraccesses fktldthr3a2gqcrcngmtglr7kdr; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dashboarduseraccesses
    ADD CONSTRAINT fktldthr3a2gqcrcngmtglr7kdr FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: usergroupattributevalues fktlnn6e4dj457rtlgf8gaangnq; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.usergroupattributevalues
    ADD CONSTRAINT fktlnn6e4dj457rtlgf8gaangnq FOREIGN KEY (attributevalueid) REFERENCES public.attributevalue(attributevalueid);


--
-- Name: predictorgroupuseraccesses fkto3xcx3275ltlx861r4julh5l; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.predictorgroupuseraccesses
    ADD CONSTRAINT fkto3xcx3275ltlx861r4julh5l FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: dataelementcategoryoptionattributevalues fktokd1a55e5b1vetrjv1ka84av; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.dataelementcategoryoptionattributevalues
    ADD CONSTRAINT fktokd1a55e5b1vetrjv1ka84av FOREIGN KEY (categoryoptionid) REFERENCES public.dataelementcategoryoption(categoryoptionid);


--
-- Name: programusergroupaccesses fku1h7cukhyye5ejgjbs0kaye0; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.programusergroupaccesses
    ADD CONSTRAINT fku1h7cukhyye5ejgjbs0kaye0 FOREIGN KEY (programid) REFERENCES public.program(programid);


--
-- Name: constantuseraccesses fkv2m3q13hlwe2199m0wy2mmqv; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.constantuseraccesses
    ADD CONSTRAINT fkv2m3q13hlwe2199m0wy2mmqv FOREIGN KEY (useraccessid) REFERENCES public.useraccess(useraccessid);


--
-- Name: potentialduplicate potentialduplicate_lastupdatedby_user; Type: FK CONSTRAINT; Schema: public; Owner: dhis
--

ALTER TABLE ONLY public.potentialduplicate
    ADD CONSTRAINT potentialduplicate_lastupdatedby_user FOREIGN KEY (lastupdatedby) REFERENCES public.users(userid);


--
-- PostgreSQL database dump complete
--

