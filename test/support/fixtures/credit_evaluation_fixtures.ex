defmodule LightCredit.CreditEvaluationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LightCredit.CreditEvaluation` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        category: "some category",
        points: 42,
        question_text: "some question_text",
        step_number: 42
      })
      |> LightCredit.CreditEvaluation.create_question()

    question
  end
end
