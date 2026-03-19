# stunnel_config

Manages the main stunnel configuration file.

## Actions

| Action    | Description                              |
|-----------|------------------------------------------|
| `:create` | Creates the configuration file (default) |
| `:delete` | Removes the configuration file           |

## Properties

| Property           | Type           | Default                                  | Description                    |
|--------------------|----------------|------------------------------------------|--------------------------------|
| `config_file`      | String         | `'/etc/stunnel/stunnel.conf'`            | Path to the configuration file |
| `ssl_version`      | String         | `'all'`                                  | SSL protocol version           |
| `ssl_options`      | String         |                                          | SSL options directive          |
| `ciphers`          | String         |                                          | Permitted SSL ciphers          |
| `certificate_path` | String         |                                          | Path to SSL certificate        |
| `key_path`         | String         |                                          | Path to SSL private key        |
| `use_chroot`       | true, false    | `false`                                  | Enable chroot jail             |
| `chroot_path`      | String         | `'/usr/var/lib/stunnel'`                 | Chroot directory path          |
| `pidfile`          | String         | `'/tmp/stunnel.pid'`                     | PID file path                  |
| `user`             | String         | `'root'`                                 | Run as user                    |
| `group`            | String         | `'root'`                                 | Run as group                   |
| `client_mode`      | true, false    | `true`                                   | Enable client mode             |
| `fips`             | true, false    |                                          | Enable FIPS mode               |
| `debug`            | Integer,String | `4`                                      | Debug level                    |
| `output`           | String         | `'/var/log/stunnel.log'`                 | Log output file                |
| `socket_tunings`   | Array          | `['l:TCP_NODELAY=1', 'r:TCP_NODELAY=1']` | Socket tuning options          |
| `compression`      | String         |                                          | Compression algorithm          |
| `config_options`   | Array          |                                          | Additional config options      |
| `services`         | Hash           | `{}`                                     | Inline service definitions     |
| `cookbook`         | String         | `'stunnel'`                              | Cookbook for template source   |

## Examples

### Basic client mode configuration

```ruby
stunnel_config 'default' do
  client_mode true
end
```

### Server mode with certificate

```ruby
stunnel_config 'default' do
  client_mode false
  certificate_path '/etc/stunnel/cert.pem'
  key_path '/etc/stunnel/key.pem'
end
```

### Custom SSL settings

```ruby
stunnel_config 'default' do
  ssl_version 'TLSv1.2'
  ciphers 'HIGH:!aNULL:!MD5'
  debug 7
  output '/var/log/stunnel/stunnel.log'
end
```
