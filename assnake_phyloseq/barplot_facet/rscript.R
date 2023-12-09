library(phyloseq)
library(dplyr)

filter_phyloseq_by_sample_count <- function(ps_obj, facet_variable, min_sample_count = 3) {
  # Extract metadata
  meta <- as(sample_data(ps_obj), 'data.frame')
    meta$SampleID <- rownames(sample_data(ps_obj))

    # Identify groups with more than min_sample_count samples
    valid_samples <- meta %>%
        group_by(!!sym(facet_variable)) %>%
        filter(n() >= min_sample_count) %>%
        pull(SampleID)

    # Filter the phyloseq object to include only the selected samples
    filtered_ps_obj <- prune_samples(valid_samples, ps_obj)
  print(filtered_ps_obj)

  return(filtered_ps_obj)
}


plot_bar_facet_v0 <- function(filepath, output_pdf, n_taxa = 20, tax_level = "Genus", facet_variable = "batch_x", pdf_width = 300, pdf_height = 135) {
  library(phyloseq)
  library(ggplot2)
  library(dplyr)
  library(stringr)
  library(microViz)

  ps_obj <- readRDS(filepath)
  ps_obj <- filter_phyloseq_by_sample_count(ps_obj, facet_variable)

  ps_obj <- ps_obj %>%
    tax_fix(
      min_length = 3,
      unknowns = c("NA", "gingivalis", "haemolyticus", "oralis", "oris", "sputigena"),
      sep = " ", anon_unique = TRUE,
      suffix_rank = "classified"
    )

  p <- ps_obj %>%
    comp_barplot(
      tax_level = tax_level, 
      n_taxa = n_taxa, 
      other_name = "Other", 
      order_with_all_taxa = TRUE,
      sample_order = "bray",
      taxon_renamer = function(x) stringr::str_remove(x, " [ae]t rel."),
      palette = distinct_palette(n = n_taxa, add = "grey90"),
      merge_other = FALSE, 
      bar_outline_colour = NA,
      bar_width = 1
    ) +
    labs(y = NULL, x =NULL) +
    facet_wrap(facet_variable, nrow = 4, scales = "free") +
    theme(
      axis.text.y = element_blank(), 
      axis.ticks.y = element_blank(),
      axis.text.x = element_text(angle = 75, hjust = 1)
    )

  ggsave(output_pdf, plot = p, device = "pdf", width = pdf_width, height = pdf_height, limitsize = FALSE)
}
