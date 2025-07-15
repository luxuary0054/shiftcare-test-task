require 'spec_helper'
require 'json'
require 'tempfile'

RSpec.describe ShiftCare::ClientManager do
  let(:sample_clients) do
    [
      { 'id' => 1, 'name' => 'John Doe', 'email' => 'john@example.com', 'created_at' => '2023-01-01' },
      { 'id' => 2, 'name' => 'Jane Smith', 'email' => 'jane@example.com', 'created_at' => '2023-01-02' },
      { 'id' => 3, 'name' => 'John Smith', 'email' => 'john@example.com', 'created_at' => '2023-01-03' },
      { 'id' => 4, 'name' => 'Alice Johnson', 'email' => 'alice@example.com', 'created_at' => '2023-01-04' },
      { 'id' => 5, 'name' => 'Bob Wilson', 'email' => 'bob@example.com', 'created_at' => '2023-01-05' }
    ]
  end

  describe '#initialize' do
    context 'with valid JSON file' do
      let(:temp_file) do
        file = Tempfile.new(['clients', '.json'])
        file.write(sample_clients.to_json)
        file.close
        file.path
      end

      after { File.delete(temp_file) if File.exist?(temp_file) }

      it 'loads clients from file successfully' do
        manager = described_class.new(temp_file)
        expect(manager.clients).to eq(sample_clients)
      end
    end

    context 'with invalid JSON file' do
      let(:temp_file) do
        file = Tempfile.new(['clients', '.json'])
        file.write('invalid json content')
        file.close
        file.path
      end

      after { File.delete(temp_file) if File.exist?(temp_file) }

      it 'raises an error for invalid JSON' do
        expect { described_class.new(temp_file) }.to raise_error(/Invalid JSON format/)
      end
    end

    context 'with non-existent file' do
      it 'raises an error for missing file' do
        expect { described_class.new('nonexistent.json') }.to raise_error(/File not found/)
      end
    end
  end

  describe '#search_by_name' do
    let(:manager) { described_class.new }

    before do
      allow(manager).to receive(:load_clients)
      manager.instance_variable_set(:@clients, sample_clients)
    end

    context 'with matching query' do
      it 'finds clients with partial name match' do
        results = manager.search_by_name('john')
        expect(results.length).to eq(2)
        expect(results.map { |c| c['name'] }).to include('John Doe', 'John Smith')
      end

      it 'is case insensitive' do
        results = manager.search_by_name('JOHN')
        expect(results.length).to eq(2)
        expect(results.map { |c| c['name'] }).to include('John Doe', 'John Smith')
      end

      it 'finds exact name match' do
        results = manager.search_by_name('John Doe')
        expect(results.length).to eq(1)
        expect(results.first['name']).to eq('John Doe')
      end
    end

    context 'with non-matching query' do
      it 'returns empty array for no matches' do
        results = manager.search_by_name('xyz')
        expect(results).to be_empty
      end
    end

    context 'with edge cases' do
      it 'returns empty array for nil query' do
        results = manager.search_by_name(nil)
        expect(results).to be_empty
      end

      it 'returns empty array for empty query' do
        results = manager.search_by_name('')
        expect(results).to be_empty
      end

      it 'returns empty array for whitespace-only query' do
        results = manager.search_by_name('   ')
        expect(results).to be_empty
      end

      it 'handles clients with nil names' do
        clients_with_nil = sample_clients + [{ 'id' => 6, 'name' => nil, 'email' => 'test@example.com' }]
        manager.instance_variable_set(:@clients, clients_with_nil)
        
        results = manager.search_by_name('test')
        expect(results).to be_empty
      end
    end
  end

  describe '#find_duplicate_emails' do
    let(:manager) { described_class.new }

    before do
      allow(manager).to receive(:load_clients)
      manager.instance_variable_set(:@clients, sample_clients)
    end

    context 'with duplicate emails' do
      it 'finds clients with duplicate email addresses' do
        duplicates = manager.find_duplicate_emails
        expect(duplicates.keys).to include('john@example.com')
        expect(duplicates['john@example.com'].length).to eq(2)
      end

      it 'returns only emails with duplicates' do
        duplicates = manager.find_duplicate_emails
        expect(duplicates.keys).not_to include('jane@example.com', 'alice@example.com', 'bob@example.com')
      end
    end

    context 'with no duplicates' do
      let(:unique_clients) do
        [
          { 'id' => 1, 'name' => 'John Doe', 'email' => 'john@example.com' },
          { 'id' => 2, 'name' => 'Jane Smith', 'email' => 'jane@example.com' },
          { 'id' => 3, 'name' => 'Alice Johnson', 'email' => 'alice@example.com' }
        ]
      end

      it 'returns empty hash when no duplicates exist' do
        manager.instance_variable_set(:@clients, unique_clients)
        duplicates = manager.find_duplicate_emails
        expect(duplicates).to be_empty
      end
    end

    context 'with edge cases' do
      it 'handles clients with nil emails' do
        clients_with_nil = sample_clients + [{ 'id' => 6, 'name' => 'Test User', 'email' => nil }]
        manager.instance_variable_set(:@clients, clients_with_nil)
        
        duplicates = manager.find_duplicate_emails
        expect(duplicates.keys).to include('john@example.com')
      end

      it 'handles clients with empty emails' do
        clients_with_empty = sample_clients + [{ 'id' => 6, 'name' => 'Test User', 'email' => '' }]
        manager.instance_variable_set(:@clients, clients_with_empty)
        
        duplicates = manager.find_duplicate_emails
        expect(duplicates.keys).to include('john@example.com')
      end

      it 'is case insensitive for email comparison' do
        clients_with_case = [
          { 'id' => 1, 'name' => 'John Doe', 'email' => 'JOHN@EXAMPLE.COM' },
          { 'id' => 2, 'name' => 'John Smith', 'email' => 'john@example.com' }
        ]
        manager.instance_variable_set(:@clients, clients_with_case)
        
        duplicates = manager.find_duplicate_emails
        expect(duplicates.keys).to include('john@example.com')
        expect(duplicates['john@example.com'].length).to eq(2)
      end
    end
  end

  describe '#total_clients' do
    let(:manager) { described_class.new }

    before do
      allow(manager).to receive(:load_clients)
      manager.instance_variable_set(:@clients, sample_clients)
    end

    it 'returns the total number of clients' do
      expect(manager.total_clients).to eq(5)
    end
  end

  describe '#unique_emails' do
    let(:manager) { described_class.new }

    before do
      allow(manager).to receive(:load_clients)
      manager.instance_variable_set(:@clients, sample_clients)
    end

    it 'returns the number of unique email addresses' do
      expect(manager.unique_emails).to eq(4) # john@example.com appears twice
    end

    it 'handles nil and empty emails' do
      clients_with_edge_cases = sample_clients + [
        { 'id' => 6, 'name' => 'Test User', 'email' => nil },
        { 'id' => 7, 'name' => 'Test User 2', 'email' => '' }
      ]
      manager.instance_variable_set(:@clients, clients_with_edge_cases)
      
      expect(manager.unique_emails).to eq(4) # nil and empty emails are excluded
    end
  end
end 