defmodule HnCommentsGame.QuestionTest do
  use HnCommentsGame.DataCase

  alias HnCommentsGame.Question

  describe "hn_comments" do
    alias HnCommentsGame.Question.Comment

    @valid_attrs %{post_id: 42, text: "some text"}
    @update_attrs %{post_id: 43, text: "some updated text"}
    @invalid_attrs %{post_id: nil, text: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Question.create_comment()

      comment
    end

    test "list_hn_comments/0 returns all hn_comments" do
      comment = comment_fixture()
      assert Question.list_hn_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Question.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Question.create_comment(@valid_attrs)
      assert comment.post_id == 42
      assert comment.text == "some text"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Question.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Question.update_comment(comment, @update_attrs)
      assert comment.post_id == 43
      assert comment.text == "some updated text"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Question.update_comment(comment, @invalid_attrs)
      assert comment == Question.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Question.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Question.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Question.change_comment(comment)
    end
  end
end
