#!/bin/sh

VERSION=1.9.9

if [ ! -e neo4j-${VERSION}.tar ]; then
    curl "http://neo4j.com/artifact.php?name=neo4j-community-${VERSION}-unix.tar.gz" -o neo4j-${VERSION}.tar
    tar -xvf neo4j-${VERSION}.tar
fi

mkdir -p db
cp -R neo4j-community-${VERSION} ./db/test/
cp -R neo4j-community-${VERSION} ./db/dev/
