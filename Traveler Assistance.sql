--@C:\Users\CzarekPC\Downloads\PLSQL_Schema.sql

DECLARE
    v_country_name_1            countries.country_translated_name%TYPE := 'Poland'; -- 1
    v_country_name_2            countries.country_translated_name%TYPE := 'Poland'; -- 2
    p_country_region_curr_rec   traveler_assistance_package.country_region_curr; -- 2
    v_region_name               regions.region_name%TYPE := 'Eastern Europe'; -- 3
    p_countries_arr             traveler_assistance_package.t_countries; -- 3, 4
    v_country_name_5            countries.country_translated_name%TYPE := 'Switzerland'; -- 5
    p_lang_arr                  traveler_assistance_package.t_languages; -- 5, 6
BEGIN
    traveler_assistance_package.country_demographics(v_country_name_1); -- INVOKE 1 1
    
    traveler_assistance_package.find_region_and_currency(v_country_name_2, p_country_region_curr_rec); -- INVOKE 2
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE(LPAD('COUNTRY NAME: ', 15)   || p_country_region_curr_rec.country_name);
    DBMS_OUTPUT.PUT_LINE(LPAD('REGION: ', 15)         || p_country_region_curr_rec.region);
    DBMS_OUTPUT.PUT_LINE(LPAD('CURRENCY: ', 15)       || p_country_region_curr_rec.currency);
    
    traveler_assistance_package.countries_in_same_region(v_region_name, p_countries_arr); -- INVOKE 3
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('REGION: ' || v_region_name || '  - COUNTRIES: ');
    traveler_assistance_package.print_region_array(p_countries_arr); -- INVOKE 4
    
    traveler_assistance_package.country_languages(v_country_name_5, p_lang_arr); -- INVOKE 5
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('COUNTRY: ' || v_country_name_5 || '  - LANGUAGES: ');
    traveler_assistance_package.print_language_array(p_lang_arr); -- INVOKE 6
    
    
END;

