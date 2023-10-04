Todo.Structure.Validation <- \(){
  exception <- Todo.Exceptions()
  
  validators <- list()
  validators[["Todo"]]      <- \(todo) {
    todo |>
      validators[["TodoExist"]]() |>
      validators[["HasId"]]()     |>
      validators[["HasTask"]]()   |>
      validators[["HasStatus"]]()  
  }
  validators[["TodoExist"]] <- \(todo) {
    todo |> is.null() |> exception[["TodoIsNull"]]()
    return(todo)
  }
  validators[["HasId"]]     <- \(todo) {
    todo[["Id"]] |> is.null() |> exception[["TodoIdIsNull"]]()
    return(todo)
  }
  validators[["HasTask"]]   <- \(todo) {
    todo[["Task"]] |> is.null() |> exception[["TodoTaskIsNull"]]()
    return(todo)
  }
  validators[["HasStatus"]] <- \(todo) {
    todo[["Status"]] |> is.null() |> exception[["TodoStatusIsNull"]]()
      return(todo)
  }
  validators[["IdExist"]]   <- \(id) {
    id |> is.null() |> exception[["IdIsNull"]]()
    return(id)
  }
  return(validators)  
}