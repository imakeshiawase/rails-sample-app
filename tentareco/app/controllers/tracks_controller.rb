class TracksController < ApplicationController
  before_action :login_required, except: [:index, :show]

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @tracks = @user.tracks
    else
      @tracks = Track.all
    end
  end

  def show
    @track = Track.find(params[:id])
  end

  def new
    @track = Track.new(posted_at: Time.current)
  end

  def edit
    @track = current_user.tracks.find(params[:id])
  end

  def create
    @track = Track.new(track_params)
    @track.artist = current_user
    if @track.save
      redirect_to @track, notice: "トラックを作成しました。"
    else
      render "new"
    end
  end

  def update
    @track = current_user.tracks.find(params[:id])
    @track.assign_attributes(track_params)
    if @track.save
      redirect_to @track, notice: "トラックを更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @track = current_user.tracks.find(params[:id])
    @track.destroy
    redirect_to :tracks, notice: "記事を削除しました。" 
  end

  def like
    @track = Track.find(params[:id])
    current_user.clapped_tracks << @track
    redirect_to @track, notice: "拍手を送りました。"
  end

  def unlike
    current_user.clapped_tracks.destroy(Track.find(params[:id]))
    redirect_to :clapped_tracks, notice: "あなたの拍手を取り消しました。"
  end

  def clapped
    @tracks = current_user.clapped_tracks.order("claps.created_at DESC")
  end

  private def track_params
    params.require(:track).permit(
      :user_id,
      :title,
      :body,
      :posted_at
    )
  end
end
