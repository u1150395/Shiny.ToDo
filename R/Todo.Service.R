Todo.Service <- \(broker){
  validate.structure <- Todo.Structure.Validation()
  validate.logic     <- Todo.Logic.Validation()
  
  services <- list()
  services[["Add"]]          <- \(todo) {
    todos <- broker[['Select']]()
    
    todo |>
      validate.structure[['Todo']]() |>
      validate.logic[['IsDuplicate']](todos)
    
    todo |>
      broker[['Insert']]()

    return(data.frame())
  }
  services[['Retrieve']]     <- \(...) {
    ... |> broker[['Select']]()
  }
  services[["RetrieveById"]] <- \(id) {
    id |>
      validate.structure[['IdExist']]()

    id |> 
      broker[['SelectById']]()
  }
  services[['Modify']]       <- \(todo) {
    todo |>
      validate.structure[['Todo']]()
    
    todo |>
      broker[['Update']]()

    return(data.frame())
  }
  services[['Remove']]       <- \(id) {
    id |>
      validate.structure[['IdExist']]()
    
    id |>
      broker[['Delete']]()

    return(data.frame())
  }  
  
  return(services)
}