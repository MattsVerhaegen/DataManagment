-- publicatie: wal_level = logisch

ROLLBACK;
BEGIN;

CREATE SCHEMA replication_demo;

GRANT usage on SCHEMA replication_demo TO public;

SET search_path TO replication_demo;

CREATE TABLE demo_users(
	user_id serial	PRIMARY KEY,
	voornaam varchar(32) NOT NULL,
	achternaam varchar(64)
);;

GRANT select, insert ON demo_users TO public;

CREATE PUBLICATION mypub FOR TABLE demo_users;

--abonnee, als superuser

ROLLBACK;
BEGIN;

CREATE SCHEMA replication_demo;

GRANT usage on SCHEMA replication_demo TO public;

SET search_path TO replication_demo;

CREATE TABLE demo_users(
	user_id serial	PRIMARY KEY,
	voornaam varchar(32) NOT NULL,
	achternaam varchar(64)
);;

CREATE SUBSCRIPTION mysub
CONNECTION 'dbname=probeer host=localhost user=postgres port=5432 password=test sslmode=prefer'
PUBLICATION mypub;

-- To connect with fuji use this 'dbname=dataman host=fuji.ucll.be port=ac_jaar_poort user=local_jestudentnr password=mypass sslmode=require'
-- and database maintance has to dataman

-- uitvoeren in administration databank om REPLICATION te krijgen
SELECT user_administration.get_replication();

-- create chinook scheme
--
-- TOC entry 217 (class 1259 OID 69057)
-- Name: Album; Type: TABLE; Schema: chinook; Owner: wibrt
--

CREATE TABLE chinook."Album" (
    "AlbumId" integer NOT NULL,
    "Title" character varying(160) NOT NULL,
    "ArtistId" integer NOT NULL
);




--
-- TOC entry 3242 (class 2606 OID 69091)
-- Name: Album PK_Album; Type: CONSTRAINT; Schema: chinook; Owner: wibrt
--

ALTER TABLE ONLY chinook."Album"
    ADD CONSTRAINT "PK_Album" PRIMARY KEY ("AlbumId");

create publication album_insert for table chinook."Album" with (publish='insert');

-- Maakt subscription
create subscription dataman_test connection 'dbname=dataman host=fuji.ucll.be port=52324 user=r0933333 password=mypass sslmode=require' publication album_insert;