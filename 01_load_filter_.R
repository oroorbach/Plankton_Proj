install.packages()
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
library(writexl)

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
  filter(station_code %in% c("GTMLMNUT", "GTMGRNUT"),
        !(component_short %in% c("WIND_D", "SECCHI")))
# selecting out just the year fomr the time_date column so I can then add it to the staion-code column

dat3 <- dat2 %>%
  mutate(year = year(sample_date),
         month = month(sample_date))

# adding year to the station_code 

dat3$uniq <- paste(dat3$station_code, dat3$year, sep = "_")
dat3$uniqq <- paste(dat3$uniq, dat3$month, sep = '_')


#RE-order and pivot to format for gabby's needs
dat3$result <- as.numeric(dat3$result)

-----could also use mutate(result = as.numeric(result)) within function???

## selecting out the column I need  
dat_wider <- dat3 %>%
select(uniqq,
       component_short,
       result)

# widening data for gabby's formatting 
plank_dat <- dat_wider %>%
  pivot_wider(names_from = "component_short",
               values_from = "result")


# save as excel for Gabby to use in primer
write_xlsx(plank_dat, "LM_GL4_Plank.xlsx")









