-- Create the procedure that should return the next available id in the table
CREATE OR REPLACE FUNCTION next_id() RETURNS INT
    LANGUAGE plpgSQL
AS
$$
DECLARE
    max_id INT = (SELECT max(router.id)
             FROM router);
BEGIN
    IF (SELECT array_agg(router.id) from router) IS NULL THEN RETURN 0; END IF;
    FOR next_id IN 0..max_id + 1
        LOOP
            IF next_id NOT IN (SELECT router.id FROM router) THEN RETURN (next_id); END IF;
        END LOOP;
END
$$;

-- Create the procedure that generate the data to the database
CREATE OR REPLACE FUNCTION generate_data(rows INT)
    LANGUAGE plpgSQL
AS
$$
DECLARE
    mac_add   TEXT;
    ip        TEXT;
    countries TEXT[] = '{Russian Federation, Latvia, Germany, Egypt, Spain,Italy,Norway,Litva,Angola,Ukraine}';
    country   TEXT;
    "date"    DATE;
BEGIN
    FOR i IN 0..rows - 1
        LOOP
            ip = concat(floor(random() * 256)::TEXT, '.', floor(random() * 256)::TEXT, '.',
                        floor(random() * 256)::TEXT, '.', floor(random() * 256)::TEXT);
            mac_add =
                    concat(to_hex(floor(random() * 256)::INT)::TEXT, ':', to_hex(floor(random() * 256)::INT)::TEXT, ':',
                           to_hex(floor(random() * 256)::INT)::TEXT, ':', to_hex(floor(random() * 256)::INT)::TEXT, ':',
                           to_hex(floor(random() * 256)::INT)::TEXT, ':', to_hex(floor(random() * 256)::INT)::TEXT);
            country = countries[floor(random() * 10) + 1];
            "date" = NOW() + (random() * (NOW() + '100 days' - NOW())) + '20 days';
            INSERT INTO router (id, mac_add, ip, country, date) VALUES (next_id(), mac_add, ip, country, date);
        END LOOP;
END
$$;

-- Create the procedure that transform the ip-address from the common form to the binary one
CREATE OR REPLACE FUNCTION transform_to_binary_form_ip(ip TEXT) RETURNS TEXT
    LANGUAGE plpgSQL
AS
$$
DECLARE
    ip_stack       INT[] := '{}';
    ip_binary_form TEXT  := '';
BEGIN
    ip_stack = concat('{', replace(ip, '.', ','), '}')::INT[];
    FOR byte IN 1..3
        LOOP
            ip_binary_form = concat(ip_binary_form, (ip_stack[byte]::BIT(8))::TEXT, '.');
        END LOOP;
    ip_binary_form = concat(ip_binary_form, (ip_stack[4]::BIT(8))::TEXT);

    RETURN ip_binary_form;

END
$$;

-- Create the procedure that transform all ip-addresses related to the specific country
CREATE OR REPLACE FUNCTION transform_ip_by_country(country_arg TEXT) RETURNS TEXT[]
    LANGUAGE plpgSQL
AS
$$
DECLARE
    ip_stack        TEXT[] := '{}';
    ip_binary       TEXT   := '';
    ip_split        TEXT[] = '{}';
    ip_stack_result TEXT[] = '{}';
    total           INT    = (SELECT COUNT(ip)
                              FROM router
                              WHERE country LIKE country_arg);
BEGIN
    ip_stack = (SELECT array_agg(ip) FROM router WHERE country LIKE country_arg);
    ip_stack_result = (SELECT array_agg(ip) FROM router WHERE country LIKE country_arg);

    FOR i IN 1..total
        LOOP
            ip_split = concat('{', replace(ip_stack[i], '.', ','), '}')::INT[];

            FOR byte IN 1..3
                LOOP
                    ip_binary = concat(ip_binary, (ip_split[byte]::INT::BIT(8))::TEXT, '.');
                END LOOP;
            ip_binary = concat(ip_binary, (ip_split[4]::INT::BIT(8))::TEXT);
            ip_stack_result[i] = ip_binary;
            ip_binary = '';
        END LOOP;
    RETURN ip_stack_result;
END
$$;

-- Create Table
CREATE TABLE router
(
    id      INT PRIMARY KEY NOT NULL,
    mac_add TEXT            NOT NULL,
    ip      TEXT            NOT NULL,
    country TEXT            NOT NULL,
    date    DATE            NOT NULL
);
call generate_data(10000);
select *
from router;