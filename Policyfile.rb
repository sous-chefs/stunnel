# frozen_string_literal: true

name 'stunnel'
default_source :supermarket

run_list 'test::default'

cookbook 'stunnel', path: '.'
cookbook 'test', path: './test/cookbooks/test'
