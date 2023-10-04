# Mock Broker table name, fields, and data
sql.utilities <- Query::SQL.Utilities()
sql.functions <- Query::SQL.Functions()

table <- 'Todo'
fields <- list(
  'Id'     |> sql.utilities[['BRACKET']]() |> sql.functions[['LOWER']]('Id'),
  'Task'   |> sql.utilities[['BRACKET']](),
  'Status' |> sql.utilities[['BRACKET']]()
)