
<!-- README.md is generated from README.Rmd. Please edit that file -->

# varnames

<!-- badges: start -->

[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/milanwiedemann/varnames?branch=master&svg=true)](https://ci.appveyor.com/project/milanwiedemann/varnames)
[![Travis build
status](https://travis-ci.com/milanwiedemann/varnames.svg?branch=master)](https://travis-ci.com/milanwiedemann/varnames)
<!-- badges: end -->

The goal of `varnames` is to help with creating consistent variable
names. Good variable names have many advantages, particularly when
managing larger datasets.

Consistent names make also make it easier to transform data sets to
“tidy data”, see [Wickham
(2013)](https://www.jstatsoft.org/article/view/v059i10). I’ll show some
examples how consistent variable names can be really powerful because
it’s easier to automate things and use [Regular
Expressions](https://stringr.tidyverse.org/articles/regular-expressions.html).

## Installation

This is work in progress, the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("milanwiedemann/varnames")
```

## Example

### Base R

For most cases there might be a very easy way to create consistent
variable names simply by using the `paste()` function. This function
comes with base R which means that no further packages are needed and it
is very flexible\!

``` r
# Create vector of a measure with 3 time points (t)
paste("measure_", "t", 1:3, sep = "")
#> [1] "measure_t1" "measure_t2" "measure_t3"
```

Sometimes more than one specification need to be added to a variable
name. This is still possible using base function but it gets a bit
tricky so I build functions that help with this.

### varnames R package

Similar to the example above, the `create_var_names()` function creates
a vector (or list) of a measure with 3 time points (“t”) specified in
the arguments `str = "t"` and `n = 3`.

``` r
library(varnames)
library(tidyverse)
#> ── Attaching packages ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──
#> ✓ ggplot2 3.3.0     ✓ purrr   0.3.4
#> ✓ tibble  3.0.1     ✓ dplyr   0.8.5
#> ✓ tidyr   1.0.2     ✓ stringr 1.4.0
#> ✓ readr   1.3.1     ✓ forcats 0.5.0
#> ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()

# Create vector of a measure with 3 time points (t)
create_var_names(var_name = "measure", str = "t", n = 3, unlist = T)
#> [1] "measure_t1" "measure_t2" "measure_t3"
```

The `add_specifier()` function adds a further specification to the
variables created in the step before, here `"i"` for item. Depending on
what output format is most suitable for further use, this function can
return the output in different ways.

The example below adds two items “i” for each time point “t” and returns
a list that is sorted by the output format from the previous function
using `sort = "previous"`. This creates a list with 3 vectors, one for
each time point specified in the previous function.

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

The output list can also be sorted by the new specifyer that was added
by using the argument `sort = "current"`. Now a list with two vectors is
returned, one vector for each indicator that was added.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "current")
#> [[1]]
#> [1] "measure_t1_i1" "measure_t2_i1" "measure_t3_i1"
#> 
#> [[2]]
#> [1] "measure_t1_i2" "measure_t2_i2" "measure_t3_i2"
```

A list can be returned using the argument `unlist = TRUE`.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "current", unlist = TRUE)
#> [1] "measure_t1_i1" "measure_t2_i1" "measure_t3_i1" "measure_t1_i2"
#> [5] "measure_t2_i2" "measure_t3_i2"
```

The order of the vector can still be changed when using `unlist = TRUE`
by changing the sort argument.

``` r
create_var_names(var_name = "measure", str = "t", n = 3) %>% 
  add_specifier(str = "i", n = 2, sort = "previous", unlist = F)
#> [[1]]
#> [1] "measure_t1_i1" "measure_t1_i2"
#> 
#> [[2]]
#> [1] "measure_t2_i1" "measure_t2_i2"
#> 
#> [[3]]
#> [1] "measure_t3_i1" "measure_t3_i2"
```

## TODOs

  - Say something about “tidy” data
    [Wickham2013](https://www.jstatsoft.org/article/view/v059i10)
  - Take a closer look at the bad data guide
    <https://github.com/Quartz/bad-data-guide>
  - In the examples below I’m showing how data stored in these variable
    names can be transformend into “long” data.
  - Add Why is this so useful? Show some examples, regular expressions
    automation etc
  - Add rename functions
  - Currently this only works when adding one specifyer, I think more
    would be cool, I might need help with this
