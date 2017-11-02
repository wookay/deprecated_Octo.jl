using Octo
using Test

tbl = SQL.Table(:users)
u = (__octo_table=tbl, name=SQL.Column(tbl, :name))

@test SQL.repr[u] == "users"
@test SQL.repr[FROM(u)] == "FROM users"
@test SQL.repr[SELECT(*) FROM(u)] == "SELECT * FROM users"
@test SQL.repr[SELECT(*) FROM(u=u)] == "SELECT * FROM users AS u"
@test SQL.repr[SELECT(u.name) FROM(u)] == "SELECT name FROM users"
@test SQL.repr[WHERE(u.name == "john")] == "WHERE name = 'john'"
@test SQL.repr[SELECT(*) FROM(u) WHERE(u.name == "john")] == "SELECT * FROM users WHERE name = 'john'"
