Postgres FDW

Is de extensie beschikbaar op je lokale server?

 select *
 from   pg_available_extensions
 where  name='postgres_fdw';
Extensie installeren

 create extension postgres_fdw;
Extensie gebruiken

 create server ucll_jaarcluster foreign data wrapper postgres_fdw options
    (host 'databanken.ucll.be',
    db_name 'oefeningen',
    port '52324');

checken welke foreign servers er draaien
select *
from information_schema.foreign_servers

Wie ben ik?

 select current_user;
Met je gebruiker via de local_user de server aanspreken om de verbinding te maken (mapping).

create user mapping for postgres server ucll_jaarcluster options
    (user 'postgres', password 'test');
