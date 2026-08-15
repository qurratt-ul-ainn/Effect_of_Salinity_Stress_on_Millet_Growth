# ============================================================
# 06_pca_correlation.R
# PCA of standardized growth traits.
# ============================================================

library(tidyverse)
library(FactoMineR)
library(factoextra)

dat <- read_csv("data/processed/millet_clean.csv", show_col_types=FALSE)

traits <- c(
  "emergence_pct","plant_height_cm","leaves_per_plant",
  "root_length_cm","shoot_dry_weight_g",
  "root_dry_weight_g","total_dry_biomass_g","relative_growth_pct"
)

pca_data <- dat %>%
  select(all_of(traits)) %>%
  drop_na()

pca <- PCA(pca_data, scale.unit=TRUE, graph=FALSE)

dir.create("figures/publication", recursive=TRUE, showWarnings=FALSE)

png("figures/publication/07_PCA_biplot.png", width=2400, height=1800, res=300)
print(fviz_pca_biplot(pca, repel=TRUE))
dev.off()

pdf("figures/publication/07_PCA_biplot.pdf", width=8, height=6)
print(fviz_pca_biplot(pca, repel=TRUE))
dev.off()

write_csv(
  as.data.frame(pca$var$coord),
  "tables/pca_variable_coordinates.csv"
)

write_csv(
  as.data.frame(pca$ind$coord),
  "tables/pca_individual_coordinates.csv"
)
