module PostsHelper
  def minor_title_for_visual(index)
    text_title = @minor_posts[index].title
    if text_title.length > 70
      text_title = text_title[0..69] + '...'
    else
      text_title
    end
  end
end
