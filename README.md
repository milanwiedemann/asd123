
<!-- README.md is generated from README.Rmd. Please edit that file -->

# varnames

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/milanwiedemann/varnames?branch=master&svg=true)](https://ci.appveyor.com/project/milanwiedemann/varnames)
[![Travis build
status](https://travis-ci.com/milanwiedemann/varnames.svg?branch=master)](https://travis-ci.com/milanwiedemann/varnames)
<!-- badges: end -->

The goal of `varnames` is to help with creating consistent variable
names. This has many advantages, even if no further calculations of the
data are needed.

Consistent variable names are particularly helpful when managing larger
datasets. Below I some examples how consistent variable names help when
combined with other useful tools like [Regular
Expressions](https://stringr.tidyverse.org/articles/regular-expressions.html).

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

For most cases there might be a very simple solution in creating
consistent variable names using the `paste()` function.

``` r
# Create vector of a measure with 3 time points (t)
paste("measure_", "t", 1:3, sep = "")
#> [1] "measure_t1" "measure_t2" "measure_t3"
```

Sometimes more than one specification need to be added to a variable
name. Say something about “wide” data. Allthough this is not the best
way to store data
\[@Wickham2013\](<https://www.jstatsoft.org/article/view/v059i10>), it
is often how data looks like. In the examples below I’m showing how data
stored in these variable names can be transformend into “long” data.

Similar to the example above, the `create_var_names()` function creates
a vector (or list) of consistent variable names.

``` r
library(varnames)
library(tidyverse)
#> ── Attaching packages ───────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.0     ✓ purrr   0.3.3
#> ✓ tibble  3.0.0     ✓ dplyr   0.8.5
#> ✓ tidyr   1.0.2     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.5.0
#> ── Conflicts ──────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

# Create vector of a measure with 3 time points (t)
create_var_names(var_name = "measure", str = "t", n = 3)
#> [[1]]
#> [1] "measure_t1"
#> 
#> [[2]]
#> [1] "measure_t2"
#> 
#> [[3]]
#> [1] "measure_t3"
```

The `add_specifier()` function adds a specifier, here “i” to the
variables created in the step before. A feature of this function is that
variable names can be returend in different ways, depending on what
output format is most suitable for further use.

The example below adds two indicators “i” for each time point “t” and
returns a list that is sorted by the specifyer added created initially
“t”.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "previous")
#> [[1]]
#> [1] "measure_t1_i1" "measure_t1_i2"
#> 
#> [[2]]
#> [1] "measure_t2_i1" "measure_t2_i2"
#> 
#> [[3]]
#> [1] "measure_t3_i1" "measure_t3_i2"
```

The output list can also be sorted according to the second specifyer
that is added by using the argument `sort = "current"`. Now a list with
two elements gets returned, one for each indicator that was added.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "current")
#> [[1]]
#> [1] "measure_t1_i1" "measure_t2_i1" "measure_t3_i1"
#> 
#> [[2]]
#> [1] "measure_t1_i2" "measure_t2_i2" "measure_t3_i2"
```

If the desired output is a vactor of all variables the argument `unlist
= TRUE` can be used.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "current", unlist = TRUE)
#> [1] "measure_t1_i1" "measure_t2_i1" "measure_t3_i1" "measure_t1_i2"
#> [5] "measure_t2_i2" "measure_t3_i2"
```

The order of the vector can still be changed by the sort argument.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "previous", unlist = TRUE)
#> [1] "measure_t1_i1" "measure_t1_i2" "measure_t2_i1" "measure_t2_i2"
#> [5] "measure_t3_i1" "measure_t3_i2"
```

## TODOS

  - Add Why is this so useful? Show some examples, regular expressions
    automation etc
  - Add rename functions
  - Currently this only works when adding one specifyer, I think more
    would be cool, I might need help with this
