data <- read.csv("../DATA/data.csv") 
data <- data[data$Year >= 2010 & data$Year <= 2023, ]

years <- 2010:2023
total_letters <- numeric(length(years))
total_words <- numeric(length(years))
total_sentences <- numeric(length(years))
total_paragraphs <- numeric(length(years))
yearly_totals <- numeric(length(years)) 


for (i in seq_along(years)) {
  year_data <- data[data$Year == years[i], ]
  total_letters[i] <- sum(year_data$Letters, na.rm = TRUE)
  total_words[i] <- sum(year_data$Words, na.rm = TRUE)
  total_sentences[i] <- sum(year_data$Sentences, na.rm = TRUE)
  total_paragraphs[i] <- sum(year_data$Paragraphs, na.rm = TRUE)
  yearly_totals[i] <- total_letters[i] + total_words[i] + total_sentences[i] + total_paragraphs[i]
}


percent_letters <- total_letters / sum(total_letters)
percent_words <- total_words / sum(total_words)
percent_sentences <- total_sentences / sum(total_sentences)
percent_paragraphs <- total_paragraphs / sum(total_paragraphs)

moving_avg <- function(x, n = 3) {
  stats::filter(x, rep(1 / n, n), sides = 2)
}

letters_moving_avg <- moving_avg(percent_letters)
words_moving_avg <- moving_avg(percent_words)
sentences_moving_avg <- moving_avg(percent_sentences)
paragraphs_moving_avg <- moving_avg(percent_paragraphs)



---------
  # Definir la función de promedio móvil que maneja los bordes
  moving_avg <- function(x, n = 3) {
    stats::filter(x, rep(1 / n, n), sides = 2, circular = TRUE)
  }

# Calcular los promedios móviles
letters_moving_avg <- moving_avg(percent_letters, n = 3)
words_moving_avg <- moving_avg(percent_words, n = 3)
sentences_moving_avg <- moving_avg(percent_sentences, n = 3)
paragraphs_moving_avg <- moving_avg(percent_paragraphs, n = 3)

# Rellenar los valores NA en los bordes si es necesario
letters_moving_avg[is.na(letters_moving_avg)] <- percent_letters[is.na(letters_moving_avg)]
words_moving_avg[is.na(words_moving_avg)] <- percent_words[is.na(words_moving_avg)]
sentences_moving_avg[is.na(sentences_moving_avg)] <- percent_sentences[is.na(sentences_moving_avg)]
paragraphs_moving_avg[is.na(paragraphs_moving_avg)] <- percent_paragraphs[is.na(paragraphs_moving_avg)]

letters_moving_avg*10



letters_moving_avg
# Graficar los datos
plot(years, letters_moving_avg*10, type = "o", col = "skyblue",
     main = "Relationship between variables",
     xlab = "Years", ylab = "Percentages",
     ylim = range(c(letters_moving_avg*10, words_moving_avg*10, sentences_moving_avg*10, paragraphs_moving_avg*10), na.rm = TRUE))
lines(years, words_moving_avg*10, type = "o", col = "lightgreen")
lines(years, sentences_moving_avg*10, type = "o", col = "orange")
lines(years, paragraphs_moving_avg*10, type = "o", col = "purple")

legend("topright", legend = c("Letters", "Words", "Sentences", "Paragraphs"),
       col = c("skyblue", "lightgreen", "orange", "purple"), lty = 1, pch = 19)


# Inspeccionar el rango de cada conjunto de datos
------------
totals_data=0

top_sources <- aggregate(Letters ~ Source, data = data, sum)
top_sources <- top_sources[order(-top_sources$Letters), ][1:5, "Source"]

top_data <- data[data$Source %in% top_sources, ]
pdf("../IMAGES/graphics.pdf", width = 20, height = 12)

#...................

# Crear una lista de vectores
list_of_vectors <- list(total_letters,total_paragraphs,total_sentences ,total_words)
list_of_vectors
# Juntar los vectores usando unlist()
combined_vector <- unlist(list_of_vectors)

# Ver el resultado
print(combined_vector)

hist(total_letters, column)
#-----
  plot(x = totals_data,
       y = years)

summary(total_letters)
sd(total_letters)

print(totals_data)

# Crear una matriz con las variables totales
totals_matrix <- cbind(total_letters, total_words, total_sentences, total_paragraphs)

