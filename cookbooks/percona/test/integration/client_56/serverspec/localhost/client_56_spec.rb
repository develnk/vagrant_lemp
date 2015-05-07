require "serverspec"

set :backend, :exec

def ubuntu?
  os[:family] == "ubuntu"
end

def redhat?
  os[:family] == "redhat"
end

describe "Ubuntu package installation" do
  describe package("percona-server-client-5.6"), if: ubuntu? do
    it { should be_installed }
  end

  describe package("percona-toolkit") do
    it { should be_installed }
  end
end

describe "Red Hat package installation" do
  describe yumrepo("percona"), if: redhat? do
    it { should exist }
    it { should be_enabled }
  end

  describe package("Percona-Server-devel-56"), if: redhat? do
    it { should be_installed }
  end

  describe package("Percona-Server-client-56"), if: redhat? do
    it { should be_installed }
  end

  describe package("percona-toolkit") do
    it { should be_installed }
  end
end
