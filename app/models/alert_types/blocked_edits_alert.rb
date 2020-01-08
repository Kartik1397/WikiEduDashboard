# frozen_string_literal: true

# == Schema Information
#
# Table name: alerts
#
#  id             :integer          not null, primary key
#  course_id      :integer
#  user_id        :integer
#  article_id     :integer
#  revision_id    :integer
#  type           :string(255)
#  email_sent_at  :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  message        :text(65535)
#  target_user_id :integer
#  subject_id     :integer
#  resolved       :boolean          default(FALSE)
#  details        :text(65535)
#

class BlockedEditsAlert < Alert
  def main_subject
    "Edit by #{user.username} was blocked"
  end

  def url
    user_profile_url
  end

  def ticket_body
    <<~BLOCK_DETAILS
      An automatic Dashboard edit was blocked. This may mean the Dashboard's IP address is
      being affected by a range block. (No additional alerts for subsequent blocked edits
      will be generated for 8 hours.)

      Affected user: #{user.username}

      Info: #{details}
    BLOCK_DETAILS
  end
end
