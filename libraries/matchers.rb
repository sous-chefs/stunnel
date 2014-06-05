if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method :stunnel_connection

  def create_stunnel_connection(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:stunnel_connection, :create, resource_name)
  end

  def delete_stunnel_connection(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:stunnel_connection, :delete, resource_name)
  end
end
