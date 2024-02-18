#!/bin/bash

##Command to run this script:./task2.sh NC_000913.faa OR bash task2.sh NC_000913.faa

fasta=${1}


function __extract_proteinseqs()
{
    echo "Inside __extract_proteinseqs"
    echo "Extracting the sequences from the FASTA file"
    protein_seqs=$(awk '/^>/ { if (seq) { print seq }; printf("%s\t",$0); seq=""; } \
        !/^>/ { seq = seq $0 } END { print seq }' ${fasta})
}


function __compute_lengths()
{

    echo "Inside  __compute_lengths"
    if [[ ! -z $protein_seqs ]]; then
        echo "Computing the length of each protein sequence in ${fasta}...."
        lengths=$(echo "$protein_seqs" | awk -F '\t' '{ print length($2) }')
    else
        echo "The variable protein_seqs is empty"
    fi
}

function __compute_avglength()
{
    echo "Inside __compute_avglength"
    if [[ ! -z $lengths ]]; then
        echo "Computing the average length of the protein sequences"
        aminoacid_count=0
        seq_count=0
        for length in $lengths; do
            aminoacid_count=$((aminoacid_count + length))
            seq_count=$((seq_count + 1))
        done
    else
        echo "The variable lengths is empty"
    fi

    average_length=$((aminoacid_count / seq_count))

    echo "Total number of amino acids: $aminoacid_count"
    echo "Total number of sequences: $seq_count"
    echo "Average length of protein in MG1655 strain of E.coli: $average_length"
}


if [[ ! -z $fasta ]]; then
    __extract_proteinseqs
    __compute_lengths
    __compute_avglength
else
   echo "Input fastq is required"
fi
