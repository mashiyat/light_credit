defmodule LightCreditWeb.CreditEvaluation do
  use LightCreditWeb, :live_view

  alias LightCreditWeb.Components.QuestionComponent
  alias LightCreditWeb.Components.RejectionComponent
  alias LightCreditWeb.Components.CreditCalculatorComponent


  @impl true
  def mount(_params, _session, socket) do
    questions = LightCredit.CreditEvaluation.list_questions()
    assigns = [
      total_point: 0,
      current_step: 0,
      questions: questions
    ]
    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    question = Enum.at(assigns.questions, assigns.current_step)
    ~H"""
      <%= if (assigns.current_step < 5) do%>
      <.live_component module={QuestionComponent} id={question.step_number} question={question.question_text}/>
      <button phx-click="increse_point" phx-value-points={question.points} phx-value-step={assigns.current_step}>Yes</button>
      <button phx-click="next_question" phx-value-step={assigns.current_step}>No</button>
      <%end%>

      <%= if (assigns.current_step >= 5 && assigns.total_point <= 6) do%>
      <.live_component module={RejectionComponent} id="rejection"/>
      <button phx-click="check_again">Check Again</button>
      <%end%>

      <%= if (assigns.current_step >= 5 && assigns.total_point > 6) do%>
      <.live_component module={CreditCalculatorComponent} id="credit_calculator" total_point={assigns.total_point}/>
      <%end%>
    """
  end

  @impl true
  def handle_event("check_again", %{"value" => ""}, socket)  do
    {:noreply,
      socket
      |> redirect(to: Routes.live_path(socket, LightCreditWeb.CreditEvaluation))
    }
  end

  @impl true
  def handle_event("increse_point", %{"points" => points, "step" => step}, socket)  do
    total_point = socket.assigns.total_point + String.to_integer(points)
    current_step = String.to_integer(step) + 1

    assigns = [
      total_point: total_point,
      current_step: current_step
    ]

    {:noreply,
      socket
      |> assign(assigns)
    }
  end

  @impl true
  def handle_event("next_question", %{"step" => step}, socket) do
    current_step = String.to_integer(step) + 1
    assigns = [
      current_step: current_step
    ]

    {:noreply,
      socket
      |> assign(assigns)
    }
  end
end
