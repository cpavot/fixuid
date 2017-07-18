#!/bin/sh
cd $(dirname $0)
set -e

./build.sh
mv fixuid docker/fs-stage/usr/local/bin
rm -rf docker/alpine/stage
cp -r docker/fs-stage docker/alpine/stage
rm -rf docker/centos/stage
cp -r docker/fs-stage docker/centos/stage
rm -rf docker/debian/stage
cp -r docker/fs-stage docker/debian/stage
docker-compose build

echo "\nalpine default user/group cmd"
docker run --rm fixuid-alpine fixuid-test.sh docker docker
echo "\ncentos default user/group cmd"
docker run --rm fixuid-centos fixuid-test.sh docker docker
echo "\ndebian default user/group cmd"
docker run --rm fixuid-debian fixuid-test.sh docker docker
echo "\nalpine default user/group entrypoint"
docker run --rm --entrypoint fixuid fixuid-alpine fixuid-test.sh docker docker
echo "\ncentos default user/group entrypoint"
docker run --rm --entrypoint fixuid fixuid-centos fixuid-test.sh docker docker
echo "\ndebian default user/group entrypoint"
docker run --rm --entrypoint fixuid fixuid-debian fixuid-test.sh docker docker

echo "\nalpine 1001:1001 cmd"
docker run --rm -u 1001:1001 fixuid-alpine fixuid-test.sh docker docker
echo "\ncentos 1001:1001 cmd"
docker run --rm -u 1001:1001 fixuid-centos fixuid-test.sh docker docker
echo "\ndebian 1001:1001 cmd"
docker run --rm -u 1001:1001 fixuid-debian fixuid-test.sh docker docker
echo "\nalpine 1001:1001 entrypoint"
docker run --rm -u 1001:1001 --entrypoint fixuid fixuid-alpine fixuid-test.sh docker docker
echo "\ncentos 1001:1001 entrypoint"
docker run --rm -u 1001:1001 --entrypoint fixuid fixuid-centos fixuid-test.sh docker docker
echo "\ndebian 1001:1001 entrypoint"
docker run --rm -u 1001:1001 --entrypoint fixuid fixuid-debian fixuid-test.sh docker docker

echo "\nalpine 0:0 cmd"
docker run --rm -u 0:0 fixuid-alpine fixuid-test.sh root root
echo "\ncentos 0:0 cmd"
docker run --rm -u 0:0 fixuid-centos fixuid-test.sh root root
echo "\ndebian 0:0 cmd"
docker run --rm -u 0:0 fixuid-debian fixuid-test.sh root root
echo "\nalpine 0:0 entrypoint"
docker run --rm -u 0:0 --entrypoint fixuid fixuid-alpine fixuid-test.sh root root
echo "\ncentos 0:0 entrypoint"
docker run --rm -u 0:0 --entrypoint fixuid fixuid-centos fixuid-test.sh root root
echo "\ndebian 0:0 entrypoint"
docker run --rm -u 0:0 --entrypoint fixuid fixuid-debian fixuid-test.sh root root


echo "\nalpine 0:1001 cmd"
docker run --rm -u 0:1001 fixuid-alpine fixuid-test.sh root docker
echo "\ncentos 0:1001 cmd"
docker run --rm -u 0:1001 fixuid-centos fixuid-test.sh root docker
echo "\ndebian 0:1001 cmd"
docker run --rm -u 0:1001 fixuid-debian fixuid-test.sh root docker
echo "\nalpine 0:1001 entrypoint"
docker run --rm -u 0:1001 --entrypoint fixuid fixuid-alpine fixuid-test.sh root docker
echo "\ncentos 0:1001 entrypoint"
docker run --rm -u 0:1001 --entrypoint fixuid fixuid-centos fixuid-test.sh root docker
echo "\ndebian 0:1001 entrypoint"
docker run --rm -u 0:1001 --entrypoint fixuid fixuid-debian fixuid-test.sh root docker

echo "\nalpine 1001:0 cmd"
docker run --rm -u 1001:0 fixuid-alpine fixuid-test.sh docker root
echo "\ncentos 1001:0 cmd"
docker run --rm -u 1001:0 fixuid-centos fixuid-test.sh docker root
echo "\ndebian 1001:0 cmd"
docker run --rm -u 1001:0 fixuid-debian fixuid-test.sh docker root
echo "\nalpine 1001:0 entrypoint"
docker run --rm -u 1001:0 --entrypoint fixuid fixuid-alpine fixuid-test.sh docker root
echo "\ncentos 1001:0 entrypoint"
docker run --rm -u 1001:0 --entrypoint fixuid fixuid-centos fixuid-test.sh docker root
echo "\ndebian 1001:0 entrypoint"
docker run --rm -u 1001:0 --entrypoint fixuid fixuid-debian fixuid-test.sh docker root

echo "\nalpine run twice"
docker run --rm fixuid-alpine sh -c "fixuid && fixuid"
echo "\ncentos run twice"
docker run --rm fixuid-centos sh -c "fixuid && fixuid"
echo "\ndebian run twice"
docker run --rm fixuid-debian sh -c "fixuid && fixuid"
