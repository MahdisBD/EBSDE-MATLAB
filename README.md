# EBSDE: Enhanced Bernstain-Search Differential Evolution

[![MATLAB](https://img.shields.io/badge/MATLAB-R2016b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)
[![Article](https://img.shields.io/badge/IJCSE-Vol.%209%2C%20Issue%206-blue.svg)](https://www.ijcse.net/issue.php?file=vol09issue6)

MATLAB implementation of the **Enhanced Bernstain-Search Differential Evolution (EBSDE)** algorithm for constrained engineering design optimization.

> **Naming note:** The spelling "Bernstain" is retained because it is used in the published article and the original BSD algorithm's title.

> **Abbreviation note:** This repository uses **EBSDE** as the algorithm abbreviation. Some text in the associated 2020 article and the original release archive uses the shorter form **EBSD**.

## Associated paper

> H. Zamani, M. H. Nadimi-Shahraki, S. Taghian, and M. Banaie-Dezfouli, "Enhancement of Bernstain-Search Differential Evolution Algorithm to Solve Constrained Engineering Problems," *International Journal of Computer Science Engineering (IJCSE)*, vol. 9, no. 6, pp. 386-396, 2020.

- [Author-provided paper copy](paper/EBSDE-paper.pdf)
- [Journal issue page](https://www.ijcse.net/issue.php?file=vol09issue6)
- ResearchGate deposit identifier cited in the original source-code headers: [10.13140/RG.2.2.16902.40004](https://doi.org/10.13140/RG.2.2.16902.40004)

The `10.13140/...` identifier refers to a ResearchGate deposit and is not presented here as a publisher-assigned journal DOI.

## Algorithm overview

EBSDE enhances the Bernstain-Search Differential Evolution algorithm to improve population diversity and reduce local-optimum trapping in constrained engineering problems. Its main mechanisms include:

1. a modified trial-pattern-vector generation strategy;
2. a Chebyshev chaotic map for population diversity;
3. Bernstein-polynomial-based selection of active dimensions;
4. stochastic evolutionary step sizes; and
5. a weighted penalty function for inequality and equality constraints.

Candidate trial vectors that exceed their decision-variable bounds are randomly regenerated within the corresponding valid interval. A trial solution replaces its current solution when its penalized objective value is better.

## Included demonstration

This release implements the **welded-beam design optimization problem** with four decision variables and seven inequality constraints. The objective minimizes fabrication cost subject to shear-stress, bending-stress, geometry, deflection, buckling-load, and related design restrictions.

The paper also reports pressure-vessel, tension/compression-spring, and three-bar-truss experiments. Their problem-definition files are not included in this archive.

## Repository contents

| File | Purpose |
|---|---|
| `main.m` | Runs 30 independent welded-beam experiments and plots convergence |
| `EBSDE.m` | Main EBSDE optimization procedure |
| `GetAlpha.m` | Generates the Bernstein-polynomial dimension-selection parameter |
| `Bound_Constraint.m` | Repairs decision variables outside their bounds |
| `ObjectiveFun.m` | Combines the engineering objective and constraint penalty |
| `WBP_Constraint.m` | Implements the weighted penalty method |
| `Cost_Function.m` | Welded-beam fabrication-cost objective |
| `constraint.m` | Welded-beam inequality constraints |
| `getH.m` | Inequality-constraint indicator |
| `geteqH.m` | Equality-constraint indicator |
| `paper/EBSDE-paper.pdf` | Author-provided copy of the associated article |
| `CITATION.cff` | Machine-readable citation metadata |

## Requirements

- MATLAB R2016b or later
- No additional MATLAB toolbox is required by the included demo

The source-code headers state that the implementation was developed in MATLAB R2016b.

## Quick start

1. Download or clone this repository.
2. Open the repository folder in MATLAB.
3. Run:

```matlab
main
```

The default settings are:

```matlab
SearchAgents = 100;
Max_iteration = 2000;
runs = 30;
```

The script saves the accumulated workspace results as `WBP_EBSDE_Results.mat`, reports the best result, and plots the convergence curve from the best run.

For a faster initial test, temporarily use:

```matlab
SearchAgents = 20;
Max_iteration = 100;
runs = 2;
```

These reduced values are suitable only for verifying execution, not for reproducing the published experiment.

## Calling EBSDE directly

```matlab
N = 100;
D = 4;
MaxIt = 2000;
lb = [0.1 0.1 0.1 0.1];
ub = [2 10 10 2];

[bestPosition,bestFitness,curve] = EBSDE( ...
    N,D,lb,ub,MaxIt,@Cost_Function,@constraint);
```

Outputs:

- `bestPosition`: best decision vector;
- `bestFitness`: best penalized objective value; and
- `curve`: best objective value recorded at each iteration.

## Reproducibility

EBSDE is stochastic. Uncomment `rng(1,'twister')` in `main.m` for a repeatable demonstration. For research comparisons, use independent runs and report appropriate summary statistics.

## Release notes

The GitHub-ready package removes the MATLAB autosave file, empty text placeholder, and previously saved workspace result. It retains the original EBSDE search and constraint-handling logic while adding input validation, array preallocation, clearer numeric output, optional reproducibility, and automatic figure cleanup.

## Citation

If this implementation contributes to your work, cite the associated article:

```bibtex
@article{Zamani2020EBSDE,
  author  = {Zamani, Hoda and Nadimi-Shahraki, Mohammad H. and Taghian, Shokooh and Banaie-Dezfouli, Mahdis},
  title   = {Enhancement of Bernstain-Search Differential Evolution Algorithm to Solve Constrained Engineering Problems},
  journal = {International Journal of Computer Science Engineering},
  volume  = {9},
  number  = {6},
  pages   = {386--396},
  year    = {2020},
  issn    = {2319-7323}
}
```

## Contact

**Mahdis Banaie-Dezfouli**  
GitHub: [MahdisBD](https://github.com/MahdisBD)

Corresponding author of the paper: **Hoda Zamani** ([zamanie_hoda@ymail.com](mailto:zamanie_hoda@ymail.com)).

## Usage and citation

This repository is provided for academic and research visibility. No open-source software license is currently granted. If you use or refer to this implementation in academic work, please cite the associated paper. For permission to reuse, modify, or redistribute the code, please contact the authors.

No separate license is asserted here for the included article; its publication and reuse terms remain those of the journal and copyright holders.
