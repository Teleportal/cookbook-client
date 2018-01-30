require 'unirest'
require_relative 'controllers/recipes_controller'
require_relative 'models/recipe'
require_relative 'views/recipes_views'

class Frontend
  include RecipesController
  include RecipeViews


  def run
    system "clear"

    puts "Welcome to my Cookbook App"
    puts "Make a selection"
    puts "   [1] See all recipes"
    puts "       [1.1] Search all recipes"
    puts "       [1.2] Sort recipes by chef"
    puts "       [1.3] Sort recipes by prep time"
    puts "   [2] See one recipe"
    puts "   [3] Create a new recipe"
    puts "   [4] Update a recipe"
    puts "   [5] Delete a recipe"

    input_options = gets.chomp

    if input_options == "1"
      recipes_index
      
    elsif input_options == "1.1"
      print "Enter a search term: "
      search_term = gets.chomp

      response = Unirest.get("http://localhost:3000/recipes?search=#{search_term}")
      recipes = response.body
      puts JSON.pretty_generate(recipes)

    elsif input_options == "1.2"

      response = Unirest.get("http://localhost:3000/recipes?sort=chef")
      recipes = response.body
      puts JSON.pretty_generate(recipes)
      
    elsif input_options == "1.3"

      response = Unirest.get("http://localhost:3000/recipes?sort=prep_time")
      recipes = response.body
      puts JSON.pretty_generate(recipes)
      
    elsif input_options == "2"
      recipes_show

    elsif input_options == "3"
      recipes_create
      
    elsif input_options == "4"
      recipes_update

    elsif input_options == "5"
      recipes_destroy

    end
  end

  private
  def get_request(url, client_params={})
    Unirest.get("http://localhost:3000#{url}", parameters: client_params).body
  end

  def post_request(url, client_params={})
    response = Unirest.post("http://localhost:3000#{url}", parameters: client_params).body
  end

  def patch_request(url, client_params={})
    Unirest.patch("http://localhost:3000#{url}", parameters: client_params).body
  end

  def delete_request(url, client_params={})
    Unirest.delete("http://localhost:3000#{url}", parameters: client_params).body
  end
end