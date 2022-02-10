#!/bin/bash

# generate shorted snoRNA list
awk '{if($0 ~ /^116/){print ">"$0}; else {n=(split($0, a, "")-11); for(i=16; i <= n; i++) printf a[i]; print ""}}' snoRNAs.txt > short_snoRNAs.fasta


# generating gene.bed
#awk -v OFS="\t" '{if ($0 ~ /\(\+\)/) {print $0, ".", ".", "+"; print $0, "." , ".", "-"} else {print $0, ".", ".", "-"; print $0, ".", ".", "+"}}' gene.bed > gene_tmp.bed
#awk -v OFS="\t" '{gsub("\(\+\):", "\t", $0); gsub("\(\-\):", "\t", $0); gsub("[0-9]-[0-9]", "\t", $0);  print $0}' gene_tmp.bed > gene_tmp2.bed
#awk -v FS="\t" -v OFS="\t" '{$2=$2-1000; $3=$3+1000; print $0}' gene_tmp2.bed > genes_final.bed
awk -v FS="\t" -v OFS="\t" 'NR>1 {print $2, $5-1000, $6+1000, $1"_"$7"_"$(8), $8, $3}' genes.tsv > genes.bed


# start Guugle
conda activate guugle
./guugle genes.fasta snoRNA.fasta -d 9 | gzip > guugle_genes_result.txt
