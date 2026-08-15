#  Millet Response to Increasing Soil Salinity
### A Reproducible R Analysis of a Controlled Pot Experiment

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:2E8B57,100:6A994E&height=180&section=header&text=Millet%20Response%20to%20Salinity&fontSize=34&fontColor=ffffff&fontAlignY=38&desc=Controlled%20Pot%20Experiment%20%7C%20Reproducible%20R%20Analysis&descAlignY=62&descSize=16"/>
</p>

<p align="center">
  <strong>Experimental Research • Soil Salinity • Plant Growth • Biomass • R </strong>
</p>

---

## 1. Project Overview

Soil salinity is an important constraint to crop production because increasing salt concentration in the soil environment can influence seed establishment, water relations, vegetative development, root growth and biomass accumulation.

This repository documents a controlled pot experiment designed to examine how increasing salinity affected millet growth.

The experiment was built around a straightforward biological question:

> **How does increasing soil salinity affect millet establishment, vegetative growth, root development and biomass production?**

Rather than relying on a single indicator of plant performance, the experiment followed the response of millet across several stages, beginning with seed emergence and continuing through shoot development, root growth and fresh and dry biomass accumulation.

The purpose of this repository is therefore broader than statistical analysis alone. It provides a reproducible research record in which the original observations can be followed through:

**experimental design → data preparation → quality control → statistical analysis → visualization → interpretation**

The project is implemented in **R** and is structured so that the analysis can be reproduced from the project root without relying on personal computer file paths.

---

# 2. Research Question

The central research question is:

> **Does progressively increasing salinity reduce millet establishment, vegetative growth, root development and biomass production?**

The experiment uses an increasing electrical conductivity (EC) gradient:

**1 → 4 → 8 → 12 → 16 dS m⁻¹**

This allows the data to be examined in two complementary ways:

1. **As five defined experimental treatments**, using treatment-level statistical comparisons.
2. **As an increasing salinity gradient**, using target EC as a numerical explanatory variable.

These approaches answer related but different questions and are therefore retained separately in the analysis.

---

# 3. Experimental Design

The experiment consisted of:

| Experimental component | Description |
|---|---|
| Experimental unit | Individual pot |
| Total pots | 15 |
| Salinity treatments | 5 |
| Replications per treatment | 3 |
| Soil per pot | 10 kg |
| Seeds sown per pot | 3 |
| Target EC range | 1–16 dS m⁻¹ |
| Analysis environment | R |

The experimental structure was balanced:

**5 salinity treatments × 3 replications = 15 pots**

Each pot represents one experimental observation.

The cleaned dataset contains **15 observations and 19 variables**.

---

# 4. Salinity Treatment Structure

The treatments were arranged as a progressive salinity gradient.

| Treatment | Salinity level | Target EC (dS m⁻¹) | Replications |
|---|---|---:|---:|
| T0 | Control | 1 | 3 |
| T1 | Low salinity | 4 | 3 |
| T2 | Moderate salinity | 8 | 3 |
| T3 | High salinity | 12 | 3 |
| T4 | Severe salinity | 16 | 3 |

The treatment codes are used consistently throughout the R workflow.

The numerical variable `target_ec` is retained because it represents the ordered salinity gradient, whereas `treatment` represents the five experimental categories.

---

# 5. Pot Identification and Replication

Each pot has a unique identifier based on treatment and replication.

Examples include:

```text
T0R1
T0R2
T0R3

T1R1
T1R2
T1R3

T2R1
T2R2
T2R3
```

and the same treatment × replication structure continues through T4.

This makes the experimental structure directly traceable from the raw observations.

The R workflow checks that pot identifiers are unique before exporting the processed dataset.

---

# 6. Experimental Conditions Recorded in the Dataset

The dataset records:

- **10 kg soil per pot**
- **3 seeds sown per pot**
- target EC for each treatment
- replication number
- a NaCl-related treatment variable from the original dataset

The original NaCl-related field is:

```text
NaCl_per_Pot_g_if_EC10
```

and is standardised in R as:

```r
nacl_per_pot_g
```

This variable is retained as part of the experimental record.

## Methodological boundary

The current dataset does **not** provide sufficient information to reconstruct the complete salinity-treatment procedure.

Therefore, this repository does not assume or invent:

