require 'minitest/spec'
require 'minitest/autorun'
require 'pp'

require File.expand_path("../../lib/eloquent", __FILE__)

ROOT = File.expand_path("../..", __FILE__)
TMP_DIR = File.join ROOT, "tmp"
BIN_DIR = File.join ROOT, "bin"

support = File.join(ROOT, "spec/support/*.rb")
Dir[support].each{|f| require f}


include IntegrationSupport

