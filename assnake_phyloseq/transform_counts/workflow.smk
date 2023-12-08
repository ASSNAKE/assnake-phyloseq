rule transform_counts:
    input:
        ps = get_previous_step_output
    output:
        transformed_ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}transform_{transformation_preset}/phyloseq.rds'
    params:
        transformation_method = '{transformation_preset}'
    wildcard_constraints:    
        df="[\w\d_-]+",
        ft_name="[\w\d_-]+",
        sample_set="[\w\d_-]+",
        step_num="\d+",
        transformation_method="[^/]+",
        filter_chain=".*"
    shell:
        """
        Rscript -e " \
        library(microbiome); \
        library(phyloseq); \
        ps_obj <- readRDS('{input.ps}'); \
        transformed_ps_obj <- microbiome::transform(ps_obj, '{params.transformation_method}'); \
        saveRDS(transformed_ps_obj, '{output.transformed_ps}'); \
        "
        """
