# Attributes of cookbook

# Using attributes to set parameteres of cookbook
# attributes to be set for external cookbook
default['nodejs']['repo'] = 'https://deb.nodesource.com/node_8.x'
default['nodejs']['version'] = '8.11.2'

# Attributes to be set for intenal use
default['nginx']['proxy_port'] = 3000
