rule plot_detection_prevalence_heatmap:
    input:
        ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds'
    output:
        heatmap = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/detection_prevalence_heatmap_{heatmap_preset}.pdf'
    wildcard_constraints:
        df="[^/]+",
        ft_name="[^/]+",
        sample_set="[^/]+"
    shell:
        """
        Rscript -e " \
        library(phyloseq); \
        library(metasbm); \
        library(ggplot2); \
        ps_obj <- readRDS('{input.ps}'); \
        metasbm::plot_detection_prevalence_heatmap(ps_obj, \
                                                   filepath='{output.heatmap}'); \
        "
        """