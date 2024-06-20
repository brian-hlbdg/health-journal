defmodule HealthJournalWeb.DailyCheckInLiveTest do
  use HealthJournalWeb.ConnCase

  import Phoenix.LiveViewTest
  import HealthJournal.CheckInsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_daily_check_in(_) do
    daily_check_in = daily_check_in_fixture()
    %{daily_check_in: daily_check_in}
  end

  describe "Index" do
    setup [:create_daily_check_in]

    test "lists all daily_check_ins", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/daily_check_ins")

      assert html =~ "Listing Daily check ins"
    end

    test "saves new daily_check_in", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_check_ins")

      assert index_live |> element("a", "New Daily check in") |> render_click() =~
               "New Daily check in"

      assert_patch(index_live, ~p"/daily_check_ins/new")

      assert index_live
             |> form("#daily_check_in-form", daily_check_in: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_check_in-form", daily_check_in: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_check_ins")

      html = render(index_live)
      assert html =~ "Daily check in created successfully"
    end

    test "updates daily_check_in in listing", %{conn: conn, daily_check_in: daily_check_in} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_check_ins")

      assert index_live |> element("#daily_check_ins-#{daily_check_in.id} a", "Edit") |> render_click() =~
               "Edit Daily check in"

      assert_patch(index_live, ~p"/daily_check_ins/#{daily_check_in}/edit")

      assert index_live
             |> form("#daily_check_in-form", daily_check_in: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#daily_check_in-form", daily_check_in: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/daily_check_ins")

      html = render(index_live)
      assert html =~ "Daily check in updated successfully"
    end

    test "deletes daily_check_in in listing", %{conn: conn, daily_check_in: daily_check_in} do
      {:ok, index_live, _html} = live(conn, ~p"/daily_check_ins")

      assert index_live |> element("#daily_check_ins-#{daily_check_in.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#daily_check_ins-#{daily_check_in.id}")
    end
  end

  describe "Show" do
    setup [:create_daily_check_in]

    test "displays daily_check_in", %{conn: conn, daily_check_in: daily_check_in} do
      {:ok, _show_live, html} = live(conn, ~p"/daily_check_ins/#{daily_check_in}")

      assert html =~ "Show Daily check in"
    end

    test "updates daily_check_in within modal", %{conn: conn, daily_check_in: daily_check_in} do
      {:ok, show_live, _html} = live(conn, ~p"/daily_check_ins/#{daily_check_in}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Daily check in"

      assert_patch(show_live, ~p"/daily_check_ins/#{daily_check_in}/show/edit")

      assert show_live
             |> form("#daily_check_in-form", daily_check_in: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#daily_check_in-form", daily_check_in: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/daily_check_ins/#{daily_check_in}")

      html = render(show_live)
      assert html =~ "Daily check in updated successfully"
    end
  end
end