- the exact NaCl preparation procedure
- stock-solution concentration
- solution volume applied per pot
- exact EC adjustment procedure
- irrigation frequency
- irrigation volume
- timing of salt application
- frequency of EC measurement
- or the exact relationship between NaCl quantity and target EC

If these details are available in the original experimental notebook, they should be added to this README before the repository is used as a complete experimental methods record.

---

# 7. Measurements and Biological Response

The experiment was designed to capture plant response at several stages.

## 7.1 Seed Establishment

The first response stage was establishment.

The dataset records:

- Seeds sown
- Plants emerged
- Emergence percentage

Corresponding R variables:

```r
seeds_sown
plants_emerged
emergence_pct
```

Emergence percentage provides an early indication of whether increasing salinity affected successful establishment.

---

## 7.2 Vegetative Growth

Two variables describe above-ground vegetative development.

### Plant height

```r
plant_height_cm
```

Unit:

**cm**

Plant height provides a direct measure of shoot development.

### Leaves per plant

```r
leaves_per_plant
```

This provides an additional indicator of vegetative development.

Together, these measurements allow the analysis to distinguish early establishment from subsequent shoot growth.

---

# 8. Root Development

Root response was assessed using:

```r
root_length_cm
```

Unit:

**cm**

Root length was treated as a separate response because salinity can influence below-ground and above-ground development differently.

Including root measurements also allows the experiment to examine whether reductions in shoot growth are accompanied by changes in root development.

---

# 9. Biomass Assessment

Biomass was recorded separately for shoots and roots.

## Shoot biomass

### Shoot fresh weight

```r
shoot_fresh_weight_g
```

### Shoot dry weight

```r
shoot_dry_weight_g
```

## Root biomass

### Root fresh weight

```r
root_fresh_weight_g
```

### Root dry weight

```r
root_dry_weight_g
```

## Total dry biomass

The dataset also contains:

```r
total_dry_biomass_g
```

Total dry biomass provides an integrated measure of accumulated plant material.

Fresh and dry biomass are retained separately because fresh weight is influenced by tissue water content, whereas dry weight provides a more stable representation of accumulated structural material.

---

# 10. Relative Growth

The dataset contains a derived variable:

```r
relative_growth_pct
```

This variable is retained exactly as supplied in the original dataset.

The analysis workflow does not silently redefine its formula.

If the original calculation is available, the exact formula should be documented in the experimental methods section so that the derived variable can be independently reproduced.

---

# 11. Complete Dataset Structure

The original dataset contains 19 variables.

| Original variable | Analytical variable | Description |
|---|---|---|
| `Pot_ID` | `pot_id` | Unique pot identifier |
| `Treatment` | `treatment` | Salinity treatment |
| `Salinity_Level` | `salinity_level` | Salinity category |
| `Target_EC_dS_m` | `target_ec` | Target EC |
| `Replication` | `replication` | Replicate number |
| `Soil_per_Pot_kg` | `soil_per_pot_kg` | Soil quantity |
| `NaCl_per_Pot_g_if_EC10` | `nacl_per_pot_g` | Recorded NaCl-related variable |
| `Seeds_Sown` | `seeds_sown` | Seeds sown |
| `Plants_Emerged` | `plants_emerged` | Plants emerged |
| `Emergence_pct` | `emergence_pct` | Emergence percentage |
| `Plant_Height_cm` | `plant_height_cm` | Plant height |
| `Leaves_per_Plant` | `leaves_per_plant` | Leaves per plant |
| `Root_Length_cm` | `root_length_cm` | Root length |
| `Shoot_Fresh_Weight_g` | `shoot_fresh_weight_g` | Shoot fresh weight |
| `Shoot_Dry_Weight_g` | `shoot_dry_weight_g` | Shoot dry weight |
| `Root_Fresh_Weight_g` | `root_fresh_weight_g` | Root fresh weight |
| `Root_Dry_Weight_g` | `root_dry_weight_g` | Root dry weight |
| `Total_Dry_Biomass_g` | `total_dry_biomass_g` | Total dry biomass |
| `Relative_Growth_pct` | `relative_growth_pct` | Relative growth |

The cleaned naming convention follows `snake_case` to make the dataset easier to use consistently throughout R.

---

