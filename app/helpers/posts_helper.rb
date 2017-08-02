module PostsHelper
  def сategory_selection
    {
      'Люди': :people, 'Мнения':     :opinions,
      'Авто': :auto, 'Технологии': :technologies,
      'Недвижимость': :realty
    }
  end
end
