# Define standard botanical character ontology for Flora audits

Retrieves the controlled vocabulary and categorical trait definitions
used for botanical literature auditing.

## Usage

``` r
ta_get_ontology()
```

## Value

A named `list` where each element represents a botanical trait category
(e.g., leaf shape, indumentum) containing a character vector of valid
state terms.

## Examples

``` r
ontology <- ta_get_ontology()
names(ontology)
#> [1] "leaf_shape"   "leaf_margin"  "indumentum"   "flower_color"
head(ontology$leaf_shape)
#> [1] "elliptic"   "lanceolate" "ovate"      "linear"     "obovate"   
#> [6] "cordate"   
```
