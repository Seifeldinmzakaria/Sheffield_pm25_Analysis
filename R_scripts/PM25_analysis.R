Barnsley <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/Barnsley.csv")
>   View(Barnsley)
> Devonshire <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/Devonshire.csv")
>   View(Devonshire)
> Tinsley <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/Tinsley.csv")
>   View(Tinsley)
> weather_raw <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/weather_raw.csv", comment.char="#")
>   View(weather_raw)
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:
  
  filter, lag

The following objects are masked from ‘package:base’:
  
  intersect, setdiff, setequal, union
> library(lubridate)

Attaching package: ‘lubridate’

The following objects are masked from ‘package:base’:
  
  date, intersect, setdiff, union
> library(ggplot2)
Warning message:
  package ‘ggplot2’ was built under R version 4.5.2 

> # Combine PM2.5 Datasets
  > aq <- aq_raw %>% 
  + filter(parameter == "pm25") %>%
  + mutate(datetime = ymd_hms(datetimeUtc),
           + date = as.Date(datetime),
           + value = as.numeric(value)) %>%
  + select(location_name, date, value)
Error: object 'aq_raw' not found

> aq_raw <- bind_rows(Barnsley, Devonshire, Tinsley)
> View(aq_raw)
> aq_daily <- aq_raw %>% 
  + filter(parameter == "pm25") %>%
  + mutate(
    + datetime = ymd_hms(datetimeUtc),
    + date = as.Date(datetime),
    + value =as.numeric(value) 
    + )
> filter(!is.na(value)) %>%
  + group_by(date) %>% 
  + summarise(
    + pm25 = mean(value, na.rm = TRUE),
    + .groups = "drop"
    + )
Error: object 'value' not found

