defmodule Pluggy.Student do

    require IEx

    defstruct id: nil, first_name: "", last_name: ""
    alias Pluggy.Student
    
    def get(id) do
        x = Postgrex.query!(DB, "SELECT (id, first_name, last_name) FROM students WHERE id = $1 LIMIT 1", [String.to_integer(id)], [pool: DBConnection.Poolboy]).rows
        # IEx.pry
        to_struct(x)
    end

    def create(params) do
		first_name = params["first_name"]
		last_name = params["last_name"]
		
        Postgrex.query!(DB, "INSERT INTO students (first_name, last_name) VALUES ($1, $2)", [first_name, last_name], [pool: DBConnection.Poolboy])	
	end

    def to_struct([[{id, first_name, last_name}]]) do
        %Student{id: id, first_name: first_name, last_name: last_name }
    end
end