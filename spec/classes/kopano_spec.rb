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

          # Classes
          it { is_expected.to contain_class('kopano::server') }
          it { is_expected.to contain_class('kopano::dagent') }
          it { is_expected.to contain_class('kopano::gateway') }
          it { is_expected.to contain_class('kopano::ical') }
          it { is_expected.to contain_class('kopano::monitor') }
          it { is_expected.to contain_class('kopano::search') }
          it { is_expected.to contain_class('kopano::spooler') }
          it { is_expected.to contain_class('kopano::webapp') }

          # Services
					it { is_expected.to contain_service('kopano-server') }
					it { is_expected.to contain_service('kopano-dagent') }
					it { is_expected.to contain_service('kopano-gateway') }
					it { is_expected.to contain_service('kopano-ical') }
					it { is_expected.to contain_service('kopano-monitor') }
					it { is_expected.to contain_service('kopano-search') }
					it { is_expected.to contain_service('kopano-spooler') }

          # Packages 
          it { is_expected.to contain_package('kopano-server').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-dagent').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-gateway').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-ical').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-monitor').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-search').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-spooler').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-webapp').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-webapp-plugin-desktopnotifications').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-webapp-plugin-spell-en-us').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-webapp-plugin-spell-nl').with_ensure('installed') }
          it { is_expected.to contain_package('kopano-webapp-plugin-spell').with_ensure('installed') }

          # Files
					it { is_expected.to contain_file('/etc/kopano/server.cfg').with_require('Package[kopano-server]') }
					it { is_expected.to contain_file('/etc/kopano/dagent.cfg').with_require('Package[kopano-dagent]') }
					it { is_expected.to contain_file('/etc/kopano/gateway.cfg').with_require('Package[kopano-gateway]') }
					it { is_expected.to contain_file('/etc/kopano/ical.cfg').with_require('Package[kopano-ical]') }
					it { is_expected.to contain_file('/etc/kopano/monitor.cfg').with_require('Package[kopano-monitor]') }
					it { is_expected.to contain_file('/etc/kopano/search.cfg').with_require('Package[kopano-search]') }
					it { is_expected.to contain_file('/etc/kopano/spooler.cfg').with_require('Package[kopano-spooler]') }

        end
      end
    end
  end
end