> names(aq_raw)
[1] "location_id"   "location_name" "parameter"    
[4] "value"         "unit"          "datetimeUtc"  
[7] "datetimeLocal" "timezone"      "latitude"     
[10] "longitude"     "country_iso"   "isMobile"     
[13] "isMonitor"     "owner_name"    "provider"     
> library(dplyr)
> library(lubridate)
> aq_daily <- aq_raw %>% 
  + filter(parameter == "pm25") %>% 
  + mutate(
    +     datetime = ymd_hms(datetimeutc),
    + date = as.Date(datetime), 
    + value    = as.numeric(value) 
    + ) %>%      
  +  filter(!is.na(value)) %>%      
  + group_by(date) %>%  
  + summarise(
    +     pm25 = mean(value, na.rm = TRUE),
    + mean PM2.5
    Error: unexpected symbol in:
      "    pm25 = mean(value, na.rm = TRUE),
mean PM2.5"
    
    > aq_daily <- aq_raw %>% 
      +     + filter(parameter == "pm25") %>% 
      +     + mutate(
        +         +     datetime = ymd_hms(datetimeutc),
        Error: unexpected '=' in:
          "    + mutate(
        +     datetime ="
        
        > aq_daily <- aq_raw %>%
          +     filter(parameter == "pm25") %>%
          +     mutate(
            +         datetime = ymd_hms(datetimeutc),
            +         date     = as.Date(datetime),
            +         value    = as.numeric(value)
            +     ) %>%
          +     filter(!is.na(value)) %>%
          +     group_by(date) %>%
          +     summarise(
            +         pm25 = mean(value, na.rm = TRUE),
            +         .groups = "drop"
            +     )
        Error in `mutate()`:
          ℹ In argument: `datetime = ymd_hms(datetimeutc)`.
        Caused by error:
          ! object 'datetimeutc' not found
        Run `rlang::last_trace()` to see where the error occurred.
        
        > library(dplyr)
        > library(lubridate)
        > 
          > aq_daily <- aq_raw %>%
          +     filter(parameter == "pm25") %>%
          +     mutate(
            +         datetime = ymd_hms(datetimeUtc),
            +         date     = as.Date(datetime),
            +         value    = as.numeric(value)
            +     ) %>%
          +     filter(!is.na(value)) %>%
          +     group_by(date) %>%
          +     summarise(
            +         pm25 = mean(value, na.rm = TRUE),
            +         .groups = "drop"
            +     )
        > 
          > head(aq_daily)
        # A tibble: 6 × 2
        date        pm25
        <date>     <dbl>
          1 2018-01-01  7.33
        2 2018-01-02  7.32
        3 2018-01-03  8.69
        4 2018-01-04  9.18
        5 2018-01-05 10.2 
        6 2018-01-06 17.5 
        > nrow(aq_daily)
        [1] 179
        > nrow(aq_raw)
        [1] 3000
        > 
          > weather_clean <- weather_raw[-c(1,2), ]
        > 
          > names(weather_clean) <- c("time", "temp")
        > 
          > weather_clean <- weather_clean %>%
          +     mutate(
            +         time = ymd_hm(time),
            +         date = as.Date(time),
            +         temp = as.numeric(temp)
            +     ) %>%
          +     filter(!is.na(temp))
        Error in `mutate()`:
          ! Can't transform a data frame with `NA` or `""` names.
Run `rlang::last_trace()` to see where the error occurred.

> head(weather_raw, 10)
           latitude           longitude elevation
1         53.391914          -1.3714294      87.0
2              time temperature_2m (°C)          
3  2018-01-01T00:00                 4.5          
4  2018-01-01T01:00                 4.5          
5  2018-01-01T02:00                 4.5          
6  2018-01-01T03:00                 4.2          
7  2018-01-01T04:00                 4.1          
8  2018-01-01T05:00                 4.1          
9  2018-01-01T06:00                 4.6          
10 2018-01-01T07:00                 3.6          
   utc_offset_seconds timezone timezone_abbreviation
1                   0      GMT                   GMT
2                                                   
3                                                   
4                                                   
5                                                   
6                                                   
7                                                   
8                                                   
9                                                   
10                                                  
> weather_clean <- weather_raw[-c(1,2), ]
> names(weather_clean) <- weather_clean[1,]
> weather_clean <- weather_clean[-1,]
> library(lubridate)
> library(dplyr)
> 
> weather_clean <- weather_clean %>%
+     select(time, temp = temperature_2m (°C)) %>%
Error: unexpected input in:
"weather_clean <- weather_clean %>%
    select(time, temp = temperature_2m (°"

> names(weather_raw)
[1] "latitude"              "longitude"            
[3] "elevation"             "utc_offset_seconds"   
[5] "timezone"              "timezone_abbreviation"
> weather_raw <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/weather_raw.csv", comment.char="#")
>   View(weather_raw)
> head(weather_raw, 20)
           latitude           longitude elevation
1         53.391914          -1.3714294      87.0
2              time temperature_2m (°C)          
3  2018-01-01T00:00                 4.5          
4  2018-01-01T01:00                 4.5          
5  2018-01-01T02:00                 4.5          
6  2018-01-01T03:00                 4.2          
7  2018-01-01T04:00                 4.1          
8  2018-01-01T05:00                 4.1          
9  2018-01-01T06:00                 4.6          
10 2018-01-01T07:00                 3.6          
11 2018-01-01T08:00                 3.2          
12 2018-01-01T09:00                 2.7          
13 2018-01-01T10:00                 4.4          
14 2018-01-01T11:00                 5.6          
15 2018-01-01T12:00                 5.9          
16 2018-01-01T13:00                 5.9          
17 2018-01-01T14:00                 6.1          
18 2018-01-01T15:00                 5.6          
19 2018-01-01T16:00                 5.1          
20 2018-01-01T17:00                 4.7          
   utc_offset_seconds timezone timezone_abbreviation
1                   0      GMT                   GMT
2                                                   
3                                                   
4                                                   
5                                                   
6                                                   
7                                                   
8                                                   
9                                                   
10                                                  
11                                                  
12                                                  
13                                                  
14                                                  
15                                                  
16                                                  
17                                                  
18                                                  
19                                                  
20                                                  
> weather_clean <- weather_raw[-c(1,2),]
> names(weather_clean) <- c("time", "temp", "elevation", "utc_offset_seconds", "timezone", "timezone_abbrevations")
> weather_clean <- weather_clean %>%
+ select(time, temp) %>%
+ mutate(
+ time = ymd_hm(time),
+ date = as.Date(time),
+ temp = as.numeric(temp)
+ ) %>%
+ filter(!is.na(temp))
Warning message:
There were 2 warnings in `mutate()`.
The first warning was:
ℹ In argument: `time = ymd_hm(time)`.
Caused by warning:
!  5116 failed to parse.
ℹ Run warnings()dplyr::last_dplyr_warnings() to see the 1 remaining warning. 

> weather_clean <- weather_clean %>%
+     + select(time, temp) %>%
+     + mutate(
+         + time = ymd_hms(time),
Error: unexpected '=' in:
"    + mutate(
        + time ="

> weather_clean <- weather_clean %>%
+     select(time, temp) %>%
+     mutate(
+         time = ymd_hms(time),
+         date = as.Date(time),
+         temp = as.numeric(temp)
+     ) %>%
+     filter(!is.na(temp))
Warning message:
There was 1 warning in `mutate()`.
ℹ In argument: `time = ymd_hms(time)`.
Caused by warning:
!  2557 failed to parse. 

> head(weather_clean)
                 time temp       date
1                <NA>  4.5       <NA>
2 2018-01-01 01:00:00  4.5 2018-01-01
3 2018-01-01 02:00:00  4.5 2018-01-01
4 2018-01-01 03:00:00  4.2 2018-01-01
5 2018-01-01 04:00:00  4.1 2018-01-01
6 2018-01-01 05:00:00  4.1 2018-01-01
> nrow(weather_clean)
[1] 63925
> weather_daily <- weather_clean %>%
+ group_by(date) %>%
+ summarise(
+ temp_mean = mean(temp, na.rm = TRUE),
+ .groups = "drop"
+ )
> head(weather_daily)
# A tibble: 6 × 2
  date       temp_mean
  <date>         <dbl>
1 2018-01-01      4.78
2 2018-01-02      5.59
3 2018-01-03      6.62
4 2018-01-04      5.93
5 2018-01-05      2.67
6 2018-01-06      2.73
> nrow(weather_daily)
[1] 2558
> all_combined <- inner_join(aq_daily, weather_daily, by "date")
Error: unexpected string constant in "all_combined <- inner_join(aq_daily, weather_daily, by "date""

> all_combined <- inner_join(aq_daily, weather_daily, by = "date")
> library(lubridate)
> library(dplyr)
> 
> combined <- all_combined %>%
+     mutate(
+         period = case_when(
+             date < as.Date("2020-03-23") ~ "pre",
+             date >= as.Date("2021-03-29") ~ "post",
+             TRUE ~ "covid"
+         ),
+         month   = month(date),
+         year    = year(date),
+         season  = case_when(
+             month %in% c(12, 1, 2) ~ "Winter",
+             month %in% c(3, 4, 5) ~ "Spring",
+             month %in% c(6, 7, 8) ~ "Summer",
+             TRUE                  ~ "Autumn"
+         ),
+         weekday    = wday(date, label = TRUE),
+         is_weekend = if_else(weekday %in% c("Sat", "Sun"),
+                              "Weekend", "Weekday")
+     ) %>%
+     filter(period != "covid")
> 
> library(dplyr)
> 
> summary_pm25 <- combined %>%
+     summarise(
+     min_pm25    = min(pm25, na.rm = TRUE),
+     median_pm25 = median(pm25, na.rm = TRUE),
+     mean_pm25   = mean(pm25, na.rm = TRUE),
+     max_pm25    = max(pm25, na.rm = TRUE),        n_days      = n()
+     )
> 
> summary_pm25
# A tibble: 1 × 5
  min_pm25 median_pm25 mean_pm25 max_pm25 n_days
     <dbl>       <dbl>     <dbl>    <dbl>  <int>
1        2        7.26      9.51     57.7    179
> ggplot(combined, aes(x = date, y = pm25)) +
+ geom_line(color = "steelblue") +
+ labs(title = "PM2.5 Levels Over Time (2018–2024)",         x = "Date", y = "PM2.5 (µg/m³)") +
+     theme_minimal()
> ggsave("Line chart – PM2.5 over time.pdf", width = 8, height = 4)
> ggplot(combined, aes(x = pm25)) +
+ geom_histogram(aes(y = ..density..), bins = 30,
+ fill = "skyblue", color = "black") +
+ geom_density(color = "darkblue", size = 1) +
+ labs(title = "Distribution of PM2.5", x = "PM2.5 (µg/m³)", y = "Density") +
+ theme_minimal()
Warning messages:
1: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
ℹ Please use `linewidth` instead.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this
warning was generated. 
2: The dot-dot notation (`..density..`) was deprecated in ggplot2
3.4.0.
ℹ Please use `after_stat(density)` instead.
This warning is displayed once every 8 hours.
Call `lifecycle::last_lifecycle_warnings()` to see where this
warning was generated. 
> ggsave("Histogram – Distribution of PM2.5.pdf", width = 8, height = 4)
> 
> library(ggplot2)
> 
> ggplot(combined, aes(x = period, y = pm25, fill = period)) +
+ geom_boxplot() +
+ labs(
+ title = "PM2.5 Levels: Pre vs Post COVID",
+ x = "Period",
+ y = "PM2.5 (µg/m³)"
+ ) +
+ theme_minimal() +
+ scale_fill_manual(values = c("pre" = "#1b9e77", "post" = "#d95f02"))
> library(ggplot2)
> library(dplyr)
> 
> ggplot(combined, aes(x = season, y = pm25, fill = season)) +
+ geom_boxplot() +
+ labs(
+ title = "PM2.5 Levels by Season",
+ x = "Season",
+ y = "PM2.5 (µg/m³)"
+ ) +
+ theme_minimal()
> library(ggplot2)
> 
> ggplot(combined, aes(x = is_weekend, y = pm25, fill = is_weekend)) +
+ geom_boxplot() +
+ labs(
+ title = "PM2.5 Levels: Weekday vs Weekend",
+ x = "Day Type",
+ y = "PM2.5 (µg/m³)"
+     ) +
+ scale_fill_manual(values = c("Weekday" = "#1b9e77", "Weekend" = "#d95f02")) +
+ theme_minimal()
> library(ggplot2)
> p_line <- ggplot(combined, aes(x = date, y = pm25)) +
+ geom_line(color = "#1b9e77", linewidth = 0.8, alpha = 0.9) +
+ labs(
+ title = "Daily PM2.5 Levels Over Time",
+ x = "Date",
+ y = "PM2.5 (µg/m³)"
+     ) +
+     theme_minimal()
> 
> p_line
> library(ggplot2)
> 
> p_heatmap <- ggplot(combined, aes(x = factor(month), y = factor(year), fill = pm25)) +
+ geom_tile() +
+ scale_fill_viridis_c() +
+ labs(
+ title = "PM2.5 by Month and Year",
+ x = "Month",
+ y = "Year",
+ fill = "PM2.5"
+     ) +
+     theme_minimal()
> 
> p_heatmap
> library(ggplot2)
> 
> p_scatter <- ggplot(combined, aes(x = temp_mean, y = pm25)) +
+ geom_point(alpha = 0.6, color = "#1b9e77") +
+ geom_smooth(method = "lm", se = FALSE, color = "#d95f02", linewidth = 1) +
+ labs(
+ title = "Relationship Between Temperature and PM2.5",
+ x = "Daily Mean Temperature (°C)",
+ y = "PM2.5 (µg/m³)"
+     ) +
+     theme_minimal()
> 
> p_scatter
`geom_smooth()` using formula = 'y ~ x'
> library(dplyr)
> library(ggplot2)
> 
> stations <- aq_raw %>%
+ distinct(location_name, latitude, longitude)
> stations
                          location_name latitude longitude
1    Sheffield Barnsley Road - UKA00622 53.40495 -1.455815
2 Sheffield Devonshire Green - UKA00575 53.37862 -1.478096
3          Sheffield Tinsley - UKA00181 53.41058 -1.396139
> stations
                          location_name latitude longitude
1    Sheffield Barnsley Road - UKA00622 53.40495 -1.455815
2 Sheffield Devonshire Green - UKA00575 53.37862 -1.478096
3          Sheffield Tinsley - UKA00181 53.41058 -1.396139
> p_map <- ggplot(stations, aes(x = longitude, y = latitude)) +
+ geom_point(color = "red", size = 3) +
+ geom_text(aes(label = location_name), vjust = -1, size = 3) +
+ labs(
+ title = "Monitoring Locations in Sheffield",
+ x = "Longitude",
+ y = "Latitude"
+     ) +
+ theme_minimal()
> 
> p_map
> 