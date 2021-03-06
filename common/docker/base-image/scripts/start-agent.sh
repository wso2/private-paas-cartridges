#!/bin/bash
# ------------------------------------------------------------------------
#
# Copyright 2005-2015 WSO2, Inc. (http://wso2.com)
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

# run script sets the configurable parameters for the cartridge agent in agent.conf and
# starts the cartridge agent process.


source /root/.bashrc

set -o posix ; set | sed -e ':a;N;$!ba;s/\n/,/g' > ${PCA_HOME}/payload/launch-params
# set PCA_HOME
echo "PCA_HOME=${PCA_HOME}" >> /etc/environment

# set CARBON_HOME as APPLICATION_PATH for carbon products
if [ "${CARBON_HOME}" ] && [ "${MULTITENANT}" == "true" ]; then
	export APPLICATION_PATH="${CARBON_HOME}"
	echo "APPLICATION_PATH=${APPLICATION_PATH}" >> /etc/environment
fi

# mandatory parameters
sed -i "s/MB-IP/${MB_IP}/g" ${PCA_HOME}/agent.conf
sed -i "s/MB-PORT/${MB_PORT}/g" ${PCA_HOME}/agent.conf
sed -i "s/MB-URLS/${MB_URLS}/g" ${PCA_HOME}/agent.conf

if [ -z "${MB_PUBLISHER_TIMEOUT}" ]; then
	sed -i "s/MB-PUBLISHER-TIMEOUT/900/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MB-PUBLISHER-TIMEOUT/${MB_PUBLISHER_TIMEOUT}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${MB_USERNAME}" ]; then
	sed -i "s/MB-USERNAME/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MB-USERNAME/${MB_USERNAME}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${MB_PASSWORD}" ]; then
	sed -i "s/MB-PASSWORD/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MB-PASSWORD/${MB_PASSWORD}/g" ${PCA_HOME}/agent.conf
fi

# parameters that can be empty
# default values have to be set

if [ -z "${LISTEN_ADDR}" ]; then
	sed -i "s/LISTEN_ADDR/localhost/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/LISTEN_ADDR/${LISTEN_ADDR}/g" ${PCA_HOME}/agent.conf
fi

# defaults to the message broker if not set
if [ -z "${CEP_URLS}" ]; then
	sed -i "s/CEP-URLS/${MB_IP}:${MB-PORT}/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/CEP-URLS/${CEP_URLS}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${CEP_USERNAME}" ]; then
	sed -i "s/CEP-ADMIN-USERNAME/admin/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/CEP-ADMIN-USERNAME/${CEP_USERNAME}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${CEP_PASSWORD}" ]; then
	sed -i "s/CEP-ADMIN-PASSWORD/admin/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/CEP-ADMIN-PASSWORD/${CEP_PASSWORD}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${ENABLE_HEALTH_PUBLISHER}" ]; then
	sed -i "s/ENABLE_HEALTH_PUBLISHER/true/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/ENABLE_HEALTH_PUBLISHER/${ENABLE_HEALTH_PUBLISHER}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${LB_PRIVATE_IP}" ]; then
	sed -i "s/LB_PRIVATE_IP/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s/LB_PRIVATE_IP/${LB_PRIVATE_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${LB_PUBLIC_IP}" ]; then
	sed -i "s/LB_PUBLIC_IP/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s/LB_PUBLIC_IP/${LB_PUBLIC_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${ENABLE_ARTFCT_UPDATE}" ]; then
	sed -i "s/ENABLE_ARTFCT_UPDATE/true/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/ENABLE_ARTFCT_UPDATE/${ENABLE_ARTFCT_UPDATE}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${COMMIT_ENABLED}" ]; then
	sed -i "s/COMMIT_ENABLED/false/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/COMMIT_ENABLED/${COMMIT_ENABLED}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${CHECKOUT_ENABLED}" ]; then
	sed -i "s/CHECKOUT_ENABLED/true/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/CHECKOUT_ENABLED/${CHECKOUT_ENABLED}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${ARTFCT_UPDATE_INT}" ]; then
	sed -i "s/ARTFCT_UPDATE_INT/15/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/ARTFCT_UPDATE_INT/${ARTFCT_UPDATE_INT}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${ARTFCT_CLONE_RETRIES}" ]; then
	sed -i "s/ARTFCT_CLONE_RETRIES/5/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/ARTFCT_CLONE_RETRIES/${ARTFCT_CLONE_RETRIES}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${ARTFCT_CLONE_INT}" ]; then
	sed -i "s/ARTFCT_CLONE_INT/10/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/ARTFCT_CLONE_INT/${ARTFCT_CLONE_INT}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${PORT_CHECK_TIMEOUT}" ]; then
	sed -i "s/PORT_CHECK_TIMEOUT/600000/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/PORT_CHECK_TIMEOUT/${PORT_CHECK_TIMEOUT}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${ENABLE_DATA_PUBLISHER}" ]; then
	sed -i "s/ENABLE-DATA-PUBLISHER/false/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/ENABLE-DATA-PUBLISHER/${ENABLE_DATA_PUBLISHER}/g" ${PCA_HOME}/agent.conf
