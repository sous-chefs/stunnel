# Change Log

## Unreleased

## 4.1.3 - *2023-02-14*

- Remove delivery folder

## 4.1.2 - *2021-08-31*

- Standardise files with files in sous-chefs/repo-management

## [v4.1.0](https://github.com/sous-chefs/chef-stunnel/tree/v4.1.0) (2020-02-20)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v4.0.0...v4.1.0)

### Add

- Add docs for stunnel cert / key path attributes [\#29](https://github.com/sous-chefs/chef-stunnel/pull/29) ([jhmartin](https://github.com/jhmartin))
- Adds the protocol option when creating a STunnel server [\#25](https://github.com/sous-chefs/chef-stunnel/pull/25) ([maraca](https://github.com/maraca))
- Support arbitrary options for tunnels [\#24](https://github.com/sous-chefs/chef-stunnel/pull/24) ([ssevertson](https://github.com/ssevertson))
- Resolved: ChefStyle/UnnecessaryPlatformCaseStatement cookstyle warning
- Migrated to Github Actions for testing

## [v4.0.0](https://github.com/sous-chefs/chef-stunnel/tree/v4.0.0)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v3.1.1...v4.0.0)

### Add

- Add CircleCI testing [\#46](https://github.com/sous-chefs/chef-stunnel/pull/46) ([damacus](https://github.com/damacus))

## [v3.1.1](https://github.com/sous-chefs/chef-stunnel/tree/v3.1.1) (2018-10-23)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v3.1.0...v3.1.1)

**Merged pull requests:**

- Add in deprecation warnings for Chef 12 removal [\#44](https://github.com/sous-chefs/chef-stunnel/pull/44) ([martinisoft](https://github.com/martinisoft))
- Update Copyright [\#43](https://github.com/sous-chefs/chef-stunnel/pull/43) ([onlyhavecans](https://github.com/onlyhavecans))

## [v3.1.0](https://github.com/sous-chefs/chef-stunnel/tree/v3.1.0) (2017-11-08)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v3.0.0...v3.1.0)

**Merged pull requests:**

- Testing to chef 13 [\#42](https://github.com/sous-chefs/chef-stunnel/pull/42) ([onlyhavecans](https://github.com/onlyhavecans))
- Add key and verifyChain connection options [\#40](https://github.com/sous-chefs/chef-stunnel/pull/40) ([mitch-roblox](https://github.com/mitch-roblox))

## [v3.0.0](https://github.com/sous-chefs/chef-stunnel/tree/v3.0.0) (2017-09-06)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v2.3.0...v3.0.0)

**Implemented enhancements:**

- Convert to Chef 12.6+ Custom Resource [\#41](https://github.com/sous-chefs/chef-stunnel/pull/41) ([martinisoft](https://github.com/martinisoft))

**Merged pull requests:**

- Remove 'supports { manage\_home: true }' [\#39](https://github.com/sous-chefs/chef-stunnel/pull/39) ([RavWar](https://github.com/RavWar))
- Add FIPS configuration option [\#37](https://github.com/sous-chefs/chef-stunnel/pull/37) ([mitch-roblox](https://github.com/mitch-roblox))

## [v2.3.0](https://github.com/sous-chefs/chef-stunnel/tree/v2.3.0) (2016-11-23)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v2.2.0...v2.3.0)

**Merged pull requests:**

- Add a ulimit setting, added to init script if not nil [\#36](https://github.com/sous-chefs/chef-stunnel/pull/36) ([onlyhavecans](https://github.com/onlyhavecans))

## [v2.2.0](https://github.com/sous-chefs/chef-stunnel/tree/v2.2.0) (2016-11-15)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v2.1.0...v2.2.0)

**Implemented enhancements:**

- Lower the precedence of services node attributes [\#31](https://github.com/sous-chefs/chef-stunnel/pull/31) ([martinisoft](https://github.com/martinisoft))
- Expose SSL ciphers option [\#23](https://github.com/sous-chefs/chef-stunnel/pull/23) ([thoutenbos](https://github.com/thoutenbos))
- Source install [\#22](https://github.com/sous-chefs/chef-stunnel/pull/22) ([thoutenbos](https://github.com/thoutenbos))

**Closed issues:**

- Latest version 0.2.5 should be version 2.0.5 [\#16](https://github.com/sous-chefs/chef-stunnel/issues/16)

**Merged pull requests:**

- Replacing restart on the configuration for reload  [\#35](https://github.com/sous-chefs/chef-stunnel/pull/35) ([therobot](https://github.com/therobot))
- Modernize cookbook [\#30](https://github.com/sous-chefs/chef-stunnel/pull/30) ([martinisoft](https://github.com/martinisoft))
- Add basic ChefSpec matchers [\#20](https://github.com/sous-chefs/chef-stunnel/pull/20) ([jeffbyrnes](https://github.com/jeffbyrnes))
- Feature/log warnings [\#9](https://github.com/sous-chefs/chef-stunnel/pull/9) ([dje](https://github.com/dje))

## [v2.1.0](https://github.com/sous-chefs/chef-stunnel/tree/v2.1.0) (2014-04-11)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v2.0.4...v2.1.0)

**Merged pull requests:**

- Added CAfile, cert, verify \(eg. 1, 2, 3\) to stunnel\_connection resource [\#18](https://github.com/sous-chefs/chef-stunnel/pull/18) ([portertech](https://github.com/portertech))
- Add override for client\_mode option per connection [\#12](https://github.com/sous-chefs/chef-stunnel/pull/12) ([autrejacoupa](https://github.com/autrejacoupa))

## [v2.0.4](https://github.com/sous-chefs/chef-stunnel/tree/v2.0.4) (2013-06-19)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v2.0.2...v2.0.4)

**Merged pull requests:**

- Make the config Chef 11 compatible [\#10](https://github.com/sous-chefs/chef-stunnel/pull/10) ([mzsanford](https://github.com/mzsanford))

## [v2.0.2](https://github.com/sous-chefs/chef-stunnel/tree/v2.0.2) (2013-03-27)

[Full Changelog](https://github.com/sous-chefs/chef-stunnel/compare/v2.0.0...v2.0.2)

## [v2.0.0](https://github.com/sous-chefs/chef-stunnel/tree/v2.0.0) (2012-12-29)

**Merged pull requests:**

- A few improvements: [\#1](https://github.com/sous-chefs/chef-stunnel/pull/1) ([freerobby](https://github.com/freerobby))

\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
