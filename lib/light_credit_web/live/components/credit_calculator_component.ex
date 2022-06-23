defmodule LightCreditWeb.Components.CreditCalculatorComponent do
  use LightCreditWeb, :live_component
  alias LightCreditWeb.Components.ApprovalComponent

  @impl true
  def mount(socket) do
    {:ok, assign(socket, income: 0, expense: 0, credit_limit: 0, credit_score: 0)}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div>
        <form phx-change="validate" phx-target={@myself}>
          <div>
            <h3>What is your total monthly income from all income source?</h3>
            <input type="number" name="income" min="0.01" step="0.01" max="25000000" pattern="[0-9]+" placeholder="Enter amount in US$"/>
          </div>
          <br/>
          <div>
            <h3>What are your total monthly expenses?</h3>
            <input type="number" name="expense" min="0.01" step="0.01" max="25000000" pattern="[0-9]+" placeholder="Enter amount in US$"/>
          </div>
          <input type="hidden" name="total_point", value={@total_point}/>
        </form>
        <button phx-click="calculate_credit" phx-target={@myself}>Get Credit Limit</button>
        <%= if(assigns.credit_limit > 0) do %>
          <.live_component module={ApprovalComponent} id="approval_component"
                          credit_limit= {assigns.credit_limit}
                          credit_score= {assigns.credit_score} />
        <% end %>
      </div>
    """
  end

  defp validate(_income, nil, socket), do: {:noreply, socket}
  defp validate(_income, 0, socket), do: {:noreply, socket}
  defp validate(_income, "", socket), do: {:noreply, socket}
  defp validate(income, expense, socket) when income <= expense  do
    {:noreply, socket |> put_flash(:info, "Expense can not be greater or equal to income.")}
  end

  defp validate(income, expense, socket) when income > expense  do
    {:ok, socket}
  end

  def handle_event("validate", %{"income" => income, "expense" => expense, "total_point" => total_point}, socket) do
    case validate(income, expense, socket) do
      {:ok, socket} -> {:noreply, assign(socket,
                                    income: income,
                                    expense: expense,
                                    total_point: total_point)}
      {:noreply, _} -> {:noreply, assign(socket,
                        income: income,
                        expense: expense,
                        total_point: total_point)}
    end
  end

  @impl true
  def handle_event("calculate_credit", %{"value" => ""}, socket) do
    case get_credit_score(socket.assigns.total_point, socket) do
      {:ok, body} ->
            values = Jason.decode!(body)
            %{"creditScore" => credit_score} = values
            credit_limit = get_credit_limit(socket.assigns.income, socket.assigns.expense)
            socket = assign(socket,
                    credit_limit: credit_limit,
                    credit_score: credit_score)
            {:noreply, socket}
      {:noreply, _} ->
            {:noreply, socket}
      {:error, _reason} ->
            {:noreply, socket |> put_flash(:info, "Something is wrong, Try again.")}
    end
  end

  @spec get_credit_score(integer, Map) :: {Atom, String.t}
  defp get_credit_score(total_point, socket) do
    url = "https://lxzau4xjot.api.quickmocker.com/creditScore/" <> total_point
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:noreply, socket |> put_flash(:info, "Expense can not be greater or equal to income.")}
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        {:error, reason}
    end
  end

  @spec get_credit_limit(integer, integer) :: {integer}
  defp get_credit_limit(income, expense) do
    (String.to_integer(income) - String.to_integer(expense)) * 12
  end
end