# 12. Data Management and Quality Control

The raw Excel file is treated as the original observation record.

It should be stored unchanged in:

```text
data/raw/millet_salt_tolerance_dataset.xlsx
```

The R workflow then performs the required transformations.

### Data-processing sequence

```text
Raw Excel Dataset
       │
       ▼
Import into R
       │
       ▼
Standardise variable names
       │
       ▼
Convert variable types
       │
       ▼
Validate experimental structure
       │
       ▼
Check missing values
       │
       ▼
Check duplicate pot IDs
       │
       ▼
Export cleaned dataset
       │
       ▼
Statistical analysis
       │
       ▼
Figures and tables
       │
       ▼
Scientific interpretation
```

This approach keeps the raw observations separate from processed data.

---

# 13. Data Validation

Before analysis, the workflow verifies:

- the Excel file exists;
- the expected dataset is imported;
- the number of observations is correct;
- the expected variables are present;
- treatment levels are correctly represented;
- replication information is retained;
- numerical variables are numeric;
- categorical variables are appropriately encoded;
- missing observations are identified;
- and pot identifiers are unique.

The supplied cleaned dataset contains:

```text
15 experimental observations
19 variables
```

The treatment structure is:

```text
5 treatments
3 replicates per treatment
```

---

# 14. Statistical Analysis Strategy

The statistical workflow is organised around the biological question.

The analysis does not begin with a single statistical test. It proceeds from description to validation, inference and interpretation.

## Stage 1: Descriptive statistics

For every response variable and treatment, the workflow calculates:

- sample size (`n`);
- mean;
- standard deviation;
- standard error.

This provides an initial picture of how plant performance changes across salinity levels.

---

## Stage 2: Assumption checks

For each response, the analysis examines:

- residual normality;
- homogeneity of variance.

These checks are particularly important because there are only three replicate pots per treatment.

Statistical significance is therefore considered alongside observed variation and biological effect magnitude.

---

# 15. ANOVA

The primary treatment-level model is:

```r
response ~ treatment
```

For example:

```r
plant_height_cm ~ treatment
```

and:

```r
total_dry_biomass_g ~ treatment
```

This asks:

> **Does the measured response differ among the five salinity treatments?**

ANOVA results are stored systematically for all major response variables.

---

# 16. Estimated Marginal Means and Tukey Comparisons

Where treatment-level comparisons are required, estimated marginal means are calculated.

Pairwise treatment comparisons are adjusted using the Tukey method.

This allows the analysis to move beyond:

> "There is a treatment effect."

and examine:

> "Which treatment levels differ from one another?"

The resulting tables are saved separately from the ANOVA table.

This prevents the common problem of combining multiple statistical outputs into one difficult-to-read table.

---

# 17. Salinity Gradient Analysis

In addition to categorical treatment comparisons, `target_ec` is retained as a numerical variable.

This allows visualisation and exploratory analysis of the response along the salinity gradient:

```text
1 → 4 → 8 → 12 → 16 dS m⁻¹
```

This is useful for examining whether plant responses show:

- gradual decline;
- threshold-like behaviour;
- stronger responses at high EC;
- or considerable variation among replicate pots.

The EC-gradient analysis complements rather than replaces treatment-level ANOVA.

---

# 18. Correlation Analysis

The experiment contains multiple measurements describing related aspects of plant performance.

Correlation analysis is therefore used to explore relationships among:

- emergence;
- plant height;
- leaves per plant;
- root length;
- shoot biomass;
- root biomass;
- total dry biomass;
- and relative growth.

The correlation matrix is exploratory and should not be interpreted as proof of causation.

---

# 19. Principal Component Analysis

Principal Component Analysis (PCA) is included as an exploratory multivariate analysis.

The purpose is to examine whether multiple plant traits respond together across the salinity gradient.

PCA can help answer questions such as:

- Do high-salinity observations cluster separately from control observations?
- Which traits contribute most strongly to the major axes of variation?
- Are biomass and growth traits responding in a coordinated manner?

PCA is used as a complementary analysis rather than a replacement for the primary treatment comparisons.

---

# 20. Visualization Strategy

The visualisation workflow is designed around the actual experimental structure.

Rather than presenting only treatment means, the figures retain the individual observations wherever appropriate.

