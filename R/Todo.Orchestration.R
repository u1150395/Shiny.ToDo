#' Todo Orchestration service
#' 
#' @description
#'  This is the service is the primary access point of the data access layer.
#'
#' @usage NULL
#' @export
Todo.Orchestration <- \(storage) {
  process <- storage |> 
    Todo.Broker()    |> 
    Todo.Service()   |> 
    Todo.Processing()

  orchestrations <- list()
  orchestrations[['UpsertRetrieve']] <- \(todo) {
    todo |> process[['Upsert']]()

    todos <- process[['Retrieve']]()
    return(todos)
  }
  orchestrations[['Retrieve']]       <- \() {
    todos <- process[['Retrieve']]()
    return(todos)
  }
  orchestrations[['DeleteRetrieve']] <- \(id) {
    id |> process[['Remove']]()

    todos <- process[['Retrieve']]()
    return(todos)
  }
  return(orchestrations)
}