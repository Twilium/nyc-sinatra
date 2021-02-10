class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"landmarks/index"
  end

  get '/landmarks/new' do
    erb :"landmarks/new"
  end

  post '/landmarks' do
    @landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    erb :"landmarks/show"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find_by_id(params[:id])
    erb :"/landmarks/edit"
  end

  patch '/landmarks/:id' do 
    ####### bug fix
    if !params[:landmark].keys.include?("landmark_ids")
      params[:landmark]["landmark_ids"] = []
    end
    #######

    @landmark = Landmark.find(params[:id])
    @landmark.update(params["landmark"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end

end
