FROM debian:8.6

MAINTAINER Erwin Müller <erwin.mueller@nttdata.com>

# Configuration variables.
ENV DEBIAN_FRONTEND noninteractive
ENV COLLECTD_VERSION 5.4.1-6+deb8u1
ENV COLLECTD_CONFIG /mnt/collectd/collectd.conf

# Install collectd.
RUN set -x \
    && apt-get update --quiet \
    && apt-get install --quiet --yes \
        collectd=$COLLECTD_VERSION \
    # Collectd configuration directory.
    && mkdir -p /mnt/collectd \
    # Clean up.
    && apt-get autoclean \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/man/* \
    && rm -rf /usr/share/info/* \
    && rm -rf /var/cache/man/*

# Add files.
COPY docker-entrypoint.sh /usr/local/bin/
COPY collectd/collectd.conf /mnt/collectd/
COPY collectd/collectd.conf.d/filters.conf /mnt/collectd/collectd.conf.d/
COPY collectd/collectd.conf.d/thresholds.conf /mnt/collectd/collectd.conf.d/

# Collectd configuration directory.
VOLUME /mnt/collectd

# Collectd database.
VOLUME /var/lib/collectd

# Set entrypoint script.
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Run collectd.
CMD ["chroot", "/mnt", "collectd", "-C", "/collectd/collectd.conf", "-f"]

# Set default configuration.
RUN set -x \
    # Make sure entrypoint script is executable.
    && chmod +x /usr/local/bin/docker-entrypoint.sh

# Collectd working directory.
WORKDIR /mnt
