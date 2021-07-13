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
			gosu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*	
RUN pip install cython && pip install bxa

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