# Generar el gráfico con matplot
matplot(
  years, 
  totals_matrix, 
  type = "b", # "b" para puntos y líneas
  pch = 1:4, # Símbolos diferentes para cada línea
  col = 1:4, # Colores diferentes para cada línea
  xlab = "Years", 
  ylab = "Totals", 
  main = "Correlación de variables totales con años"
)

# Agregar una leyenda
legend(
  "topright", 
  legend = c("Total Letters", "Total Words", "Total Sentences", "Total Paragraphs"), 
  col = 1:4, 
  pch = 1:4, 
  lty = 1:4
)


-----

barplot(total_words, beside = TRUE, col = "lightgreen", 
        main = "Total Words per Year", 
        xlab = "Years", ylab = "Total Words", 
        names.arg = years)
barplot(total_sentences, beside = TRUE, col = "orange", 
        main = "Total Sentences per Year", 
        xlab = "Years", ylab = "Total Sentences", 
        names.arg = years)
barplot(total_paragraphs, beside = TRUE, col = "purple", 
        main = "Total Paragraphs per Year", 
        xlab = "Years", ylab = "Total Paragraphs", 
        names.arg = years)

# Filtrar las noticias del periódico 'eju'
eju_data <- subset(top_data, Source == 'opinion')

# Contar cuántas noticias hay
total_noticias_eju <- nrow(eju_data)

# Ver el resultado
print(total_noticias_eju)




boxplot(Letters ~ Source, data = top_data,
        main = "Letters per Source",
        xlab = "Top 5 Sources", ylab = "Letters",
        col = "lightgreen")

dotchart(total_letters, labels = years, 
         main = "Total Letters per Year",
         xlab = "Total Letters", ylab = "Years", pch = 19, col = "darkblue")

plot(years, total_letters, type = "o", col = "darkblue",
     main = "Time Series of Total Letters per Year",
     xlab = "Years", ylab = "Total Letters")

plot(years, letters_moving_avg, type = "o", col = "skyblue",
     main = "Relationship between variables",
     xlab = "Years", ylab = "Percentages",
     ylim = range(c(letters_moving_avg, words_moving_avg, sentences_moving_avg, paragraphs_moving_avg), na.rm = TRUE))
lines(years, words_moving_avg, type = "o", col = "lightgreen")
lines(years, sentences_moving_avg, type = "o", col = "orange")
lines(years, paragraphs_moving_avg, type = "o", col = "purple")

legend("topright", legend = c("Letters", "Words", "Sentences", "Paragraphs"),
       col = c("skyblue", "lightgreen", "orange", "purple"), lty = 1, pch = 19)

--
  # Instalar y cargar las librerías necesarias
  library(ggplot2)

# Crear un dataframe con los datos
data <- data.frame(
  year = c(2010,2014, 2015, 2017, 2018, 2020, 2023),
  percentage = c(0.43,0.53, 0.46, 0.52, 0.57, 0.54, 0.37) # 100% - porcentaje de no lectores
)

# Crear el gráfico de línea
ggplot(data, aes(x = year, y = percentage)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 3) +
  labs(title = "Porcentaje de Lectores activos en Bolivia (2010-2023)",
       x = "Año",
       y = "Porcentaje de Lectores activos(%)") +
  theme_minimal()



library(ggplot2)

# Crear gráfico de dispersión (gráfico de puntos)
ggplot(data, aes(x = total_letters, y = percentage)) +
  geom_point(color = "blue", size = 3) +
  labs(title = "Gráfico de Dispersión: Total de Letras vs. Porcentaje de Lectores",
       x = "Total de Letras",
       y = "Porcentaje de Lectores (%)") +
  theme_minimal()


----------
# Definir el intervalo de años
start_year <- 2010
end_year <- 2023

# Filtrar los años y las variables correspondientes
filtered_indices <- years >= start_year & years <= end_year

filtered_years <- years[filtered_indices]
filtered_letters_moving_avg <- letters_moving_avg[filtered_indices]
filtered_words_moving_avg <- words_moving_avg[filtered_indices]
filtered_sentences_moving_avg <- sentences_moving_avg[filtered_indices]
filtered_paragraphs_moving_avg <- paragraphs_moving_avg[filtered_indices]

