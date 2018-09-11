defmodule Pluggy.StudentController do
    require IEx
    alias Pluggy.Student
    import Pluggy.Template
    import Plug.Conn, only: [send_resp: 3]
    def index(_) do
        
    end
    def show(conn, id),     do: send_resp(conn, 200, render("students/show", student: Student.get(id)))
    # IEx.pry
    def new(conn), do:  send_resp(conn, 200, render("students/new", []))
    def create(conn, params) do
        Student.create(params)
        redirect(conn, "/students")
    end
    defp redirect(conn, url) do
        Plug.Conn.put_resp_header(conn, "location", url) |> send_resp(303, "")
    end
end