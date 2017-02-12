class SlackNotifier
  def self.ping(channel="#server", content)
    retry_time = 0
    @notifier ||= Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
    begin
      @notifier.ping "#{Rails.env}: #{content}"
    rescue
      if retry_time < 3
        retry_time += 1
        retry
      end
    end
  end
end
