module ComicVine
  class Api
    module ApiMethods
      def types
        api_call('types', {})
      end

      def search(args = {})
        api_call('search', args)
      end

      def initial_define_api_methods
        # types data from API has bug(s), in json file data are fixed
        path = File.join(File.dirname(__FILE__), '../../../config/types.json')
        stored_types = JSON.parse(File.read(path))
        define_api_methods(stored_types)
      end

      # Maybe in future ComicVine devs will fix bug in types,
      # when it happened then you can still work with new endpoints,
      # just run #redefine_api_methods method,
      def redefine_api_methods
        define_api_methods(types.results, true)
      end

      private

      def define_api_methods(stored_types, redefine = false)
        stored_types.each do |type|
          define_collection_method(type, redefine)
          define_entity_method(type, redefine)
        end
      end

      def define_collection_method(type, redefine)
        resource_name = type['list_resource_name']
        optional_define_api_method(resource_name, redefine) do |method_name|
          self.class.send(:define_method, method_name) do |args = {}|
            api_call(resource_name, args)
          end
        end
      end

      def define_entity_method(type, redefine)
        resource_name = type['detail_resource_name']
        optional_define_api_method(resource_name, redefine) do |method_name|
          self.class.send(:define_method, method_name) do |id, args = {}|
            path = "#{resource_name}/#{type['id']}-#{id}"
            api_call(path, args)
          end
        end
      end

      def optional_define_api_method(type, redefine)
        return if redefine || (!redefine && self.class.method_defined?(type))

        method_name = :"#{type}_#{Time.now.to_f.to_s.tr('.', '_')}"
        yield(method_name)
        self.class.send(:alias_method, type.to_sym, method_name)
      end
    end
  end
end