# Crear el gráfico solo para el intervalo de años filtrado
plot(filtered_years, filtered_letters_moving_avg*10, type = "o", col = "skyblue",
     main = "Relationship between variables (2018-2023)",
     xlab = "Years", ylab = "Percentages",
     ylim = range(c(filtered_letters_moving_avg*10, filtered_words_moving_avg*10, filtered_sentences_moving_avg*10, filtered_paragraphs_moving_avg*10,reader_percentage*2), na.rm = TRUE))
lines(filtered_years, filtered_words_moving_avg*10, type = "o", col = "lightgreen")
lines(filtered_years, filtered_sentences_moving_avg*10, type = "o", col = "orange")
lines(filtered_years, filtered_paragraphs_moving_avg*10, type = "o", col = "purple")
lines(reader_years, reader_percentage*2, type = "o", col = "black")
legend("topright", legend = c("Letters", "Words", "Sentences", "Paragraphs"),
       col = c("skyblue", "lightgreen", "orange", "purple"), lty = 1, pch = 19)

  
-----
totals_data <- data.frame(
  Years = rep(years, each = 4),
  Category = rep(c("Letters", "Words", "Sentences", "Paragraphs"), times = length(years)),
  Counts = c(total_letters, total_words, total_sentences, total_paragraphs)
)

dotchart(totals_data$Counts, labels = paste(totals_data$Years, totals_data$Category, sep = "-"),
         main = "Relationships between all variables",
         xlab = "Count", ylab = "Years")

source_letters_diff <- aggregate(Letters ~ Source, data = data, FUN = median)
hist(source_letters_diff$Letters, 
     main = "Median Difference in Letters by Sources",
     xlab = "Median Letters", col = "orange")


# Instalar y cargar las librerías necesarias
library(ggplot2)

# Crear un dataframe con los datos
data <- data.frame(
  year = c(2014, 2015, 2017, 2018, 2020, 2023),
  percentage = c(0.53, 0.46, 0.52, 0.57, 0.54, 0.37) # 100% - porcentaje de no lectores
)

data <- data.frame(
  percentage = c(0.53, 0.46, 0.52, 0.57, 0.54, 0.37) # 100% - porcentaje de no lectores
)


# Crear el gráfico de línea
ggplot(data, aes(x = year, y = percentage)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 3) +
  labs(title = "Porcentaje de Lectores en Bolivia (2014-2023)",
       x = "Año",
       y = "Porcentaje de Lectores") +
  theme_minimal()

# Años completos
years <- 2010:2023

# Datos que deseas mantener (filtrar años)
keep_years <- !(years %in% c(2010, 2011, 2013, 2016, 2019, 2021, 2022))

# Filtrar los datos de letters_moving_avg
letters_moving_avg_filtered <- letters_moving_avg[keep_years]

# Filtrar también los años para mantener coherencia
filtered_years <- years[keep_years]

# Ver los resultados
letters_moving_avg_filtered
filtered_years

# Instalar y cargar las librerías necesarias
library(ggplot2)

# Crear un dataframe con los datos
data <- data.frame(
  year = c(2010,2014, 2015, 2017, 2018, 2020, 2023),
  percentage = c(0.43,0.53, 0.46, 0.52, 0.57, 0.54, 0.37) # 100% - porcentaje de no lectores
)

