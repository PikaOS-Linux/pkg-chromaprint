# Add dependent repositories
sudo dpkg --add-architecture i386
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports

# Clone Upstream
tar -xf chromaprint_1.5.1.orig.tar.xz -C ./
mv ./chromaprint-1.5.1 ./chromaprint
cp -rvf ./debian ./chromaprint
cd ./chromaprint

# Get build deps
apt-get install build-essential -y
apt-get install crossbuild-essential-i386 lib32gcc-11-dev -y
apt-get build-dep ./ -y -a i386

# Build package
#LOGNAME=root dh_make --createorig -y -l -p chromaprint_1.5.1
dpkg-buildpackage -a i386

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
