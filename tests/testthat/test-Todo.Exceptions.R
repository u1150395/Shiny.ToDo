describe('Given Todo.Exceptions',{
  it('exist',{
    # Given
    Todo.Exceptions |> expect.exist()
  })
})

describe('When exceptions <- Todo.Exceptions()',{
  it('then exceptions is a list',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions |> expect.list()
  })
  it('then exceptions contains TodoIsNull exception',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions[['TodoIsNull']] |> expect.exist()
  })
  it('then exceptions contains TodoIdIsNull exception',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions[['TodoIdIsNull']] |> expect.exist()
  })
  it('then exceptions contains TodoTaskIsNull exception',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions[['TodoTaskIsNull']] |> expect.exist()
  })
  it('then exceptions contains TodoStatusIsNull exception',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions[['TodoStatusIsNull']] |> expect.exist()
  })
  it('then exceptions contains DuplicateKey exception',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions[['DuplicateKey']] |> expect.exist()
  })
  it('then exceptions contains IdIsNull exception',{
    # Given
    exceptions <- Todo.Exceptions()

    # Then
    exceptions[['IdIsNull']] |> expect.exist()
  })
})

describe("When input |> exception[['TodoIsNull']]()",{
  it('then no exception is thrown if input is FALSE',{
    # Given
    exception <- Todo.Exceptions()

    input <- FALSE

    # Then
    input |> exception[["TodoIsNull"]]() |> expect.no.error()
  })
  it('then an exception is thrown if input is TRUE',{
    # Given
    exception <- Todo.Exceptions()

    input <- TRUE

    expected.error <- 'successful validation requires a data frame with todo'

    # Then
    input |> exception[["TodoIsNull"]]() |> expect.error(expected.error)
  })
})
describe("When input |> exception[['TodoIdIsNull']]()",{
  it('then no exception is thrown if input is FALSE',{
    # Given
    exception <- Todo.Exceptions()

    input <- FALSE

    # Then
    input |> exception[["TodoIdIsNull"]]() |> expect.no.error()
  })
  it('then an exception is thrown if input is TRUE',{
    # Given
    exception <- Todo.Exceptions()

    input <- TRUE

    expected.error <- 'todo data frame has no Id'

    # Then
    input |> exception[["TodoIdIsNull"]]() |> expect.error(expected.error)
  })
})
describe("When input |> exception[['TodoTaskIsNull']]()",{
  it('then no exception is thrown if input is FALSE',{
    # Given
    exception <- Todo.Exceptions()

    input <- FALSE

    # Then
    input |> exception[["TodoTaskIsNull"]]() |> expect.no.error()
  })
  it('then an exception is thrown if input is TRUE',{
    # Given
    exception <- Todo.Exceptions()

    input <- TRUE

    expected.error <- 'todo data frame has no Task'

    # Then
    input |> exception[["TodoTaskIsNull"]]() |> expect.error(expected.error)
  })
})
describe("When input |> exception[['TodoStatusIsNull']]()",{
  it('then no exception is thrown if input is FALSE',{
    # Given
    exception <- Todo.Exceptions()

    input <- FALSE

    # Then
    input |> exception[["TodoStatusIsNull"]]() |> expect.no.error()
  })
  it('then an exception is thrown if input is TRUE',{
    # Given
    exception <- Todo.Exceptions()

    input <- TRUE

    expected.error <- 'todo data frame has no Status'

    # Then
    input |> exception[["TodoStatusIsNull"]]() |> expect.error(expected.error)
  })
})
describe("When input |> exception[['DuplicateKey']]()",{
  it('then no exception is thrown if input is FALSE',{
    # Given
    exception <- Todo.Exceptions()

    input <- FALSE

    # Then
    input |> exception[["DuplicateKey"]]() |> expect.no.error()
  })
  it('then an exception is thrown if input is TRUE',{
    # Given
    exception <- Todo.Exceptions()

    input <- TRUE

    expected.error <- 'todo already exist, duplicate key not allowed'

    # Then
    input |> exception[["DuplicateKey"]]() |> expect.error(expected.error)
  })
})
describe("When input |> exception[['IdIsNull']]()",{
  it('then no exception is thrown if input is FALSE',{
    # Given
    exception <- Todo.Exceptions()

    input <- FALSE

    # Then
    input |> exception[["IdIsNull"]]() |> expect.no.error()
  })
  it('then an exception is thrown if input is TRUE',{
    # Given
    exception <- Todo.Exceptions()

    input <- TRUE

    expected.error <- 'successful validation requires an Id'

    # Then
    input |> exception[["IdIsNull"]]() |> expect.error(expected.error)
  })
})