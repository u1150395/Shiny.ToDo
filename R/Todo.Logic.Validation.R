Todo.Logic.Validation <- \() {
  exception <- Todo.Exceptions()
  
  validators <- list()
  validators[["IsDuplicate"]] <-  \(todo,todos) {
    match.count <- 
      todos |> dplyr::filter(Id == todo[["Id"]]) |> nrow()
        
    (match.count != 0) |> exception[["DuplicateKey"]]()

    return(todo)
  }
  return(validators)
}