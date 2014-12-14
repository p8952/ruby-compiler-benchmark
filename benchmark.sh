#!/usr/bin/env bash
set -o errexit

function EMERGE() {
	set +e
	sudo emerge --pretend --quiet $1
	if [[ $? == 1 ]]; then
		sudo emerge --autounmask-write $1
		sudo etc-update --automode -5
	fi
	set -e
	sudo emerge --usepkg --quiet $1
}

function SETCOMP() {
	if [[ $1 == "gcc_4.4_O2" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.4.7" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O2" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.4_O3" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.4.7" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O3" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.7_O2" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.7.3" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O2" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.7_O3" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.7.3" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O3" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.8_O2" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.8.3" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O2" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.8_O3" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.8.3" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O3" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.9_O2" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.9.2" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O2" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "gcc_4.9_O3" ]]; then
		sudo gcc-config "x86_64-pc-linux-gnu-4.9.2" > /dev/null 2>&1
		source /etc/profile
		echo "dev-lang/ruby O3" | sudo tee /etc/portage/package.env > /dev/null
		gcc --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "clang_3.2" ]]; then
		EMERGE "sys-devel/clang:0/3.2" > /dev/null 2>&1
		echo "dev-lang/ruby Clang" | sudo tee /etc/portage/package.env > /dev/null
		clang --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "clang_3.3" ]]; then
		EMERGE "sys-devel/clang:0/3.3" > /dev/null 2>&1
		echo "dev-lang/ruby Clang" | sudo tee /etc/portage/package.env > /dev/null
		clang --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "clang_3.4" ]]; then
		EMERGE "sys-devel/clang:0/3.4" > /dev/null 2>&1
		echo "dev-lang/ruby Clang" | sudo tee /etc/portage/package.env > /dev/null
		clang --version | head -n 1
		cat /etc/portage/package.env
		echo ""

	elif [[ $1 == "clang_3.5" ]]; then
		EMERGE "sys-devel/clang:0/3.5" > /dev/null 2>&1
		echo "dev-lang/ruby Clang" | sudo tee /etc/portage/package.env > /dev/null
		clang --version | head -n 1
		cat /etc/portage/package.env
		echo ""

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
	gcc_4.4_O2
	gcc_4.4_O3
	gcc_4.7_O2
	gcc_4.7_O3
	gcc_4.8_O2
	gcc_4.8_O3
	gcc_4.9_O2
	gcc_4.9_O3
	clang_3.2
	clang_3.3
	clang_3.4
	clang_3.5
	)

for COMPILER in "${COMPILERS[@]}"; do
	SETCOMP "$COMPILER"
	#EMERGE "dev-lang/ruby:2.1"
	#BENCH
done
