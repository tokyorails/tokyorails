module ActiveResource
  class Base
    class << self
      def instantiate_collection(collection, prefix_options = {})
        collection = collection["results"] if collection.instance_of?(Hash)
        collection.collect! { |record| instantiate_record(record, prefix_options) }
      end
    end
  end
end
