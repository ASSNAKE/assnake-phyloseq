plot_ordination_script = os.path.join(config['assnake-phyloseq']['install_dir'], 'ordination_plot/rscript.R')

rule plot_ordination:
    input:
        ps = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds'
    output:
        pdf = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/ordination_plot_color{color_feature_preset}_tax{max_taxa_preset}_rank{rank_preset}_w{pdf_width_preset}_h{pdf_height_preset}.pdf'
    wildcard_constraints:
        df = "[^/]+",
        ft_name = "[^/]+",
        sample_set = "[^/]+",
        color_feature_preset = "[\w]+",
        max_taxa_preset = "\d+",
        rank_preset = "[\w]+",
        pdf_width_preset = "\d+",
        pdf_height_preset = "\d+"
    params:
        plot_ordination_script = plot_ordination_script
    shell:
        """
        Rscript -e " \
        source('{params.plot_ordination_script}'); \
        plot_ordination('{input.ps}', '{output.pdf}', '{wildcards.color_feature_preset}', {wildcards.max_taxa_preset}, '{wildcards.rank_preset}', {wildcards.pdf_width_preset}, {wildcards.pdf_height_preset}); \
        "
        """
