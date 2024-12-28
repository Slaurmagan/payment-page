module ApplicationHelper
  def fingerprint_tag(api_key, endpoint, url_pattern)
    return content_tag :div if api_key.blank? || endpoint.blank? || url_pattern.blank?

    content_tag :div, '',
                data: {
                  controller: 'analytics',
                  analytics_api_key_value: api_key,
                  analytics_endpoint_value: endpoint,
                  analytics_script_url_pattern: url_pattern
                }
  end
end
