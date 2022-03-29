
## setwd('C:/Users/roorbach_o/Documents/R/win-library/4.0')
#### if you created the project right, here function should be able to find you #####

library(readxl)
library(xlsx)
library(janitor)
library(here)
library(tidyverse)
library(lubridate)
library(broom)
library(knitr)
library(rmarkdown)
library(cowplot)
library(gridExtra)
library(patchwork)
library(scales)
library(plotly)
library(ggcorrplot)
library(kableExtra)
library(khroma)
library(mosaic)
library(psych)

## ???
here::here('data')

## using the clipped data due to NOX MDL readings 

dat <- readxl::read_xlsx(here::here('data', 'Guana_masterdata_2021_clip.xlsx'), 
                         sheet = 'Sheet1') %>% 
  janitor::clean_names()


glimpse(dat)

## selecting parameters I want

dat2 <- dat %>%
  select(station_code, 
         sample_date, 
         component_short, 
         result) %>%
  filter(station_code %in% c("GTMLMNUT", "GTMGRNUT"))

# selecting out just the year fomr the time_date column so I can then add it to the staion-code column

dat3 <- dat2 %>%
  mutate(year = year(sample_date))

# adding year to the station_code 

dat3$uniq <- paste(dat3$station_code, dat3$year, sep = "_")











