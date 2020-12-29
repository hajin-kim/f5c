
hdf5header()
{
	echo "I could not find the include path for your hdf5.h"
	echo "Manually enter the value for HDF5_INC in config.mk"

}


# manual_hts()
# {
# wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2
# tar -xzf htslib-1.9.tar.bz2
# rm htslib-1.9.tar.bz2

# }
 
#echo "HTS_INC =" > config.mk
 
echo "#autogenerated from configure.sh" > config.mk
echo "int main(){return 0;}" > test.c
 
if  ldconfig -p | grep "libhts.so" > /dev/null
then
	echo "libhts found"
	echo "HTS_LDFLAGS = -lhts" >> config.mk
else
	echo "HTS library development files not found!" 
	echo "On Debian based systems such as Ubuntu you may use sudo apt-get install libhts-dev."
	echo "Or you can download and install the latest release of htslib from http://www.htslib.org/download/."
	echo "After doing so, run this script again"
	exit;
fi


if  ldconfig -p | grep "libhdf5" > /dev/null
then
	echo "libhdf5 found"
	if ldconfig -p | grep "libhdf5_serial.so" > /dev/null
	then
		echo "HDF5_LDFLAGS = -lhdf5_serial" >> config.mk
		if [ -e /usr/include/hdf5/serial/hdf5.h ] 
		then
			echo "HDF5_INC = /usr/include/hdf5/serial/" >> config.mk
		else
			hdf5header
		fi
	elif ldconfig -p | grep "libhdf5.so" > /dev/null
	then 
		echo "HDF5_LDFLAGS = -lhdf5" >> config.mk
		if [ -e /usr/include/hdf5/hdf5.h ] 
		then
			echo "HDF5_INC = /usr/include/hdf5/" >> config.mk
		else
			hdf5header
		fi		
		echo "HDF5_INC = /usr/include/hdf5/" >>  config.mk
	else
		echo "HDF5_LDFLAGS = -lhdf5" >> config.mk
		echo "HDF5_INC = /usr/include/hdf5/" >> config.mk
		echo "I could not found a suitable LDFLAG for your version of HDF."
		echo "Manually enter the value for HDF5_LDFLAGS and in HDF5_INC in config.mk"
	fi
	
else
	echo "HDF5 development files not found!"
	echo "On Debian based systems such as Ubuntu you may use sudo apt-get install libhdf5-dev."
	echo "After doing so, run this script again"
	exit;
fi

echo "now run make"

# wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.14/src/hdf5-1.8.14.tar.gz; 
# tar -xzf hdf5-1.8.14.tar.gz 
# rm hdf5-1.8.14.tar.gz 
# mkdir hdf5
# cd hdf5-1.8.14 
# ./configure --enable-threadsafe --prefix=`pwd`/../hdf5 
# make 
# make install
# rm hdf5-1.8.14.tar.gz


