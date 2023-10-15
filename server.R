# Mock Storage do not need configuration details but does require mock data
# When using an Azure SQL Server, configuration details are needed
# Configuration details can be stored in .Reviron file and retrieved via Environment Package
configuration <- data.frame()

storage <- configuration |> Storage::Storage(type = "memory")
Todo.Mock.Data |> storage[['Seed.Table']]('Todo')

# Data Layer
data  <- storage |> Todo.Orchestration()

shinyServer(\(input, output, session) {
  Todo.Controller("todo", data)
})