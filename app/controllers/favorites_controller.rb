class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end
  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "liked #{favorite.feed.user.name}'s post'"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "unliked #{favorite.feed.user.name}'s post'"
  end
end
