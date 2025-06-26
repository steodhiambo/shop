module AdsHelper
  # Returns the name of the ad creator
  def ad_author(ad)
    ad.user&.name || "Unknown Seller"
  end

  # Checks if the current user can edit the ad (only the creator can edit)
  def can_edit_ad?(ad)
    user_signed_in? && current_user == ad.user
  end

  # Checks if the current user can delete the ad (only the creator can delete)
  def can_delete_ad?(ad)
    user_signed_in? && current_user == ad.user
  end

  # Returns edit and delete links if the current user is the ad owner
  def ad_action_links(ad)
    return unless can_edit_ad?(ad)

    content_tag :div, class: "ad-actions" do
      concat link_to("Edit", edit_ad_path(ad), class: "button is-small is-info")
      concat " "
      concat link_to("Delete", ad_path(ad), method: :delete,
                     confirm: "Are you sure?", class: "button is-small is-danger")
    end
  end

  # Returns status badge for ad
  def ad_status_badge(ad)
    if ad.expired?
      content_tag :span, "Expired", class: "tag is-danger"
    elsif !ad.active?
      content_tag :span, "Inactive", class: "tag is-warning"
    else
      content_tag :span, "Active", class: "tag is-success"
    end
  end

  # Format ad contact information
  def format_contact_info(ad)
    case ad.contact_method
    when 'email'
      "Email: #{ad.user.email}"
    when 'phone'
      "Phone: #{ad.contact_info}"
    when 'both'
      "Email: #{ad.user.email} | Phone: #{ad.contact_info}"
    else
      "Email: #{ad.user.email}"
    end
  end
end
