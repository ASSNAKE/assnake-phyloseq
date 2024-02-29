save_deseq2_results <- function(ps_filepath, dds_out_file, params_yaml_path, sigtab_out_file, pdf_out_file) {
    params <- yaml::read_yaml(params_yaml_path)
    params

    library(phyloseq)
    library(DESeq2)
    library(ggplot2)
    library(ggpubr)
    library(metasbmR)


    ps_obj <- readRDS(ps_filepath)


    results <- plot_deseq2(
        ps_obj, 
        formula=params$formula, 
        contrast=c(params$contrast_condition, params$contrast_level1, params$contrast_level2), 
        alpha=params$alpha, 
        minlfc=params$minlfc
    )

    # Save the results
    saveRDS(results[[1]], dds_out_file)
    write.csv(results[[2]], sigtab_out_file, row.names = FALSE)
    ggsave(pdf_out_file, plot = results[[3]], device = "pdf")
}
