# AIRSTATS Dataset

The **airstats** dataset contains global aviation data sourced from [OurAirports.com](https://ourairports.com/data/) (Public Domain). It is loaded into Snowflake under the `AIRSTATS.RAW` schema.

---

## Tables

The dataset consists of three tables that share a common key — `airport_ident` (ICAO code):

```
airports (72K rows)
    │
    ├──< runways (44K rows)         via airport_ident
    └──< airport_comments (variable) via airport_ident
```

---

## `airports`

Global airport registry, roughly 72,000 records.

| Column | Type | Description |
|---|---|---|
| `id` | INTEGER | Internal numeric identifier |
| `ident` | STRING | **ICAO airport code** (e.g. `KLAX`, `EGLL`) — primary key |
| `type` | STRING | Airport classification (see below) |
| `name` | STRING | Official airport name |
| `latitude_deg` | FLOAT | Latitude in decimal degrees (-90 to 90) |
| `longitude_deg` | FLOAT | Longitude in decimal degrees (-180 to 180) |
| `elevation_ft` | INTEGER | Elevation above sea level in feet |
| `continent` | STRING | Two-letter continent code (e.g. `EU`, `NA`) |
| `iso_country` | STRING | ISO 3166-1 alpha-2 country code (e.g. `US`, `DE`) |
| `iso_region` | STRING | ISO 3166-2 region code (e.g. `US-CA`) |
| `municipality` | STRING | City or municipality name |
| `scheduled_service` | STRING | Whether the airport has scheduled commercial service (`yes`/`no`) |
| `gps_code` | STRING | GPS code (often same as `ident`) |
| `iata_code` | STRING | IATA 3-letter code (e.g. `LAX`, `LHR`) — nullable |
| `local_code` | STRING | Local/FAA identifier — nullable |
| `home_link` | STRING | URL to the airport's official website — nullable |
| `wikipedia_link` | STRING | URL to the Wikipedia article — nullable |
| `keywords` | STRING | Comma-separated search keywords — nullable |

**Airport types** (`type` column):

| Value | Description |
|---|---|
| `small_airport` | Small general aviation airport |
| `medium_airport` | Medium-sized airport |
| `large_airport` | Major international airport |
| `heliport` | Helicopter landing pad |
| `seaplane_base` | Water-based landing facility |
| `balloonport` | Hot-air balloon launch site |
| `closed` | Formerly operational, now closed |

---

## `runways`

Physical runway data for airports, roughly 44,000 records. Each row describes one runway direction pair. The `le_` prefix stands for *low end* and `he_` for *high end* of the runway.

| Column | Type | Description |
|---|---|---|
| `id` | INTEGER | Primary key |
| `airport_ref` | INTEGER | Foreign key to `airports.id` |
| `airport_ident` | STRING | ICAO airport code — joins to `airports.ident` |
| `length_ft` | INTEGER | Runway length in feet |
| `width_ft` | INTEGER | Runway width in feet |
| `surface` | STRING | Surface material (e.g. `ASP`, `CON`, `GRS`, `GRE`) — nullable |
| `lighted` | INTEGER | 1 if runway is lit at night, 0 otherwise |
| `closed` | INTEGER | 1 if runway is closed, 0 otherwise |
| `le_ident` | STRING | Low-end runway designator (e.g. `09L`) |
| `le_latitude_deg` | FLOAT | Low-end latitude |
| `le_longitude_deg` | FLOAT | Low-end longitude |
| `le_elevation_ft` | INTEGER | Low-end elevation in feet |
| `le_heading_degT` | FLOAT | Low-end true heading in degrees |
| `le_displaced_threshold_ft` | INTEGER | Low-end displaced threshold in feet |
| `he_ident` | STRING | High-end runway designator (e.g. `27R`) |
| `he_latitude_deg` | FLOAT | High-end latitude |
| `he_longitude_deg` | FLOAT | High-end longitude |
| `he_elevation_ft` | INTEGER | High-end elevation in feet |
| `he_heading_degT` | FLOAT | High-end true heading in degrees |
| `he_displaced_threshold_ft` | INTEGER | High-end displaced threshold in feet |

---

## `airport_comments`

User-submitted comments about airports from OurAirports.com. Row count varies.

| Column | Type | Description |
|---|---|---|
| `id` | INTEGER | Primary key |
| `thread_ref` | INTEGER | Comment thread identifier |
| `airport_ref` | INTEGER | Foreign key to `airports.id` |
| `airport_ident` | STRING | ICAO airport code — joins to `airports.ident` |
| `date` | DATETIME | When the comment was posted |
| `member_nickname` | STRING | Username of the commenter — nullable |
| `subject` | STRING | Comment subject line |
| `body` | STRING | Comment body text — nullable |
| `loaded_at` | TIMESTAMP_NTZ | Timestamp when the record was loaded into Snowflake |

---

## Data Source & Loading

- **Origin:** [OurAirports.com](https://ourairports.com/data/) — freely available under Public Domain
- **Format:** CSV files stored in `s3://dbt-datasets/airstats/csv/`
- **Loaded via:** Snowflake `COPY INTO` command into `AIRSTATS.RAW`
