localDir = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift (localDir)
require "resistor.rb"
require "value_hashes.rb"

resistor = Resistor.new
resistor.repeater
resistor.writer


puts resistor.valueString