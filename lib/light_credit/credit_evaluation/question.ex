defmodule LightCredit.CreditEvaluation.Question do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "questions" do
    field :category, :string
    field :points, :integer
    field :question_text, :string
    field :step_number, :integer

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    required_fields = [:step_number, :question_text, :points]
    optional_fields = [:category]

    question
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
  end
end
