# tinyproxy container

A really simple container that runs tinyproxy.

## Configuration

Out of the box tinyproxy listens on port 8888 and will forward requests from private and link-local IP addresses.

You can configure tinyproxy with either environment variables or a full config file.

### Environment Variables

| Variable                   | Description                                                                                                                                               | Default                                                                     |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `TINYPROXY_ALLOWLIST`      | A comma-separated list of addresses and CIDRs that are mapped to `Allow` entries in `tinyproxy.conf`                                                      | `192.168.0.0/16,172.16.0.0/12,10.0.0.0/8,fd00::/8,169.254.0.0/15,fe80::/10` |
| `TINYPROXY_PORT`           | The port to listen on                                                                                                                                     | `8888`                                                                      |
| `TINYPROXY_LISTEN`         | The address to listen on                                                                                                                                  | `0.0.0.0 `                                                                  |
| `TINYPROXY_HEALTHCHECKURL` | The url to fetch via the proxy to confirm health. This must succeed.                                                                                      | `http://tinyproxy.stats                              `                      |
| `TINYPROXY_LOGLEVEL`       | The log level, one of `critical` (least verbose), `error`, `warning`, `notice`, `connect`(to log connections without Info's noise),`info` (most verbose). | `connect`                                                                   |

### tinyproxy.conf

Create your own tinyproxy.conf, and map the volume to `/conf`

For example, if your config file is in `conf/tinyproxy.conf`, then add `-v ./conf:/conf` to your docker run command.

### `compose.yaml`

A sample `compose.yaml` is provided.
