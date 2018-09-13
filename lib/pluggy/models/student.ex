defmodule Pluggy.Student do

    require IEx

    defstruct id: nil, first_name: "", last_name: ""
    alias Pluggy.Student
    
    def get(id) do
        Postgrex.query!(DB, "SELECT (id, first_name, last_name) FROM students WHERE id = $1 LIMIT 1", [String.to_integer(id)], [pool: DBConnection.Poolboy]).rows
        # IEx.pry
        |>to_struct
    end

    def create(params) do
		first_name = params["first_name"]
        last_name = params["last_name"]
        username = params["username"]
        pwd = params["pwd"]
		hashed_password = Bcrypt.hash_pwd_salt(pwd)
        Postgrex.query!(DB, "INSERT INTO students (first_name, last_name, username, password) VALUES ($1, $2, $3, $4)", [first_name, last_name, username, hashed_password], [pool: DBConnection.Poolboy])	
	end

    def to_struct([[{id, first_name, last_name}]]) do
        %Student{id: id, first_name: first_name, last_name: last_name }
    end
end