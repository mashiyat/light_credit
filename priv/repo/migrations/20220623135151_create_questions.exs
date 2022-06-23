defmodule LightCredit.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :category, :string
      add :step_number, :integer
      add :question_text, :string
      add :points, :integer

      timestamps()
    end
  end
end
