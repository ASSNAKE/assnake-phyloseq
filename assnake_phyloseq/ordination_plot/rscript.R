plot_ordination <- function(filepath, output_pdf, color_feature = "batch_x", max_taxa = 30, rank = "Species", pdf_width = 8, pdf_height = 6) {
  library(phyloseq)
  library(microViz)
  library(ggplot2)
  
  ps_obj <- readRDS(filepath)

  ps_obj <- ps_obj %>%
    tax_fix(
      min_length = 1,
      unknowns = c("Catenibacterium", "Lawsonibacter"),
      sep = " ", anon_unique = TRUE,
      suffix_rank = "current"
    )

  my_colors <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", 
                 "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf",
                 "#1a55FF", "#e0b352")

  # Convert 'ASV' to R's NA
  if (rank == 'ASV') {
      rank <- NA
  }

  p <- ps_obj %>%
    tax_transform("clr", rank = rank) %>%
    ord_calc(method = "PCA") %>%
    ord_plot(color = color_feature, size = 2, plot_taxa = 1:max_taxa) +
    scale_colour_manual(values = my_colors)

  ggsave(output_pdf, plot = p, device = "pdf", width = pdf_width, height = pdf_height)
}
