def integer?(input)
  /^-?\d+$/.match(input)
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def years_to_months(years)
  years.to_f * 12
end

duration_in_years = nil
duration_in_months = nil
loop do
  puts "What is the duration of the load? (in years)"
  duration_in_years = gets.chomp
  
  if valid_number?(duration_in_years)
    duration_in_months = years_to_months(duration_in_years)
    break
  else
    puts "Must enter valid duration in years"
  end
end

puts duration_in_months