defmodule LightCreditWeb.Components.ApprovalComponent do
  use LightCreditWeb, :live_component
  import Number.Currency

  def render(assigns) do
    ~H"""
      <div>
          <h2>Congratulations, you have been approved for credit upto <%= Number.Currency.number_to_currency(@credit_limit, unit: "$", precision: 2)%></h2>
          <h1>Your Credit Score is <%= @credit_score %> </h1>
      </div>
    """
  end
end
