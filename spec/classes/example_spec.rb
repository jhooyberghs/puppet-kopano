require 'spec_helper'

describe 'kopano' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "kopano class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('kopano::params') }
          it { is_expected.to contain_class('kopano::install').that_comes_before('kopano::config') }
          it { is_expected.to contain_class('kopano::config') }
          it { is_expected.to contain_class('kopano::service').that_subscribes_to('kopano::config') }

          it { is_expected.to contain_service('kopano') }
          it { is_expected.to contain_package('kopano').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'kopano class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('kopano') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
