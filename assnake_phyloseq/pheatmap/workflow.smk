rule plot_microbiome_heatmap:
    input:
        ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds'
    output:
        heatmap = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/heatmap_{heatmap_preset}.pdf'
    wildcard_constraints:    
        df="[^/]+",
        ft_name="[^/]+",
        sample_set="[^/]+"
    shell:
        """
        Rscript -e " \
        library(phyloseq); \
        library(pheatmap); \
        library(metasbmR); \
        ps_obj <- readRDS('{input.ps}'); \
        metasbmR::plot_microbiome_heatmap(ps_obj, \
                                         base_dir='{wildcards.fs_prefix}', \
                                         perform_clustering=as.logical('FALSE'), \
                                         filename='{output.heatmap}'); \
        "
        """