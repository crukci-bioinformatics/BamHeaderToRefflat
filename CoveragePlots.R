#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(tidyverse))

# Load coverage generated from Salmon alignment

readMetrSal <- function(fil){
    samNam <- basename(fil) %>% str_remove(".RNAseq_metrics.txt")
    read_tsv(fil, skip = 10, show_col_types = FALSE) %>%
        rename_with(str_replace, starts_with("All"), ".*", samNam)
}

salm <- list.files(pattern = ".*RNAseq_metrics.*") %>%
    map(readMetrSal) %>%
    reduce(full_join, by = "normalized_position") %>%
    rename(Position = "normalized_position") %>%
    pivot_longer(names_to = "Sample", values_to = "Coverage", -Position)

# Plot coverage 

salm %>% 
    ggplot(aes(x = Position, y = Coverage, group = Sample)) +
        geom_line(aes(colour = Sample))
ggsave("images/Coverage_plots.png", width=8.80, height=5)

