require 'spec_helper'

RSpec.describe ShiftCare::CommandProcessor do
  let(:client_manager) { instance_double(ShiftCare::ClientManager) }
  let(:display_manager) { instance_double(ShiftCare::DisplayManager) }
  let(:processor) { described_class.new(client_manager, display_manager) }

  describe '#process_command' do
    context 'with search command' do
      it 'processes search command with arguments' do
        expect(client_manager).to receive(:search_by_name).with('john doe').and_return([])
        expect(display_manager).to receive(:display_search_results).with([], 'john doe')
        
        processor.process_command('search john doe')
      end

      it 'handles search command without arguments' do
        expect(display_manager).to receive(:display_error).with("Search command requires a query. Usage: search <query>")
        
        processor.process_command('search')
      end

      it 'handles search command with empty arguments' do
        expect(display_manager).to receive(:display_error).with("Search command requires a query. Usage: search <query>")
        
        processor.process_command('search   ')
      end
    end

    context 'with duplicates command' do
      it 'processes duplicates command' do
        expect(client_manager).to receive(:find_duplicate_emails).and_return({})
        expect(display_manager).to receive(:display_duplicate_emails).with({})
        
        processor.process_command('duplicates')
      end
    end

    context 'with stats command' do
      it 'processes stats command' do
        expect(display_manager).to receive(:display_stats).with(client_manager)
        
        processor.process_command('stats')
      end
    end

    context 'with help command' do
      it 'processes help command' do
        expect(display_manager).to receive(:display_help)
        
        processor.process_command('help')
      end
    end

    context 'with exit command' do
      it 'processes exit command' do
        expect(display_manager).to receive(:display_goodbye)
        expect { processor.process_command('exit') }.to raise_error(SystemExit)
      end

      it 'processes quit command' do
        expect(display_manager).to receive(:display_goodbye)
        expect { processor.process_command('quit') }.to raise_error(SystemExit)
      end
    end

    context 'with unknown command' do
      it 'displays error for unknown command' do
        expect(display_manager).to receive(:display_error).with("Unknown command: 'unknown'. Type 'help' for available commands.")
        
        processor.process_command('unknown')
      end
    end

    context 'with edge cases' do
      it 'handles nil input' do
        expect { processor.process_command(nil) }.not_to raise_error
      end

      it 'handles empty input' do
        expect { processor.process_command('') }.not_to raise_error
      end

      it 'handles whitespace-only input' do
        expect { processor.process_command('   ') }.not_to raise_error
      end

      it 'handles case insensitive commands' do
        expect(display_manager).to receive(:display_help)
        processor.process_command('HELP')
      end
    end

    context 'with errors' do
      it 'handles exceptions and displays error message' do
        allow(client_manager).to receive(:search_by_name).and_raise(StandardError.new('Test error'))
        expect(display_manager).to receive(:display_error).with('Test error')
        
        processor.process_command('search test')
      end
    end
  end
end 