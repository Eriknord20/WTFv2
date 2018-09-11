defmodule Pluggy.StudentController do
    alias Pluggy.Student
    import Pluggy.Template, only: [render: 2]
    import Plug.Conn, only: [send_resp: 3]

    def show(conn, id),     do: send_resp(conn, 200, render("students/show", student: Student.get(id)))
        
end