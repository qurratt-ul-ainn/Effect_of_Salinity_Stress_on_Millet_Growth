# ============================================================
# 02_descriptive_statistics.R
# Treatment means, SD, SE and sample size.
# ============================================================

library(tidyverse)

dat <- read_csv("data/processed/millet_clean.csv", show_col_types = FALSE)

responses <- c(
  "emergence_pct", "plant_height_cm", "leaves_per_plant",
  "root_length_cm", "shoot_fresh_weight_g", "shoot_dry_weight_g",
  "root_fresh_weight_g", "root_dry_weight_g",
  "total_dry_biomass_g", "relative_growth_pct"
)

long <- dat %>%
  pivot_longer(all_of(responses), names_to="response", values_to="value")

summary_tbl <- long %>%
  group_by(treatment, salinity_level, target_ec, response) %>%
  summarise(
    n = sum(!is.na(value)),
    mean = mean(value, na.rm=TRUE),
    sd = sd(value, na.rm=TRUE),
    se = sd / sqrt(n),
    .groups="drop"
  )

dir.create("tables", showWarnings=FALSE)
write_csv(summary_tbl, "tables/descriptive_statistics_long.csv")

means <- summary_tbl %>%
  select(treatment, salinity_level, target_ec, response, mean, se)

write_csv(means, "tables/treatment_means_se.csv")
