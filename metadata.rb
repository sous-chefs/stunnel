name             'stunnel' # ~FC121
maintainer       'DNSimple Corp'
maintainer_email 'ops@dnsimple.com'
license          'Apache-2.0'
description      'Provides resources to help install and configure stunnel'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/aetrion/chef-stunnel'
issues_url       'https://github.com/aetrion/chef-stunnel/issues'
version          '3.1.1'

chef_version '>= 12.6' if respond_to?(:chef_version)
supports 'ubuntu'
supports 'centos'

depends 'build-essential'
