save_permanova_results <- function(ps_filepath, results_rds, params_yaml_path, pdf_out_file) {
    params <- yaml::read_yaml(params_yaml_path)
    library(phyloseq)
    library(vegan)
    library(ggplot2)
    library(metasbmR)
    library(ggpubr)

    ps_obj <- readRDS(ps_filepath)
    result <- perform_permanova(ps_obj, formula=params$formula, transformation=params$transformation, method=params$method, show_plot=TRUE)

    # Save the results
    saveRDS(result[[1]], results_rds)
    ggsave(pdf_out_file, plot = result[[2]], device = "pdf")
}
