# Class kopano
#
class kopano (
  Boolean $enable_server  = true,
  Boolean $enable_dagent  = true,
  Boolean $enable_gateway = true,
  Boolean $enable_ical    = true,
  Boolean $enable_monitor = true,
  Boolean $enable_search  = true,
  Boolean $enable_spooler = true,
  Boolean $enable_webapp = true,
)
{
  if $enable_server {
    include kopano::server
  }
  if $enable_dagent {
    include kopano::dagent
  }
  if $enable_gateway {
    include kopano::gateway
  }
  if $enable_ical {
    include kopano::ical
  }
  if $enable_monitor {
    include kopano::monitor
  }
  if $enable_search {
    include kopano::search
  }
  if $enable_spooler {
    include kopano::spooler
  }
  if $enable_webapp {
    include kopano::webapp
  }

}
