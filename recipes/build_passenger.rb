#
# Author:: Chase Bolt (<chase.bolt@gmail.com>)
# Recipe:: build_passenger
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

docker_image 'phusion/passenger-ruby22' do
  read_timeout 300
end

remote_directory '/opt/src/passenger' do
  source 'passenger'
  purge true
  notifies :build, 'docker_image[passenger]', :immediately
end

docker_image 'passenger' do
  tag 'latest'
  source '/opt/src/passenger'
  action :build_if_missing
  notifies :redeploy, 'docker_container[passenger]', :immediately
end
