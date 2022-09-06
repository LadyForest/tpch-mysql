###############################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
###############################################################################

FROM ubuntu:20.04
LABEL maintainer="qingyue.cqy@gmail.com"
LABEL version="0.1"
LABEL description="tpch-mysql"

ARG src="./TPC-H V3.0.1/"
COPY ${src} /tpch/
WORKDIR /tpch/dbgen
RUN apt-get update && apt-get install -y \
    build-essential \
    vim \
    && make -d

# keep container alive
ENTRYPOINT ["tail", "-f", "/dev/null"]