This is particularly important because the experiment contains only three replicates per treatment.

The main figures cover:

- emergence response;
- plant height;
- root length;
- total dry biomass;
- relative growth;
- PCA of growth traits.

Publication-oriented figures are exported in:

```text
PNG
PDF
SVG
```

This allows the same figures to be used in:

- research presentations;
- reports;
- thesis chapters;
- manuscripts;
- posters;
- and academic portfolios.

---

# 21. Interactive Visualization

The repository includes an R-only interactive visualization workflow.

The script:

```text
scripts/07_interactive_visualization.R
```

uses `plotly` to allow individual observations to be explored interactively.

The visualization can display information such as:

- treatment;
- salinity level;
- replication;
- target EC;
- total dry biomass.

The repository intentionally does **not** store HTML files.

Interactive visualization is generated directly from R/RStudio when the script is run.

---

# 22. Repository Structure

```text
millet-salt-tolerance-r-repository/
│
├── README.md
├── millet-salt-tolerance-r-repository.Rproj
├── .gitignore
│
├── data/
│   │
│   ├── raw/
│   │   └── millet_salt_tolerance_dataset.xlsx
│   │
│   └── processed/
│       └── millet_clean.csv
│
├── docs/
│   ├── experiment_details.md
│   ├── analysis_plan.md
│   └── data_dictionary.csv
│
├── scripts/
│   ├── 01_import_clean.R
│   ├── 02_descriptive_statistics.R
│   ├── 03_assumption_checks.R
│   ├── 04_anova_tukey.R
│   ├── 05_publication_figures.R
│   ├── 06_pca_correlation.R
│   └── 07_interactive_visualization.R
│
├── figures/
│   ├── exploratory/
│   └── publication/
│
├── tables/
│
└── results/
    └── interpretation.md
```

---

# 23. R Analysis Workflow

The scripts should be run in the following order.

### `01_import_clean.R`

Imports and validates the original dataset.

**Output:**

```text
data/processed/millet_clean.csv
```

---

### `02_descriptive_statistics.R`

Generates treatment-level descriptive statistics.

**Outputs:**

```text
tables/descriptive_statistics_long.csv
tables/treatment_means_se.csv
```

---

### `03_assumption_checks.R`

Checks statistical assumptions for the treatment models.

**Output:**

```text
tables/assumption_checks.csv
```

---

### `04_anova_tukey.R`

Runs ANOVA, estimated marginal means and Tukey-adjusted comparisons.

**Outputs:**

```text
tables/anova_results.csv
tables/estimated_marginal_means.csv
tables/tukey_pairwise_comparisons.csv
```

---

### `05_publication_figures.R`

Creates publication-quality figures.

**Outputs include:**

```text
figures/publication/emergence_vs_ec.*
figures/publication/plant_height_vs_ec.*
figures/publication/root_length_vs_ec.*
figures/publication/biomass_vs_ec.*
figures/publication/relative_growth_vs_ec.*
```

where `*` represents the exported PNG, PDF and SVG formats.

---

### `06_pca_correlation.R`

Generates:

```text
tables/correlation_matrix.csv
tables/pca_scores.csv
figures/publication/pca_growth_traits.*
```

---

### `07_interactive_visualization.R`

Launches the interactive R visualization.

No HTML file is committed to the repository.

---

# 24. Reproducibility

The project uses an RStudio project file:

```text
millet-salt-tolerance-r-repository.Rproj
```

The project should always be opened from the repository root.

The analysis uses relative paths such as:

```r
data/raw/millet_salt_tolerance_dataset.xlsx
```

rather than machine-specific paths such as:

```text
C:/R_studio_practice/basics/data/project_04/...
```

This makes the project portable.

Another researcher can clone the repository, place the raw Excel file in the correct location, open the `.Rproj` file and reproduce the workflow.

---

# 25. Scientific Interpretation Framework

The results should be interpreted in biological sequence rather than as isolated statistical outputs.

The intended interpretation pathway is:

```text
Increasing salinity
        ↓
Seed establishment
        ↓
Shoot development
        ↓
Root development
        ↓
Fresh biomass
        ↓
Dry biomass
        ↓
Overall plant performance
```

For example, if increasing EC is associated with lower emergence, reduced plant height, shorter roots and lower dry biomass, the first conclusion should describe this observed pattern.

