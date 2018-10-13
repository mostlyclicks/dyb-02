module Refinery
  module Inquiries
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Inquiries

      engine_name :refinery_inquiries

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "inquiries"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.inquiries_admin_inquiries_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Inquiries)
      end
    end
  end
end
