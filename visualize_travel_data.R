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

names(dane)
ggplot(dane, aes(x = `2025`, y = reorder(country, `2025`))) +
  geom_col(fill = "steelblue") +
  labs(title = "Liczba turystów w 2025 r. według kraju",
       x = "Liczba turystów (mln)",
       y = "Kraj") +
  theme_minimal() +
  theme(
    axis.text.y = element_text(size = 4),  # zmniejsza czcionkę krajów
    plot.margin = margin(10, 10, 10, 30)   # dodaje margines po lewej
  )
