os_id=${1:-darwin-amd64}

echo "os id: $os_id"

mkdir tmp

cd tmp

curl https://get.helm.sh/helm-v3.0.1-${os_id}.tar.gz > helm301.tar.gz
curl https://get.helm.sh/helm-v3.0.2-${os_id}.tar.gz > helm302.tar.gz

tar xf helm301.tar.gz
mv ${os_id}/helm helm301
tar xf helm302.tar.gz
mv ${os_id}/helm helm302

./helm301 version
./helm302 version
