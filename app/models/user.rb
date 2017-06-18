class User < ApplicationRecord
  has_many :likes

  validates :name, presence: true, uniqueness: true
  validates :password, :length => {:in => 4..15}
  validates :name, :length => {:maximum => 12}

  has_secure_password

  def create_avatar_for_user(object, attributes)
    path = File.join Rails.root, 'app', 'assets', 'images', object.id.to_s, 'avatar'
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(File.join(path, "avatar#{object.name}.png"), 'wb') do |file|
      file.puts attributes.read
    end
  end

  def admin?
    name == "admin"
  end
end
