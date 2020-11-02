## makes a container with Strelka installed plus bcftools and samtools as utilities
FROM fredhutch/bcftools:1.9


RUN apt-get update -y && apt-get install -y curl build-essential bzip2 gcc g++ make python zlib1g-dev wget libncurses5-dev

RUN curl -LO https://github.com/Illumina/strelka/archive/v2.9.10.tar.gz

RUN tar zxf v2.9.10.tar.gz

WORKDIR /strelka-2.9.10

RUN mkdir build

WORKDIR /strelka-2.9.10/build

RUN ../configure --jobs=4 && make -j4 install

WORKDIR /

RUN rm -rf strelka-2.9.10 v2.9.10.tar.gz

## Install samtools 1.10
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
	tar jxf samtools-1.10.tar.bz2 && \
	rm samtools-1.10.tar.bz2 && \
	cd samtools-1.10 && \
	make 
ENV PATH=${PATH}:/samtools-1.10

