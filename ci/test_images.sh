#!/bin/bash

echo "Testing..."

ANSI_RED="\033[31;1m"
# shellcheck disable=SC2034
ANSI_GREEN="\033[32;1m"
ANSI_RESET="\033[0m"
# shellcheck disable=SC2034
ANSI_CLEAR="\033[0K"

retry_cmd() {
    local result=0
    local count=1
    set +e

    retry_cnt=2

    while [ $count -le "${retry_cnt}" ]; do
        [ $result -ne 0 ] && {
            echo -e "\n${ANSI_RED}The command \"$*\" failed. Retrying, $count of ${retry_cnt}${ANSI_RESET}\n" >&2
        }
        "$@"
        result=$?
        [ $result -eq 0 ] && break
        count=$((count + 1))
        sleep 1
    done

    [ $count -gt "${retry_cnt}" ] && {
        echo -e "\n${ANSI_RED}The command \"$*\" failed ${retry_cnt} times.${ANSI_RESET}\n" >&2
    }

    set -e
    return $result
}

jobfiles=$(find ./ci/jobs -name "*.job" | sort | awk "NR % ${CIRCLE_NODE_TOTAL} == ${CIRCLE_NODE_INDEX}")

if [ -z "${jobfiles}" ]; then
    echo "[*] More parallelism than tests"
else

    # login docker
    echo "try to login to aliyun docker hub...."
    docker login --username=${DOCKER_USERNAME} -e ${DOCKER_USERNAME} --password=${DOCKER_PASSWORD} registry.cn-shanghai.aliyuncs.com
    echo "login ret: $?"

    while read -r line; do
        echo "[*] Node ${CIRCLE_NODE_INDEX} running test for job ${line}..."
        dockerfile=$(cat "${line}")
        echo "test dockerfile $dockerfile"
        floydker test "${dockerfile}" || {
            echo "${dockerfile} test failed."
            exit 1
        }

        echo "test end, try to push docker to server..."
        retry_cmd floydker push "${dockerfile}" "v${CIRCLE_BUILD_NUM}" ${CIRCLE_IS_TEST} || {
            echo "Failed pushing ${dockerfile}."
            kill -9 "${ALIVEPID}"
            exit 1
        }
    done <<< "${jobfiles}"

fi
