FROM grafana/grafana:7.1.5-ubuntu

# Disable Login form or not
ENV GF_AUTH_DISABLE_LOGIN_FORM "true"
# Allow anonymous authentication or not
ENV GF_AUTH_ANONYMOUS_ENABLED "true"
# Role of anonymous user
ENV GF_AUTH_ANONYMOUS_ORG_ROLE "Admin"
# Install plugins here our in your own config file
# ENV GF_INSTALL_PLUGINS="<list of plugins seperated by ,"

# Add provisioning
ADD ./provisioning /etc/grafana/provisioning
# Add configuration file
ADD ./grafana.ini /etc/grafana/grafana.ini
# Add dashboard json files
ADD ./dashboards /etc/grafana/dashboards
