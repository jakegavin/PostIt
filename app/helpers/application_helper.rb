module ApplicationHelper

  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end

  def fix_date(date)
    if date.nil?
      nil
    else
      if logged_in? && !current_user.time_zone.blank?
        date = date.in_time_zone(current_user.time_zone)
      end
      date.strftime("%m/%d/%Y at %l:%M %p %Z")
    end
  end
end