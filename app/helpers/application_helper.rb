module ApplicationHelper
  def time
    @time = Time.now.strftime("%T")
  end

  def like_image
    @like_image = "like-full.png"
  end
end
