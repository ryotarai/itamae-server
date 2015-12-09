module EventsHelper
  def event_description_html(event)
    payload = event.payload

    case event.event_type
    when "attribute_changed"
      html = ''
      html << '<h5>Attribute Changed</h5>'
      html << '<table class="table">'
      html << "<tr><th>Field</th><th>From</th><th>To</th></tr>"
      payload["from"].each do |key, from_value|
        to_value = payload["to"][key]
        if from_value.nil? && to_value.nil?
          # pass
        elsif from_value == to_value || to_value.nil?
          # does not change
        else
          html << "<tr><td>#{key}</td><td>#{from_value}</td><td>#{to_value}</td></tr>"
        end
      end
      html << "</table>"
      html
    when "file_content_changed"
      lines = payload["diff"].each_line.map do |line|
        line.chomp!
        if line.start_with?('+')
          %{<span style="color: green;">#{line}</span>}
        elsif line.start_with?('-')
          %{<span style="color: red;">#{line}</span>}
        else
          line
        end
      end
      "<h5>File Content Changed</h5><pre><code>#{lines.join("\n")}</code></pre>"
    else
      ""
    end
  end
end
