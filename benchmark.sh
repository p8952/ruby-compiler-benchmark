#!/usr/bin/env bash
set -o errexit

function PREPARE() {
	sudo rm -rf /var/tmp/portage/* || true
	git clone git://github.com/acangiano/ruby-benchmark-suite.git || true
	rm -rf ruby-benchmark-suite/results/* || true
}

function EMERGE() {
	set +e
	sudo emerge --pretend --quiet $1
	if [[ $? == 1 ]]; then
		sudo emerge --autounmask-write $1
		sudo etc-update --automode -5
	fi
	set -e
	sudo emerge --quiet $1
}

function SETCOMP() {
	COMPILER=$1
	VERSION=$2
	OPTIMIZATION=$3

	echo "dev-lang/ruby $OPTIMIZATION" | sudo tee /etc/portage/package.env > /dev/null

	if [[ $COMPILER == "gcc" ]]; then
		sudo gcc-config "$VERSION" > /dev/null 2>&1
		source /etc/profile
		gcc --version | head -n 1
	elif [[ $COMPILER == "clang" ]]; then
		EMERGE "--usepkg $VERSION" > /dev/null 2>&1
		clang --version | head -n 1
	fi
}

function BENCH() {
	cd ruby-benchmark-suite
	for i in {1..3}; do
		rake bench
	done
	cd ..
}

COMPILERS=(
	"gcc x86_64-pc-linux-gnu-4.4.7 O2"
	"gcc x86_64-pc-linux-gnu-4.4.7 O3"
	"gcc x86_64-pc-linux-gnu-4.7.3 O2"
	"gcc x86_64-pc-linux-gnu-4.7.3 O3"
	"gcc x86_64-pc-linux-gnu-4.8.3 O2"
	"gcc x86_64-pc-linux-gnu-4.8.3 O3"
	"gcc x86_64-pc-linux-gnu-4.9.2 O2"
	"gcc x86_64-pc-linux-gnu-4.9.2 O3"
	"clang sys-devel/clang:0/3.2 clang"
	"clang sys-devel/clang:0/3.3 clang"
	"clang sys-devel/clang:0/3.4 clang"
	"clang sys-devel/clang:0/3.5 clang"
	)

PREPARE
for COMPILER in "${COMPILERS[@]}"; do
	SETCOMP $COMPILER
	#EMERGE "dev-lang/ruby:2.1"
	#BENCH
done
