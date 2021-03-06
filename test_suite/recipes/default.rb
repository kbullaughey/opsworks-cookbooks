# setup environment for running cookbook tests
# This recipe uses "minitest-chef-handler" to facilitate cookbook testing.
# minitest-chef-handler project: https://github.com/calavera/minitest-chef-handler

if node[:opsworks][:run_cookbook_tests]
  Chef::Log.info('Initializing Cookbook Test Environment.')

  OpsWorks::InternalGems.internal_gem_package 'minitest-chef-handler', :version => node[:opsworks_test_suite_loader][:minitest_chef_handler][:version]
  require 'minitest-chef-handler'

  Chef::Log.info('Enabling minitest-chef-handler as a report handler')
  handler = MiniTest::Chef::Handler.new({
    :verbose => true})

  Chef::Config.send('report_handlers').delete_if do |v|
    v.class.to_s.include? MiniTest::Chef::Handler
  end

  Chef::Config.send('report_handlers') << handler
end
