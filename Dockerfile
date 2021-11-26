FROM densavchenko/heasoft:v6.28

USER root

RUN apt-get update \
    && apt-get -y install python3-astropy \
			python3-astroquery \
			python3-matplotlib \
			python3-pandas \
			python3-pip \
			python3-pyvo \
			python3-scipy \
			python3-ipykernel \
			python3-h5py \
			gosu \
			saods9 \
			vim \
			less \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*	
RUN sed -i 's/exec/exec \/usr\/bin\/env -u LD_LIBRARY_PATH/' /usr/bin/ds9
RUN pip install cython && pip install bxa

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
