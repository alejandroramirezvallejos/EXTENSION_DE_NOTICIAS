if (!file.exists("../DATA/data.csv")) {
  stop("El archivo '../DATA/data.csv' no existe.")
}
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

percent_letters <- total_letters / sum(total_letters, na.rm = TRUE)
percent_words <- total_words / sum(total_words, na.rm = TRUE)
percent_sentences <- total_sentences / sum(total_sentences, na.rm = TRUE)
percent_paragraphs <- total_paragraphs / sum(total_paragraphs, na.rm = TRUE)

moving_avg <- function(x, n = 3) {
  x[is.na(x)] <- 0 
  stats::filter(x, rep(1 / n, n), sides = 2)
}

letters_moving_avg <- moving_avg(percent_letters)
words_moving_avg <- moving_avg(percent_words)
sentences_moving_avg <- moving_avg(percent_sentences)
paragraphs_moving_avg <- moving_avg(percent_paragraphs)

top_sources <- aggregate(Letters ~ Source, data = data, sum)
top_sources <- top_sources[order(-top_sources$Letters), ][1:5, "Source"]

top_data <- data[data$Source %in% top_sources, ]

correlation_matrix <- cor(data[, c("Letters", "Words", "Sentences", "Paragraphs")], use = "complete.obs")

if (!require(gridExtra)) install.packages("gridExtra", dependencies = TRUE)
if (!require(grid)) install.packages("grid", dependencies = TRUE)

pdf("../GRAPHICS/graphics.pdf", width = 20, height = 12)

par(mfrow = c(2, 2))
barplot(total_letters, col = "skyblue", main = "Total Letters per Year", xlab = "Years", ylab = "Total Letters", names.arg = years)
barplot(total_words, col = "lightgreen", main = "Total Words per Year", xlab = "Years", ylab = "Total Words", names.arg = years)
barplot(total_sentences, col = "orange", main = "Total Sentences per Year", xlab = "Years", ylab = "Total Sentences", names.arg = years)
barplot(total_paragraphs, col = "purple", main = "Total Paragraphs per Year", xlab = "Years", ylab = "Total Paragraphs", names.arg = years)

par(mfrow = c(2, 2))
boxplot(Letters ~ Source, data = top_data, main = "Letters per Source", xlab = "Top 5 Sources", ylab = "Letters", col = "lightgreen")

plot(years, letters_moving_avg, type = "o", col = "skyblue", main = "Moving Average of Percentages", xlab = "Years", ylab = "Percentages",
     ylim = range(c(letters_moving_avg, words_moving_avg, sentences_moving_avg, paragraphs_moving_avg), na.rm = TRUE))
lines(years, words_moving_avg, type = "o", col = "lightgreen")
lines(years, sentences_moving_avg, type = "o", col = "orange")
lines(years, paragraphs_moving_avg, type = "o", col = "purple")
legend("topright", legend = c("Letters", "Words", "Sentences", "Paragraphs"), col = c("skyblue", "lightgreen", "orange", "purple"), lty = 1, pch = 19)

plot(years, percent_letters, type = "p", col = "skyblue", pch = 19, ylim = range(
  c(percent_letters, percent_words, percent_sentences, percent_paragraphs), na.rm = TRUE
), 
main = "Correlation Variables-Years", 
xlab = "Years", 
ylab = "Percentages")
points(years, percent_words, col = "lightgreen", pch = 19)
points(years, percent_sentences, col = "orange", pch = 19)
points(years, percent_paragraphs, col = "purple", pch = 19)
legend("topright", legend = c("Letters", "Words", "Sentences", "Paragraphs"),
       col = c("skyblue", "lightgreen", "orange", "purple"),
       pch = 19)

correlation_matrix <- cor(data[, c("Letters", "Words", "Sentences", "Paragraphs")], use = "complete.obs")
correlation_table <- as.data.frame(as.table(correlation_matrix))
correlation_table <- correlation_table[correlation_table$Var1 != correlation_table$Var2, ] 
correlation_table <- correlation_table[!duplicated(t(apply(correlation_table[, 1:2], 1, sort))), ]

colnames(correlation_table) <- c("Variable 1", "Variable 2", "Correlation")
grid.newpage()
grid.table(correlation_table, rows = NULL, theme = ttheme_default(
  colhead = list(fg_params = list(fontface = "bold", fontsize = 10)), 
  padding = unit(c(5, 5), "mm")
))

dev.off()

