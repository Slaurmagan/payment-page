Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_URL', nil)
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Получаем namespace и ветку из переменных окружения
  kubernetes_namespace = ENV.fetch('KUBERNETES_NAMESPACE', nil)
  current_branch = ENV.fetch('GIT_BRANCH', nil) # Передается через CI/CD или Kubernetes

  # Настраиваем environment для Sentry
  config.environment = kubernetes_namespace

  # Разрешаем Sentry только для определенных namespace и веток
  allowed_namespaces = %w[dev prod]
  allowed_branches = %w[dev main]

  if allowed_namespaces.include?(kubernetes_namespace) && allowed_branches.include?(current_branch)
    config.enabled_environments = allowed_namespaces
  end
end
