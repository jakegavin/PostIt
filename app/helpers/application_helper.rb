module ApplicationHelper

  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end

  def fix_date(date)
    if date.nil?
      nil
    else
      date.strftime("%m/%d/%Y at %l:%M %p")
    end
  end
end