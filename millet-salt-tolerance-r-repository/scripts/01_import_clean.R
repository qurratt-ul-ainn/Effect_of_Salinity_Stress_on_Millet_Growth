# ============================================================
# 01_import_clean.R
# Project: Effect of Salinity Stress on Millet Growth
#
# Purpose:
#   1. Import the original Excel dataset
#   2. Clean variable names
#   3. Convert variables to appropriate formats
#   4. Check experimental structure
#   5. Check missing values
#   6. Check duplicate pot IDs
#   7. Save cleaned dataset
# ============================================================


# ------------------------------------------------------------
# 1. Load packages
# ------------------------------------------------------------

library(readxl)
library(tidyverse)


# ------------------------------------------------------------
# 2. Define repository location
# ------------------------------------------------------------

repo_root <- "C:/R_studio_practice/basics/data/project_04/millet-salt-tolerance-r-repository"


# ------------------------------------------------------------
# 3. Define input Excel file
# ------------------------------------------------------------

raw_file <- file.path(
  repo_root,
  "data",
  "raw",
  "millet_salt_tolerance_dataset.xlsx"
)


# ------------------------------------------------------------
# 4. Define output file
# ------------------------------------------------------------

processed_file <- file.path(
  repo_root,
  "data",
  "processed",
  "millet_clean.csv"
)


# ------------------------------------------------------------
# 5. Set working directory
# ------------------------------------------------------------

setwd(repo_root)


cat("\n============================================\n")
cat("WORKING DIRECTORY\n")
cat("============================================\n")

cat(getwd(), "\n")


# ------------------------------------------------------------
# 6. Check whether Excel file exists
# ------------------------------------------------------------

if (!file.exists(raw_file)) {
  
  stop(
    "\nERROR: Excel file was not found.\n\n",
    "Expected location:\n",
    raw_file,
    "\n"
  )
  
}


# ------------------------------------------------------------
# 7. Import Excel dataset
# ------------------------------------------------------------

cat("\n============================================\n")
cat("IMPORTING EXCEL DATA\n")
cat("============================================\n")

raw <- read_excel(raw_file)


# ------------------------------------------------------------
# 8. Confirm data import
# ------------------------------------------------------------

cat("\nData imported successfully!\n")

cat("\nClass of data:\n")
print(class(raw))

cat("\nNumber of rows:\n")
print(nrow(raw))

cat("\nNumber of columns:\n")
print(ncol(raw))

cat("\nOriginal column names:\n")
print(names(raw))


# ------------------------------------------------------------
# 9. Rename variables
# ------------------------------------------------------------
#
# IMPORTANT:
# dplyr syntax is:
#
# new_name = old_excel_name
#
# ------------------------------------------------------------

rename_map <- c(
  
  # Experimental identification
  pot_id = "Pot_ID",
  
  treatment = "Treatment",
  
  salinity_level = "Salinity_Level",
  
  target_ec = "Target_EC_dS_m",
  
  replication = "Replication",
  
  
  # Soil and treatment information
  soil_per_pot_kg = "Soil_per_Pot_kg",
  
  nacl_per_pot_g = "NaCl_per_Pot_g_if_EC10",
  
  
  # Seed emergence
  seeds_sown = "Seeds_Sown",
  
  plants_emerged = "Plants_Emerged",
  
  emergence_pct = "Emergence_pct",
  
  
  # Vegetative growth
  plant_height_cm = "Plant_Height_cm",
  
  leaves_per_plant = "Leaves_per_Plant",
  
  
  # Root growth
  root_length_cm = "Root_Length_cm",
  
  
  # Shoot biomass
  shoot_fresh_weight_g = "Shoot_Fresh_Weight_g",
  
  shoot_dry_weight_g = "Shoot_Dry_Weight_g",
  
  
  # Root biomass
  root_fresh_weight_g = "Root_Fresh_Weight_g",
  
  root_dry_weight_g = "Root_Dry_Weight_g",
  
  
  # Total biomass
  total_dry_biomass_g = "Total_Dry_Biomass_g",
  
  
  # Relative growth
  relative_growth_pct = "Relative_Growth_pct"
  
)


# ------------------------------------------------------------
# 10. Apply variable names
# ------------------------------------------------------------

dat <- raw %>%
  rename(any_of(rename_map))


# ------------------------------------------------------------
# 11. Check renamed variables
# ------------------------------------------------------------

