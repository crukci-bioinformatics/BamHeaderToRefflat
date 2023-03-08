# README

This repository contains a simple python script that takes the header of a BAM file created by [Salmon](https://combine-lab.github.io/salmon/) (Patro et al., 2017) and generates
a [refFlat file](http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=1220235277_SJWvNhqI4wCU4FbY6LcxOLoaaC5l&hgta_doSchemaDb=macFas5&hgta_doSchemaTable=refFlat) based on the target
contigs (ignores "decoy" sequences if present). This refFlat file can then be
used in conjunction with the Picard tool
[CollectRnaSeqMetricx](https://broadinstitute.github.io/picard/command-line-overview.html#CollectRnaSeqMetrics)
in order to gather data required to a plot a normalised gene body coverage plot.

## Usage

samtools view -H  | 
    create_refflat_from_sam_header.py > references/GRCh38_tx_refflat.txt






Patro, R., Duggal, G., Love, M. I., Irizarry, R. A., & Kingsford, C. (2017).
Salmon provides fast and bias-aware quantification of transcript expression.
Nature Methods.
