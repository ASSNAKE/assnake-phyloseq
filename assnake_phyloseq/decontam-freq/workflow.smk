decontam_script = os.path.join(config['assnake-phyloseq']['install_dir'], 'decontam-freq/rscript.R')

rule decontam_freq:
    input:
        ps_decont = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/phyloseq.rds'
    output:
        contam_csv = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/decontam/results_{min_samples_prevalence_preset}_{filter_var_preset}_{filter_val_preset}.csv',
        contam_rds = '{fs_prefix}/{df}/feature_tables/{sample_set}/{ft_name}/{filter_chain}/decontam/results_{min_samples_prevalence_preset}_{filter_var_preset}_{filter_val_preset}.rds'
    params:
        min_samples_prevalence = '{min_samples_prevalence_preset}',
        min_reads = 100,
        filter_var = '{filter_var_preset}',
        filter_val = '{filter_val_preset}',
        decontam_script = decontam_script
    wildcard_constraints:
        df = "[^/]+",
        ft_name = "[^/]+",
        sample_set = "[^/]+",
        filter_var_preset = "[\w]+",
        filter_val_preset = "[\w]+",
        min_samples_prevalence_preset = "\d+",
        detection_preset = "\d+",
        min_reads_preset = "\d+"
    shell:
        """
        Rscript -e " \
        source('{params.decontam_script}'); \
        process_decontam_with_io('{input.ps_decont}', '{output.contam_csv}', '{output.contam_rds}', '{params.filter_var}', '{params.filter_val}', {params.min_samples_prevalence}, {params.min_reads}); \
        "
        """
