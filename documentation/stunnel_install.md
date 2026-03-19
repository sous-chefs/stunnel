# stunnel_install

Installs stunnel via package manager or from source.

## Actions

| Action    | Description                           |
|-----------|---------------------------------------|
| `:create` | Installs stunnel (default)            |
| `:delete` | Removes stunnel packages and symlinks |

## Properties

| Property            | Type   | Default                                                     | Description                           |
|---------------------|--------|-------------------------------------------------------------|---------------------------------------|
| `install_method`    | String | `'package'`                                                 | Install method: `package` or `source` |
| `packages`          | Array  | `['stunnel4']` (Debian) / `['stunnel']` (RHEL)              | Packages to install                   |
| `source_url`        | String | `'https://www.stunnel.org/archive/4.x/stunnel-4.56.tar.gz'` | Source tarball URL                    |
| `source_checksum`   | String | *(SHA256 of default tarball)*                               | Checksum for source tarball           |
| `ssl_devel_package` | String | `'libssl-dev'` (Debian) / `'openssl-devel'` (RHEL)          | SSL development package               |

## Examples

### Package install (default)

```ruby
stunnel_install 'default'
```

### Source install

```ruby
stunnel_install 'default' do
  install_method 'source'
  source_url 'https://www.stunnel.org/archive/4.x/stunnel-4.56.tar.gz'
end
```

### Remove stunnel

```ruby
stunnel_install 'default' do
  action :delete
end
```
