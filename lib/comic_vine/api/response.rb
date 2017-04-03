module ComicVine
  class Api
    class Response
      attr_reader :raw_response, :status, :headers, :body, :error, :limit,
                  :offset, :number_of_page_results, :number_of_total_results,
                  :status_code, :results, :version

      def initialize(status:, headers:, body:)
        @status = status
        @headers = headers
        @body = body

        parse_body
      end

      private

      def parse_body
        data = JSON.parse(body)
        methods = %w[error limit offset number_of_page_results
                     number_of_total_results status_code results version]

        methods.each do |method_name|
          instance_variable_set(:"@#{method_name}", data[method_name])
        end
      rescue
        nil
      end
    end
  end
end
