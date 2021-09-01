require 'json'
require 'http'
module Notifications
  module Hooks
    class IssuesHook < Redmine::Hook::ViewListener
      def controller_issues_new_after_save(context = {})
        if Setting.plugin_notifications[:push] == 'yes'
          params = {
            :action => 'issue_create',
            :project_id => context[:project].id,
            :project_name => context[:project].name,
            :issue_id => context[:issue].id,
            :issue_subject => context[:issue].subject,
            :issue_status_id => context[:issue].status_id,
            :issue_status_name => IssueStatus.find(context[:issue].status_id).name,
            :assigned_to_id => context[:issue].assigned_to_id,
            :assigned_to_username => if (u = User.find_by_id(context[:issue].assigned_to_id)) != nil ; u.name; else "" end,
            :issue_author_id => context[:issue].author_id,
            :issue_author_name => User.find_by_id(context[:issue].author_id).name
          }

          Thread.new do
            HTTP.post(Setting.plugin_notifications[:url], :json => params)
          end
        end
      end

      def controller_issues_edit_after_save(context = {})
        if Setting.plugin_notifications[:push] == 'yes'
          params = {
            :action => 'issue_update',
            :project_id => context[:project].id,
            :project_name => context[:project].name,
            :issue_id => context[:issue].id,
            :issue_subject => context[:issue].subject,
            :issue_status_id => context[:issue].status_id,
            :issue_status_name => IssueStatus.find(context[:issue].status_id).name,
            :assigned_to_id => context[:issue].assigned_to_id,
            :assigned_to_username => if (u = User.find_by_id(context[:issue].assigned_to_id)) != nil ; u.name; else ""; end,
            :issue_author_id => context[:issue].author_id,
            :issue_author_name => User.find_by_id(context[:issue].author_id).name
          }

          Thread.new do
            HTTP.post(Setting.plugin_notifications[:url], :json => params)
          end
        end
      end
    end

  end
end
