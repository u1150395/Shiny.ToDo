# Interactive Applications in R

This repository contains a sample `Shiny` application which can be used as a boilerplate when developing enterprise-level applications using the R programming languages.

The unique feature of the ToDo App includes a:

1. Custom Styling
2. Custom Shiny Module
3. Custom Event Handler
4. Custom Data Layer
5. Units Test with 100% Data Layer Coverage
6. Github Workflow with Automated Unit Testing

## Getting Started

### Installation

Whether your development environment is based on RStudio or VS Code the installation follows the same steps:

1. R `devtools` is required. Install and Reboot:

```r
install.packages("devtools")
```

If you have difficulty, please consult this [page](https://www.r-project.org/nosvn/pandoc/devtools.html) for manual installation instructions.

2. Install the application dependencies:

```r
install.packages("shiny")
install.packages("shinydashboard")
install.packages("dplyr")
install.packages("DT")
install.packages("shinytest2")
install.packages("uuid")
```

3. Install a Mock Storage Service from GitHub:

```r
devtools::install_github("https://github.com/FlippieCoetser/Environment")
devtools::install_github("https://github.com/FlippieCoetser/Query")
devtools::install_github("https://github.com/FlippieCoetser/Storage")
```

4. Clone this repository:

```bash
git clone https://github.com/FlippieCoetser/Shiny.ToDo.git
```

### Run Application

Follow these steps to run the application:

1. Open your development environment and ensure your working directory is correct.
   Since the repository is called `Shiny.ToDo`, you should have such a directory in the location where your cloned the repository.
   In RStudio or VS Code R terminal, you can use `getwd()` and `setwd()` to get or set the current working directory.
   Example:

```r
getwd()
# Prints: "C:/Data/Shiny.Todo"
```

3. Load `Shiny` Package

```r
library(shiny)
```

4. Run the application:

```r
runApp()
```

5. Application should open with this screen:

![Enterprise Application Hierarchy](/man/figures/App.Final.PNG)

## Software Architecture

Before jumping into the details of the ToDo Application, it is important to understand the software architecture used. This is best explained by functionally decomposing the application into different layers with accompanying diagrams.

### Functional Decomposition

In textbooks focusing on software architecture, it is typical to see a software application segmented into three layers: `User Interface`, `Business Logic`, and `Data`.

![Architecture](/man/figures//Architecture.png)

- The `User Interface (UI)` layer is responsible for the look and feel of the application. It is the layer that the user interacts with.

- The `Business Logic (BL)` layer is responsible for the business rules of the application. It is the layer that contains the application logic.

- The `Data` layer is responsible for the data persistence of the application. It is the layer that contains the data access logic.

### Shiny Application Architecture

The software architecture presented above is not the only approach to designing software. However, as you will see it aligns well with the sample application build using `shiny`. But what is `shiny`? `Shiny` is an open-source framework made available as an R package that allows users to build interactive web applications directly from R. Shiny is intended to simplify the process of producing web-friendly, interactive data visualizations and makes it easier for R users who might not necessarily have the expertise in web development languages like HTML, CSS, and Javascript. In essence just like `vue.js` and `react` in Javascript or `Blazor` in C#, R has the `Shiny` application framework.

However, the `shiny` framework does not include a `data` layer. This is because most application developed with `shiny` only ingests data from an external source once the application starts. The data is then stored in memory and manipulated by the `business logic` layer. Below is a update architecture diagram which better reflects applications build with the `shiny` framework:

![Architecture](/man/figures//Shiny.Architecture.png)

This is not ideal for enterprise-level applications. In enterprise-level applications is more transaction based: data is not only ingested but rather the ability to create, retrieve, update or deleted from storage in very common. This sample application includes a custom `data` layer with all four common data operations: Create, Retrieve, Update and Delete (CRUD). We will look this in more detail later.

For now we return to the typical `shiny` application architecture:

- The `User Interface (UI)` is defined using different `layout`, `input`, `output` widgets and contained in the `ui.R` file. Let's take a look at the `ui.R` file in the repository to see how the UI is defined:

```r
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
```

From a layout perspective, you can see we have a `dashboardPage` which contains `header`, `sidebar` and `body` widgets. For simplicity, the `sidebar` have been disabled. The `body` element contains a custom shiny widget: `Todo.View` and `Custom.Style()`. Although not used in the main `UI` layer, there are many standard `shiny` widgets which can be used. We will explore some when we look at the custom `Todo.View` widget.

- The `Business Logic (BL)` layer reacts to events from `input` widgets and updating of contents in `output` widgets using some predefined logic. The logic is defined in the `server.R` file. Referring back to the diagram, `3` represent events from `input` widgets captured by reactive function in the `BL` layer, while `2` represent updates pushed by the `BL` layer to `output` widgets.

Let's take a look at the `server.R` file in the repository to see how the `BL` layer is defined:

```r
shinyServer(\(input, output, session) {
  Todo.Controller("todo", data)
})
```

The `shinyServer` is part of the `shiny` framework and takes a function in which all `Business Logic` are defined. If you take a closer look at the arguments on this function you will notice `input` and `output` arguments. These arguments is how one can capture event on `input` widgets or send updates to `output` widgets. The reference to the `Todo.Controller` is part of the custom shiny module we will discuss next.

### Shiny Module Architecture

At this point it should not come as a surprise that custom module architecture is the same as the core architecture. The main difference is that the `UI` and `BL` layers are encapsulated in a module: `Todo.View` and `Todo.Controller`. Here is an update diagram with the custom `shiny` module:

![Architecture](/man/figures//Shiny.Module.Overview.png)

Important point to note: custom shiny modules always come in a pair: `View` and `Controller`. The `View` is the `UI` layer or the module, while the `Controller` is the `BL` layer. Unlike the core application, the `View` and `Controller` modules are not defined in separate files inside the `R` folder. The advantage of using custom shiny modules is that it allows us to build modular UI components, which increase reusability and scalability.

Lets look at the `Todo.View` module in more detail.

![Architecture](/man/figures//Shiny.Module.UI.png)

Here are the contents of the `Todo.View` file:

<details>
  <summary>Module UI Layer</summary>

```r
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
```

Notice the many different types of UI widgets used:

- Layout: `fluidRow`, `conditionalPanel`, `box`, `column`
- Input: `textInput`
- Output: `dataTableOutput`
- Actions: `actionButton`
- Events: `On.Enter.Event` (example of a custom event)

There are many more widgets available in the Shiny framework. You can find a complete list [here](https://shiny.rstudio.com/gallery/widget-gallery.html).

</details>

Lets look at the `Todo.Controller` module in more detail.

![Architecture](/man/figures//Shiny.Module.BL.png)

Here are the contents of the `Todo.Controller` file:

<details>
  <summary>Module BL Layer</summary>

```r
Todo.Controller <- \(id, data) {
  moduleServer(
    id,
    \(input, output, session) {
      # Local State
      state <- reactiveValues()
      state[["todos"]] <- data[['Retrieve']]()
      state[["todo"]]  <- NULL

      # Input Binding
      observeEvent(input[['create']], { controller[['create']]() })
      observeEvent(input[["todos_rows_selected"]], { controller[["select"]]() }, ignoreNULL = FALSE )
      observeEvent(input[["update"]], { controller[["update"]]() })
      observeEvent(input[["delete"]], { controller[["delete"]]() })

      # Input Verification
      verify <- list()
      verify[["taskEmpty"]]    <- reactive(input[["newTask"]] == '')
      verify[["todoSelected"]] <- reactive(!is.null(input[["todos_rows_selected"]]))

      # User Actions
      controller <- list()
      controller[['create']] <- \() {
        if (!verify[["taskEmpty"]]()) {
          state[["todos"]] <- input[["newTask"]] |> Todo.Model() |> data[['UpsertRetrieve']]()
          # Clear the input
          session |> updateTextInput("task", value = '')
        }
      }
      controller[['select']] <- \() {
        if (verify[["todoSelected"]]()) {
          state[["todo"]] <- state[["todos"]][input[["todos_rows_selected"]],]

          session |> updateTextInput("task", value = state[["todo"]][["Task"]])
          session |> updateTextInput("status", value = state[["todo"]][["Status"]])

        } else {
          state[["todo"]] <- NULL
        }
      }
      controller[['update']] <- \() {
        state[['todo']][["Task"]]   <- input[["task"]]
        state[['todo']][["Status"]] <- input[["status"]]

        state[["todos"]] <- state[['todo']] |> data[["UpsertRetrieve"]]()
      }
      controller[['delete']] <- \() {
        state[["todos"]] <- state[["todo"]][["Id"]] |> data[['DeleteRetrieve']]()
      }

      # Table Configuration
      table.options <- list(
        dom = "t",
        ordering = FALSE,
        columnDefs = list(
          list(visible = FALSE, targets = 0),
          list(width = '50px', targets = 1),
          list(className = 'dt-center', targets = 1),
          list(className = 'dt-left', targets = 2)
        )
      )

      # Output Bindings
      output[["todos"]] <- DT::renderDataTable({
        DT::datatable(
          state[["todos"]],
          selection = 'single',
          rownames = FALSE,
          colnames = c("", ""),
          options = table.options
        )
      })
      output[["isSelectedTodoVisible"]] <- reactive({ is.data.frame(state[["todo"]]) })
      outputOptions(output, "isSelectedTodoVisible", suspendWhenHidden = FALSE)
    }
  )
}
```

The `Todo.Controller` is a `reactive` function which takes two arguments: `id` and `data`. The `id` is used to identify the custom shiny widget, and the `data` is used to inject the data access layer into the business logic. We will look at the data access layer in the next section. Key elements in the `Todo.Controller` are:

1. Input Events: `observeEvent`
2. Input Validation: `reactive`
3. User Actions: `controller`
4. Output Bindings: `output`

From a high level, the module `Business Logic` uses `observerEvent` to capture events from `input` widgets, execute logic using the `controller` and update the `output` using `reactiveValues`.

Many more Reactive programming functions are available as part of the Shiny framework. You can find a complete list under the Reactive Programming section [here](https://shiny.posit.co/r/reference/shiny/latest/).

</details>

### Data Layer

- The `Data (Data)` layer is responsible for `creating`, `retrieving`, `updating` and `deleting` data in long-term storage. Unfortunately, unlike `Entity Framework` in C#, R has no framework to build `Data Layers`. Typically a data access Layer includes features which translate R code to, for example, SQL statements. Input, Output and Structural Validation and Exception handling are also included. Injecting the data access layer into a Shiny application is trivial.

Here is an example of how a data access layer is injected into the sample application:

```r
# Mock Storage
configuration <- data.frame()
storage       <- configuration |> Storage::Storage(type = 'memory')

table <- 'Todo'
Todo.Mock.Data |> storage[['SeedTable']](table)

# Data Access Layer
data  <- storage |> Todo.Orchestration()

shinyServer(\(input, output, session) {
  Todo.Controller("todo", data)
})
```

> Refer to the `Storage` package documentation for more information [here](https://github.com/FlippieCoetser/Storage)

<details>
  <summary>Custom Data Layer</summary>

The typical components in a Data Layer include:

1. Broker
2. Service
3. Processing
4. Orchestration
5. Validator
6. Exceptions

You can read all about the details of each of these components [here](https://github.com/hassanhabib/The-Standard). Here is an high-level overview of each component:

The Todo application uses a Mock Storage Service. The Mock Storage Service is a simple in-memory data structure which implements the Broker interface. The Broker interface is used to perform primitive operations against the data in storage, while the service is used to perform input and output validation. The Validator Service is used to perform structural and logic validation. The Exception Service is used to handle exceptions. The Processing Service is used to perform higher-order operations, and lastly, the Orchestration Service is used to perform a sequence of operations as required by the application.

Also, if you look closely at the `Todo.Controller` code previously presented, you will notice the use of the data layer:

1. Create Todo: `state[["todos"]] <- input[["newTask"]] |> Todo.Model() |> data[['UpsertRetrieve']]()`
2. Retrieve Todo: `state[["todos"]] <- data[['Retrieve']]()`
3. Update Todo: `state[["todos"]] <- state[['todo']] |> data[["UpsertRetrieve"]]()`
4. Delete Todo: `state[["todos"]] <- state[["todo"]][["Id"]] |> data[['DeleteRetrieve']]()`

</details>

The complete sample application architecture is presented below:

![Architecture](/man/figures//Custom.Data.Layer.png)

Application architecture is a complex topic. This section aimed to provide a high-level overview of enterprise-level software development with a focus on R and its ecosystem. The information presented is simplified and generalized as much as possible. The best way to learn Shiny is by experimenting: clone the sample application and start playing with the code.