Only afterward should possible mechanisms be discussed.

Potential explanations such as:

- osmotic stress;
- ion toxicity;
- altered nutrient availability;
- reduced water uptake;
- or changes in plant water relations

should not be presented as experimentally demonstrated mechanisms unless the experiment included measurements capable of testing them.

---

# 26. Limitations

This is a controlled pot experiment with:

```text
3 replicate pots per treatment
```

Therefore, conclusions should be interpreted with appropriate caution.

The experiment provides evidence about the response of the tested millet material under the experimental conditions represented in the dataset.

It does **not**, by itself, establish:

- a universal millet salinity tolerance threshold;
- a field-scale yield response;
- a recommendation for all soils;
- a response for all millet cultivars;
- or a complete physiological mechanism of salt tolerance.

The small number of experimental units also means that effect size, replicate variation and model assumptions are important alongside p-values.

---

# 27. Information Required for Complete Experimental Reproduction

The current dataset establishes the treatment structure and measured responses, but it does not contain every methodological detail required to reproduce the physical experiment.

If available, the following information should be added from the original experimental record:

### Plant material
- Millet species
- Cultivar/genotype
- Seed source
- Seed quality information

### Soil
- Soil source
- Soil classification
- Texture
- Initial pH
- Initial EC
- Organic matter
- Initial nutrient status

### Salinity preparation
- Exact NaCl preparation procedure
- Stock solution concentration
- Amount of solution applied
- Target EC preparation method
- EC measurement procedure
- Frequency of EC monitoring

### Experimental management
- Experiment start date
- Experiment duration
- Irrigation schedule
- Irrigation volume
- Greenhouse/environmental conditions
- Temperature
- Relative humidity
- Light conditions
- Pot arrangement
- Randomisation procedure

### Harvest and laboratory measurements
- Harvest date
- Root washing procedure
- Fresh-weight measurement procedure
- Drying temperature
- Drying duration
- Balance/instrument information
- Formula for relative growth percentage

These details should be added from the original experimental notebook rather than inferred.

---

# 28. Why This Repository Is Reproducible

The repository follows a simple principle:

> **Raw data should remain unchanged; every analytical transformation should be visible in R.**

The workflow therefore separates:

**Raw observations**

from

**Processed data**

from

**Statistical outputs**

from

**Figures**

from

**Interpretation**

This means a final figure can be traced backward to the analysis script, the processed dataset and ultimately the original experimental observations.

---

# 29. Research Value

Although this is a relatively small controlled experiment, its structure makes it useful as a reproducible example of soil–plant salinity analysis.

The project demonstrates how experimental observations can be transformed into a research workflow combining:

- soil science;
- plant response assessment;
- experimental design;
- statistical analysis;
- R programming;
- data visualisation;
- multivariate analysis;
- and reproducible research practices.

The repository is therefore intended not simply as a storage location for an experiment, but as a transparent analytical record.

---

# 30. Final Experimental Perspective

The central idea behind this experiment is simple:

> **As the salinity environment becomes increasingly stressful, how does the plant respond?**

The experiment approaches this question from several angles.

A seed must first establish.

An established plant must develop shoots and leaves.

Roots must continue to develop.

The plant must accumulate biomass.

By measuring these components separately, the experiment provides a more complete picture of the plant's response than any single measurement could provide.

The analytical workflow follows the same logic: describe the observations, test treatment differences, examine the salinity gradient, explore relationships among traits, visualise the responses and interpret the biological pattern carefully.

---

## Research Team

### Qurrat-ul-Ain & Moazzam Riaz

This experimental study was conducted as a collaborative research project by **Qurrat-ul-Ain** and **Moazzam Riaz**.

Both contributors were involved in the experimental work and development of this research project, with contributions spanning experimental observations, data analysis, interpretation, and research documentation.

**Research areas:**  
Soil Science • Soil Salinity • Experimental Research • Plant–Soil Interactions • R & Data Analysis • GIS & Environmental Analysis

---
## Reproducibility Statement

The analysis is designed to be fully traceable from the original experimental data through data cleaning, statistical analysis, visualization, and interpretation.

Only experimentally documented information is reported; undocumented methodological details are not assumed or inferred.