fi

# defaults to the message broker IP if not set
if [ -z "${MONITORING_SERVER_IP}" ]; then
	sed -i "s/MONITORING-SERVER-IP/${MB_IP}/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MONITORING-SERVER-IP/${MONITORING_SERVER_IP}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${MONITORING_SERVER_PORT}" ]; then
	sed -i "s/MONITORING-SERVER-PORT/7611/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MONITORING-SERVER-PORT/${MONITORING_SERVER_PORT}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${MONITORING_SERVER_SECURE_PORT}" ]; then
	sed -i "s/MONITORING-SERVER-SECURE-PORT/7711/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MONITORING-SERVER-SECURE-PORT/${MONITORING_SERVER_SECURE_PORT}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${MONITORING_SERVER_ADMIN_USERNAME}" ]; then
	sed -i "s/MONITORING-SERVER-ADMIN-USERNAME/admin/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MONITORING-SERVER-ADMIN-USERNAME/${MONITORING_SERVER_ADMIN_USERNAME}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${MONITORING_SERVER_ADMIN_PASSWORD}" ]; then
	sed -i "s/MONITORING-SERVER-ADMIN-PASSWORD/admin/g" ${PCA_HOME}/agent.conf
else
	sed -i "s/MONITORING-SERVER-ADMIN-PASSWORD/${MONITORING_SERVER_ADMIN_PASSWORD}/g" ${PCA_HOME}/agent.conf
fi

if [ -z "${LOG_FILE_PATHS}" ]; then
	sed -i "s/LOG_FILE_PATHS/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s#LOG_FILE_PATHS#${LOG_FILE_PATHS}#g" ${PCA_HOME}/agent.conf
fi

if [ -z "${APPLICATION_PATH}" ]; then
	sed -i "s/APPLICATION-PATH/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s#APPLICATION-PATH#${APPLICATION_PATH}#g" ${PCA_HOME}/agent.conf
fi

if [ -z "${METADATA_SERVICE_URL}" ]; then
	sed -i "s/METADATA-SERVICE-URL/ /g" ${PCA_HOME}/agent.conf
else
	sed -i "s#METADATA-SERVICE-URL#${METADATA_SERVICE_URL}#g" ${PCA_HOME}/agent.conf
fi

if [ -z "${LOG_LEVEL}" ]; then
	sed -i "s/^.*level.*=.*$/level=INFO/g" ${PCA_HOME}/logging.ini
else
	sed -i "s/^.*level.*=.*$/level=${LOG_LEVEL}/g" ${PCA_HOME}/logging.ini
fi

# Start cartridge agent
cd ${PCA_HOME}/
python agent.py > /tmp/agent.screen.log 2>&1 &