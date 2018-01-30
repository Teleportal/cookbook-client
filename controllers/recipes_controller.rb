module RecipesController

  def recipes_index
    
    recipes_hashes = get_request('/recipes')
    recipes = []
    recipes_hashes.each do |recipe|
      recipes << Recipe.new(recipe)
    end
    
    recipes_index_view(recipes)
  end

  def recipes_create
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
    recipe_hash = response.body

    recipe = Recipe.new(recipe_hash)

    recipe_show_view(recipe)
  end

  def recipes_show
    print "Enter recipe id:"
    input_id = gets.chomp
    
    recipe_hash = get_request("/recipes/#{input_id}")

    recipe = Recipe.new(recipe_hash)

    recipe_show_view(recipe)
  end

  def recipes_update
    print "Enter recipe id: "
      input_id = gets.chomp

      recipe = get_request("/recipes/#{input_id}")

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
  end

  def recipes_destroy
    print "Enter recipe id: "
      input_id = gets.chomp

      response = Unirest.delete("http://localhost:3000/recipes/#{input_id}")
      data = response.body
      puts data["message"]
  end

end