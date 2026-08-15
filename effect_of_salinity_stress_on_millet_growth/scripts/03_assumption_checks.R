# ============================================================
# 03_assumption_checks.R
# Residual diagnostics for the one-way treatment models.
# ============================================================

library(tidyverse)
library(car)

dat <- read_csv("data/processed/millet_clean.csv", show_col_types = FALSE)

responses <- c(
  "emergence_pct", "plant_height_cm", "leaves_per_plant",
  "root_length_cm", "shoot_fresh_weight_g", "shoot_dry_weight_g",
  "root_fresh_weight_g", "root_dry_weight_g",
  "total_dry_biomass_g", "relative_growth_pct"
)

results <- map_dfr(responses, function(v) {
  f <- as.formula(paste(v, "~ treatment"))
  fit <- aov(f, data=dat)
  sh <- shapiro.test(residuals(fit))
  lev <- leveneTest(f, data=dat)[["Pr(>F)"]][1]
  tibble(response=v, shapiro_p=sh$p.value, levene_p=lev)
})

write_csv(results, "tables/assumption_checks.csv")
