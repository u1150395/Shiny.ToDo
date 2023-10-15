header  <- dashboardHeader(
  title = "ToDo App"
)
sidebar <- dashboardSidebar(
  disable = TRUE
)
body    <- dashboardBody(
  Todo.View("todo"),
  Custom.Style()
)

dashboardPage(
  header,
  sidebar,
  body
)