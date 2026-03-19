# Limitations

## Package Availability

stunnel is available in the default repositories of all supported platforms. No vendor
repositories are required.

### APT (Debian/Ubuntu)

- Package name: `stunnel4`
- Ubuntu 22.04: stunnel 5.63 (amd64, arm64)
- Ubuntu 24.04: stunnel 5.71 (amd64, arm64)
- Debian 12: stunnel 5.71 (amd64, arm64)

### DNF/YUM (RHEL family)

- Package name: `stunnel`
- AlmaLinux 8 / Rocky Linux 8: stunnel 5.56 (amd64, arm64)
- AlmaLinux 9 / Rocky Linux 9: stunnel 5.68 (amd64, arm64)
- Amazon Linux 2023: stunnel 5.67 (amd64, arm64)
- CentOS Stream 9: stunnel 5.68 (amd64, arm64)
- Fedora: stunnel 5.75+ (amd64, arm64)

## Architecture Limitations

- All supported platforms provide both amd64 and arm64 packages

## Source/Compiled Installation

### Build Dependencies

| Platform Family | Packages                              |
|-----------------|---------------------------------------|
| Debian          | `build-essential`, `libssl-dev`       |
| RHEL            | `gcc`, `make`, `openssl-devel`        |

Source installation compiles from <https://www.stunnel.org/archive/>.

## Container Limitations

- stunnel requires systemd for service management; Dokken containers must run
  with `pid_one_command` set to systemd
- The `stunnel4` user is auto-created by the Debian package but must be created
  manually on RHEL family platforms

## Known Issues

- The Debian package installs the binary as `/usr/bin/stunnel4`, while RHEL
  installs it as `/usr/bin/stunnel`. The `stunnel_service` resource uses
  `/usr/bin/stunnel` which is also available on Debian via an alternatives symlink
