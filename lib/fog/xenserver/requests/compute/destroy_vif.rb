module Fog
  module Compute
    class XenServer
      class Real
        def destroy_vif( ref, extra_args = {})
          Fog::Logger.deprecation(
              'This method is deprecated. Use #destroy_record instead.'
          )
          @connection.request({:parser => Fog::Parsers::XenServer::Base.new, :method => 'VIF.destroy'}, ref)
        end
      end

      class Mock
        def destroy_vif()
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
