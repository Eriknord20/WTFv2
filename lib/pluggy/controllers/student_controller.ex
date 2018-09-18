defmodule Pluggy.StudentController do
  require IEx
  alias Pluggy.Student
  import Pluggy.Template, only: [render: 2]
  import Plug.Conn, only: [send_resp: 3]

  def new(conn) do
    IO.inspect(conn)
    send_resp(conn, 200, render("students/new", []))
  end

  def test(conn), do: send_resp(conn, 200, render("students/test", []))

  def index(conn) do
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> Student.get(session_user)
      end
      IO.inspect current_user
    send_resp(conn, 200, render("students/index", user: current_user))
  end
  def show(conn, id), do: send_resp(conn, 200, render("students/show", student: Student.get(id)))
  def list(conn) do
    session_user = conn.private.plug_session["user_id"]

    current_user =
      case session_user do
        nil -> nil
        _ -> Student.get(session_user)
      end 
      id = current_user.id
      # IEx.pry
    send_resp(conn, 200, render("students/list", user: current_user, student: Student.get(id)))
  end
  # IEx.pry
  def login(conn, params) do
    username = params["username"]
    password = params["pwd"]

    result =
      Postgrex.query!(DB, "SELECT id, password FROM students WHERE username = $1", [username],
        pool: DBConnection.Poolboy
      )

    case result.num_rows do
      # no user with that username
      0 ->
        redirect(conn, "/students")

      # user with that username exists
      _ ->
        [[id, password_hash]] = result.rows

        # make sure password is correct
        if Bcrypt.verify_pass(password, password_hash) do
          Plug.Conn.put_session(conn, :user_id, id)
          |> redirect("/students")
        else
          redirect(conn, "/students")
        end
    end
  end

  def logout(conn) do
    Plug.Conn.configure_session(conn, drop: true)
    |> redirect("/students")
  end

  def create(conn, params) do
    Student.create(params)
    redirect(conn, "/students")
  end

  defp redirect(conn, url) do
    Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
  end
end
