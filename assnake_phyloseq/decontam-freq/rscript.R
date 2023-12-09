library(phyloseq)
library(decontam)
library(dplyr)
library(microbiome)

process_decontam_with_io <- function(input_path, output_csv_path, output_rds_path, filter_var, filter_val, min_samples_prevalence, min_reads) {
    # Read the Phyloseq object
    ps_obj_decont <- readRDS(input_path)

    # Process decontamination
    results <- process_decontam(ps_obj_decont, filter_var, filter_val, min_samples_prevalence, min_reads)

    # Write the results to CSV and RDS
    write.csv(results$data, output_csv_path, row.names = FALSE)
    saveRDS(results$full_out, output_rds_path)
}


process_decontam <- function(ps_obj_decont, filter_var, filter_val, min_samples_prevalence, min_reads) {

    # Error handling: Check if filter_var exists in the sample data
    if (!filter_var %in% names(sample_data(ps_obj_decont))) {
        stop(paste("Error: filter_var", filter_var, "not found in sample data."))
    }

    # Subset samples based on the specified variable and value
    sample_meta <- sample_data(ps_obj_decont)
    selected_samples <- sample_meta[[filter_var]] == filter_val
    ps_obj <- prune_samples(selected_samples, ps_obj_decont)

    # Error handling: Check if any samples remain after subsetting
    if (nsamples(ps_obj) == 0) {
        stop(paste("Error: No samples found with", filter_var, "=", filter_val))
    }

    prevalence <- min_samples_prevalence / nsamples(ps_obj)
    taxas <- core_members(ps_obj, detection = 1, prevalence = prevalence)
    ps_obj <- prune_taxa(taxas, ps_obj)
    ps_obj <- prune_samples(sample_sums(ps_obj) > min_reads, ps_obj)


    ps_meta <- as(sample_data(ps_obj), 'data.frame')
    with_conc <- rownames(ps_meta[!is.na(ps_meta$concentration),])
    ps_obj <- prune_samples(with_conc, ps_obj)


    ps_meta <- as(sample_data(ps_obj), 'data.frame')
    ps_obj@sam_data$concentration <- as.numeric(ps_meta$concentration )

    # Error handling: Check if any taxa remain after pruning
    if (ntaxa(ps_obj) == 0) {
        stop("Error: No taxa remain after pruning.")
    }

    contamdf.freq.full <- isContaminant(ps_obj, method = "freq", conc = "concentration", normalize = TRUE)
    contamdf.freq <- contamdf.freq.full[, c('contaminant', 'p'), drop = FALSE]
    colnames(contamdf.freq) <- c(paste0('contaminant_', filter_val), paste0('p_', filter_val))
    
    return(list(data = contamdf.freq, full_out = contamdf.freq.full))
}
