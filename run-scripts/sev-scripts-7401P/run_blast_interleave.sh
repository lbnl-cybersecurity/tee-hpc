sync; echo 1 > /proc/sys/vm/drop_caches
time numactl --interleave=0,1,2,3 /usr/bin/blastn -query scaffolds.trim.shred.fasta -db nt -evalue 1e-30 -perc_identity 90 -word_size 45 -task megablast -show_gis -dust yes -soft_masking true -num_alignments 5 -outfmt '6 qseqid sseqid bitscore evalue length pident qstart qend qlen sstart send slen staxids salltitles' -num_threads 24 > blast_interleave 2>&1 
