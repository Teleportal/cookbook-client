class Recipe
  attr_accessor :id, :title, :chef, :ingredients, :prep_time, :directions

  def initialize(input_options)
    @id = input_options["id"]
    @title = input_options["title"]
    @chef = input_options["chef"]
    @ingredients = input_options["ingredients"]
    @prep_time = input_options["prep_time"]
    @directions = input_options["directions"]
  end
end