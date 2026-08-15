# ============================================================
# 05_publication_figures.R
# Publication-ready figures. No HTML is created here.
# Outputs: PNG, PDF and SVG.
# ============================================================

library(tidyverse)

dat <- read_csv("data/processed/millet_clean.csv", show_col_types=FALSE)
dir.create("figures/publication", recursive=TRUE, showWarnings=FALSE)

theme_pub <- theme_classic(base_size=12) +
  theme(
    plot.title=element_text(face="bold", size=14),
    plot.subtitle=element_text(size=11),
    axis.title=element_text(face="bold"),
    legend.position="bottom"
  )

save_pub <- function(p, name, width=7, height=5) {
  ggsave(file.path("figures/publication", paste0(name,".png")),
         p, width=width, height=height, dpi=600, bg="white")
  ggsave(file.path("figures/publication", paste0(name,".pdf")),
         p, width=width, height=height, bg="white")
  ggsave(file.path("figures/publication", paste0(name,".svg")),
         p, width=width, height=height, bg="white")
}

# 1. Biomass by salinity
p1 <- ggplot(dat, aes(factor(target_ec), total_dry_biomass_g)) +
  geom_boxplot(width=.55, outlier.shape=NA) +
  geom_jitter(width=.08, size=2.8) +
  labs(
    title="Millet biomass response to salinity",
    x=expression("Target salinity (dS m"^-1*")"),
    y="Total dry biomass (g)"
  ) + theme_pub
save_pub(p1, "01_biomass_by_salinity")

# 2. Plant height
p2 <- ggplot(dat, aes(factor(target_ec), plant_height_cm)) +
  geom_boxplot(width=.55, outlier.shape=NA) +
  geom_jitter(width=.08, size=2.8) +
  labs(
    title="Plant height across salinity treatments",
    x=expression("Target salinity (dS m"^-1*")"),
    y="Plant height (cm)"
  ) + theme_pub
save_pub(p2, "02_height_by_salinity")

# 3. Root length
p3 <- ggplot(dat, aes(factor(target_ec), root_length_cm)) +
  geom_boxplot(width=.55, outlier.shape=NA) +
  geom_jitter(width=.08, size=2.8) +
  labs(
    title="Root length across salinity treatments",
    x=expression("Target salinity (dS m"^-1*")"),
    y="Root length (cm)"
  ) + theme_pub
save_pub(p3, "03_root_length_by_salinity")

# 4. Multi-trait response
traits <- c(
  "emergence_pct","plant_height_cm","leaves_per_plant",
  "root_length_cm","shoot_dry_weight_g","root_dry_weight_g",
  "total_dry_biomass_g","relative_growth_pct"
)

long <- dat %>%
  pivot_longer(all_of(traits), names_to="trait", values_to="value") %>%
  group_by(trait) %>%
  mutate(z=(value-mean(value,na.rm=TRUE))/sd(value,na.rm=TRUE)) %>%
  ungroup()

p4 <- ggplot(long, aes(factor(target_ec), trait, fill=z)) +
  geom_tile(color="white") +
  scale_fill_gradient2(
    low="navy", mid="white", high="firebrick",
    midpoint=0, name="Standardized\nresponse"
  ) +
  labs(
    title="Standardized response of millet traits to salinity",
    x=expression("Target salinity (dS m"^-1*")"),
    y=NULL
  ) + theme_pub +
  theme(axis.text.y=element_text(face="plain"))
save_pub(p4, "04_trait_response_heatmap", 8, 5.5)

# 5. Salinity dose-response
p5 <- ggplot(dat, aes(target_ec, total_dry_biomass_g)) +
  geom_point(size=3) +
  geom_smooth(method="lm", se=TRUE) +
  labs(
    title="Salinity–biomass relationship",
    x=expression("Target salinity (dS m"^-1*")"),
    y="Total dry biomass (g)"
  ) + theme_pub
save_pub(p5, "05_salinity_biomass_relationship")

# 6. Correlation heatmap
corr_vars <- c(
  "emergence_pct","plant_height_cm","leaves_per_plant",
  "root_length_cm","shoot_dry_weight_g","root_dry_weight_g",
  "total_dry_biomass_g","relative_growth_pct"
)

cm <- cor(dat[,corr_vars], use="pairwise.complete.obs")
corr_long <- as.data.frame(as.table(cm))
names(corr_long) <- c("trait1","trait2","correlation")

p6 <- ggplot(corr_long, aes(trait1, trait2, fill=correlation)) +
  geom_tile(color="white") +
  geom_text(aes(label=sprintf("%.2f",correlation)), size=3) +
  scale_fill_gradient2(
    low="navy", mid="white", high="firebrick",
    midpoint=0, limits=c(-1,1)
  ) +
  labs(title="Correlation among measured traits", x=NULL, y=NULL, fill="r") +
  theme_pub +
  theme(axis.text.x=element_text(angle=45,hjust=1))
save_pub(p6, "06_trait_correlation_heatmap", 8, 7)
