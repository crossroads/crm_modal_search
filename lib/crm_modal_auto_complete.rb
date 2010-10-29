# Require all files in lib/crm_* plugin directory
Dir.glob(File.join(File.dirname(__FILE__), "crm_*", "*.rb")).each {|f| require f }
