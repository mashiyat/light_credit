defmodule LightCreditWeb.Components.QuestionComponent do
  use LightCreditWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
         <h2>
            <%= @question %>
         </h2>
      </div>
    """
  end
end
