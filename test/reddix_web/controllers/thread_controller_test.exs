defmodule ReddixWeb.ThreadControllerTest do
  use ReddixWeb.ConnCase

  import Reddix.ThreadsFixtures

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  describe "index" do
    test "lists all threads", %{conn: conn} do
      conn = get(conn, Routes.thread_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Threads"
    end
  end

  describe "new thread" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.thread_path(conn, :new))
      assert html_response(conn, 200) =~ "New Thread"
    end
  end

  describe "create thread" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thread_path(conn, :create), thread: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.thread_path(conn, :show, id)

      conn = get(conn, Routes.thread_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Thread"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.thread_path(conn, :create), thread: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Thread"
    end
  end

  describe "edit thread" do
    setup [:create_thread]

    test "renders form for editing chosen thread", %{conn: conn, thread: thread} do
      conn = get(conn, Routes.thread_path(conn, :edit, thread))
      assert html_response(conn, 200) =~ "Edit Thread"
    end
  end

  describe "update thread" do
    setup [:create_thread]

    test "redirects when data is valid", %{conn: conn, thread: thread} do
      conn = put(conn, Routes.thread_path(conn, :update, thread), thread: @update_attrs)
      assert redirected_to(conn) == Routes.thread_path(conn, :show, thread)

      conn = get(conn, Routes.thread_path(conn, :show, thread))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, thread: thread} do
      conn = put(conn, Routes.thread_path(conn, :update, thread), thread: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Thread"
    end
  end

  describe "delete thread" do
    setup [:create_thread]

    test "deletes chosen thread", %{conn: conn, thread: thread} do
      conn = delete(conn, Routes.thread_path(conn, :delete, thread))
      assert redirected_to(conn) == Routes.thread_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.thread_path(conn, :show, thread))
      end
    end
  end

  defp create_thread(_) do
    thread = thread_fixture()
    %{thread: thread}
  end
end
