module ApplicationHelper
  PAYMENT_METHOD_TO_REQUEST_PATH = {
    'redirect' => 'generate_invoice_link',
  }.freeze

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

  def request_on_connect(payment)
    content_tag :div, '',
                data: {
                  controller: 'request-on-connect',
                  request_on_connect_path_value: PAYMENT_METHOD_TO_REQUEST_PATH[payment[:payment_method_type]].presence || 'requisite',
                }
  end
end
