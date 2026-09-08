CREATE MATERIALIZED VIEW IF NOT EXISTS countries.country_eez_sub AS
    SELECT country_eez.gid,
        country_eez."union",
        country_eez.mrgid_eez,
        country_eez.territory1,
        country_eez.mrgid_ter1,
        country_eez.iso_ter1,
        country_eez.iso_sov1,
        country_eez.pol_type,
        ST_Subdivide(ST_Transform(country_eez.geom, 3857)) AS geom
    FROM countries.country_eez
    WHERE country_eez."union"::text <> 'Antarctica'::text;

CREATE INDEX IF NOT EXISTS country_eez_sub_geom ON countries.country_eez_sub USING GIST (geom);
CREATE INDEX IF NOT EXISTS country_eez_sub_iso_sov1 ON countries.country_eez_sub(iso_sov1);
CREATE INDEX IF NOT EXISTS country_eez_sub_iso_ter1 ON countries.country_eez_sub(iso_ter1);

CREATE MATERIALIZED VIEW IF NOT EXISTS countries.country_eez_3857 AS
    SELECT country_eez.gid,
        country_eez."union",
        country_eez.mrgid_eez,
        country_eez.territory1,
        country_eez.mrgid_ter1,
        country_eez.iso_ter1,
        country_eez.iso_sov1,
        country_eez.pol_type,
        ST_Transform(country_eez.geom, 3857) AS geom
    FROM countries.country_eez
    WHERE country_eez."union"::text <> 'Antarctica'::text;

CREATE INDEX IF NOT EXISTS country_eez_3857_geom ON countries.country_eez_3857 USING GIST (geom);
