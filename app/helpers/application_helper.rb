module ApplicationHelper
  def fingerprint_tag(api_key)
    return content_tag :div if apiKey.blank?

    content_tag :div, '', data: { controller: 'fingerprint', fingerprint_api_key_value: api_key }
  end
end
