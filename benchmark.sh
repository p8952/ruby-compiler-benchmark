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
	sudo emerge --quiet $1
}

function SETCOMP() {
	if [[ $1 == "gcc_4.4_O2" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.4_O3" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.7_O2" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.7_O3" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.8_O2" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.8_O3" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.9_O2" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "gcc_4.9_O3" ]]; then
		gcc --version | head -n 1

	elif [[ $1 == "clang_3.2" ]]; then
		clang --version | head -n 1

	elif [[ $1 == "clang_3.3" ]]; then
		clang --version | head -n 1

	elif [[ $1 == "clang_3.4" ]]; then
		clang --version | head -n 1

	elif [[ $1 == "clang_3.5" ]]; then
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
