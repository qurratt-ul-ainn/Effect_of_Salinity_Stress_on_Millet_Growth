# ============================================================
# 04_anova_tukey.R
# ANOVA and Tukey multiple-comparison analysis
# ============================================================


# ------------------------------------------------------------
# 1. Packages
# ------------------------------------------------------------

library(tidyverse)
library(emmeans)


# ------------------------------------------------------------
# 2. Load cleaned data
# ------------------------------------------------------------

dat <- read_csv(
  "data/processed/millet_clean.csv",
  show_col_types = FALSE
)


# ------------------------------------------------------------
# 3. Make sure treatment is a factor
# ------------------------------------------------------------

dat <- dat %>%
  mutate(
    treatment = factor(treatment)
  )


# ------------------------------------------------------------
# 4. Define response variables
# ------------------------------------------------------------

responses <- c(
  "emergence_pct",
  "plant_height_cm",
  "leaves_per_plant",
  "root_length_cm",
  "shoot_fresh_weight_g",
  "shoot_dry_weight_g",
  "root_fresh_weight_g",
  "root_dry_weight_g",
  "total_dry_biomass_g",
  "relative_growth_pct"
)


# ------------------------------------------------------------
# 5. Create tables folder if needed
# ------------------------------------------------------------

if (!dir.exists("tables")) {
  
  dir.create(
    "tables",
    recursive = TRUE
  )
  
}


# ------------------------------------------------------------
# 6. ANOVA results
# ------------------------------------------------------------

anova_all <- map_dfr(
  
  responses,
  
  function(v) {
    
    fit <- aov(
      as.formula(
        paste(v, "~ treatment")
      ),
      data = dat
    )
    
    result <- summary(fit)[[1]]
    
    tibble(
      response = v,
      df_treatment = result["treatment", "Df"],
      sum_sq_treatment = result["treatment", "Sum Sq"],
      mean_sq_treatment = result["treatment", "Mean Sq"],
      F_value = result["treatment", "F value"],
      p_value = result["treatment", "Pr(>F)"]
    )
    
  }
)


# ------------------------------------------------------------
# 7. Save ANOVA results
# ------------------------------------------------------------

write_csv(
  anova_all,
  "tables/anova_results.csv"
)


# ------------------------------------------------------------
# 8. Estimated marginal means
# ------------------------------------------------------------

emm_all <- map_dfr(
  
  responses,
  
  function(v) {
    
    fit <- aov(
      as.formula(
        paste(v, "~ treatment")
      ),
      data = dat
    )
    
    em <- emmeans(
      fit,
      ~ treatment
    )
    
    as.data.frame(em) %>%
      mutate(
        response = v,
        .before = 1
      )
    
  }
)


# ------------------------------------------------------------
# 9. Tukey pairwise comparisons
# ------------------------------------------------------------

tukey_all <- map_dfr(
  
  responses,
  
  function(v) {
    
    fit <- aov(
      as.formula(
        paste(v, "~ treatment")
      ),
      data = dat
    )
    
    em <- emmeans(
      fit,
      ~ treatment
    )
    
    pairs(
      em,
      adjust = "tukey"
    ) %>%
      as.data.frame() %>%
      mutate(
        response = v,
        .before = 1
      )
    
  }
)


# ------------------------------------------------------------
# 10. Save estimated means
# ------------------------------------------------------------

write_csv(
  emm_all,
  "tables/estimated_marginal_means.csv"
)


# ------------------------------------------------------------
# 11. Save Tukey results
# ------------------------------------------------------------

write_csv(
  tukey_all,
  "tables/tukey_pairwise_comparisons.csv"
)


# ------------------------------------------------------------
# 12. Print results
# ------------------------------------------------------------

cat("\n============================================\n")
cat("ANOVA RESULTS\n")
cat("============================================\n")

print(anova_all)


cat("\n============================================\n")
cat("ESTIMATED MARGINAL MEANS\n")
cat("============================================\n")

print(emm_all)


cat("\n============================================\n")
cat("TUKEY RESULTS\n")
cat("============================================\n")

print(tukey_all)


# ============================================================
# END OF SCRIPT
# ============================================================