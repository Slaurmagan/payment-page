module ApplicationHelper
  def fingerprint_tag(api_key, endpoint, url_pattern)
    return content_tag :div if api_key.blank? || endpoint.blank? || url_pattern.blank?

    content_tag :div, '',
                data: {
                  controller: 'analytics',
                  analytics_api_key_value: api_key,
                  analytics_endpoint_value: endpoint,
                  analytics_url_pattern_value: url_pattern
                }
  end

  def link_as_qr_code(uri)
    RQRCode::QRCode.new(uri).as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 3,
      standalone: true,
      size: 10
    ).html_safe
  end
end
