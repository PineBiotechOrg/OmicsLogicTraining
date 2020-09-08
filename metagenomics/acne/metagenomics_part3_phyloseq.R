#install.packages("vegan")
library("phyloseq")
library("ggplot2")
library("dplyr")

#theme_set(theme_bw())

otu_mat<- read.table("Acne_Amplicon_Abundance_table.txt", header = TRUE, sep = "\t")
tax_mat<- read.table("Acne_Taxonomy_table.txt", header = TRUE, sep = "\t")
samples_df <- read.table("Acne_SupplementaryTable.txt", header = TRUE, sep = "\t")

row.names(otu_mat) <- otu_mat$OTUs
otu_mat <- otu_mat %>% select (-OTUs)

row.names(tax_mat) <- tax_mat$class
tax_mat <- tax_mat %>% select (-class) 

row.names(samples_df) <- samples_df$Run
samples_df <- samples_df %>% select (-Run) 

sampletype <- unique(row.names(samples_df))

otu_mat <- as.matrix(otu_mat)
tax_mat <- as.matrix(tax_mat)

OTU = otu_table(otu_mat, taxa_are_rows = TRUE)
TAX = tax_table(tax_mat)
samples = sample_data(samples_df)

acne <- phyloseq(OTU, TAX, samples)
acne

plot_bar(acne, fill = "Phylum")

#NMDS - non-metric multidimensional scaling ordination
acne.ord <- ordinate(acne, "NMDS", "bray")

sample_variables(acne)
plot_richness(acne, color="Dermatology_Disord", measures=c("Chao1", "Shannon"))
plot_ordination(acne, acne.ord, type="samples", color="Dermatology_Disord")
