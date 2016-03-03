# polycom-boot-server Cookbook
[![Build Status](https://travis-ci.org/chasebolt/chef-polycom-boot-server.svg?branch=master)](http://travis-ci.org/chasebolt/chef-polycom-boot-server) [![Cookbook Version](https://img.shields.io/cookbook/v/polycom-boot-server.svg)](https://supermarket.chef.io/cookbooks/polycom-boot-server)

The polycom-boot-server cookbook sets up the necessary services to create a boot server
that polycom phones can be provisioned from. A default phone template will be deployed,
but a wrapper cookbook will be necessary to manage individual phone templates
or override the default.

Utilizes Docker for running nginx/passenger

## Requirements
- Chef 12+

### Platforms
- Fedora and RHEL based distributions (RHEL, CentOS, and Scientific Linux) are supported

## Attributes
The following attributes are set by default

```ruby
default['polycom-boot-server']['webapp']['managed'] = true
default['polycom-boot-server']['webapp']['repo'] = 'https://github.com/chasebolt/webapp-polycom-boot-server.git'

```

## Usage Example
Add `include_recipe 'polycom-boot-server'` into your wrapper cookbook. You can override
the webapp that is used for provisioning the polycom configs by setting
`default['polycom-boot-server']['webapp']['repo']` to the location of your git repo.
If your repo is private, you will need to set `default['polycom-boot-server']['webapp']['managed'] = false`
and deploy your webapp to `/opt/webapp` manually.

## TODO
- Firmware Updates
- Default Config Download
- Accept phone uploads
- Support for Let's Encrypt

## Maintainers
* Chase Bolt (<chase.bolt@gmail.com>)

## License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
