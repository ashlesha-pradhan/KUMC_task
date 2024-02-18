install.packages("ggplot2")
library(ggplot2)

geneinfo_file <- "Homo_sapiens.gene_info"
gene_info <- read.table(geneinfo_file, header = TRUE, sep = "\t", quote = "", comment.char ="")


gene_info <- gene_info[!grepl("[\\|-]", gene_info$chromosome), ]

gene_info_subset <- gene_info[, c(3, 7)]
colnames(gene_info_subset) <- c("Symbol", "Chromosome")

chrom_order <- c(paste0(1:22), "X", "Y", "MT", "Un")
gene_info_subset$Chromosome <- factor(gene_info_subset$Chromosome, levels = chrom_order)


final_plot <- ggplot(gene_info_subset, aes(x = Chromosome)) +
  geom_bar() +
  labs(x = "Chromosomes", y = "Gene count")

ggsave("genes_per_chromplot.pdf", plot = final_plot)
