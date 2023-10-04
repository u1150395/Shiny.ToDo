Todo.Broker <- \(storage){
  sql.utilities <- Query::SQL.Utilities()
  sql.functions <- Query::SQL.Functions()

  table <- 'Todo'
  fields <- list(
    'Id'     |> sql.utilities[['BRACKET']]() |> sql.functions[['LOWER']]('Id'),
    'Task'   |> sql.utilities[['BRACKET']](),
    'Status' |> sql.utilities[['BRACKET']]()
  )
  
  operations <- list()
  operations[['Insert']]        <- \(todo) {
    todo |> storage[['Add']](table)
  }
  operations[['Select']]        <- \(...)  {
    table |> storage[['Retrieve']](fields)
  }
  operations[['SelectById']]    <- \(id)   {
    id |> storage[['RetrieveWhereId']](table, fields)
  }
  operations[['Update']]        <- \(todo) {
    todo |> storage[['Modify']](table)
  }
  operations[['Delete']]        <- \(id)   {
    id |> storage[['Remove']](table)
  }
  return(operations)
}