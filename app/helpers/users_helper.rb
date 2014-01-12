module UsersHelper
  def gravatar_for(user, options = { size: 480 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.profile_pic, class: "gravatar")
  end

  def main_pic(user)
    default_pic = current_user.profile_pic
    if current_user.profile_pic.empty?
      gravatar_for @user
    else
      image_tag default_pic
    end
  end
end

