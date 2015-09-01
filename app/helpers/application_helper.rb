module ApplicationHelper
  STATUS_LABEL_TYPE = {
    "pending" => "default",
    "in_progress" => "info",
    "completed" => "success",
    "aborted" => "danger",
  }

  def status_label(status)
    type = STATUS_LABEL_TYPE[status]
    unless type
      raise "unknown status: #{status}"
    end

    %{<span class="label label-#{type}">#{status.gsub('_', ' ')}</span>}
  end

  def dry_run_label(is_dry_run)
    if is_dry_run
      type = "default"
      body = "dry run"
    else
      type = "primary"
      body = "actual run"
    end

    %{<span class="label label-#{type}">#{body}</span>}
  end
end
