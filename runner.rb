require 'unirest'

system "clear"

puts "Welcome to my Cookbook App"
puts "Make a selection"
puts "   [1] See all recipes"
puts "   [2] See one recipe"
puts "   [3] Create a new recipe"
puts "   [4] Update a recipe"
puts "   [5] Delete a recipe"

input_options = gets.chomp

if input_options == "1"
  response = Unirest.get("http://localhost:3000/recipes")
  recipes = response.body
  puts JSON.pretty_generate(recipes)
elsif input_options == "2"
  print "Enter recipe id:"
  input_id = gets.chomp
  response = Unirest.get("http://localhost:3000/recipes/#{input_id}")
  recipe = response.body
  puts JSON.pretty_generate(recipe)
elsif input_options == "3"
  client_params = {}
  print "Title:"
  client_params[:title] = gets.chomp
  print "Chef:"
  client_params[:chef] = gets.chomp
  print "Ingredients:"
  client_params[:ingredients] = gets.chomp 
  print "Directions:"
  client_params[:directions] = gets.chomp

  response = Unirest.post("http://localhost:3000/recipes",
                          parameters: client_params
                          )
  recipe = response.body

  puts JSON.pretty_generate(recipe)
  
elsif input_options == "4"
  print "Enter recipe id: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/recipes/#{input_id}")
  recipe = response.body

  client_params = {}
  print "Title (#{recipe["title"]}): "
  client_params[:title] = gets.chomp
  print "Chef (#{recipe["chef"]}): "
  client_params[:chef] = gets.chomp
  print "Ingredients (#{recipe["ingredients"]}): "
  client_params[:ingredients] = gets.chomp 
  print "Directions (#{recipe["directions"]}): "
  client_params[:directions] = gets.chomp
  print "Prep time (#{recipe["prep_time"]}): "
  client_params[:prep_time] = gets.chomp

  client_params.delete_if { |key, value| value.empty? }

  response = Unirest.patch(
                          "http://localhost:3000/recipes",
                          parameters: client_params
                          )
  updated_recipe = response.body

  puts JSON.pretty_generate(updated_recipe)

elsif input_options == "5"
  print "Enter recipe id: "
  input_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/recipes/#{input_id}")
  data = response.body
  puts data["message"]

end
  
  
