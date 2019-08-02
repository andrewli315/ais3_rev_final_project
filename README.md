# AIS3 FINAL Project

## Requirement
Install bochs
After downloading bochs-2.6.9.tar.gz from [here](https://sourceforge.net/projects/bochs/files/bochs/2.6.9/bochs-2.6.9.tar.gz/download)
```
sudo apt-get install libgtk2.0-dev
sudo tar zxvf bochs-2.6.9.tar.gz
cd bochs-2.6.9
./configure --enable-debugger --enable-disasm --enable-readline LIBS='-lX11'
sudo make
sudo make install
```

## Build
Enter the repos folder...
```shell
bximage
# Choose 1 : Create new floppy or hard disk image
# Choose hd
# Choose flat
# Choose 60
# Input  hd60M.img

mkdir build
make
```

## Run
```shell
bochs
```




