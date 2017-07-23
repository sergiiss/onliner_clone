module PostsHelper
  def post_title_for_visual(posts, index)
    text_title = posts[index].title
    if text_title.length > 70
      text_title = text_title[0..69] + '...'
    else
      text_title
    end
  end

  def сategory_selection
    {
      'Люди': :people, 'Мнения':     :opinions,
      'Авто': :auto, 'Технологии': :technologies,
      'Недвижимость': :realty
    }
  end
end
