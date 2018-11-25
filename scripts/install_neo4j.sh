#!/bin/sh

set -euo pipefail

VERSION=3.4.10

curl "https://neo4j.com/artifact.php?name=neo4j-community-${VERSION}-unix.tar.gz" | tar -xvz

# deactivate Neo4j authentication
sed -i '' 's/#dbms.security.auth_enabled=false/dbms.security.auth_enabled=false/' neo4j-community-${VERSION}/conf/neo4j.conf

mkdir -p db
cp -R neo4j-community-${VERSION} ./db/test/
mv neo4j-community-${VERSION} ./db/dev/