# Crear el gráfico de línea
ggplot(data, aes(x = year, y = percentage)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red", size = 3) +
  labs(title = "Porcentaje de Lectores en Bolivia (2014-2023)",
       x = "Año",
       y = "Porcentaje de Lectores (%)") +
  theme_minimal()


# Asegurarse de que las longitudes coincidan
if (length(letters_moving_avg_filtered) != nrow(data)) {
  stop("Las variables tienen longitudes distintas. Verifica que los datos sean correctos.")
}

# Crear el gráfico de dispersión
plot(
  data$percentage, letters_moving_avg_filtered,
  main = "Gráfico de correlación entre Lectura y Letters Moving Avg",
  xlab = "Porcentaje de Lectores (%)",
  ylab = "Letters Moving Avg (Filtrado)",
  pch = 19,        # Estilo de los puntos
  col = "blue"     # Color de los puntos
)

# Añadir una línea de tendencia (opcional)
abline(lm(letters_moving_avg_filtered ~ data$percentage), col = "red", lwd = 2)

# Calcular el índice de correlación
correlation_index <- cor(data$percentage, letters_moving_avg_filtered)

# Mostrar el resultado
correlation_index




# Datos del porcentaje de lectores
reader_years <- c(2010,2014, 2015, 2017, 2018, 2020, 2023)
reader_percentage <- c(0.43,0.53, 0.46, 0.52, 0.57, 0.54, 0.37) # Convertimos a porcentaje

# Gráfico original con la nueva línea añadida
plot(filtered_years, filtered_letters_moving_avg * 10, type = "o", col = "skyblue",
     main = "Relationship between variables (2018-2023)",
     xlab = "Years", ylab = "Percentages",
     ylim = range(c(filtered_letters_moving_avg * 10, filtered_words_moving_avg * 10,
                    filtered_sentences_moving_avg * 10, filtered_paragraphs_moving_avg * 10,
                    reader_percentage), na.rm = TRUE))
lines(filtered_years, filtered_words_moving_avg * 10, type = "o", col = "lightgreen")
lines(filtered_years, filtered_sentences_moving_avg * 10, type = "o", col = "orange")
lines(filtered_years, filtered_paragraphs_moving_avg * 10, type = "o", col = "purple")

# Añadir la nueva línea
lines(reader_years, reader_percentage, type = "o", col = "red", lty = 2, pch = 17)

# Leyenda actualizada
legend("topright", legend = c("Letters", "Words", "Sentences", "Paragraphs", "Readers"),
       col = c("skyblue", "lightgreen", "orange", "purple", "red"),
       lty = c(1, 1, 1, 1, 2), pch = c(19, 19, 19, 19, 17))


plot(x=total_letters,y=reader_percentage)

# Crear un data frame
letters_moving_avg_scaled








# Filtrar los datos para los años específicos
data <- data[data$Year %in% c(2010, 2014, 2015, 2017, 2018, 2020, 2023), ]


years <- c(2010, 2014, 2015, 2017, 2018, 2020, 2023)
total_letters <- numeric(length(years))
total_words <- numeric(length(years))
total_sentences <- numeric(length(years))
total_paragraphs <- numeric(length(years))
yearly_totals <- numeric(length(years)) 

for (i in seq_along(years)) {
  year_data <- data[data$Year == years[i], ]
  total_letters[i] <- sum(year_data$Letters, na.rm = TRUE)
  total_words[i] <- sum(year_data$Words, na.rm = TRUE)
  total_sentences[i] <- sum(year_data$Sentences, na.rm = TRUE)
  total_paragraphs[i] <- sum(year_data$Paragraphs, na.rm = TRUE)
  yearly_totals[i] <- total_letters[i] + total_words[i] + total_sentences[i] + total_paragraphs[i]
}
#/////////////////////////////////////////////////////////
lista_vectores <- list(total_letters, total_words, total_sentences,total_paragraphs)

# Encontrar el valor máximo en cada vector
maximos_letters <- max(total_letters)
maximos_word <-max(total_words)
maximos_sentence <-max(total_sentences)
maximos_parrafos <-max(total_paragraphs)
# Encontrar el valor máximo entre todos los vectores


#/////////////////////////////////////////////////////////

# Instalar y cargar ggplot2 si no está instalado
if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# Datos
letras <- total_letters/maximos_letters
palabras <- total_words/maximos_word
oraciones <- total_sentences/maximos_sentence
parrafos <- total_paragraphs/maximos_parrafos
años <- c(2010, 2014, 2015, 2017, 2018, 2020, 2023)
percentage <- c(0.43, 0.53, 0.46, 0.52, 0.57, 0.54, 0.37)

# Crear un data frame
data <- data.frame(años, letras, palabras, oraciones, parrafos, percentage)

# Crear gráficos de dispersión
ggplot(data, aes(y = percentage)) +
  geom_point(aes(x = letras, color = "letras")) +
  geom_point(aes(x = palabras, color = "palabras")) +
  geom_point(aes(x = oraciones, color = "oraciones")) +
  geom_point(aes(x = parrafos, color = "parrafos")) +
  labs(title = "Longitudes de Noticias vs Lectores Activos",
       y = "cantidad de lectores",
       x = "Valores",
       color = "Variables") +
  theme_minimal()

cor(percentage,letras,method='pearson')
dev.off()



