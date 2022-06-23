# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LightCredit.Repo.insert!(%LightCredit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias LightCredit.Repo
alias LightCredit.CreditEvaluation.Question

#question1 =
  %Question{}
  |> Question.changeset(%{
      category: "job",
      points: 4,
      question_text: "Do you have a paying job?",
      step_number: 1
    })
  |> Repo.insert!

#question2 =
  %Question{}
  |> Question.changeset(%{
      category: "job",
      points: 2,
      question_text: "Did you consistently had a paying job for past 12 months?",
      step_number: 2
    })
  |> Repo.insert!

#question3 =
  %Question{}
  |> Question.changeset(%{
      category: "job",
      points: 2,
      question_text: "Do you have a home?",
      step_number: 3
    })
  |> Repo.insert!

#question4 =
  %Question{}
  |> Question.changeset(%{
      category: "job",
      points: 1,
      question_text: "Do you have a car?",
      step_number: 4
    })
  |> Repo.insert!

#question5 =
  %Question{}
  |> Question.changeset(%{
      category: "job",
      points: 2,
      question_text: "Do you have any additional source of income?",
      step_number: 5
    })
  |> Repo.insert!
