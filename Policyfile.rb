# frozen_string_literal: true

name 'stunnel'
default_source :supermarket

run_list 'test::default'

named_run_list :certificates, 'test::certificates'
named_run_list :source, 'test::source'

cookbook 'stunnel', path: '.'
cookbook 'test', path: './test/cookbooks/test'
