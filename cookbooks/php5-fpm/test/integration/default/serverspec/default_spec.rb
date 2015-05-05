require 'serverspec'

#################################################
## New Version of Serverspec -- Not Needed ##
#include SpecInfra::Helper::Exec
#include SpecInfra::Helper::DetectOS
#################################################

set :backend, :exec

if ['debian', 'ubuntu'].include?(os[:family])

    describe package('php5-fpm') do
        it { should be_installed }
    end

    describe service('php5-fpm') do
        it { should be_enabled }
    end

    describe service('php5-fpm') do
        it { should be_running }
    end

elsif ['redHat', 'centos', 'fedora'].include?(os[:family])

    describe package('php-fpm') do
        it { should be_installed }
    end

    describe service('php-fpm') do
        it { should be_enabled }
    end

    describe service('php-fpm') do
        it { should be_running }
    end

end