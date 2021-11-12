#!/usr/bin/env bash
set -euo pipefail

DOCKERGENTO_CONFIG_DIR="config/dockergento"

set_ssh()
{
    COPY_COMMAND="cp -R ~/.ssh /var/www"
    OWNERSHIP_COMMAND="chown -R ${USER_PHP}:${GROUP_PHP} /var/www/.ssh"
    PERMISSION_COMMAND="chmod -R 700 /var/www/.ssh"
    PERMISSION_COMMAND2="chmod 600 /var/www/.ssh/*"
    echo " > setting permissions and ownership for .ssh"

    CONTAINER_ID=$(${DOCKER_COMPOSE} ps -q ${SERVICE_PHP})
    docker cp ~/.ssh ${CONTAINER_ID}:${WORKDIR_PHP}/../

    ${COMMANDS_DIR}/exec.sh --root sh -c "${OWNERSHIP_COMMAND}"
    ${COMMANDS_DIR}/exec.sh --root sh -c "${PERMISSION_COMMAND}"
    ${COMMANDS_DIR}/exec.sh --root sh -c "${PERMISSION_COMMAND2}"
}

printf "${GREEN}Setting up dockergento SSH${COLOR_RESET}\n"

set_ssh

echo ""
printf "${GREEN}Dockergento SSH set up successfully!${COLOR_RESET}\n"
echo ""
