require "serverspec"

set :backend, :exec

def ubuntu?
  os[:family] == "ubuntu"
end

def redhat?
  os[:family] == "redhat"
end

describe "Ubuntu package installation", if: ubuntu? do
  describe package("percona-server-client-5.5") do
    it { should be_installed }
  end

  describe package("percona-toolkit") do
    it { should be_installed }
  end
end

describe "Red Hat package installation", if: redhat? do
  describe yumrepo("percona") do
    it { should exist }
    it { should be_enabled }
  end

  describe package("Percona-Server-devel-55") do
    it { should be_installed }
  end

  describe package("Percona-Server-client-55") do
    it { should be_installed }
  end

  describe package("percona-toolkit") do
    it { should be_installed }
  end
end
