# spec helper
#
ROOT_DIR = File.expand_path("../..", __FILE__)
TMP_DIR = File.join(ROOT_DIR, "tmp")
BIN_DIR = File.join(ROOT_DIR, "bin")

require 'support/bin_support'

RSpec.configure do |config|
  config.include BinSupport
  config.mock_with :rspec
  config.fail_fast = true
end

