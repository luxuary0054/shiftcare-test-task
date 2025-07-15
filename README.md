# ShiftCare Client Management System

A robust command-line application built in Ruby for managing and analyzing client data. This application provides powerful search capabilities and duplicate detection features with a modern, user-friendly interface.

## 🚀 Features

- **Smart Client Search**: Search through clients by name with partial matching (case-insensitive)
- **Duplicate Email Detection**: Find and display clients with duplicate email addresses
- **Interactive CLI**: Beautiful, colorized command-line interface with intuitive commands
- **Data Statistics**: View comprehensive dataset statistics
- **Error Handling**: Robust error handling for various edge cases
- **Extensible Architecture**: Designed for easy expansion and modification

## 📋 Requirements

- Ruby 2.7 or higher
- Internet connection (for fetching the initial dataset)

## 🛠️ Setup Instructions

### 1. Clone or Download the Project

```bash
git clone <repository-url>
cd shiftcare-test-task
```

### 2. Install Dependencies

```bash
bundle install
```

### 3. Make the Application Executable

```bash
chmod +x bin/shiftcare
```

### 4. Run the Application

```bash
./bin/shiftcare
```

Or alternatively:

```bash
ruby bin/shiftcare
```

## 📖 Usage

Once the application starts, you'll see a welcome screen with available commands. Here are the main commands:

### Search for Clients
```bash
search john
```
This will find all clients whose names contain "john" (case-insensitive).

### Find Duplicate Emails
```bash
duplicates
```
This will analyze the dataset and show any clients with duplicate email addresses.

### View Statistics
```bash
stats
```
This will display comprehensive statistics about the dataset.

### Get Help
```bash
help
```
Shows all available commands and their descriptions.

### Exit the Application
```bash
exit
```
or
```bash
quit
```

## 🧪 Running Tests

To run the comprehensive test suite:

```bash
bundle exec rspec
```

To run tests with coverage report:

```bash
bundle exec rspec --format documentation
```

## 🏗️ Project Structure

```
shiftcare-client-manager/
├── bin/
│   └── shiftcare                 # Main executable
├── lib/
│   ├── shiftcare.rb             # Main application entry point
│   ├── client_manager.rb        # Core business logic for client operations
│   ├── display_manager.rb       # UI and display logic
│   └── command_processor.rb     # Command parsing and execution
├── spec/
│   ├── spec_helper.rb           # RSpec configuration
│   ├── client_manager_spec.rb   # Tests for ClientManager
│   └── command_processor_spec.rb # Tests for CommandProcessor
├── Gemfile                      # Ruby dependencies
├── README.md                    # This file
└── .gitignore                   # Git ignore rules
```

## 🎯 Assumptions and Decisions Made

### Data Source
- **Assumption**: The application fetches data from the provided URL by default
- **Decision**: Implemented fallback to local file support for offline development
- **Rationale**: Ensures the application works in various environments

### Search Functionality
- **Assumption**: Users want partial matching for names
- **Decision**: Case-insensitive search with substring matching
- **Rationale**: Provides more flexible and user-friendly search experience

### Email Duplicate Detection
- **Assumption**: Case-insensitive email comparison is needed
- **Decision**: Normalize emails to lowercase before comparison
- **Rationale**: Prevents false negatives due to case differences

### Error Handling
- **Assumption**: Graceful degradation is important for user experience
- **Decision**: Comprehensive error handling with user-friendly messages
- **Rationale**: Prevents application crashes and guides users to correct usage

### Architecture
- **Assumption**: Code should be maintainable and testable
- **Decision**: Separation of concerns with distinct classes for different responsibilities
- **Rationale**: Makes the codebase easier to understand, test, and extend

## ⚠️ Known Limitations

1. **Network Dependency**: Requires internet connection for initial data loading
2. **Single Data Source**: Currently supports one data source at a time
3. **Search Field Limitation**: Search is currently limited to the 'name' field
4. **No Data Persistence**: Changes are not persisted between sessions
5. **No Authentication**: No user authentication or authorization features

## 🔮 Future Improvements

### High Priority
1. **Dynamic Field Search**: Allow users to specify which field to search (name, email, etc.)
2. **REST API Support**: Expose functionality via HTTP endpoints
3. **Multiple Data Sources**: Support for multiple JSON files or databases
4. **Data Validation**: Implement comprehensive data validation and sanitization
5. **Caching**: Add caching for improved performance with large datasets

### Medium Priority
1. **Advanced Search**: Implement regex search, fuzzy matching, and filters
2. **Data Export**: Export search results to various formats (CSV, JSON, etc.)
3. **Batch Operations**: Support for bulk operations on multiple clients
4. **Configuration**: User-configurable settings and preferences
5. **Logging**: Comprehensive logging for debugging and monitoring

### Low Priority
1. **Web Interface**: Add a web-based UI alongside the CLI
2. **Database Integration**: Support for PostgreSQL, MySQL, etc.
3. **Real-time Updates**: WebSocket support for real-time data updates
4. **User Management**: Multi-user support with roles and permissions
5. **Analytics Dashboard**: Advanced analytics and reporting features

## 🚀 Scaling Considerations

### Performance Optimizations
- **Indexing**: Implement database indexing for faster searches
- **Pagination**: Add pagination for large result sets
- **Caching**: Redis/Memcached for frequently accessed data
- **Background Jobs**: Use Sidekiq for heavy operations

### Architecture Enhancements
- **Microservices**: Split into separate services (search, analytics, etc.)
- **Load Balancing**: Distribute load across multiple instances
- **CDN**: Use CDN for static assets and data distribution
- **Monitoring**: Implement comprehensive monitoring and alerting

### Data Management
- **Sharding**: Distribute data across multiple databases
- **Replication**: Implement read replicas for better performance
- **Backup Strategy**: Automated backup and recovery procedures
- **Data Archiving**: Archive old data to reduce storage costs