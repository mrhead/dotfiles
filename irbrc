begin
  # Configure history for Ruby 3.2 and older; Ruby 3.3+ defaults to the same
  # values.
  require "irb/ext/save-history"

  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
rescue LoadError
end

AwesomePrint.irb! if defined?(AwesomePrint)
