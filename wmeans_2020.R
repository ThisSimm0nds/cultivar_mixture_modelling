setwd("~/Desktop/git_repos/cultivar_mixture_modelling")


library(ggplot2)
library(readr)
library(magrittr)
library(dbplyr)
cultivar_mix_disease_scoring_2020 <- read_csv("cultivar_mix_disease_scoring_2020.csv")
View(cultivar_mix_disease_scoring_2020)
keep <- c("Plot", "Trat","Cultivar", "Z1","Z2","Z3","Z4")
cultivar_2020 <- cultivar_mix_disease_scoring_2020[keep]

#Replace mixture % for Cellule
cultivar_2020$Trat[cultivar_2020$Trat == "C1"] <- 100
cultivar_2020$Trat[cultivar_2020$Trat == "A1C3"] <- 75
cultivar_2020$Trat[cultivar_2020$Trat == "A1C1"] <- 50
cultivar_2020$Trat[cultivar_2020$Trat == "A3C1"] <- 25
cultivar_2020$Trat[cultivar_2020$Trat == "A1"] <- 0

#makes dataframe for % mixture
Cellule_2020_25 <- filter(cultivar_2020, Trat == "25")
Cellule_2020_75 <- filter(cultivar_2020, Trat == "75")
Cellule_2020_50 <- filter(cultivar_2020, Trat == "50")
Apache_2020_100 <- filter(cultivar_2020, Trat == "0")
Cellule_2020_100 <- filter(cultivar_2020, Trat == "100")

write.csv(Cellule_2020_75, "Cellule_2020_75.csv")
write.csv(Cellule_2020_25, "Cellule_2020_25.csv")


Cellule_2020_75 <- read_csv("Cellule_2020_75.csv")

wmean_cellule_2020_75_Z1 <- weighted.mean(Cellule_2020_75$Z1, Cellule_2020_75$Weights, na.rm = T)
wmean_cellule_2020_75_Z2 <- weighted.mean(Cellule_2020_75$Z2, Cellule_2020_75$Weights, na.rm = T)
wmean_cellule_2020_75_Z3 <- weighted.mean(Cellule_2020_75$Z3, Cellule_2020_75$Weights, na.rm = T)
wmean_cellule_2020_75_Z4 <- weighted.mean(Cellule_2020_75$Z4, Cellule_2020_75$Weights, na.rm = T)



#cultivar_2020_wider <- cultivar_2020 %>% 
#  group_by(Plot,Trat,Cultivar) %>% 
#  aggregate(cbind(Z1,Z2)~Plot+Trat+Cultivar,FUN=mean) 

#%>% 
#  pivot_wider(names_from="Cultivar",values_from = "Z1",names_prefix="Z1")%>% 
#  mutate(ratio_A=0.5)  %>% #dictionary %>% 
#  mutate(Z1_wavg= ifelse(ratio_A * Z1A == NA, 0,ratio_A * Z1A)  + ifelse((1-ratio_A) * Z1C == NA, 0,(1-ratio_A) * Z1C) )

#ratio_dict <- {"A1" : 0, "A1C1" : 0.25, "A1C3":0.5, "A3C1":0.75,"C1":1}

