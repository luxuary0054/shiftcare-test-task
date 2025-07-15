require 'json'
require 'net/http'
require 'uri'

module ShiftCare
  class ClientManager
    attr_reader :clients

    def initialize(data_source = nil)
      @clients = []
      @data_source = data_source || 'https://appassets02.shiftcare.com/manual/clients.json'
      load_clients
    end

    def search_by_name(query)
      return [] if query.nil? || query.strip.empty?

      query_lower = query.downcase.strip
      @clients.select do |client|
        client['name']&.downcase&.include?(query_lower)
      end
    end

    def find_duplicate_emails
      email_counts = Hash.new(0)
      email_groups = Hash.new { |h, k| h[k] = [] }

      @clients.each do |client|
        email = client['email']&.downcase&.strip
        next unless email && !email.empty?

        email_counts[email] += 1
        email_groups[email] << client
      end

      email_groups.select { |_email, clients| clients.length > 1 }
    end

    def total_clients
      @clients.length
    end

    def unique_emails
      @clients.map { |client| client['email']&.downcase&.strip }.compact.uniq.length
    end

    private

    def load_clients
      if @data_source.start_with?('http')
        load_from_url
      else
        load_from_file
      end
    rescue StandardError => e
      raise "Failed to load clients data: #{e.message}"
    end

    def load_from_url
      uri = URI(@data_source)
      response = Net::HTTP.get_response(uri)
      
      unless response.is_a?(Net::HTTPSuccess)
        raise "HTTP request failed with status #{response.code}: #{response.message}"
      end

      @clients = JSON.parse(response.body)
    rescue JSON::ParserError => e
      raise "Invalid JSON format: #{e.message}"
    end

    def load_from_file
      unless File.exist?(@data_source)
        raise "File not found: #{@data_source}"
      end

      @clients = JSON.parse(File.read(@data_source))
    rescue JSON::ParserError => e
      raise "Invalid JSON format in file: #{e.message}"
    end
  end
end 