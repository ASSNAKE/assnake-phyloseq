


rule filter_taxa:
    input:
        ps = get_previous_step_output
    output:
        filtered_ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/step{step_num}_filter_taxa_by_detection_{detection_preset}_prevalence_{prevalence_preset}/phyloseq.rds'
    params:
        detection = '{detection_preset}',
        prevalence = '{prevalence_preset}',
    wildcard_constraints:    
        df="[\w\d_-]+",
        ft_name="[\w\d_-]+",
        sample_set="[\w\d_-]+",
        step_num="\d+",
        detection_preset="\d+",
        prevalence_preset="[^/]+"
    shell:
        """
        Rscript -e " \
        library(metasbm); \
        library(phyloseq); \
        library(microbiome); \
        ps_obj <- readRDS('{input.ps}'); \
        filtered_ps_obj <- metasbm::filter_taxa(ps_obj, detection = as.numeric('{params.detection}'), prevalence = as.numeric('{params.prevalence}')); \
        saveRDS(filtered_ps_obj, '{output.filtered_ps}'); \
        "
        """