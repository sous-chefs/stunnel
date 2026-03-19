# stunnel_service

Manages the stunnel systemd service unit.

## Actions

| Action    | Description                                       |
|-----------|---------------------------------------------------|
| `:create` | Creates, enables, and starts the service (default)|
| `:delete` | Stops, disables, and removes the service          |

## Properties

| Property       | Type   | Default                       | Description                      |
|----------------|--------|-------------------------------|----------------------------------|
| `service_name` | String | name property                 | Name of the systemd service unit |
| `config_file`  | String | `'/etc/stunnel/stunnel.conf'` | Path to stunnel config file      |

## Examples

### Basic usage

```ruby
stunnel_service 'stunnel'
```

### Custom service name and config

```ruby
stunnel_service 'my-tunnel' do
  config_file '/etc/stunnel/custom.conf'
end
```

### Remove a service

```ruby
stunnel_service 'stunnel' do
  action :delete
end
```
