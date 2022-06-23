defmodule LightCreditWeb.Components.RejectionComponent do
  use LightCreditWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <h1>
          Thank you for your answers.
        </h1>
        <h1>
          We are currently unable to issue credit to you.
        </h1>
      </div>
    """
  end
end
