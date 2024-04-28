CREATE OR REPLACE PACKAGE traveler_assistance_package AUTHID DEFINER IS
    TYPE country_region_curr IS RECORD ( -- 2, 3
        country_name    countries.country_name%TYPE,
        region          regions.region_name%TYPE,
        currency        currencies.currency_name%TYPE
    );
    
    TYPE t_countries IS TABLE OF country_region_curr -- 3, 4
    INDEX BY BINARY_INTEGER;
    
    TYPE country_lang IS RECORD ( -- 5, 6
        country_name    countries.country_name%TYPE,
        language_name   regions.region_name%TYPE,
        official        currencies.currency_name%TYPE 
    );
    
    TYPE t_languages IS TABLE OF country_lang -- 5, 6
    INDEX BY BINARY_INTEGER;
    
    PROCEDURE country_demographics (p_country_name IN countries.country_name%TYPE); -- 1.display info about country
    PROCEDURE find_region_and_currency (p_country_name IN countries.country_name%TYPE, p_country_region_curr_rec OUT NOCOPY country_region_curr); -- 2.display info about region and currency in country
    PROCEDURE countries_in_same_region (p_region_name IN regions.region_name%TYPE, p_countries OUT NOCOPY t_countries); -- 3.create an array of countries
    PROCEDURE print_region_array (p_countries_arr IN t_countries); -- 4.print array of countries 
    PROCEDURE country_languages (p_country_name IN countries.country_name%TYPE, p_languages OUT NOCOPY t_languages); -- 5.create an array of languges in country
    PROCEDURE print_language_array (p_lang_arr IN t_languages); -- 6.print array of languges
END traveler_assistance_package;