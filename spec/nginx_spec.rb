require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"

describe command('which nginx') do
  its(:exit_status) { should eq 0 }
end

[
  "#{ENV['NGINX_ROOT_CONFIG_REMOTE']}",
  "#{ENV['NGINX_EXTRA_CONFIGS_REMOTE_DIR']}/site1.json",
  "#{ENV['NGINX_EXTRA_CONFIGS_REMOTE_DIR']}/site2.json"
].each do |f|
  describe file(f) do
    it { should be_file }
    it { should be_readable }
    it { should be_owned_by ENV['NGINX_CONFIG_OWNER'] }
    it { should be_grouped_into ENV['NGINX_CONFIG_GROUP'] }
  end
end
