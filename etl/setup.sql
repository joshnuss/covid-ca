DROP TABLE IF EXISTS provinces;
DROP TABLE IF EXISTS timeseries;

CREATE TABLE timeseries (
  province VARCHAR,
  date DATE,
  cases INT DEFAULT 0,
  deaths INT DEFAULT 0,
  active INT DEFAULT 0,
  recovered INT DEFAULT 0
);

CREATE UNIQUE INDEX timeseries$main ON timeseries (province, date);
CREATE INDEX timeseries$province ON timeseries (province);
CREATE INDEX timeseries$date ON timeseries (date);

CREATE TABLE provinces (
  code VARCHAR,
  name VARCHAR,
  population INT
);

-- population data from https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710000901

INSERT INTO provinces (name, code, population) VALUES ('Ontario', 'ON', 14915270);
INSERT INTO provinces (name, code, population) VALUES ('Quebec', 'QC', 8631147);
INSERT INTO provinces (name, code, population) VALUES ('Alberta', 'AB', 4464170);
INSERT INTO provinces (name, code, population) VALUES ('Saskatchewan', 'SK', 1180867);
INSERT INTO provinces (name, code, population) VALUES ('Manitoba', 'MB', 1386333);
INSERT INTO provinces (name, code, population) VALUES ('Nova Scotia', 'NS', 998832);
INSERT INTO provinces (name, code, population) VALUES ('New Brunswick', 'NB', 794300);
INSERT INTO provinces (name, code, population) VALUES ('Yukon', 'YK', 43095);
INSERT INTO provinces (name, code, population) VALUES ('Nunavut', 'NU', 39589);
INSERT INTO provinces (name, code, population) VALUES ('NWT', 'NW', 45515);
INSERT INTO provinces (name, code, population) VALUES ('PEI', 'PEI', 165936);
INSERT INTO provinces (name, code, population) VALUES ('Newfoundland', 'NL', 521758);
INSERT INTO provinces (name, code, population) VALUES ('British Columbia', 'BC', 5249635);
