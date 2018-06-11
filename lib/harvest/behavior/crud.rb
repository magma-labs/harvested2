module Harvest
  module Behavior
    module Crud
      # Retrieves all items
      # @return [Array<Harvest::BaseModel>] an array of models depending on where you're calling it from (e.g. [Harvest::Client] from Harvest::Base#clients)
      def all(query_options = {})
        response = request(:get, credentials, api_model.api_path, query: query_options)
        response_parsed = api_model.to_json(response.parsed_response)

        if response_parsed['total_pages'] > 1
          counter = response_parsed['page']

          while counter <= response_parsed['total_pages'] do
            counter += 1
            query_options = query_options.merge!({ 'page' => counter })

            response_page = request(:get, credentials, api_model.api_path,
              query: query_options)
            page_result = api_model.to_json(response_page.parsed_response)
            response_parsed[api_model.json_root.pluralize.to_s]
              .concat(page_result[api_model.json_root.pluralize.to_s])
          end
        end

        api_model.parse(response_parsed)
      end

      # Retrieves an item by id
      # @overload find(id)
      #   @param [Integer] the id of the item you want to retreive
      # @overload find(id)
      #   @param [String] id the String version of the id
      # @overload find(model)
      #   @param [Harvest::BaseModel] id you can pass a model and it will return a refreshed version
      #
      # @return [Harvest::BaseModel] the model depends on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def find(id, query_options = {})
        raise 'ID is required' unless id

        response = request(:get, credentials, "#{api_model.api_path}/#{id}", query: query_options)
        api_model.parse(response.parsed_response).first
      end

      # Creates an item
      # @param [Harvest::BaseModel] model the item you want to create
      # @return [Harvest::BaseModel] the created model depending on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def create(model)
        model = api_model.wrap(model)
        response = request(:post, credentials, api_model.api_path, body: model.to_json)
        model = api_model.parse(response.parsed_response).first
        find(model.id)
      end

      # Updates an item
      # @param [Harvest::BaseModel] model the model you want to update
      # @return [Harvest::BaseModel] the created model depending on where you're calling it from (e.g. Harvest::Client from Harvest::Base#clients)
      def update(model)
        model = api_model.wrap(model)
        response = request(:put, credentials, "#{api_model.api_path}/#{model.id}", body: model.to_json)
        model = api_model.parse(response.parsed_response).first
        find(model.id)
      end

      # Deletes an item
      # @overload delete(model)
      #  @param [Harvest::BaseModel] model the item you want to delete
      # @overload delete(id)
      #  @param [Integer] id the id of the item you want to delete
      # @overload delete(id)
      #  @param [String] id the String version of the id of the item you want to delete
      #
      # @return [Integer] the id of the item deleted
      def delete(model)
        model = api_model.wrap(model)
        response = request(:delete, credentials, "#{api_model.api_path}/#{model.id}")
        model.id
      end
    end
  end
end
