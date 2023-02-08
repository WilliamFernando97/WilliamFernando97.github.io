library(devtools)
devtools::install_github("mattflor/chorddiag")
library(chorddiag)
library(dplyr)
library(tidyr)
library(RColorBrewer)


# Datasets
atheltes <- read.csv(file = 'olympic_athletes.csv')
host <- read.csv('olympic_hosts.csv')
medals <- read.csv('olympic_medals.csv')
results <- read.csv('olympic_results.csv')

medals_by_event <- merge(medals,host,by.x ="slug_game", by.y = "game_slug")

medals_by_event <- medals_by_event %>%  rename("Medals"="medal_type",
                                               "Country"="country_name")

countries <- c("Afghanistan","Algeria","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas",
               "Bahrain","Barbados","Belarus","Belgium","Bermuda","Bohemia","Botswana","Brazil","Bulgaria","Burkina Faso",
               "Burundi","Cameroon","Canada","Chile","Chinese Taipei","Colombia","Costa Rica","Côte d'Ivoire","Croatia","Cuba",
               "Cyprus","Czech Republic","Czechoslovakia","Democratic People's Republic of Korea","Denmark","Djibouti","Dominican Republic",
               "Ecuador","Egypt","Eritrea","Estonia","Ethiopia","Fiji","Finland","France","Gabon","Georgia","Germany","Ghana","Great Britain","Greece","Grenada","Guatemala","Guyana","Haiti",
               "Hong Kong, China","Hungary","Iceland","India","Indonesia","Iraq","Ireland","Islamic Republic of Iran",
               "Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kosovo","Kuwait","Kyrgyzstan","Latvia","Lebanon","Lithuania",
               "Luxembourg","Malaysia","Mauritius","Mexico","Mongolia","Montenegro","Morocco","Mozambique","Namibia","Netherlands","New Zealand","Niger","Nigeria","North Macedonia","Norway","Pakistan","Panama","Paraguay",
               "People's Republic of China","Peru","Philippines","Poland","Portugal","Puerto Rico","Qatar","Republic of Korea",
               "Republic of Moldova","Romania","Russian Federation","Samoa","San Marino","Saudi Arabia","Senegal","Serbia",
               "Serbia and Montenegro","Singapore","Slovakia","Slovenia","South Africa","Soviet Union","Spain","Sri Lanka","Sudan",
               "Suriname","Sweden","Switzerland","Tajikistan","Thailand","Togo","Tonga","Trinidad and Tobago",
               "Tunisia","Turkey","Turkmenistan","Uganda","Ukraine","United Arab Emirates","United Republic of Tanzania",
               "United States of America","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands","Yugoslavia","Zambia","Zimbabwe")


df_medals_summer <- medals_by_event %>%
             select(Medals,Country) %>% filter(medals_by_event$game_season=="Summer"& Country %in% countries & Medals >=5) %>% table()



df_medals_winter <- medals_by_event %>%
             select(Medals,Country) %>% filter(medals_by_event$game_season=="Winter") %>% table()

df_medals_summer <- t(as.matrix(df_medals_summer))

df_medals_winter <- t(as.matrix(df_medals_winter))


colors1 <- c("#9E0142", "#D53E4F", "#F46D43", "#FDAE61", "#FEE08B", "#ABDDA4", "#66C2A5", "#3288BD", "#5E4FA2")

colors2 <- c("#D7D7D7","#AD8A56","#C9B037")

chord_summer <- chorddiag(df_medals_summer, type = "bipartite", showTicks = F, groupnameFontsize = 11, groupnamePadding = 10, margin = 80,groupColors = colors1)

chord_winter <- chorddiag(df_medals_winter, type = "bipartite", showTicks = F, groupnameFontsize = 14, groupnamePadding = 10, margin = 100,groupColors = colors1)

chord_winter$jsHooks

htmlwidgets::createWidget("winter.html",chord_winter)
