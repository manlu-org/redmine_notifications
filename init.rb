Redmine::Plugin.register :notifications do
  name 'Redmine Notifications plugin'
  author 'sllt'
  description 'This plugin allows your application receive redmine notifications'
  version '0.0.1'
  url 'https://github.com/manlu-org/redmine_notifications'
  author_url 'http://github.com/sllt'

  settings :default => {
    :push => 'no',
    :url => 'https://example.com',
  }, :partial => 'settings/notification_settings'
end

require 'notifications/hooks/controller_issues_new_after_save'
