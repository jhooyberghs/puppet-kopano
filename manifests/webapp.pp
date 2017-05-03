# Class kopano::webapp
#
class kopano::webapp (
  String $package_name          = 'kopano-webapp',
  Array[String] $enable_plugins = [ 'desktopnotifications', 'spell', 'spell-en-us', 'spell-nl', ],
  String $package_version       = 'installed',
)
{
  package { $package_name:
    ensure => $package_version,
  }

  # install plugins
  $enable_plugins.each | $plugin | {
    package { "${package_name}-plugin-${plugin}":
      ensure => $package_version,
    }
  }
}
