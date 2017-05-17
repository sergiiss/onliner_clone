module ApplicationHelper
  def time
    @time = Time.now.strftime("%T")
  end
end
