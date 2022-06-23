defmodule LightCredit.CreditEvaluationTest do
  use LightCredit.DataCase

  alias LightCredit.CreditEvaluation

  describe "questions" do
    alias LightCredit.CreditEvaluation.Question

    import LightCredit.CreditEvaluationFixtures

    @invalid_attrs %{category: nil, points: nil, question_text: nil, step_number: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert CreditEvaluation.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert CreditEvaluation.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{category: "some category", points: 42, question_text: "some question_text", step_number: 42}

      assert {:ok, %Question{} = question} = CreditEvaluation.create_question(valid_attrs)
      assert question.category == "some category"
      assert question.points == 42
      assert question.question_text == "some question_text"
      assert question.step_number == 42
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CreditEvaluation.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{category: "some updated category", points: 43, question_text: "some updated question_text", step_number: 43}

      assert {:ok, %Question{} = question} = CreditEvaluation.update_question(question, update_attrs)
      assert question.category == "some updated category"
      assert question.points == 43
      assert question.question_text == "some updated question_text"
      assert question.step_number == 43
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = CreditEvaluation.update_question(question, @invalid_attrs)
      assert question == CreditEvaluation.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = CreditEvaluation.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> CreditEvaluation.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = CreditEvaluation.change_question(question)
    end
  end
end
