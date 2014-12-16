#!/usr/bin/env bash
set -o errexit

function PREPARE() {
	sudo cp /vagrant/make.conf /etc/portage/make.conf
	sudo eselect news read all > /dev/null
	git clone git://github.com/acangiano/ruby-benchmark-suite.git || true
	rm -rf ruby-benchmark-suite/results/* || true
}

function SETCOMP() {
	echo "app-admin/eselect-ruby $3" | sudo tee /etc/portage/package.env > /dev/null
	echo "dev-libs/libyaml $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "dev-ruby/json $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "dev-ruby/racc $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "dev-ruby/rake $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "dev-ruby/rdoc $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "dev-ruby/rubygems $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "dev-util/ragel $3" | sudo tee -a /etc/portage/package.env > /dev/null
	echo "virtual/rubygems $3" | sudo tee -a /etc/portage/package.env > /dev/null

	if [[ $1 == "gcc" ]]; then
		sudo gcc-config "$2" > /dev/null 2>&1
		source /etc/profile
		gcc --version | head -n 1
	elif [[ $1 == "clang" ]]; then
		EMERGE "--usepkg $2" > /dev/null 2>&1
		clang --version | head -n 1
	fi
}

function UNMERGE() {
	sudo emerge --unmerge --quiet $1 || true
	sudo emerge --depclean --quiet
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

function BENCH() {
	cd ruby-benchmark-suite
	rake bench
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
	UNMERGE "dev-lang/ruby"
	EMERGE "dev-lang/ruby"
	BENCH
done
