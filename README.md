# ena-philosophy

This repository contains code and data processing pipelines for analysing epistemic and discourse-level structures in student writing using Epistemic Network Analysis (ENA) and NLP-based preprocessing.

The project explores how different disciplinary backgrounds and learning contexts are reflected in the structure of learners’ knowledge and argumentation networks, rather than only in surface-level performance or content.

---

## Overview

Traditional learning analytics often focuses on individual variables such as ability, test scores, or isolated linguistic features. This project instead adopts a structural perspective, modelling learning as a network of co-occurring concepts, discourse roles, and epistemic moves.

Using Epistemic Network Analysis (ENA), the project visualises and compares how these structures differ or converge across:
- Disciplinary backgrounds
- Learning tasks and contexts
- Performance levels

The aim is not simply to detect differences, but to examine whether learners facing the same conceptual task develop structurally similar or divergent knowledge networks, and how such structures relate to learning outcomes.

---

## Methodology

The pipeline consists of the following stages:

1. **Text preprocessing**
   - Sentence segmentation
   - Discourse or concept tagging (rule-based or model-based)
   - Conversion of tagged data into coded datasets suitable for ENA

2. **Network construction**
   - Co-occurrence modelling using sliding windows
   - Construction of weighted epistemic or discourse networks

3. **ENA modelling**
   - Accumulated or trajectory-based ENA
   - Comparison across groups and conditions
   - Visualisation of network structures

4. **Outcome analysis**
   - Linking network features to learning outcomes or performance measures

---

## Project Structure
# ena-philosophy

This repository contains code and data processing pipelines for analysing epistemic and discourse-level structures in student writing using Epistemic Network Analysis (ENA) and NLP-based preprocessing.

The project explores how different disciplinary backgrounds and learning contexts are reflected in the structure of learners’ knowledge and argumentation networks, rather than only in surface-level performance or content.

---

## Overview

Traditional learning analytics often focuses on individual variables such as ability, test scores, or isolated linguistic features. This project instead adopts a structural perspective, modelling learning as a network of co-occurring concepts, discourse roles, and epistemic moves.

Using Epistemic Network Analysis (ENA), the project visualises and compares how these structures differ or converge across:
- Disciplinary backgrounds
- Learning tasks and contexts
- Performance levels

The aim is not simply to detect differences, but to examine whether learners facing the same conceptual task develop structurally similar or divergent knowledge networks, and how such structures relate to learning outcomes.

---

## Methodology

The pipeline consists of the following stages:

1. **Text preprocessing**
   - Sentence segmentation
   - Discourse or concept tagging (rule-based or model-based)
   - Conversion of tagged data into coded datasets suitable for ENA

2. **Network construction**
   - Co-occurrence modelling using sliding windows
   - Construction of weighted epistemic or discourse networks

3. **ENA modelling**
   - Accumulated or trajectory-based ENA
   - Comparison across groups and conditions
   - Visualisation of network structures

4. **Outcome analysis**
   - Linking network features to learning outcomes or performance measures

---

## Project Structure
ena-philosophy/
├── data/               # Raw and processed datasets
├── preprocessing/      # Text processing and coding scripts
├── ena/                # ENA modelling and visualisation
├── analysis/           # Statistical analysis and interpretation
└── notebooks/          # Exploratory analysis and examples

