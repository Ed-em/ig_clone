class FavoritesController < ApplicationController
  def index
    favorite = Favorite.all
    favorite = Favorite.where(user_id: current_user.id).order(created_at: :desc).pluck(:feed_id)
    @favorites = Feed.find(favorite)
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
