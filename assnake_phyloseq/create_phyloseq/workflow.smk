rule create_phyloseq:
    input: 
        seqtab = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/asv_table.rds',
        taxa   = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/taxa.rds'
    output: 
        ps     = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/phyloseq.rds'
    wildcard_constraints:    
        df="[\w\d_-]+",
        ft_name="[\w\d_-]+",
        sample_set="[\w\d_-]+",
    conda: '../phyloseq.yaml'

    shell:
        """
        Rscript -e " \
        library(phyloseq); \
        asv_table <- readRDS('{input.seqtab}'); \
        taxa_data <- readRDS('{input.taxa}'); \
        ps <- phyloseq(otu_table(asv_table, taxa_are_rows = FALSE), tax_table(taxa_data)); \
        saveRDS(ps, '{output.ps}'); \
        "
        """