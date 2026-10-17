# Calculate Agreement and Overlap Between Two Annotation Sets

Calculate Agreement and Overlap Between Two Annotation Sets

## Usage

``` r
ta_audit_agreement(annotations_a, annotations_b)
```

## Arguments

- annotations_a:

  Data frame from Annotator A (must include trait, span_start,
  span_end).

- annotations_b:

  Data frame from Annotator B (must include trait, span_start,
  span_end).

## Value

A list containing matching statistics and agreement score.
