class FiguresController < ApplicationController
  #CREATE
  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  post '/figures' do
    binding.pry
    puts params
    @figure = Figures.create(params)
  end
end
