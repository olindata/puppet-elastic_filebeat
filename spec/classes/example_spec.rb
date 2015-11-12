require 'spec_helper'

describe 'elastic_filebeat' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "elastic_filebeat class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('elastic_filebeat::params') }
          it { is_expected.to contain_class('elastic_filebeat::install').that_comes_before('elastic_filebeat::config') }
          it { is_expected.to contain_class('elastic_filebeat::config') }
          it { is_expected.to contain_class('elastic_filebeat::service').that_subscribes_to('elastic_filebeat::config') }

          it { is_expected.to contain_service('filebeat') }
          it { is_expected.to contain_package('filebeat').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'elastic_filebeat class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('filebeat') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
