name             'test_stunnel'
maintainer       'Aetrion, LLC.'
maintainer_email 'ops@dnsimple.com'
license          'Apache 2.0'
description      'Tests stunnel cookbook integration'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'stunnel'
depends 'nginx', '~> 2.7.6'
