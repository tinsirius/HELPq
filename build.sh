set -a
source .env
set +a

cd src
./create_config
cd ..

docker build -t ece3073-helpq .
