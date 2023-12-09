
plot_bar_facet_v0_script = os.path.join(config['assnake-phyloseq']['install_dir'], 'barplot_facet/rscript.R')

rule plot_bar_facet_v0:
    input:
        ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds'
    output:
        pdf = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/bar_facet_v0_tax{tax_level_preset}_n{n_taxa_preset}_facet{facet_variable_preset}_w{pdf_width_preset}_h{pdf_height_preset}.pdf'
    wildcard_constraints:
        df = "[^/]+",
        ft_name = "[^/]+",
        sample_set = "[^/]+",
        tax_level_preset = "[\w]+",
        n_taxa_preset = "\d+",
        facet_variable_preset = "[\w]+",
        pdf_width_preset = "\d+",
        pdf_height_preset = "\d+"
    params:
        plot_bar_facet_v0_script = plot_bar_facet_v0_script
    shell:
        """
        Rscript -e " \
        source('{params.plot_bar_facet_v0_script}'); \
        plot_bar_facet_v0('{input.ps}', '{output.pdf}', {wildcards.n_taxa_preset}, '{wildcards.tax_level_preset}', '{wildcards.facet_variable_preset}', {wildcards.pdf_width_preset}, {wildcards.pdf_height_preset}); \
        "
        """

