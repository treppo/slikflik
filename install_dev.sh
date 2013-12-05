curl 'http://download.neo4j.org/artifact?edition=community&version=1.9.5&distribution=tarball' -o /tmp/neo4j.tar
tar -xvf /tmp/neo4j.tar
cp /tmp/neo4j-community-1.9.5 ./db/test/
cp /tmp/neo4j-community-1.9.5 ./db/dev/
