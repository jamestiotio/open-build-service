module Event
  class RepoBuildFinished < Base
    self.message_bus_routing_key = 'repo.build_finished'
    self.description = 'Repository finished building'
    payload_keys :project, :repo, :arch, :buildid
    after_save :clear_cache

    private

    def clear_cache
      # TODO: We should touch the repository instead of deleting the key
      # to invalidate the cache. However, repository currently does not have
      # an updated_at column so we can not use Rails' cache_key method.
      project_name = payload[:project]
      repository_name = payload[:repo]
      architecture_name = payload[:arch]
      Rails.cache.delete("build_id-#{project_name}-#{repository_name}-#{architecture_name}")
      Rails.cache.delete("failed_results-#{project_name}")
    end
  end
end

# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  eventtype   :string(255)      not null, indexed
#  payload     :text(65535)
#  created_at  :datetime         indexed
#  updated_at  :datetime
#  undone_jobs :integer          default(0)
#  mails_sent  :boolean          default(FALSE), indexed
#
# Indexes
#
#  index_events_on_created_at  (created_at)
#  index_events_on_eventtype   (eventtype)
#  index_events_on_mails_sent  (mails_sent)
#
