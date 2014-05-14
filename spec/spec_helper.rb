RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order = "random"
end

require_relative '../lib/bizarro'
Dir['lib/**/*.rb'].each { |f| require_relative "../#{f}" }
