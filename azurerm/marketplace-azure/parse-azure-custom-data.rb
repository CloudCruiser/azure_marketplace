#!/usr/bin/env ruby

require 'nokogiri'
require 'base64'

@doc = File.open('/var/lib/waagent/ovf-env.xml') { |f| Nokogiri::XML(f) }


xml_path = '//ns1:ProvisioningSection/ns1:LinuxProvisioningConfigurationSet/ns1:CustomData'
data = @doc.xpath(xml_path)

vars_file = '/etc/default/agent_service.env'

data = Base64.decode64("#{data.children.text}").split('&')

begin
  File.delete(vars_file)
rescue Errno::ENOENT => e
  p e
end

open(vars_file, 'a') do |f|
  data.each do |k|
    f << "export #{k}\n"
  end
end
