defmodule MangoWeb.LayoutView do
  use MangoWeb, :view
  import MangoWeb.CartView, only: [cart_count: 1]

  def cart_link_text(conn) do
    raw """
    <i class="fa fa-shopping-cart"></i> <span class="cart-count">#{cart_count(conn)}</span>
    """
  end

  def get_active_locale_class(locale) do
    if Gettext.get_locale(MangoWeb.Gettext) == locale, do: "active"      
  end
end
