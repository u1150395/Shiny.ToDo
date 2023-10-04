describe('Given Todo.Structure.Validation',{
  it('exist',{
    # Given
    Todo.Structure.Validation |> expect.exist()
  })
})

describe("When validators <- Todo.Structure.Validation()",{
  it('then validators is a list',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators |> expect.list()
  })
  it('then validators contains TodoExist validator',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators[['TodoExist']] |> expect.exist()
  })
  it('then validators contains HasId validator',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators[['HasId']] |> expect.exist()
  })
  it('then validators contains HasTask validator',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators[['HasTask']] |> expect.exist()
  })
  it('then validators contains HasStatus validator',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators[['HasStatus']] |> expect.exist()
  })
  it('then validators contains Todo validator',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators[['Todo']] |> expect.exist()
  })
  it('then validators contains IdExist validator',{
    # Given
    validators <- Todo.Structure.Validation()

    # Then
    validators[['IdExist']] |> expect.exist()
  })
})

describe("When todo |> validate[['TodoExist']]()",{
  it('then no exception is thrown if todo exist',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame()

    # Then
    todo |> validate[['TodoExist']]() |> expect.no.error()
  })
  it('then an exception is thrown if todo is null',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- NULL

    expected.error <- 'successful validation requires a data frame with todo'

    # Then
    todo |> validate[['TodoExist']]() |> expect.error(expected.error)
  })
})
describe("When todo |> validate[['HasId']]()",{
  it('then no exception is thrown if todo has Id',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame(
      Id = 'Id'
    )

    # Then
    todo |> validate[['HasId']]() |> expect.no.error()
  })
  it('then an exception is thrown if todo has no Id',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame()

    expected.error <- 'todo data frame has no Id'

    # Then
    todo |> validate[['HasId']]() |> expect.error(expected.error)
  })
})
describe("When todo |> validate[['HasTask']]()",{
  it('then no exception is thrown if todo has Task',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame(
      Task = 'Task'
    )

    # Then
    todo |> validate[['HasTask']]() |> expect.no.error()
  })
  it('then an exception is thrown if todo has no Task',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame()

    expected.error <- 'todo data frame has no Task'

    # Then
    todo |> validate[['HasTask']]() |> expect.error(expected.error)
  })
})
describe("When todo |> validate[['HasStatus']]()",{
  it('then no exception is thrown if todo has Status',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame(
      Status = 'Status'
    )

    # Then
    todo |> validate[['HasStatus']]() |> expect.no.error()
  })
  it('then an exception is thrown if todo has no Status',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame()

    expected.error <- 'todo data frame has no Status'

    # Then
    todo |> validate[['HasStatus']]() |> expect.error(expected.error)
  })
})
describe("When todo |> validate[['Todo']]()",{
  it('then no exception is thrown if todo is valid',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame(
      Id     = 'Id',
      Task   = 'Task',
      Status = 'Status'
    )

    # Then
    todo |> validate[['Todo']]() |> expect.no.error()
  })
  it('then an exception is thrown if todo is null',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- NULL

    expected.error <- 'successful validation requires a data frame with todo'

    # Then
    todo |> validate[['Todo']]() |> expect.error(expected.error)
  })
  it('then an exception is thrown if todo has no Id',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame()

    expected.error <- 'todo data frame has no Id'

    # Then
    todo |> validate[['Todo']]() |> expect.error(expected.error)
  })
  it('then an exception is thrown if todo has no Task',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame(
      Id = 'Id'
    )

    expected.error <- 'todo data frame has no Task'

    # Then
    todo |> validate[['Todo']]() |> expect.error(expected.error)
  })
  it('then an exception is thrown if todo has no Status',{
    # Given
    validate <- Todo.Structure.Validation()

    todo  <- data.frame(
      Id     = 'Id',
      Task   = 'Task'
    )

    expected.error <- 'todo data frame has no Status'

    # Then
    todo |> validate[['Todo']]() |> expect.error(expected.error)
  })
})
describe("When id |> validate[['IdExist']]()",{
  it('then no exception is thrown if id exist',{
    # Given
    validate <- Todo.Structure.Validation()

    id  <- uuid::UUIDgenerate()

    # Then
    id |>
      validate[['IdExist']]() |>
        expect.no.error()
  })
  it('then an exception is thrown if id is null',{
    # Given
    validate <- Todo.Structure.Validation()

    id  <- NULL

    expected.error <- 'successful validation requires an Id'

    # Then
    id |>
      validate[['IdExist']]() |>
        expect.error(expected.error)
  })
})