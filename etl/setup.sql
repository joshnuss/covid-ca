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
  name VARCHAR
);

INSERT INTO provinces (name, code) VALUES ('Ontario', 'ON');
INSERT INTO provinces (name, code) VALUES ('Quebec', 'QC');
INSERT INTO provinces (name, code) VALUES ('Alberta', 'AB');
INSERT INTO provinces (name, code) VALUES ('Saskatchewan', 'SK');
INSERT INTO provinces (name, code) VALUES ('Manitoba', 'MB');
INSERT INTO provinces (name, code) VALUES ('Nova Scotia', 'NS');
INSERT INTO provinces (name, code) VALUES ('New Brunswick', 'NB');
INSERT INTO provinces (name, code) VALUES ('Yukon', 'YK');
INSERT INTO provinces (name, code) VALUES ('Nunavut', 'NU');
INSERT INTO provinces (name, code) VALUES ('NWT', 'NW');
INSERT INTO provinces (name, code) VALUES ('PEI', 'PEI');
INSERT INTO provinces (name, code) VALUES ('Newfoundland', 'NL');
INSERT INTO provinces (name, code) VALUES ('British Columbia', 'BC');
