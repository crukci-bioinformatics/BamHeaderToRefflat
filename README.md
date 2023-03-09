# README

This repository contains a simple python script that takes the header of a BAM file created by [Salmon](https://combine-lab.github.io/salmon/) (Patro et al., 2017) and generates
a [refFlat file](http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=1220235277_SJWvNhqI4wCU4FbY6LcxOLoaaC5l&hgta_doSchemaDb=macFas5&hgta_doSchemaTable=refFlat) based on the target
contigs (ignores "decoy" sequences if present). This refFlat file can then be
used in conjunction with the Picard tool
[CollectRnaSeqMetricx](https://broadinstitute.github.io/picard/command-line-overview.html#CollectRnaSeqMetrics)
in order to gather data required to a plot a normalised gene body coverage plot.

## Usage

```
create_refflat_from_sam_header.py -b <BamFile> -o <OutputFile>
```

There are two example bam files in **example_data**. One is from a good quality
library and the other from a library with severe RNA degradation.

To test the script:

```
create_refflat_from_sam_header.py \
    -b test_data/Good_Sample.bam \
    -o refFlat.txt
```

We can then use this refFlat file in conjunction with Picard's
`CollectRnaSeqMetrics` to generate data for a gene body coverage plot:

```
java -jar picard.jar CollectRnaSeqMetrics \
    INPUT=test_data/Good_Sample.bam \
    OUTPUT=Good_Sample.RNAseq_metrics.txt \
    REF_FLAT=refFlat.txt \
    STRAND=NONE
java -jar picard.jar CollectRnaSeqMetrics \
    INPUT=test_data/Degraded_Sample.bam \
    OUTPUT=Degraded_Sample.RNAseq_metrics.txt \
    REF_FLAT=refFlat.txt \
    STRAND=NONE
```

From these we can generate coverage plots for our two samples using an
R script.

```
CoveragePlots.R
```

This should generate the file "images/Coverage_plots.png" with the following
plot:

[](images/Coverage_plots.png)

The coverage traces generated are not a smooth as we normally expect as the two 
example bam files have been downsampled to just 1.5-1.8 million reads, so that
they are small enough to include in the repository. The plot below shows the 
results of the same analysis, but this time using the full data set from which 
the example bams were derived.

[](images/Coverage_plots.full_data.png)







Patro, R., Duggal, G., Love, M. I., Irizarry, R. A., & Kingsford, C. (2017).
Salmon provides fast and bias-aware quantification of transcript expression.
Nature Methods.
