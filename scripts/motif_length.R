

setwd("~/Documents/github/Guugle_Env/scripts")

length <- read.table("../motif_length.txt", header=TRUE)
png("motif_plot.png", width=800, height=800)
par(cex=8)
hist(length[,1], xlab="Motif Length", main="")
dev.off()