cat("\n============================================\n")
cat("CLEANED COLUMN NAMES\n")
cat("============================================\n")

print(names(dat))


# ------------------------------------------------------------
# 12. Convert variables to appropriate formats
# ------------------------------------------------------------

dat <- dat %>%
  mutate(
    
    # Treatment is categorical
    treatment = factor(treatment),
    
    # Salinity category is categorical
    salinity_level = factor(salinity_level),
    
    # Replication is categorical
    replication = factor(replication),
    
    # EC is numerical
    target_ec = as.numeric(target_ec),
    
    # Numeric experimental variables
    soil_per_pot_kg = as.numeric(soil_per_pot_kg),
    
    nacl_per_pot_g = as.numeric(nacl_per_pot_g),
    
    seeds_sown = as.numeric(seeds_sown),
    
    plants_emerged = as.numeric(plants_emerged),
    
    emergence_pct = as.numeric(emergence_pct),
    
    plant_height_cm = as.numeric(plant_height_cm),
    
    leaves_per_plant = as.numeric(leaves_per_plant),
    
    root_length_cm = as.numeric(root_length_cm),
    
    shoot_fresh_weight_g = as.numeric(shoot_fresh_weight_g),
    
    shoot_dry_weight_g = as.numeric(shoot_dry_weight_g),
    
    root_fresh_weight_g = as.numeric(root_fresh_weight_g),
    
    root_dry_weight_g = as.numeric(root_dry_weight_g),
    
    total_dry_biomass_g = as.numeric(total_dry_biomass_g),
    
    relative_growth_pct = as.numeric(relative_growth_pct)
    
  )


# ------------------------------------------------------------
# 13. Check data structure after cleaning
# ------------------------------------------------------------

cat("\n============================================\n")
cat("FINAL DATA STRUCTURE\n")
cat("============================================\n")

glimpse(dat)


# ------------------------------------------------------------
# 14. Check experimental structure
# ------------------------------------------------------------

cat("\n============================================\n")
cat("EXPERIMENTAL STRUCTURE\n")
cat("============================================\n")

experimental_structure <- dat %>%
  count(
    treatment,
    salinity_level,
    target_ec,
    replication
  )

print(experimental_structure)


# ------------------------------------------------------------
# 15. Check number of observations
# ------------------------------------------------------------

cat("\n============================================\n")
cat("DATASET SIZE\n")
cat("============================================\n")

cat("Rows:", nrow(dat), "\n")

cat("Columns:", ncol(dat), "\n")


# ------------------------------------------------------------
# 16. Check missing values
# ------------------------------------------------------------

cat("\n============================================\n")
cat("MISSING VALUE CHECK\n")
cat("============================================\n")

missing_values <- dat %>%
  summarise(
    across(
      everything(),
      ~ sum(is.na(.))
    )
  )

print(missing_values)


# ------------------------------------------------------------
# 17. Check duplicate pot IDs
# ------------------------------------------------------------

cat("\n============================================\n")
cat("DUPLICATE POT ID CHECK\n")
cat("============================================\n")

duplicate_pots <- dat %>%
  count(pot_id) %>%
  filter(n > 1)


if (nrow(duplicate_pots) == 0) {
  
  cat("No duplicate pot IDs detected.\n")
  
} else {
  
  cat("WARNING: Duplicate pot IDs detected:\n")
  
  print(duplicate_pots)
  
}


# ------------------------------------------------------------
# 18. Create processed-data folder
# ------------------------------------------------------------

processed_dir <- file.path(
  repo_root,
  "data",
  "processed"
)


if (!dir.exists(processed_dir)) {
  
  dir.create(
    processed_dir,
    recursive = TRUE
  )
  
}


# ------------------------------------------------------------
# 19. Save cleaned dataset
# ------------------------------------------------------------

write_csv(
  dat,
  processed_file
)


# ------------------------------------------------------------
# 20. Confirm successful export
# ------------------------------------------------------------

cat("\n============================================\n")
cat("EXPORT SUCCESSFUL\n")
cat("============================================\n")

cat(
  "\nCleaned dataset saved to:\n",
  processed_file,
  "\n"
)


# ------------------------------------------------------------
# 21. Show first 10 rows
# ------------------------------------------------------------

cat("\n============================================\n")
cat("FIRST 10 ROWS OF CLEANED DATA\n")
cat("============================================\n")

print(
  dat %>%
    slice_head(n = 10)
)


# ============================================================
# END OF SCRIPT
# ============================================================