require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

AwesomePrint.irb! if defined?(AwesomePrint)
