Vagrant.configure(2) do |config|
	config.vm.box = 'ruby-benchmark'
	config.vm.box_url = 'https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box'
	config.vm.synced_folder '.', '/vagrant', type: 'rsync', rsync__exclude: ['ruby-benchmark-suite/']
	config.vm.provider :aws do |aws, override|
		aws.ami = 'ami-2efa4359'
		aws.instance_type = 'm3.medium'
		aws.region = 'eu-west-1'
		aws.keypair_name = 'AWS-Key'
		override.ssh.username = 'ec2-user'
		override.ssh.private_key_path = '~/.ssh/AWS-Key.pem'
	end
end
