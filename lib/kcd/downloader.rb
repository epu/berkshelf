require 'em-synchrony'
require 'em-synchrony/em-http'

module KnifeCookbookDependencies
  class Downloader
    attr_reader :storage_path
    attr_reader :queue
    attr_accessor :concurrency

    def initialize(storage_path, concurrency = 6)
      @storage_path = storage_path
      @concurrency = concurrency
      @queue = []
    end

    def enqueue(source)
      validate_source!(source)

      @queue << source
    end

    def dequeue(source)
      @queue.delete(source)
    end

    def download
      EM.synchrony do
        results = EM::Synchrony::Iterator.new(queue, concurrency).map do |source, iter|
          result = source.async_download(storage_path)

          result.callback do
            dequeue(source)
            iter.return(result)
          end

          result.errback { iter.return(result) }
        end

        EventMachine.stop
        results
      end
    end

    private

      def validate_source!(source)
        unless source.respond_to?(:async_download)
          raise ArgumentError, "Cannot download an object that does not respond to :async_download."
        end
      end
  end
end
