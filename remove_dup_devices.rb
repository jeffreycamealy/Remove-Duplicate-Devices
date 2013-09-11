#!/usr/bin/env ruby

if ARGV.empty?
	puts "== Error ==\nUsage: remove_dup_devices.rb <device_list> <duplicate_list> <new_filtered_list>"
	exit
end

duplicatesFile = ARGV[1]
duplicatesData = File.open(duplicatesFile, "r").read

duplicateDevices = []
duplicatesData.each_line do |line|
	duplicateDevices << /'(.+)'/.match(line)[1]
end

devicesFile = ARGV[0]
devicesData = File.open(devicesFile, "r").read

newDeviceList = []
devicesData.each_line do |line|
	device = line.split[0]
	if ! duplicateDevices.include?(device) 
		newDeviceList << line
	end
end

File.open(ARGV[2], 'w') do |file|
	file.puts newDeviceList
end
