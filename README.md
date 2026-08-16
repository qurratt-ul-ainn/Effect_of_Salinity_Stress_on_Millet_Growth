# Millet Response to Increasing Soil Salinity

### Controlled Pot Experiment and Reproducible R Analysis

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:2E8B57,100:6A994E&height=180&section=header&text=Millet%20Response%20to%20Salinity&fontSize=34&fontColor=ffffff&fontAlignY=38&desc=Controlled%20Pot%20Experiment%20%7C%20Reproducible%20R%20Analysis&descAlignY=62&descSize=16"/>
</p>

<p align="center">
  <strong>Soil Salinity • Millet • Plant Growth • Biomass • R • Reproducible Research</strong>
</p>

---

## Project Overview

This repository documents a controlled pot experiment examining how an increasing soil salinity gradient affected millet establishment, vegetative growth, root development, and biomass production. Five target EC levels (1, 4, 8, 12, and 16 dS m⁻¹) were evaluated using three replications per treatment, giving a total of 15 experimental units. The analysis was developed in R to move from the original experimental observations through data quality checks, statistical analysis, visualization, and interpretation.

### Research question

> **How does increasing soil salinity affect millet establishment, vegetative growth, root development and biomass production?**

The experiment evaluates plant responses across an increasing electrical conductivity (EC) gradient:

**1 → 4 → 8 → 12 → 16 dS m⁻¹**

The complete workflow follows:

**Experimental design → Data preparation → Quality control → Statistical analysis → Visualization → Interpretation**

The analysis is implemented in **R** using a reproducible project structure.

---

## 2. Experimental Design

| Component | Description |
|---|---|
| Experimental unit | Individual pot |
| Salinity treatments | 5 |
| Replications | 3 per treatment |
| Total experimental units | 15 |
| Seeds per pot | 3 |
| Target EC range | 1–16 dS m⁻¹ |
| Analysis | R |

The experimental structure is balanced:

**5 treatments × 3 replications = 15 experimental units**

Each experimental unit has a unique treatment × replication identifier.

---

## 3. Salinity Treatments

| Treatment | Salinity level | Target EC (dS m⁻¹) |
|---|---|---:|
| T0 | Control | 1 |
| T1 | Low | 4 |
| T2 | Moderate | 8 |
| T3 | High | 12 |
| T4 | Severe | 16 |

The treatment variable is used for categorical statistical comparisons, while `target_ec` is retained as a numerical representation of the salinity gradient.

---

## 4. Plant Measurements

The experiment records responses at several stages:

Variable                Meaning                         Unit
----------------------------------------------------------------
pot_id                  Experimental unit              -
treatment               Salinity treatment             -
target_ec               Target electrical conductivity dS m⁻¹
replication             Replicate number               -
seeds_sown              Number of seeds planted        count
plants_emerged          Number emerged                 count
emergence_pct           Emergence percentage           %
plant_height_cm         Plant height                   cm
root_length_cm          Root length                    cm
total_dry_biomass_g     Total dry biomass              g
relative_growth_pct     Relative growth                %

Additional experimental information includes treatment, replication, soil quantity, target EC and the recorded NaCl-related variable.

---

## 5. Dataset

The analytical dataset contains:

- 15 experimental observations
- 19 variables
- 5 salinity treatments
- 3 replications per treatment

Variable names are standardised using `snake_case` for consistent analysis in R.

The dataset includes information such as:

```text
pot_id
treatment
salinity_level
target_ec
replication
soil_per_pot_kg
nacl_per_pot_g
seeds_sown
plants_emerged
emergence_pct
plant_height_cm
leaves_per_plant
root_length_cm
shoot_fresh_weight_g
shoot_dry_weight_g
root_fresh_weight_g
root_dry_weight_g
total_dry_biomass_g
relative_growth_pct


```
## 6. Research Team

Qurrat-ul-Ain & Moazzam Riaz

This experimental study was conducted as a collaborative research project by Qurrat-ul-Ain and Moazzam Riaz.

Both contributors were involved in the experimental work and development of this research project, with contributions spanning experimental observations, data analysis, interpretation, and research documentation.

Research areas:Soil Science • Soil Salinity • Experimental Research • Plant–Soil Interactions • R & Data Analysis • GIS & Environmental Analysis

## 7. Reproducibility Statement

The analysis is designed to be fully traceable from the original experimental data through data cleaning, statistical analysis, visualization, and interpretation. Only experimentally documented information is reported; undocumented methodological details are not assumed or inferred.


