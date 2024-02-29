
rule filter_samples_by_depth:
    input:
        ps = get_previous_step_output
    output:
        filtered_ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}filter_samples_by_min_reads_{min_reads_preset}/phyloseq.rds'
    params:
        min_reads = '{min_reads_preset}',
    wildcard_constraints:    
        df="[\w\d_-]+",
        ft_name="[\w\d_-]+",
        sample_set="[\w\d_-]+",
        
        filter_chain=".*",
        min_reads_preset="\d+"
    shell:
        """
        Rscript -e " \
        library(metasbmR); \
        library(phyloseq); \
        ps_obj <- readRDS('{input.ps}'); \
        filtered_ps_obj <- metasbmR::filter_samples_by_depth(ps_obj, min_reads = as.numeric('{params.min_reads}')); \
        saveRDS(filtered_ps_obj, '{output.filtered_ps}'); \
        "
        """