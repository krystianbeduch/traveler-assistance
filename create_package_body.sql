CREATE OR REPLACE PACKAGE BODY traveler_assistance_package IS
-- 1. display info about country
    PROCEDURE country_demographics
        (p_country_name IN countries.country_name%TYPE)
    IS 
        v_country_demo_rec countries%ROWTYPE;
    BEGIN
        SELECT * INTO v_country_demo_rec
        FROM countries
        WHERE UPPER(country_translated_name) = UPPER(p_country_name);
        
        IF SQL%NOTFOUND THEN
            RAISE NO_DATA_FOUND;
        END IF;   
            DBMS_OUTPUT.PUT_LINE(LPAD('COUNTRY NAME: ', 15)   || v_country_demo_rec.country_name);
            DBMS_OUTPUT.PUT_LINE(LPAD('LOCATION: ', 15)       || v_country_demo_rec.location);
            DBMS_OUTPUT.PUT_LINE(LPAD('CAPTIOL: ', 15)        || v_country_demo_rec.capitol);
            DBMS_OUTPUT.PUT_LINE(LPAD('POPULATION: ', 15)     || v_country_demo_rec.population);
            DBMS_OUTPUT.PUT_LINE(LPAD('AIRPORTS: ', 15)       || v_country_demo_rec.airports);
            DBMS_OUTPUT.PUT_LINE(LPAD('CLIMATE: ', 15)        || v_country_demo_rec.climate);
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'country_demographics - country ' || p_country_name || ' not found');
        WHEN OTHERS THEN
            RAISE;
    END country_demographics;
    
    -- 2. display info about region and currency in country
    PROCEDURE find_region_and_currency
        (p_country_name IN countries.country_name%TYPE, p_country_region_curr_rec OUT NOCOPY country_region_curr)
    IS BEGIN
        SELECT country_name, region_name, currency_name
        INTO p_country_region_curr_rec
        FROM countries JOIN regions USING(region_id) JOIN currencies USING(currency_code)
        WHERE UPPER(country_translated_name) = UPPER(p_country_name);
        
        IF SQL%NOTFOUND THEN
            RAISE NO_DATA_FOUND;
        END IF;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'find_region_and_currency - country ' || p_country_name || ' not found');
        WHEN OTHERS THEN    
            RAISE;
    END find_region_and_currency;

    -- 3.create an array of countries
    PROCEDURE countries_in_same_region
        (p_region_name IN regions.region_name%TYPE, p_countries OUT NOCOPY t_countries) 
    IS 
        v_count BINARY_INTEGER := 1;
    BEGIN
        FOR country IN (SELECT country_name, region_name, currency_name 
                        FROM regions JOIN countries USING(region_id) JOIN currencies USING(currency_code) 
                        WHERE UPPER(region_name) = UPPER(p_region_name))
        LOOP
            IF SQL%NOTFOUND THEN
                RAISE NO_DATA_FOUND;
            END IF;
            p_countries(v_count) := country;
            v_count := v_count + 1;
        END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'countries_in_same_region - region ' || p_region_name || ' not found');
        WHEN OTHERS THEN
            RAISE;
    END countries_in_same_region;

    -- 4.print array of countries    
    PROCEDURE print_region_array 
        (p_countries_arr IN t_countries)
    IS 
        v_max_length_country_name NUMBER := 0;
    BEGIN
        IF p_countries_arr IS NULL OR p_countries_arr.COUNT = 0 THEN
            RAISE NO_DATA_FOUND;
        END IF;
        
        FOR i IN p_countries_arr.FIRST .. p_countries_arr.LAST LOOP
            IF LENGTH(p_countries_arr(i).country_name) > v_max_length_country_name THEN
                v_max_length_country_name := LENGTH(p_countries_arr(i).country_name);
            END IF;
        END LOOP;
        FOR i IN p_countries_arr.FIRST .. p_countries_arr.LAST LOOP
            DBMS_OUTPUT.PUT_LINE(LPAD(p_countries_arr(i).country_name, v_max_length_country_name) || ' - CURRENCY: ' || p_countries_arr(i).currency);
        END LOOP;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20004, 'Array is empty');
            WHEN OTHERS THEN
                RAISE;
    END print_region_array;
    
    -- 5.create an array of languges in country
    PROCEDURE country_languages 
        (p_country_name IN countries.country_name%TYPE, p_languages OUT NOCOPY t_languages)
    IS 
        v_count BINARY_INTEGER := 1;
    BEGIN
        FOR lang IN (SELECT country_name, language_name, official 
                    FROM countries JOIN spoken_languages USING(country_id) JOIN languages USING(language_id) 
                    WHERE UPPER(country_translated_name) = UPPER(p_country_name)
                    ORDER BY 3 DESC)
        LOOP
            IF SQL%NOTFOUND THEN
                RAISE NO_DATA_FOUND;
            END IF;
            p_languages(v_count) := lang;
            v_count := v_count + 1;
        END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'country_languages - ' || p_country_name || ' not found');
        WHEN OTHERS THEN
            RAISE;
            
    END country_languages;
    
    -- 6.print array of languges
    PROCEDURE print_language_array
        (p_lang_arr IN t_languages)
    IS 
        v_max_length_language_name NUMBER := 0;
    BEGIN
        IF p_lang_arr IS NULL OR p_lang_arr.COUNT = 0 THEN
            RAISE NO_DATA_FOUND;
        END IF;
        
        FOR i IN p_lang_arr.FIRST .. p_lang_arr.LAST LOOP
            IF LENGTH(p_lang_arr(i).language_name) > v_max_length_language_name THEN
                v_max_length_language_name := LENGTH(p_lang_arr(i).language_name);
            END IF;
        END LOOP;
        FOR i IN p_lang_arr.FIRST .. p_lang_arr.LAST LOOP
            DBMS_OUTPUT.PUT_LINE(LPAD(p_lang_arr(i).language_name, v_max_length_language_name) || ' - OFFICIAL: ' || p_lang_arr(i).official);
        END LOOP;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20006, 'Array is empty');
            WHEN OTHERS THEN
                RAISE;
    END print_language_array;
    
END traveler_assistance_package;