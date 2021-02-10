class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    erb :"figures/new"
  end

  post '/figures' do
    @figure = Figure.create(name: params[:landmark][:name])
    erb :"figures/show"
  end

  get '/figure/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/edit"
  end

  patch '/figures/:id' do 
    ####### bug fix
    if !params[:figure].keys.include?("figure_ids")
      params[:figure]["figure_ids"] = []
    end
    #######

    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if !params["figure"]["name"].empty?
      @figure.landmarks << Figure.create(name: params["figure"]["name"])
    end
    redirect "figures/#{@figure.id}"
  end


end
