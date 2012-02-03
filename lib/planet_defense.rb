require 'optparse'

begin
  EXTRACT_PATH = File.dirname(File.dirname(File.expand_path(__FILE__)))

  ROOT_PATH = if ENV['OCRA_EXECUTABLE']
                File.dirname(File.expand_path(ENV['OCRA_EXECUTABLE']))
              elsif defined? OSX_EXECUTABLE_FOLDER
                File.dirname(OSX_EXECUTABLE_FOLDER)
              else
                EXTRACT_PATH
              end

  APP_NAME = File.basename(__FILE__).chomp(File.extname(__FILE__))

  RUNNING_FROM_EXECUTABLE = (ENV['OCRA_EXECUTABLE'] or defined?(OSX_EXECUTABLE))

  DEFAULT_LOG_FILE = "#{APP_NAME}.log"
  DEFAULT_LOG_FILE_PATH = File.join(ROOT_PATH, DEFAULT_LOG_FILE)

  def parse_options
    options = {}

    OptionParser.new do |parser|
      parser.banner =<<TEXT
Usage: #{File.basename(__FILE__)} [options]

  Defaults to using --#{RUNNING_FROM_EXECUTABLE ? 'log' : 'console'}

TEXT

      begin
        parser.parse!
      rescue OptionParser::ParseError => ex
        puts "ERROR: #{ex.message}"
        puts
        puts parser
        exit
      end
    end

    options
  end

  options = parse_options

  # Default to console mode normally; default to logfile when running executable.
  if RUNNING_FROM_EXECUTABLE and not options.has_key?(:log)
  end

  ENV['PATH'] = File.join(EXTRACT_PATH, 'bin') + File::PATH_SEPARATOR + ENV['PATH']

  require_relative "../lib/planet_defense/main"

  exit_message = ""

rescue => ex
  $stderr.puts "FATAL ERROR - #{ex.class}: #{ex.message}\n#{ex.backtrace.join("\n")}"
  raise ex # Just to make sure that the user sees the error in the CLI/IDE too.
ensure
  $stderr.reopen(original_stderr) if defined?(original_stderr) and original_stderr
  $stderr.puts exit_message if exit_message
  $stdout.reopen(original_stdout) if defined?(original_stdout) and original_stdout
end