module ApplicationHelper
  def full_title(page_title)
    base_title = "Talentcrops"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def full_name(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end

end
