permanova_script = os.path.join(config['assnake-phyloseq']['install_dir'], 'permanova_plot/rscript.R')

rule permanova_analysis:
    input:
        ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds',
        params_yaml = "{fs_prefix}/{df}/presets/permanova_plot/{preset}.yaml"
    output:
        results_rds = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/permanova_{preset}_results.rds',
        plot = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/permanova_{preset}_plot.pdf',
        preset = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/permanova_plot_{preset}.yaml'
    wildcard_constraints:
        df = "[^/]+",
        ft_name = "[^/]+",
        sample_set = "[^/]+",
    params:
        permanova_script = permanova_script
    shell:
        """
        cp {input.params_yaml} {output.preset}; \
        Rscript -e " \
        source('{params.permanova_script}'); \
        save_permanova_results('{input.ps}', '{output.results_rds}', '{input.params_yaml}', '{output.plot}'); "\
        """
