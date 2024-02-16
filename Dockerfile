# ------------------------------------------------------------------------
#
# Copyright 2021 WSO2, LLC. (http://wso2.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License
#
# ------------------------------------------------------------------------

# set base Docker image to eclipse-temurin Docker image
FROM eclipse-temurin:11.0.21_9-jre-jammy

# work directory
WORKDIR /home/wso2carbon

# copy WSO2 product distribution to user's home directory and set home directory ownership to user wso2carbon
COPY ./wso2is-7.0.0 /home/wso2carbon/wso2is-7.0.0

# expose ports
EXPOSE 4000 9763 9443

# initiate container and start WSO2 Carbon server
ENTRYPOINT ["/home/wso2carbon/wso2is-7.0.0/bin/wso2server.sh"]
