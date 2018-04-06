class FiguresController < ApplicationController
  #CREATE
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all.where(figure_id: nil)
    erb :'figures/new'
  end

  post '/figures' do
    binding.pry
    #puts params
    @figure = Figure.find_or_create_by(name: params[:figure][:name])

    @title_ids = params[:figure][:title_ids].keys  #[3, 5, 7]
    @title_ids.each do |id|
      
    end

    if params[:title] != ""
      @title = Title.find_or_create_by(params[:title])
      @figure.titles << @title
    end

    if params[:landmark] != ""
      @landmark = Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << @landmark
    end
  end

end

# => {"figure"=>{"name"=>"Kyoe", "title_ids"=>{"4"=>"on", "5"=>"on"}, "landmark_ids"=>{"2"=>"on", "4"=>"on", "7"=>"on"}},
#  "title"=>{"name"=>"askdgh"},
#  "landmark"=>{"name"=>"aergaerh", "year_completed"=>"arhar"}}
