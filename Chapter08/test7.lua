dbh = freeswitch.Dbh("sqlite://my_db") -- sqlite database in subdirectory "db"
assert(dbh:connected()) -- exits the script if we didn't connect properly
dbh:test_reactive("SELECT * FROM my_table",
                  "DROP TABLE my_table",
                  "CREATE TABLE my_table (id INTEGER(8), name VARCHAR(255))")
dbh:query("INSERT INTO my_table VALUES(1, 'foo')") -- populate the table
dbh:query("INSERT INTO my_table VALUES(2, 'bar')") -- with some test data
dbh:query("SELECT id, name FROM my_table", function(row)
stream:write(string.format("%5s : %s\n", row.id, row.name))
end)
dbh:query("UPDATE my_table SET name = 'changed'")
stream:write("Affected rows: " .. dbh:affected_rows() .. "\n")
dbh:release() -- optional
------
------
dbh2 = freeswitch.Dbh("sqlite://core") -- sqlite database in subdirectory "db"
assert(dbh2:connected()) -- exits the script if we didn't connect properly
dbh2:query("select name,filename from interfaces where name='luarun'", function(row)  
stream:write("name is ".. row.name .. " while module is " .. row.filename)
end)
dbh2:release() -- optional
