#!/usr/bin/env bash
set -o errexit
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
	if [[ $1 == "gcc:4.7" ]]; then
		echo "gcc:4.7"
	elif [[ $1 == "gcc:4.8" ]]; then
		echo "gcc:4.8"
	elif [[ $1 == "clang:0/3.5" ]]; then
		echo "clang:0/3.5"
	fi
}

function BENCH() {
	cd ruby-benchmark-suite
	for i in {1..3}; do
		rake bench
	done
	cd ..
}

PREPARE

exit

SETCOMP "gcc:4.7"
EMERGE "dev-lang/ruby:2.1"
BENCH

SETCOMP "gcc:4.8"
EMERGE "dev-lang/ruby:2.1"
BENCH

SETCOMP "clang:0/3.5"
EMERGE "dev-lang/ruby:2.1"
BENCH
