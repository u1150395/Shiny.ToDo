Todo.Processing <- \(service) {
  processors <- list()
  processors[['Retrieve']] <- \() {
    service[['Retrieve']]()
  }
  processors[['Upsert']]   <- \(todo) {
    todo.exist <- todo[['Id']] |> service[['RetrieveById']]() |> nrow() > 0

    if(todo.exist) {
      todo |> service[['Modify']]()
    } else {
      todo |> service[['Add']]()
    }
  }
  processors[['Remove']]   <- \(id) {
    id |> service[['Remove']]()
  }
  return(processors)
}
