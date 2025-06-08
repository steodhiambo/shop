module ProductsHelper
  # Returns the name of the seller for a given product
  def product_author(product)
    product.user&.name || "Unknown Seller"
  end

  # Alternative method name for consistency
  def seller_name(product)
    product_author(product)
  end

  # Checks if the current user can edit the product (only the creator can edit)
  def can_edit_product?(product)
    user_signed_in? && current_user == product.user
  end

  # Checks if the current user can delete the product (only the creator can delete)
  def can_delete_product?(product)
    user_signed_in? && current_user == product.user
  end

  # Returns edit and delete links if the current user is the product owner
  def product_action_links(product)
    return unless can_edit_product?(product)

    content_tag :div, class: "product-actions" do
      concat link_to("Edit", edit_product_path(product), class: "button is-small is-info")
      concat " "
      concat link_to("Delete", product_path(product), method: :delete,
                     confirm: "Are you sure?", class: "button is-small is-danger")
    end
  end
end
