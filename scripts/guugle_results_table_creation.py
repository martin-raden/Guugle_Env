import re
import sys
import gzip


file = gzip.open("/home/florian/Documents/github/Guugle_Env/guugle_genes_result.txt.gz", "rt")
outfile = gzip.open("/home/florian/Documents/github/Guugle_Env/guugle_genes_result.tsv.gz", "wt")

outfile.write("Gene_ID\tExon\tImprint\tChr\tStart\tStop\tStrand\tGene_Motif_At\tGene_Motif_Start\tGene_Motif_Stop\tSnoRNA_ID\tChr\tStart\tStop\tStrand\tSnoRNA_Motif_At\tSnoRNA_Motif_Start\tSnoRNA_Motif_Stop\tMotif_Length\n")

for line in file:
    if(re.match("MatchLength", line)):
        line = line.strip("\n")
        v = line.split(" ")
        gene_stuff = v[3].replace("\"","").replace("_", "\t")
        gene_coords = v[2].replace("\"", "").replace("hg38|", "").replace("|", "\t")
        snoRNA_id = v[7].replace("\"","")
        snoRNA_coords_tmp = v[8].replace("\"","").replace("(", "-").replace("):", "-").split("-")
        snoRNA_coords = "{}\t{}\t{}\t{}".format(snoRNA_coords_tmp[0], snoRNA_coords_tmp[2], snoRNA_coords_tmp[3], snoRNA_coords_tmp[1])

        m_s_gene = int(gene_coords.split("\t")[1]) + int(v[5])
        m_e_gene = int(gene_coords.split("\t")[1]) + int(v[5]) + int(v[1])

        m_s_snoRNA = int(snoRNA_coords_tmp[2]) + int(v[10])
        m_e_snoRNA = int(snoRNA_coords_tmp[2]) + int(v[10]) + int(v[1])

        outfile.write("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\n".format(gene_stuff, gene_coords, v[5], str(m_s_gene), str(m_e_gene), snoRNA_id, snoRNA_coords, v[10], str(m_s_snoRNA), str(m_e_snoRNA), v[1]))

file.close()
outfile.close()