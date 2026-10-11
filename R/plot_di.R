#' Plot Pairwise Diagnosability Index Heatmap
#' @param batch_results Data frame resulting from batch pairwise audits.
#' @return A ggplot object.
#' @export
ta_plot_heatmap <- function(batch_results) {
  if (!requireNamespace('ggplot2', quietly = TRUE)) {
    stop('Package "ggplot2" is required for plotting. Please install it.')
  }
  ggplot2::ggplot(batch_results, ggplot2::aes(x = Taxon_1, y = Taxon_2, fill = DI_Score)) +
    ggplot2::geom_tile(color = 'white') +
    ggplot2::scale_fill_gradient(low = '#fee08b', high = '#3288bd', limits = c(0, 1)) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(angle = 45, hjust = 1),
      panel.grid = ggplot2::element_blank()
    ) +
    ggplot2::labs(
      title = 'Taxonomic Diagnosability Index Heatmap',
      subtitle = 'Pairwise morphological distinctness across Flora of Pakistan taxa',
      x = 'Taxon 1',
      y = 'Taxon 2',
      fill = 'DI Score'
    )
}
