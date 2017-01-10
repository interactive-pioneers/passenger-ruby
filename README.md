# passenger-ruby [![](https://img.shields.io/badge/licence-GPL-bd0000.svg)](https://github.com/interactive-pioneers/passenger-ruby/blob/master/LICENSE) [![Build Status](https://travis-ci.org/interactive-pioneers/passenger-ruby.svg?branch=feature%2Ftests)](https://travis-ci.org/interactive-pioneers/passenger-ruby)

Extended Phusion Passenger Docker image

## Features of versions 2.1 through 2.3

- Ubuntu 16.04 LTS
- Phusion Passenger 5.0.15 with nginx enabled
- Ruby 2.3 (2.3.1, incl. dev headers), 2.2 (2.2.5), 2.1 (2.1.9) or 2.1.5
- Bundler 1.13.1
- ImageMagick 6.8.9 incl. RMagick support
- MySQL 5.5 client incl. dev headers
- PostgreSQL 9.4 client incl. dev headers
- Node.js 7
- Wget 1.17.1

## Features of 2.1.5-p4a2 version

- Ubuntu 14.04 LTS
- Phusion Passenger 4.0.57 with Apache enabled
- Ruby 2.1.5
- Bundler 1.13.1
- ImageMagick 6.7.7 incl. RMagick support
- PostgreSQL 9.4
- Node.js 7
- Wget 1.15

## Legacy versions

| Image      | Node.js | Digest                                                                  |
| -------    | ------- | ------                                                                  |
| 2.1        | 4.2.6   | sha256:6ef60a7768de957a6fe4a8d2e98a47c05bee8db4d8c64623b91e17dfd4a01383 |
| 2.1.5-p4a2 | 0.10.25 | sha256:5587583bfc0226ca3fb7e9e7340adcd1fc504f1d90618d7fd704ee0a1ad2c50f |
| 2.1.5      | 4.2.6   | sha256:96e66a9a672eda2f1a7cf19aef90afedd90706297ddb475730cf00e9c5f96581 |
| 2.2        | 4.2.6   | sha256:36ea2d6066d00f26a328323b6f8121f3872bdaff5a261509481fed27ca717d6b |
| 2.3        | 4.2.6   | sha256:1742b6d06ad293435e51a2caeda92703fd09b73a2eec681ab2f11d174fc26b67 |

### Example usage:

To refer to Ruby 2.3 image with Node.js 0.10.25:

```
ipioneers/passenger-ruby@sha256:5587583bfc0226ca3fb7e9e7340adcd1fc504f1d90618d7fd704ee0a1ad2c50f
```


## Licence

Copyright © 2016, 2017 Interactive Pioneers GmbH, contributors. Licenced under [GPL-3](https://github.com/interactive-pioneers/passenger-ruby/blob/master/LICENSE).
