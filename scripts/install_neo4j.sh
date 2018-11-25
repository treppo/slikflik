#!/bin/sh

set -euo pipefail

VERSION=1.9.9

curl "http://neo4j.com/artifact.php?name=neo4j-community-${VERSION}-unix.tar.gz" | tar -xvz

mkdir -p db
cp -R neo4j-community-${VERSION} ./db/test/
mv neo4j-community-${VERSION} ./db/dev/
