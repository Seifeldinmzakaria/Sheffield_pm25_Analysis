Barnsley <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/Barnsley.csv")
> Devonshire <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/Devonshire.csv")
> Tinsley <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/Tinsley.csv")
> 
> weather_raw <- read.csv("//STUDATA09.shef.ac.uk/home/li/lip24smo/ManW10/Desktop/Intro To Data Science/weather_raw.csv", comment.char="#")
> 
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union> library(lubridate)

Attaching package: ‘lubridate’

The following objects are masked from ‘package:base’:

    date, intersect, setdiff, union> library(ggplot2)
Warning message:
package ‘ggplot2’ was built under R version 4.5.2 > 
> aq_raw <- bind_rows(Barnsley, Devonshire, Tinsley)
> 
> aq_daily <- aq_raw %>%
+     filter(parameter=="pm25") %>%
+     mutate(
+         datetime = ymd_hms(datetimeUtc),
+         date = as.Date(datetime),
+         value = as.numeric(value)
+     ) %>%
+     filter(!is.na(value)) %>%
+     group_by(date) %>%
+     summarise(pm25 = mean(value, na.rm=TRUE), .groups="drop")
> 
> weather_clean <- weather_raw[-c(1,2),]
> names(weather_clean) <- c("time","temp","elevation","utc_offset_seconds","timezone","timezone_abbrevations")
> 
> weather_clean <- weather_clean %>%
+     select(time, temp) %>%
+     mutate(
+         time = ymd_hms(time),
+         date = as.Date(time),
+         temp = as.numeric(temp)
+     ) %>%
+     filter(!is.na(temp))
Warning message:
There were 2 warnings in `mutate()`.
The first warning was:
ℹ In argument: `time = ymd_hms(time)`.
Caused by warning:
! All formats failed to parse. No formats found.
ℹ Run warnings()dplyr::last_dplyr_warnings() to see the 1 remaining warning. > 
> weather_daily <- weather_clean %>%
+     group_by(date) %>%
+     summarise(temp_mean = mean(temp, na.rm=TRUE), .groups="drop")
> 
> all_combined <- inner_join(aq_daily, weather_daily, by="date")
> 
> combined <- all_combined %>%
+     mutate(
+         period = case_when(
+             date < as.Date("2020-03-23") ~ "pre",
+             date >= as.Date("2021-03-29") ~ "post",
+             TRUE ~ "covid"
+         ),
+         month = month(date),
+         year = year(date),
+         season = case_when(
+             month %in% c(12,1,2) ~ "Winter",
+             month %in% c(3,4,5) ~ "Spring",
+             month %in% c(6,7,8) ~ "Summer",
+             TRUE ~ "Autumn"
+         ),
+         weekday = wday(date, label=TRUE),
+         is_weekend = if_else(weekday %in% c("Sat","Sun"),"Weekend","Weekday")
+     ) %>% 
+     filter(period!="covid")
> 
> summary_pm25 <- combined %>%
+     summarise(
+         min_pm25 = min(pm25, na.rm=TRUE),
+         median_pm25 = median(pm25, na.rm=TRUE),
+         mean_pm25 = mean(pm25, na.rm=TRUE),
+         max_pm25 = max(pm25, na.rm=TRUE),
+         n_days = n()
+     )
Warning message:
There were 2 warnings in `summarise()`.
The first warning was:
ℹ In argument: `min_pm25 = min(pm25, na.rm = TRUE)`.
Caused by warning in `min()`:
! no non-missing arguments to min; returning Inf
ℹ Run warnings()dplyr::last_dplyr_warnings() to see the 1 remaining warning. > 
> ggplot(combined, aes(x=date, y=pm25)) +
+     geom_line(color="steelblue") +
+     labs(title="PM2.5 Levels Over Time (2018–2024)", x="Date", y="PM2.5 (µg/m³)") +
+     theme_minimal()
> 
> ggsave("Line chart – PM2.5 over time.pdf", width=8, height=4)
> 
> ggplot(combined, aes(x=pm25)) +
+     geom_histogram(aes(y=after_stat(density)), bins=30, fill="skyblue", color="black") +
+     geom_density(color="darkblue", linewidth=1) +
+     labs(title="Distribution of PM2.5", x="PM2.5 (µg/m³)", y="Density") +
+     theme_minimal()
> 
> ggsave("Histogram – Distribution of PM2.5.pdf", width=8, height=4)
> 
> ggplot(combined, aes(x=period, y=pm25, fill=period)) +
+     geom_boxplot() +
+     labs(title="PM2.5 Levels: Pre vs Post COVID", x="Period", y="PM2.5 (µg/m³)") +
+     theme_minimal() +
+     scale_fill_manual(values=c("pre"="#1b9e77", "post"="#d95f02"))
Warning message:
No shared levels found between `names(values)` of the manual scale and
the data's fill values. > 
> ggplot(combined, aes(x=season, y=pm25, fill=season)) +
+     geom_boxplot() +
+     labs(title="PM2.5 Levels by Season", x="Season", y="PM2.5 (µg/m³)") +
+     theme_minimal()
> 
> ggplot(combined, aes(x=is_weekend, y=pm25, fill=is_weekend)) +
+     geom_boxplot() +
+     labs(title="PM2.5 Levels: Weekday vs Weekend", x="Day Type", y="PM2.5 (µg/m³)") +
+     scale_fill_manual(values=c("Weekday"="#1b9e77", "Weekend"="#d95f02")) +
+     theme_minimal()
Warning message:
No shared levels found between `names(values)` of the manual scale and
the data's fill values. > 
> ggplot(combined, aes(x=temp_mean, y=pm25)) +
+     geom_point(alpha=0.6, color="#1b9e77") +
+     geom_smooth(method="lm", se=FALSE, color="#d95f02", linewidth=1) +
+     labs(title="Relationship Between Temperature and PM2.5", x="Daily Mean Temperature (°C)", y="PM2.5 (µg/m³)") +
+     theme_minimal()
> 
> stations <- aq_raw %>% distinct(location_name, latitude, longitude)
> 
> ggplot(stations, aes(x=longitude, y=latitude)) +
+     geom_point(color="red", size=3) +
+     geom_text(aes(label=location_name), vjust=-1, size=3) +
+     labs(title="Monitoring Locations in Sheffield", x="Longitude", y="Latitude") +
+     theme_minimal()
> 


> 

