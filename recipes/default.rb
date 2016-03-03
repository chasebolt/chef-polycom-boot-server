#
# Author:: Chase Bolt (<chase.bolt@gmail.com>)
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

docker_service 'default' do
  action [:create, :start]
end

docker_image 'cbolt/passenger-ruby22'

directory '/opt/webapp'
directory '/opt/nginx'

cookbook_file '/opt/nginx/default' do
  source 'nginx.default'
end

if node['polycom-boot-server']['webapp']['managed']
  package 'git'

  deploy_revision '/opt/webapp' do
    repo node['polycom-boot-server']['webapp']['repo']
    revision 'HEAD'
    migrate false
    shallow_clone true
    rollback_on_error true
    symlink_before_migrate.clear
    create_dirs_before_symlink.clear
    purge_before_symlink.clear
    symlinks.clear
    action :deploy
    notifies :redeploy, 'docker_container[passenger]'
  end
end

docker_container 'passenger' do
  repo 'cbolt/passenger-ruby22'
  port ['80:80/tcp', '443:443/tcp']
  volumes [
    '/opt/webapp/current:/home/app/webapp',
    '/opt/nginx/default:/etc/nginx/sites-available/default:ro'
  ]
end
