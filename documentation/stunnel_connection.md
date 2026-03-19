# stunnel_connection

Manages individual stunnel service connection configurations as separate files
in a configuration directory.

## Actions

| Action    | Description                                    |
|-----------|------------------------------------------------|
| `:create` | Creates the connection config file (default)   |
| `:delete` | Removes the connection config file             |

## Properties

| Property        | Type           | Default                | Description                           |
|-----------------|----------------|------------------------|---------------------------------------|
| `service_name`  | String         | name property          | Connection name and config file name  |
| `connect`       | String,Integer | **required**           | Backend service address/port          |
| `accept`        | String,Integer | **required**           | Frontend listen address/port          |
| `cafile`        | String         |                        | Path to CA certificate file           |
| `cert`          | String         |                        | Path to certificate file              |
| `key`           | String         |                        | Path to private key file              |
| `verify`        | Integer        |                        | Certificate verification level        |
| `verify_chain`  | true, false    |                        | Verify certificate chain              |
| `timeout_close` | true, false    |                        | Enable close timeout                  |
| `client`        | true, false    |                        | Client mode for this connection       |
| `protocol`      | String         |                        | Application protocol negotiation      |
| `options`       | Hash           |                        | Additional key-value options          |
| `config_file`   | String         | `'/etc/stunnel/conf.d'`| Directory for connection config files |

## Examples

### Basic server tunnel

```ruby
stunnel_connection 'redis' do
  accept 6380
  connect '10.0.0.1:6379'
end
```

### Client tunnel with certificates

```ruby
stunnel_connection 'redis-client' do
  accept '127.0.0.1:6380'
  connect 'redis.example.com:6379'
  client true
  cafile '/etc/ssl/certs/ca.pem'
  cert '/etc/ssl/certs/client.pem'
  key '/etc/ssl/private/client.key'
  verify 2
end
```

### Remove a connection

```ruby
stunnel_connection 'redis' do
  connect '10.0.0.1:6379'
  accept 6380
  action :delete
end
```
