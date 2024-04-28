--@C:\Users\CzarekPC\Downloads\PLSQL_Schema.sql

DECLARE
    v_country_name countries.country_translated_name%TYPE := 'Poland'; -- 1, 2
    p_country_region_curr_rec v_country_region_curr_rec%TYPE;
BEGIN
    traveler_assistance_package.country_demographics(v_country_name); -- invoke 1
    traveler_assistance_package.find_region_and_currency(v_country_name, p_country_region_curr_rec); -- invoke 2
END;

