data <- read.csv("../DATA/data.csv")
data <- data[data$Year >= 2010 & data$Year <= 2023, ]

years <- 2010:2023
total_letters <- numeric(length(years))
total_words <- numeric(length(years))
total_sentences <- numeric(length(years))
total_paragraphs <- numeric(length(years))

for (i in seq_along(years)) {
  year_data <- data[data$Year == years[i], ]
  total_letters[i] <- sum(year_data$Letters, na.rm = TRUE)
  total_words[i] <- sum(year_data$Words, na.rm = TRUE)
  total_sentences[i] <- sum(year_data$Sentences, na.rm = TRUE)
  total_paragraphs[i] <- sum(year_data$Paragraphs, na.rm = TRUE)
}

pdf("../DATA/graphics.pdf", width = 8, height = 6)
barplot(total_letters, beside = TRUE, col = "skyblue", 
        main = "Total Letters per Year", 
        xlab = "Years", ylab = "Total Letters", 
        names.arg = years)

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
dev.off()

