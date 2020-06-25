# docker-kraken v1.1.1

<a href="http://ccb.jhu.edu/software/kraken/"><img src="http://ccb.jhu.edu/software/kraken/kraken-logo-t.png" alt="Kraken" height="48px"/></a> docker image based on <a href="https://hub.docker.com/_/ubuntu"><img src="https://d1q6f0aelx0por.cloudfront.net/product-logos/library-ubuntu-logo.png" alt="Ubuntu" height="48px"/> Ubuntu 20.04</a>

ABOUT KRAKEN
---
Kraken is a system for assigning taxonomic labels to short DNA sequences, usually obtained through metagenomic studies. Previous attempts by other bioinformatics software to accomplish this task have often used sequence alignment or machine learning techniques that were quite slow, leading to the development of less sensitive but much faster abundance estimation programs. Kraken aims to achieve high sensitivity and high speed by utilizing exact alignments of k-mers and a novel classification algorithm.

## Base Image
 * [Ubuntu](https://hub.docker.com/_/ubuntu) ubuntu:20.04 LTS
  
## Installed
 * Kraken 1.1.1
 * MiniKraken DB (20171019_4GB)

## Settings
	
    VOLUME /data/
    WORKDIR /data/

## Running

    docker run -it -v $(pwd):/data infotechsoft/kraken
    # kraken --db ${KRAKEN_DB_VERSION} seqs.fa

# Maintainer 
<a href="http://www.infotechsoft.com">
<img src="http://infotechsoft.com/wp-content/uploads/2017/04/InfotechSoft_logo-small.png" alt="INFOTECH Soft"/>
</a>
