# Millet Response to Increasing Soil Salinity


## Research question
How does increasing salinity affect millet emergence, vegetative growth, root development, and biomass?

## Experimental design
The supplied dataset contains five salinity treatments (T0–T4), three replications per treatment, and measurements of emergence, shoot/root growth, fresh and dry weights, total dry biomass, and relative growth.

## Repository philosophy
This repository keeps the **programming workflow in R**. It does not contain an HTML dashboard, Shiny application, JavaScript source, or knitted HTML report.

The interactive visualization is generated as a self-contained browser file **only when `07_interactive_visualization.R` is run**. That generated artifact is intentionally not part of the repository.

## Structure
- `data/raw/` — original Excel workbook; never edited by analysis scripts.
- `data/processed/` — cleaned CSV used by downstream scripts.
- `scripts/` — numbered R workflow.
- `figures/publication/` — publication-ready PNG/PDF/SVG outputs.
- `tables/` — statistical summaries.
- `results/` — human-readable interpretation.
- `docs/` — methodological notes.

## Run order
1. `01_import_clean.R`
2. `02_descriptive_statistics.R`
3. `03_assumption_checks.R`
4. `04_anova_tukey.R`
5. `05_publication_figures.R`
6. `06_pca_correlation.R`
7. `07_interactive_visualization.R`

## Packages
Core packages: `readxl`, `tidyverse`, `broom`, `car`, `emmeans`, `FactoMineR`, `factoextra`, `GGally`, `plotly`, `htmlwidgets`.

Install with:

```r
install.packages(c(
  "readxl", "tidyverse", "broom", "car", "emmeans",
  "FactoMineR", "factoextra", "GGally", "plotly", "htmlwidgets"
))
```

