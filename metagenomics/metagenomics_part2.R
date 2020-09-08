library(openxlsx)

#load data
annotatedtb <- read.xlsx("metagenomics1Annotation.xlsx", sheet = 4)

#sort the values
df <- sort(table(annotatedtb[,1]), decreasing = TRUE)

#create percentages and add them to labels
df1 <- round((prop.table(df))*100)
lbls <- paste(names(df1), " ", df1,"%", sep="")

par(mar=c(6,4,4,4))

#make a pie chart
pie(df, main="ERR1250035 by Phylum", col = rainbow(length(lbls)), labels=lbls, cex = 0.6)

#make a bar plot
barplot(df, main="ERR1250035 by Phylum", col = rainbow(length(lbls)), xlab = "Bacteria Type", las = 2, cex.names = 0.7)

df1[1]