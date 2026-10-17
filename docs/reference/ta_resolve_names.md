# Resolve and Standardize Taxonomic Names

Resolve and Standardize Taxonomic Names

## Usage

``` r
ta_resolve_names(taxon_names, synonym_db = NULL)
```

## Arguments

- taxon_names:

  Character vector of taxon names to resolve.

- synonym_db:

  Optional data frame containing 'Synonym' and 'Accepted' columns. If
  NULL, uses built-in default mappings.

## Value

A data frame containing original names, resolved accepted names, and
resolution status.
