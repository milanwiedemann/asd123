
<!-- README.md is generated from README.Rmd. Please edit that file -->

# varnames

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/milanwiedemann/varnames?branch=master&svg=true)](https://ci.appveyor.com/project/milanwiedemann/varnames)
[![Travis build
status](https://travis-ci.com/milanwiedemann/varnames.svg?branch=master)](https://travis-ci.com/milanwiedemann/varnames)
<!-- badges: end -->

The goal of varnames is to …

## Installation

You can install the released version of varnames from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("varnames")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("milanwiedemann/varnames")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(varnames)
library(tidyverse)
#> ── Attaching packages ───────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.0     ✓ purrr   0.3.3
#> ✓ tibble  3.0.0     ✓ dplyr   0.8.5
#> ✓ tidyr   1.0.2     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.5.0
#> ── Conflicts ──────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
## basic example code

create_var_names(var_name = "pds", str = "s", n = 2, unlist = T) %>% 
  add_specifier(str = "i", n = 3, sort = "previous", unlist = F) 
#> [[1]]
#> [1] "pds_s1_i1" "pds_s1_i2" "pds_s1_i3"
#> 
#> [[2]]
#> [1] "pds_s2_i1" "pds_s2_i2" "pds_s2_i3"

create_var_names(var_name = "pds", str = "s", n = 2, unlist = T) %>% 
  add_specifier(str = "i", n = 3, sort = "current", unlist = T) %>% 
  add_specifier(str = "t", n = 4, sort = "current", unlist = F)
#> [[1]]
#> [1] "pds_s1_i1_t1" "pds_s2_i1_t1" "pds_s1_i2_t1" "pds_s2_i2_t1" "pds_s1_i3_t1"
#> [6] "pds_s2_i3_t1"
#> 
#> [[2]]
#> [1] "pds_s1_i1_t2" "pds_s2_i1_t2" "pds_s1_i2_t2" "pds_s2_i2_t2" "pds_s1_i3_t2"
#> [6] "pds_s2_i3_t2"
#> 
#> [[3]]
#> [1] "pds_s1_i1_t3" "pds_s2_i1_t3" "pds_s1_i2_t3" "pds_s2_i2_t3" "pds_s1_i3_t3"
#> [6] "pds_s2_i3_t3"
#> 
#> [[4]]
#> [1] "pds_s1_i1_t4" "pds_s2_i1_t4" "pds_s1_i2_t4" "pds_s2_i2_t4" "pds_s1_i3_t4"
#> [6] "pds_s2_i3_t4"
```

Just realised something like this may be way simpler

``` r
library(tidyverse)
paste0("pds", "_", "s", 1:10) %>% 
  paste0("_",  "i", 1:4)
#>  [1] "pds_s1_i1"  "pds_s2_i2"  "pds_s3_i3"  "pds_s4_i4"  "pds_s5_i1" 
#>  [6] "pds_s6_i2"  "pds_s7_i3"  "pds_s8_i4"  "pds_s9_i1"  "pds_s10_i2"
```

### Create variable names

### Rename variables

## Why is this so useful?

  - Show some examples, regular expressions automation etc
