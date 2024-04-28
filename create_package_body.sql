CREATE OR REPLACE PACKAGE BODY traveler_assistance_package IS
-- 1. display info about country
    PROCEDURE country_demographics 
        (p_country_name IN countries.country_name%TYPE)
        IS BEGIN
            SELECT country_name, location, capitol, population, airports, climate
            INTO v_country_demo_rec
            FROM countries
            WHERE UPPER(country_translated_name) = UPPER(p_country_name);
            
            IF SQL%NOTFOUND THEN
                RAISE NO_DATA_FOUND;
            END IF;
                DBMS_OUTPUT.PUT_LINE('COUNTRY NAME: '   || v_country_demo_rec.country_name);
                DBMS_OUTPUT.PUT_LINE('LOCATION: '       || v_country_demo_rec.location);
                DBMS_OUTPUT.PUT_LINE('CAPTIOL: '        || v_country_demo_rec.capitol);
                DBMS_OUTPUT.PUT_LINE('POPULATION: '     || v_country_demo_rec.population);
                DBMS_OUTPUT.PUT_LINE('AIRPORTS: '       || v_country_demo_rec.airports);
                DBMS_OUTPUT.PUT_LINE('CLIMATE: '        || v_country_demo_rec.climate);
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20001, 'Country not found.');
            WHEN OTHERS THEN
                RAISE;
    END country_demographics;
-- 2.find_region_and_currency
-- 3.countries_in_same_region INDEX BY table of records
-- 4.print_region_array (arrays)
-- 5.country_languages INDEX BY table of records
-- 6.print_language_array (arrays)
-- 7.
END traveler_assistance_package;