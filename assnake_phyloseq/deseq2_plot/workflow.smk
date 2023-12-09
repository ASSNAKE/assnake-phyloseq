deseq2_script = os.path.join(config['assnake-phyloseq']['install_dir'], 'deseq2_plot/rscript.R')


rule deseq2_analysis:
    input:
        ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds',
        params_yaml = "{fs_prefix}/{df}/presets/deseq2_plot/{preset}.yaml"

    output:
        diagdds = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/deseq2_{preset}_diagdds.rds',
        sigtab = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/deseq2_{preset}_sigtab.csv',
        plot = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/deseq2_{preset}_plot.pdf',
        preset = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/deseq2_plot_{preset}.yaml'
    wildcard_constraints:
        df = "[^/]+",
        ft_name = "[^/]+",
        sample_set = "[^/]+",
    params:
        deseq2_script = deseq2_script
    shell:
        """
        cp {input.params_yaml} {output.preset}; \
        Rscript -e " \
        source('{params.deseq2_script}'); \
        save_deseq2_results('{input.ps}', '{output.diagdds}', '{input.params_yaml}', '{output.sigtab}', '{output.plot}'); "\
        """
