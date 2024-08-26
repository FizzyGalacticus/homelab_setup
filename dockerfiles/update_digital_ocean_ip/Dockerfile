FROM alpine:3

ENV DIGITAL_OCEAN_TOKEN=""
ENV DIGITAL_OCEAN_DOMAIN=""
ENV DIGITAL_OCEAN_RECORD_ID=""
ENV DIGITAL_OCEAN_LOG_DIRECTORY=/data

# Needed for update_domain.sh
ENV LOG_FILE=/data/ip.log

# Install dependencies
RUN apk update
RUN apk add --no-cache curl bind-tools jq

# Copy script to the container
COPY update_domain.sh /opt/update_domain.sh

# Setup the cron job
RUN mkdir /etc/cron.d
RUN echo "* * * * * /bin/ash /opt/update_domain.sh > /var/log/cron" > /etc/cron.d/cron

# Give the permission
RUN chmod +x /opt/update_domain.sh
RUN chmod 0644 /etc/cron.d/cron

# Add the cron job
RUN crontab /etc/cron.d/cron

# Link cron log file to stdout
RUN ln -s /dev/stdout /var/log/cron

# Run the cron service in the foreground
CMD [ "crond", "-l", "2", "-f" ]