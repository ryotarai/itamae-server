module ExecutionsHelper
  def event_description_html(event)
    payload = event.payload

    case event.event_type
    when "attribute_changed"
      lines = []
      lines << "<ul>"
      payload["from"].each do |key, from_value|
        to_value = payload["to"][key]
        if from_value.nil? && to_value.nil?
          # pass
        elsif from_value.nil? && !to_value.nil?
          lines << "<li>#{key} changed to '#{to_value}'</li>"
        elsif from_value == to_value || to_value.nil?
          # does not change
        else
          lines << "<li>#{key} changed from '#{from_value}' to '#{to_value}'</li>"
        end
      end
      lines << "</ul>"
      lines.join
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
      "<pre><code>#{lines.join("\n")}</code></pre>"
    else
      ""
    end
  end
end
