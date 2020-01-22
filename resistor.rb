#get the value hashes from the value_hashes.rb file in the same directory
#this loads the four hashes : "VALUES", "MULTIPLIERS", "TOLERANCES", "TEMP_COEFFS"
#and the RINGS position array
localDir = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift (localDir)
require "value_hashes.rb"


#create a resistor class
class Resistor

	attr_accessor :valueString, :resistance, :tolerance, :temp_coeff

	@@valueString = ""
	@@resistance = 0
	@@tolerance = 0
	@@temp_coeff = 0

	def getValue(ringNumber)
		puts "please type the value of the #{ringNumber} ring"
		puts "accepted values : black, brown, red, orange, yellow, green, blue, violet, grey, white"
		userSelect = gets.chop.downcase
		if VALUES.has_key?(userSelect)
			@@valueString << VALUES[userSelect]
		else
			puts "value unknown, please refer to the list"
			exit
		end
	end

	def getMultiply(ringNumber)
		puts "please type the value of the #{ringNumber} ring"
		puts "accepted values : black, brown, red, orange, yellow, green, blue, gold, silver"
		userSelect = gets.chop.downcase
		if MULTIPLIERS.has_key?(userSelect)
			@@resistance = (@@valueString.to_i) * MULTIPLIERS[userSelect]
			# @@resistance is now refactored to present 1.34MOhm instead of 1340000Ohms
			# or 1.34KOhms instead of 1340Ohms
			if @@resistance > 1000000
				@@resistance = @@resistance / 1000000
				@@resistance = @@resistance.to_s + "M"
			elsif @@resistance > 1000
				@@resistance = @@resistance / 1000
				@@resistance = @@resistance.to_s + "K"
			end
			# reset the valueString, so that it doesn't present the original unmultiplied value
			# valueString will be reused by self.writer as the final string the user will be presented with
			@@valueString = ""
		else
			puts"value unknown, please refer to the list"
			exit
		end
	end

	def getTolerance(ringNumber)
		puts "please type the value of the #{ringNumber} ring"
		puts "accepted values : brown, red, green, blue, violet, gold, silver"
		userSelect = gets.chop.downcase
		if TOLERANCES.has_key?(userSelect)
			@@tolerance = TOLERANCES[userSelect]
		else
			puts"value unknown, please refer to the list"
			exit
		end
	end

	def getTemp(ringNumber)
		puts "please type the value of the #{ringNumber} ring"
		puts "accepted values : black, brown, red, orange, yellow, green, blue, violet, grey"
		userSelect = gets.chop.downcase
		if TEMP_COEFFS.has_key?(userSelect)
			@@temp_coeff = TEMP_COEFFS[userSelect]
		else
			puts"value unknown, please refer to the list"
			exit
		end
	end

	def repeater
		puts "How many bands does the resistor have ?"
		bands = gets.chop.to_i
		ring = 0
		case bands
		when 4
			2.times {getValue(RINGS[ring]) 
			ring += 1}
			getMultiply(RINGS[ring])
			ring += 1
			getTolerance(RINGS[ring])
		when 5 
			3.times {getValue(RINGS[ring]) 
			ring += 1}
			getMultiply(RINGS[ring])
			ring += 1
			getTolerance(RINGS[ring])
		when 6
			3.times {getValue(RINGS[ring]) 
			ring += 1}
			getMultiply(RINGS[ring])
			ring += 1
			getTolerance(RINGS[ring])
			ring += 1
			getTemp(RINGS[ring])
		else
			puts "A resistor is allowed 4-6 bands, not more, not less"
			exit
		end
	end

	def writer
		@@valueString << "The value of this resistor is #{@@resistance}Ohms"
		@@valueString << ", with a tolerance of #{@@tolerance}%"
		if @@temp_coeff == 0
			@@valueString << "."
		else
			@@valueString << " and a temperature coefficient of #{@@temp_coeff}ppmK ."
		end
		puts @@valueString
	end
end