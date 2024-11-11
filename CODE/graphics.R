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

percent_letters <- total_letters / yearly_totals * 100
percent_words <- total_words / yearly_totals * 100
percent_sentences <- total_sentences / yearly_totals * 100
percent_paragraphs <- total_paragraphs / yearly_totals * 100

moving_avg <- function(x, n = 3) {
  stats::filter(x, rep(1 / n, n), sides = 2)
}

letters_moving_avg <- moving_avg(percent_letters)
words_moving_avg <- moving_avg(percent_words)
sentences_moving_avg <- moving_avg(percent_sentences)
paragraphs_moving_avg <- moving_avg(percent_paragraphs)

top_sources <- aggregate(Letters ~ Source, data = data, sum)
top_sources <- top_sources[order(-top_sources$Letters), ][1:5, "Source"]

top_data <- data[data$Source %in% top_sources, ]
pdf("../PAPER/graphics.pdf", width = 20, height = 12)

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

dev.off()



