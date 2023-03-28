apt-cache dumpavail > ~/temp_avail
sudo dpkg --merge-avail ~/temp_avail
rm ~/temp_avail
