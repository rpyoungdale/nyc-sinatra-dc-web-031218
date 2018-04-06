class FiguresController < ApplicationController
  #CREATE

  get '/figures' do 
    @figures = Figure.all
    erb :'figures/index'
  end
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all.where(figure_id: nil)
    erb :'figures/new'
  end

  post '/figures' do
    #puts params
    @figure = Figure.find_or_create_by(name: params[:figure][:name])

    @title_ids = params[:figure][:title_ids].keys  #[3, 5, 7]
    @title_ids.each do |t|
      @figure.titles << Title.find(t)
    end

    @landmark_ids = params[:figure][:landmark_ids].keys
    @landmark_ids.each do |t|
      @figure.landmarks << Landmark.find(t)
    end

    if params[:title][:name] != ""
      new_title = Title.find_or_create_by(params[:title])
      @figure.titles << new_title
    end

    if params[:landmark][:name] != ""
      new_landmark = Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << new_landmark
    end

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    #binding.pry
    @figure = Figure.find_by_id(params[:id])
    @figure.update(name: params[:figure][:name])

    @figure.title_ids = params[:figure][:title_ids].keys  #[1, 2, 4]

    @figure.landmark_ids = params[:figure][:landmark_ids].keys
    
    if params[:title][:name] != ""
      new_title = Title.find_or_create_by(params[:title])
      @figure.titles << new_title
    end

    if params[:landmark][:name] != ""
      @landmark = Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << @landmark
    end
    redirect to '/figures'
  end
end

# => {"figure"=>{"name"=>"Kyoe", "title_ids"=>{"4"=>"on", "5"=>"on"}, "landmark_ids"=>{"2"=>"on", "4"=>"on", "7"=>"on"}},
#  "title"=>{"name"=>"askdgh"},
#  "landmark"=>{"name"=>"aergaerh", "year_completed"=>"arhar"}}
