module ApplicationHelper
  def currency
    if currency == "gbp"
      "&#163;"
    end
  end
end
