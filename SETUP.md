# Setup Guide for ShiftCare Client Management System

## Prerequisites

This application requires Ruby 2.7 or higher. If you don't have Ruby installed, follow these instructions:

## Installing Ruby

### Windows

1. **Download RubyInstaller**:
   - Go to https://rubyinstaller.org/
   - Download the latest Ruby+Devkit version (recommended: Ruby+Devkit 3.2.x)
   - Choose the x64 version for 64-bit Windows

2. **Install Ruby**:
   - Run the downloaded installer
   - Check "Add Ruby executables to your PATH"
   - Check "Associate .rb and .rbw files with this Ruby installation"
   - Click "Install"

3. **Verify Installation**:
   ```cmd
   ruby --version
   gem --version
   ```

### macOS

1. **Using Homebrew** (recommended):
   ```bash
   brew install ruby
   ```

2. **Using rbenv**:
   ```bash
   brew install rbenv
   rbenv install 3.2.2
   rbenv global 3.2.2
   ```

3. **Verify Installation**:
   ```bash
   ruby --version
   gem --version
   ```

### Linux (Ubuntu/Debian)

1. **Install Ruby**:
   ```bash
   sudo apt update
   sudo apt install ruby ruby-dev ruby-bundler
   ```

2. **Verify Installation**:
   ```bash
   ruby --version
   gem --version
   ```

## Installing Bundler

Bundler should be included with Ruby, but if not:

```bash
gem install bundler
```

## Setting Up the Application

1. **Clone or download the project**:
   ```bash
   git clone <repository-url>
   cd shiftcare-client-manager
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Make the application executable** (Unix/Linux/macOS):
   ```bash
   chmod +x bin/shiftcare
   ```

4. **Run the application**:
   ```bash
   ./bin/shiftcare
   ```

   Or on Windows:
   ```cmd
   ruby bin/shiftcare
   ```

## Running Tests

1. **Install test dependencies**:
   ```bash
   bundle install
   ```

2. **Run the test suite**:
   ```bash
   bundle exec rspec
   ```

3. **Run tests with coverage**:
   ```bash
   bundle exec rspec --format documentation
   ```

## Troubleshooting

### Common Issues

1. **"ruby command not found"**:
   - Ruby is not installed or not in PATH
   - Follow the installation instructions above

2. **"bundle command not found"**:
   - Install bundler: `gem install bundler`

3. **Permission denied errors** (Unix/Linux/macOS):
   - Make the script executable: `chmod +x bin/shiftcare`

4. **Network errors when loading data**:
   - Check your internet connection
   - The application requires internet access to fetch the initial dataset

5. **Gem installation errors**:
   - Try updating bundler: `gem update bundler`
   - Clear gem cache: `gem cleanup`

### Windows-Specific Issues

1. **PowerShell execution policy**:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **Path issues**:
   - Ensure Ruby is added to your system PATH
   - Restart your terminal after installation

### macOS-Specific Issues

1. **Xcode Command Line Tools**:
   ```bash
   xcode-select --install
   ```

2. **Permission issues**:
   ```bash
   sudo gem install bundler
   ```

## Alternative Setup Methods

### Using Docker (if available)

1. **Create Dockerfile**:
   ```dockerfile
   FROM ruby:3.2-slim
   WORKDIR /app
   COPY . .
   RUN bundle install
   CMD ["./bin/shiftcare"]
   ```

2. **Build and run**:
   ```bash
   docker build -t shiftcare .
   docker run -it shiftcare
   ```

### Using RVM (Ruby Version Manager)

1. **Install RVM**:
   ```bash
   \curl -sSL https://get.rvm.io | bash -s stable
   ```

2. **Install Ruby**:
   ```bash
   rvm install 3.2.2
   rvm use 3.2.2 --default
   ```

3. **Install dependencies**:
   ```bash
   bundle install
   ```

## Verification

After setup, you can verify everything is working by running:

```bash
ruby examples/demo.rb
```

This will run a demonstration of all the application's features.

## Support

If you encounter any issues during setup, please:

1. Check the troubleshooting section above
2. Ensure you have the correct Ruby version (2.7+)
3. Verify your internet connection
4. Check the project's README.md for additional information

For additional help, please create an issue in the project repository with:
- Your operating system and version
- Ruby version (`ruby --version`)
- The exact error message you're seeing
- Steps you've already tried 