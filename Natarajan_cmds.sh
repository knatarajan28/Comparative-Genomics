mkdir -p ~/ex6/Raw_FastQs #create directory for storing downloaded files
cd ~/ex6/Raw_FastQs
for accession in SRR1993270 SRR1993271 SRR1993272 SRR2984947 SRR2985018 SRR3214715 SRR3215024 SRR3215107 SRR3215123 SRR3215124; do
  fasterq-dump \
   "${accession}" \
   --outdir . \
   --split-files \
   --skip-technical
done
pigz -9 *.fastq

#running fastp on each pair for quick read clean
fastp -i $HOME/ex6/Raw_FastQs/SRR1993270_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR1993270_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR1993270.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR1993270.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR1993270.json --html $HOME/ex6/Cleaned_FastQs/SRR1993270.html
fastp -i $HOME/ex6/Raw_FastQs/SRR1993271_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR1993271_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR1993271.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR1993271.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR1993271.json --html $HOME/ex6/Cleaned_FastQs/SRR1993271.html
fastp -i $HOME/ex6/Raw_FastQs/SRR1993272_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR1993272_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR1993272.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR1993272.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR1993272.json --html $HOME/ex6/Cleaned_FastQs/SRR1993272.html
fastp -i $HOME/ex6/Raw_FastQs/SRR2984947_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR2984947_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR2984947.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR2984947.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR2984947.json --html $HOME/ex6/Cleaned_FastQs/SRR2984947.html
fastp -i $HOME/ex6/Raw_FastQs/SRR2985018_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR2985018_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR2985018.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR2985018.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR2985018.json --html $HOME/ex6/Cleaned_FastQs/SRR2985018.html
fastp -i $HOME/ex6/Raw_FastQs/SRR3214715_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR3214715_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR3214715.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR3214715.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR3214715.json --html $HOME/ex6/Cleaned_FastQs/SRR3214715.html
fastp -i $HOME/ex6/Raw_FastQs/SRR3215024_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR3215024_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR3215024.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR3215024.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR3215024.json --html $HOME/ex6/Cleaned_FastQs/SRR3215024.html
fastp -i $HOME/ex6/Raw_FastQs/SRR3215107_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR3215107_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR3215107.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR3215107.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR3215107.json --html $HOME/ex6/Cleaned_FastQs/SRR3215107.html
fastp -i $HOME/ex6/Raw_FastQs/SRR3215123_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR3215123_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR3215123.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR3215123.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR3215123.json --html $HOME/ex6/Cleaned_FastQs/SRR3215123.html
fastp -i $HOME/ex6/Raw_FastQs/SRR3215124_1.fastq.gz -I $HOME/ex6/Raw_FastQs/SRR3215124_2.fastq.gz -o $HOME/ex6/Cleaned_FastQs/SRR3215124.R1.fq.gz -O $HOME/ex6/Cleaned_FastQs/SRR3215124.R2.fq.gz --json $HOME/ex6/Cleaned_FastQs/SRR3215124.json --html $HOME/ex6/Cleaned_FastQs/SRR3215124.html

# Create the assembly directory 
mkdir -p ~/ex6/Assemblies

# Define an array of sample names based on cleaned FastQ files
samples=(SRR1993270 SRR1993271 SRR1993272 SRR2984947 SRR2985018 SRR3214715 SRR3215024 SRR3215107 SRR3215123 SRR3215124)

# Loop through each sample, assembling one at a time
for sample in "${samples[@]}"; do
  echo "Assembling $sample..."
  skesa --reads /home/knatarajan37/ex6/Cleaned_FastQs/${sample}.R1.fq.gz,/home/knatarajan37/ex6/Cleaned_FastQs/${sample}.R2.fq.gz \
        --cores 2 \
        --min_contig 1000 \
        --max_kmer_count 200 \
        --contigs_out /home/knatarajan37/ex6/Assemblies/${sample}.fna --hash_count
  
  # After assembling check if the output file exists and its size to ensure the assembly was successful
  if [[ -s /home/knatarajan37/ex6/Assemblies/${sample}.fna ]]; then
    echo "$sample assembly completed successfully."
  else
    echo "$sample assembly failed or produced no output."
  fi
done

#create an environment for generating the phylogenetic tree
conda create -n harvestsuite -c bioconda parsnp harvesttools figtree -y
# run parSNP to generate the tree using SRR3214715 as the reference genome
parsnp  -d ~/ex6/Assemblies  -r SRR3214715.fna  -o ~/ex6/parsnp_part2  -p 4

# run figtree to generate image
figtree /home/knatarajan37/ex6/parsnp_outdir/parsnp.tree