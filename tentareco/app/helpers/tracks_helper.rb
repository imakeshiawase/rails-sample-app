module TracksHelper
  def the_first_image(track)
    one_image= track.images.order(:id)[0]
    render_track_image(one_image) if one_image
  end

  def other_images(track)
    buffer = "".html_safe

    track.images.order(:id)[1..-1]&.each do |one_image|
      buffer << render_track_image(one_image)
    end
    
    buffer
  end

  private def render_track_image(one_image)
    content_tag(:div) do
      image_tag one_image.image.variant(resize: "530x>"),
      alt: one_image.alt_text,
      style: "display: block; margin: 0 auto 15px"
    end  
  end
end
