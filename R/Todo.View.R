Todo.View <- \(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      box(
        title = div(icon("house")," Tasks"),
        status = "primary",
        solidHeader = TRUE,
        DT::dataTableOutput(
          ns("todos")
        ),
        textInput(
          ns("newTask"),
          ""
        ),
        On.Enter.Event(
          widget = ns("newTask"),
          trigger = ns("create"))
      )
    ),
    conditionalPanel(
      condition = "output.isSelectedTodoVisible",
      ns = ns,
      fluidRow(
        box(title = "Selected ToDo",
            status = "primary",
            solidHeader = TRUE,
            textInput(ns("task"), "Task"),
            textInput(ns("status"), "Status"),
            column(6,
                  align = "right",
                  offset = 5,
                  actionButton(ns("update"), "Update"),
                  actionButton(ns("delete"), "Delete")
            )
        )
      )
    )
  )
}