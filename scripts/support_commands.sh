#!/bin/bash

# generate shorted snoRNA list
awk '$0 !~ /^116/ {n=(split($0, a, "")-11); for(i=16; i <= n; i++) printf a[i]; print ""}' snoRNAs.txt > short_snoRNAs.txt


# generating gene.bed
awk -v OFS="\t" '{if ($0 ~ /\(\+\)/) {print $0, ".", ".", "+"; print $0, "." , ".", "-"} else {print $0, ".", ".", "-"; print $0, ".", ".", "+"}}' gene.bed > gene_tmp.bed
awk -v OFS="\t" '{gsub("\(\+\):", "\t", $0); gsub("\(\-\):", "\t", $0); gsub("[0-9]-[0-9]", "\t", $0);  print $0}' gene_tmp.bed > gene_tmp2.bed
awk -v FS="\t" -v OFS="\t" '{$2=$2-1000; $3=$3+1000; print $0}' gene_tmp2.bed > genes_final.bed
