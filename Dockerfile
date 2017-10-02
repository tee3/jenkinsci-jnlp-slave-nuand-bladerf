FROM tee3/jenkinsci-jnlp-slave-boostcpp:0.0.1

LABEL maintainer="Thomas Brown <tabsoftwareconsulting@gmail.com>"

# set user for modifying image
USER root

RUN apt-get -q -y update && apt-get -q -y install \
    libusb-1.0-0 \
    libusb-1.0-0-dev \
    && rm -rf /var/lib/apt/lists/*

#RUN git clone --branch 2016.06 https://github.com/nuand/bladeRF ${HOME}/bladeRF
RUN git clone --branch master https://github.com/nuand/bladeRF ${HOME}/bladeRF
WORKDIR ${HOME}/bladeRF
RUN rm -rf build
RUN mkdir build
WORKDIR ${HOME}/bladeRF/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_DOCUMENTATION=OFF ..
RUN make install
RUN ldconfig

# restore user
USER jenkins
