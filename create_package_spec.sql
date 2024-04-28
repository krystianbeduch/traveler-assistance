CREATE OR REPLACE PACKAGE traveler_assistance_package IS
    TYPE country_demo IS RECORD ( -- 1
        country_name    countries.country_name%TYPE,
        location        countries.location%TYPE,
        capitol         countries.capitol%TYPE,
        population      countries.population%TYPE,
        airports        countries.airports%TYPE,
        climate         countries.climate%TYPE
    );
    v_country_demo_rec country_demo;
    
    TYPE country_region_curr IS RECORD ( -- 2
        country_name    countries.country_name%TYPE,
        region          regions.region_name%TYPE,
        currency        currencies.currency_name%TYPE
    );
    v_country_region_curr_rec country_region_curr;
    
    PROCEDURE country_demographics (p_country_name IN countries.country_name%TYPE); -- display info about country
    PROCEDURE find_region_and_currency (p_country_name IN countries.country_name%TYPE, p_country_region_curr_rec OUT v_country_region_curr_rec%TYPE); -- display info about region and currency in country
-- 2.find_region_and_currency
-- 3.countries_in_same_region INDEX BY table of records
-- 4.print_region_array (arrays)
-- 5.country_languages INDEX BY table of records
-- 6.print_language_array (arrays)
-- 7.
END traveler_assistance_package;