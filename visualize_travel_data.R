install.packages("openxlsx")   
library(openxlsx)  

dane <- openxlsx::read.xlsx("Travel analysis 1.xlsx") 
head(dane)  

install.packages("dplyr")   
library(dplyr) 

install.packages("readxl")
library(readxl)


install.packages("ggplot2")  
library(ggplot2)

install.packages("tidyr") 
library(tidyr)  

names(dane)
#Liczba turystów 2025 r. według kraju wykres słupkowy:
ggplot(dane, aes(x = `2025`, y = reorder(country, `2025`))) +
  geom_col(fill = "steelblue") +
  labs(title = "Liczba turystów w 2025 r. według kraju",
       x = "Liczba turystów (mln)",
       y = "Kraj") +
  theme_minimal() +
  theme(
    axis.text.y = element_text(size = 4),  
    plot.margin = margin(10, 10, 10, 30)   
  )


#Wykres porównawczy 2020 VS 2025
dane_long <- dane%>%
  select(country, '2020', '2025')%>%
  tidyr::pivot_longer(cols=c('2020', '2025'), names_to = "rok", values_to = "liczba_turystow")
ggplot(dane_long, aes(x = liczba_turystow, y = reorder(country, liczba_turystow), fill = rok)) +
  geom_col(position = "dodge") +
  labs(title = "Porównanie liczy turystów: 2020 vs 2025");
    x = "Liczba turystów (mln)";
    y = "Kraj" +
  scale_fill_manual(values = c("2020" = "#f94144", "2025" = "#577590")) +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 0.1))



#TOP 15 państw 2020 VS 2025
top15 <- dane %>%
  slice_max(`2025`, n = 15)

top15_long <- top15 %>%
  pivot_longer(cols = c(`2020`, `2025`), names_to = "rok", values_to = "liczba_turystow")

ggplot(top15_long, aes(x = liczba_turystow, y = reorder(country, liczba_turystow), fill = rok)) +
  geom_col(position = "dodge") +
  labs(title = "Top 15 krajów: porównanie liczby turystów 2020 vs 2025",
       x = "Liczba turystów (mln)",
       y = "Kraj") +
  scale_fill_manual(values = c("2020" = "#f94144", "2025" = "#577590")) +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10))



#Zmiana procentowa-kraje z największym wzrostem/spadkiem turystyki w latach 2020-2025
library(dplyr)
dane <- dane%>%
  mutate(zmiana_procentowa = round((`2025` - `2020`) / `2020` * 100, 1))
top_wzrost <- dane%>%
  arrange(desc(zmiana_procentowa))%>%
  head(10)
ggplot(top_wzrost, aes(x = zmiana_procentowa, y = reorder(country, zmiana_procentowa))) +
  geom_col(fill = "darkgreen") +
  labs(title = "Top 10 krajów z największym wzrostem turystyki (2020–2025)",
       x = "Zmiana [%]",
       y = "Kraj") +
  theme_minimal()
  


#Mapa świata z liczbą turystów w 2025
install.packages("rworldmap")
library(rworldmap)

dane_map <-joinCountryData2Map(dane, joinCode = "NAME", nameJoinColumn = "country")
mapCountryData(dane_map, nameColumnToPlot = "2025", mapTitle = "Turyści w 2025 (mln)", colourPalette = "heat")

