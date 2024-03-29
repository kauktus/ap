#...............................................................................
#
#  This file is part of the Jancy toolkit.
#
#  Jancy is distributed under the MIT license.
#  For details see accompanying license.txt file,
#  the public copy of which is also available at:
#  http://tibbo.com/downloads/archive/jancy/license.txt
#
#...............................................................................

if [ "$TARGET_CPU" != "x86" ]; then
	sudo apt-get -qq update

	sudo apt-get install -y liblua5.2-dev
	sudo apt-get install -y libpcap-dev
	sudo apt-get install -y libudev-dev
else
	sudo dpkg --add-architecture i386
	sudo apt-get -qq update

	sudo apt-get install -y liblua5.2-dev:i386
	sudo apt-get install -y libpcap0.8-dev:i386
	sudo apt-get install -y libudev-dev:i386

	# OpenSSL is already installed, but 64-bit only

	sudo apt-get install -y libssl-dev:i386

	# install g++-multilib -- in the end, after i386 packages!

	sudo apt-get install -y g++-multilib

	# CMake fails to properly switch between 32-bit and 64-bit libraries on Ubuntu

	echo "set (OPENSSL_LIB_DIR /usr/lib/i386-linux-gnu)" >> paths.cmake
	echo "set (EXPAT_LIB_DIR /usr/lib/i386-linux-gnu)" >> paths.cmake
	echo "set (LUA_LIB_DIR /usr/lib/i386-linux-gnu)" >> paths.cmake
	echo "set (PCAP_LIB_DIR /usr/lib/i386-linux-gnu)" >> paths.cmake
	echo "set (EXPAT_INC_DIR DISABLED)" >> paths.cmake
fi

sudo apt-get install -y p7zip-full

if [ "$BUILD_DOC" != "" ]; then
	sudo apt-get install -y doxygen
	sudo pip install sphinx==1.7.9 sphinx_rtd_theme

	git clone --depth 1 http://github.com/vovkos/doxyrest
fi

if [ "$GET_COVERAGE" != "" ]; then
	sudo apt-get install -y lcov
	echo "axl_override_setting (GCC_FLAG_COVERAGE -coverage)" >> settings.cmake
fi
