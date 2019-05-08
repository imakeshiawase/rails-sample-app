class TrackImagesController < ApplicationController
  before_action :login_required

  before_action do
    @track = current_user.tracks.find(params[:track_id])
  end

  def index
    @images = @track.images.order(:id)
  end

  def show
    redirect_to action: "edit"
  end

  def new
    @image = @track.images.build
  end

  def edit
    @image = @track.images.find(params[:id])
  end

  def create
    @image = @track.images.build(image_params)
    if @image.save
      redirect_to [@track, :images], notice: "画像を作成しました"
    else
      render "new"
    end
  end

  def update
    @image = @track.images.find(params[:id])
    @image.assign_attributes(image_params)
    if @image.save
      redirect_to [@track, :images], notice: "画像を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @image = @track.images.find(params[:id])
    @image.destroy
    redirect_to [@track, :images], notice: "画像を削除しました。"
  end

  private def image_params
    params.require(:image).permit(
      :new_image,
      :alt_text
    )
  end
end
