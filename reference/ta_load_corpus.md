# Load the Expert-Annotated Benchmark Corpus

Retrieves the gold-standard benchmark corpus containing plant
treatments, morphological traits, and evidence spans from package
internal files.

## Usage

``` r
ta_load_corpus()
```

## Value

A `data.frame` containing gold-standard plant treatments, traits, and
evidence spans.

## Examples

``` r
corpus <- ta_load_corpus()
head(corpus)
#>            taxon      character handcoded_state extracted_state
#> 1 Cedrus deodara    growth_form            tree            tree
#> 2 Cedrus deodara leaf_length_cm         2.5-5.0         2.5-5.0
#> 3 Cedrus deodara     cone_shape           conic           conic
#> 4  Abies pindrow    growth_form            tree            tree
#> 5  Abies pindrow leaf_length_cm         3.0-6.0         3.1-5.8
#> 6  Abies pindrow   bark_texture        fissured          smooth
#>                         source_sentence    annotator       date           text
#> 1 Large evergreen tree up to 50 m tall. Aamna_Naveed 2026-06-06 Cedrus deodara
#> 2  Leaves needle-like, 2.5-5.0 cm long. Aamna_Naveed 2026-06-06 Cedrus deodara
#> 3      Cones ovoid-conic, 7-10 cm long. Aamna_Naveed 2026-06-06 Cedrus deodara
#> 4      Evergreen tree reaching 30-60 m. Aamna_Naveed 2026-06-06  Abies pindrow
#> 5       Leaves linear, 3.0-6.0 cm long. Aamna_Naveed 2026-06-06  Abies pindrow
#> 6      Bark dark gray, deeply fissured. Aamna_Naveed 2026-06-06  Abies pindrow
```
