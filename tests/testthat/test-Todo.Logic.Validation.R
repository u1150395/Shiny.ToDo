describe('Given Todo.Logic.Validation',{
  it('exist',{
    # Given
    Todo.Logic.Validation |> expect.exist()
  })
})

describe('When validators <- Todo.Logic.Validation()',{
  it('then operations is a list',{
    # Given
    validators <- Todo.Logic.Validation()

    # Then
    validators |> expect.list()
  })
  it('then operations has IsDuplicate',{
    # Given
    validators <- Todo.Logic.Validation()

    # Then
    validators[["IsDuplicate"]] |> expect.exist()
  })
})

describe("When todo |> validate[['IsDuplicate']]()",{
  it('then no exception is thrown if todo does not exist in todos',{
    # Given
    validate <- Todo.Logic.Validation()

    todos <- data.frame(
      Id     = c('7ab3df6f-2e8f-44b4-87bf-3004cf1c16ae',
               '7bfef861-6fe9-46da-9ad2-6a58779ccdcd',
               'd3b59bf0-14f0-4444-9ec9-1913e7256ee4'),
      Task   = c('Task.1','Task.2','Task.3'),
      Status = c('New','New','Done')
    )

    todo  <- 'Task' |> Todo.Model()

    # Then
    todo |> validate[['IsDuplicate']](todos) |> expect_no_error()
  })
  it('then an exception is thrown if todo does exist in todos',{
    # Given
    validate <- Todo.Logic.Validation()

    todos <- data.frame(
      Id     = c('7ab3df6f-2e8f-44b4-87bf-3004cf1c16ae',
               '7bfef861-6fe9-46da-9ad2-6a58779ccdcd',
               'd3b59bf0-14f0-4444-9ec9-1913e7256ee4'),
      Task   = c('Task.1','Task.2','Task.3'),
      Status = c('New','New','Done')
    )

    todo  <- todos |> head(1)

    # Then
    todo |> validate[['IsDuplicate']](todos) |> expect_error()
  })
})
