describe('Given Todo.Processing',{
  it('exist',{
    # Given
    Todo.Processing |> expect.exist()
  })
})

describe('When processors <- storage |> Todo.Processing()',{
  it('then processors is a list',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    processors <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    # Then
    processors |> expect.list()
  })
  it('then processors contains Retrieve processor',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    processors <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    # Then
    processors[['Retrieve']] |> expect.exist()
  })
  it('then processors contains Upsert processor',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    processors <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    # Then
    processors[['Upsert']] |> expect.exist()
  })
  it('then processors contains Remove processor',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    processors <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    # Then
    processors[['Remove']] |> expect.exist()
  })
})

describe("when process[['Retrieve']]()",{
  it("then a data.frame with all Todos are returned",{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    process <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    actual.todos   <- table |> storage[['Retrieve']](fields)
    expected.todos <- actual.todos

    # When
    retrieved.todos <- process[['Retrieve']]()

    # Then
    retrieved.todos |> expect.equal(expected.todos)
  })
})

describe("when todo |> process[['Upsert']]()",{
  it("then todo is added to todos if not exist",{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    process <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    random.todo   <- 'Task' |> Todo.Model()
    new.todo      <- random.todo 

    expected.todo <- new.todo
    
    # When
    new.todo |> process[['Upsert']]()

    # Then
    retrieved.todos <- table |> storage[['Retrieve']](fields)
    retrieved.todos |> expect.contain(expected.todo)
  })
  it("then todo is updated if exist",{
    # Given    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')
    
    process <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    existing.todo <- table |> storage[['Retrieve']](fields) |> tail(1)

    updated.todo  <- existing.todo
    updated.todo[['Task']] <- 'Updated Task'

    expected.todo <- updated.todo

    # When
    updated.todo |> process[['Upsert']]()

    # Then
    retrieved.todo <- updated.todo[['Id']] |> storage[['RetrieveWhereId']](table, fields)

    retrieved.todo[['Id']]     |> expect_equal(expected.todo[['Id']])
    retrieved.todo[['Task']]   |> expect_equal(expected.todo[['Task']])
    retrieved.todo[['Status']] |> expect_equal(expected.todo[['Status']])
  })
})

describe("then id |> process[['Remove']]()",{
  it("then todo is removed from todos",{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    process <- storage |> Todo.Broker() |> Todo.Service() |> Todo.Processing()

    existing.todo <- table |> storage[['Retrieve']](fields) |> tail(1)

    # When
    existing.todo[['Id']] |> process[['Remove']]()

    # Then
    existing.todo[['Id']] |> storage[['RetrieveWhereId']](table, fields) |> expect.empty()
  })
})