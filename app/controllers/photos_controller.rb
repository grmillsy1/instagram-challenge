class PhotosController < ApplicationController
before_action :authenticate_user!, :except => [:index, :show]
  def index
    @photos = Photo.all
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(photo_params)
    redirect_to '/photos'
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private
    def photo_params
      params.require(:photo).permit(:tag, :image)
    end

end
