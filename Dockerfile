FROM ubuntu:latest
WORKDIR /root

ENV rMATS=rMATS.4.0.2
RUN apt-get update \
        && software='libblas-dev liblapack-dev libgsl0-dev gfortran samtools wget' \
        && del='' \
        && apt-get install -y $software \
        && wget https://bootstrap.pypa.io/get-pip.py \
        && python get-pip.py \
        && pip install numpy \
        && pip install scipy \
        && wget https://github.com/alexdobin/STAR/archive/2.5.3a.tar.gz \
        && tar -zxvf 2.5.3a.tar.gz \
        && mv /root/STAR-2.5.3a/bin/Linux_x86_64_static/* /usr/local/bin/ \
        && wget https://sourceforge.net/projects/rnaseq-mats/files/MATS/${rMATS}.tgz \
        && tar -zxvf ${rMATS}.tgz \
        && wget https://sourceforge.net/projects/rnaseq-mats/files/MATS/testData.tgz \
        && tar -zxvf testData.tgz \
        && rm -rf 2.5.3a.tar.gz \
        && rm -rf STAR-2.5.3a \
        && rm -rf testData* \
        && rm ${rMATS}.tgz \
        && rm get-pip.py \
        && rm -rf /var/lib/apt/lists/*
RUN mv */*UCS4/* .
RUN rm -rf ${rMATS}

ENV file=rmats.py
RUN chmod 777 ${file}
RUN ln -s ${file} RNASeq-MATS.py

ENV PATH="${PATH}:/root"
