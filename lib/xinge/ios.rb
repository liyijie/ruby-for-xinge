require 'xinge/base'
module Xinge
  class Ios < Base

    ENV_MAP = {'production' => 2, 'development' => 2}

    def initialize(accessId = nil, secretKey = nil, options = {})
      super
    end
    def pushToSingleDevice(token, title, content, params={}, custom_content={})
      logger.info "iOS environment is:#{ENV_MAP[Xinge.config[:env]]}"
      self.push_single_device(token, 0, build_simple_message(title, content, custom_content), params.merge({environment: ENV_MAP[Xinge.config[:env]]}))
    end
    def pushToAllDevice(title, content, params={}, custom_content={})
      self.push_all_device(1, build_simple_message(title, content, custom_content), params.merge({environment: ENV_MAP[Xinge.config[:env]]}))
    end

    protected

    def build_simple_message(title, content, custom_content)
      {
        aps: {
          alert: {
            title: title,
            body: content
          },
          sound: 'default',
          badge: 1
        }
      }.merge(custom_content).to_json
    end
  end
end
