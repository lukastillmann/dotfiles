# download java jdk from https://adoptopenjdk.net/installation.html#x64_linux-jdk

sudo mkdir /usr/local/java
sudo tar xzvf [jarFILE] -C /usr/local/java/
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk11****/bin/java" 1

# to change java version later
sudo update-alternatives --config java
