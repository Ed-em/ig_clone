class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :logged_in?

  def index
    @feeds = Feed.all
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def edit
    if current_user.id != @feed.user_id
    flash[:notice] = "Not Allowed!"
    redirect_to feeds_path(session[:feed_user])
    return
  end
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id

    respond_to do |format|
      if @feed.save
        format.html {
          #FeedMailer.feed_mail(@feed).deliver
          redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render :new if @feed.invalid?
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :post, :user_id, :id)
  end
end
