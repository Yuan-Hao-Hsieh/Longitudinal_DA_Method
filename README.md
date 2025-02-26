# Longitudinal Data Analysis Repository  

This repository contains a collection of assignments and projects from my longitudinal data analysis course. All projects focus on modeling repeated measurements using real‐world data, with key statistical analyses (ANOVA, covariance structure comparisons, model selection, and hypothesis testing) performed using SAS. The following is an overview of each homework assignment:

---

## Homework p1 – Model Comparison in Cardiac Data  
**Description:**  
Analyzes factors affecting post-catheter ablation outcomes (RCAF) by comparing four different models.  
- **Model 1:** Reveals that variables AFT and MR significantly affect RCAF, whereas Age and sex are not significant.  
- **Model 2:** Incorporates AFT, MR, and LAD as significant factors.  
- **Model 3 & Model 4:** Further refine the model by including Age or excluding non-significant factors.  
- **Conclusion:** Model 4 is recommended based on better precision and model fit.  
**Note:** Parameter estimates, p-values, and related model outputs were generated using SAS.  
*(See p1_410978002_謝元皓.pdf :contentReference[oaicite:0]{index=0})*

---

## Homework p2 – ANOVA in Rabbit Treatment Study  
**Description:**  
Tests the effect of treatment (TH) on rabbits' conduction velocity (CV) using ANOVA.  
- **Designs:** Both independent and repeated-measures designs are considered.  
- **Findings:** Significant F-test results (p ≤ 0.02 or p < 0.0001) lead to rejection of the null hypothesis, indicating that the treatment improves CV.  
**Note:** SAS (PROC ANOVA and PROC GLM) was used to derive the output tables and conduct the tests.  
*(See p2_410978002_謝元皓.pdf :contentReference[oaicite:1]{index=1})*

---

## Homework p3 – Analysis of Iron Supplementation in Pregnancy  
**Description:**  
Investigates serum level changes among pregnant women, comparing groups with and without iron supplementation, and considering anemia history.  
- **Approach:** Multiple models are compared using SAS output (e.g., AIC, MSE, CV) to determine which factors (e.g., Time, Group, and their interactions) are significant.  
- **Conclusion:** Differences over time are significant—especially among women with a history of anemia—and the model incorporating these factors best explains the outcomes.  
**Note:** Detailed SAS reports provide parameter estimates and hypothesis test results.  
*(See p3_410978002_謝元皓.pdf :contentReference[oaicite:2]{index=2})*

---

## Homework p4 – Covariance Structure Analysis & Model Selection  
**Description:**  
Evaluates various covariance structures for repeated measures data (e.g., blood lead levels) including:
- Homogeneous compound symmetry, AR(1) with/without unequal variances, Toeplitz structures, and unstructured covariance.  
- **Outcome:** The AR(1) structure with unequal variances was found to have the smallest AIC, and among the fitted models, Model 2 provided the best fit.  
**Note:** SAS was used to compute sample covariance and correlation matrices, and to perform likelihood and AIC tests.  
*(See p4_410978002_謝元皓.pdf :contentReference[oaicite:3]{index=3})*

---

## Homework p5 – Inhibition Value Analysis Under Drug Treatments  
**Description:**  
Analyzes how two drugs affect inhibition values over time using residual analysis, AIC, and likelihood ratio tests.  
- **Analysis:** Tests for baseline differences (e.g., gender effect, drug differences) and interactions were performed.  
- **Findings:** While residuals approximate normality and some comparisons show significant differences, certain baseline effects are not statistically significant.  
**Note:** SAS outputs and tests (including p-value computations) support the conclusions.  
*(See p5_410978002_謝元皓.pdf :contentReference[oaicite:4]{index=4})*

---

## Repository Navigation and Usage

- **Files & Reports:**  
  Each PDF file (p1–p5) contains detailed SAS outputs, parameter estimation tables, and discussion of findings.
  
- **Software & Tools:**  
  Primary analyses were conducted using SAS. Supplemental visualization and documentation were prepared in Python.

- **How to Replicate:**  
  While the core analyses are available in the PDF reports, any corresponding code (e.g., for plotting) can be found in the individual project folders. To run such scripts:
  1. Clone the repository:
     ```bash
     git clone https://github.com/YOUR_USERNAME/your-repository.git
     cd your-repository
     ```
  2. Install required packages (if any Python scripts are provided) via:
     ```bash
     pip install -r requirements.txt
     ```
  3. Open the project folder and review the scripts and reports.

---

*Howard Hsieh – Longitudinal Data Analysis, Statistical Modeling & SAS Implementation*
