describe('Given Todo.Broker',{
  it('exist',{
    # Given
    Todo.Broker |> expect.exist()
  })
})

describe('When operations <- storage |> Todo.Broker()',{
  it('then operations is a list',{
    # When
    operations <- storage |> Todo.Broker()

    # Then
    operations |> expect.list()
  })
  it('then operations contains Insert operation',{
    # When
    operations <- storage |> Todo.Broker()

    # Then
    operations[['Insert']] |> expect.exist()
  })
  it('then operations contains Select operation',{
    # When
    operations <- storage |> Todo.Broker()

    # Then
    operations[['Select']] |> expect.exist()
  })
  it('then operations contains SelectById operation',{
    # When
    operations <- storage |> Todo.Broker()

    # Then
    operations[['SelectById']] |> expect.exist()
  })
  it('then operations contains Update operation',{
    # When
    operations <- storage |> Todo.Broker()

    # Then
    operations[['Update']] |> expect.exist()
  })
  it('then operations contains Delete operation',{
    # When
    operations <- storage |> Todo.Broker()

    # Then
    operations[['Delete']] |> expect.exist()
  })
})

describe("When todo |> operation[['Insert']]()",{
  it('then todo is inserted into storage',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    operation <- storage |> Todo.Broker()

    new.todo      <- 'Task' |> Todo.Model()
    expected.todo <- new.todo

    # When
    new.todo |> operation[['Insert']]()

    # Then
    retrieved.todo <- new.todo[['Id']] |> storage[['RetrieveWhereId']](table, fields)
    
    retrieved.todo |> expect.equal.data(expected.todo)
  })
})
describe("When operation[['Select']]()",{
  it('then all todos are retrieved from storage',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    operation <- storage |> Todo.Broker()

    expected.todos <- table |> storage[['Retrieve']](fields) 

    # When
    retrieved.todos <- operation[['Select']]()

    # Then
    retrieved.todos |> expect.equal(expected.todos)
  })
})
describe("When id |> operation[['SelectById']]()",{
  it('then todo with matching id is retrieved from storage',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')

    Todo.Mock.Data |> storage[['SeedTable']]('Todo')
    
    operation <- storage |> Todo.Broker()
    
    existing.todo <- table |> storage[['Retrieve']](fields) |> head(1)

    input.todo    <- existing.todo
    expected.todo <- existing.todo

    # When
    retrieved.todo <- input.todo[['Id']] |> operation[['SelectById']]()

    # Then
    retrieved.todo |> expect.equal.data(expected.todo)
  })
})
describe("When todo |> operation[['Update']]()",{
  it('then todo is updated in storage',{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    operation <- storage |> Todo.Broker()

    existing.todo <- table |> storage[['Retrieve']](fields) |> head(1)

    updated.todo <- existing.todo
    updated.todo[['Status']] <- 'Updated'

    expected.todo <- updated.todo

    # When
    updated.todo |> operation[['Update']]()

    # Then
    retrieved.todo <- updated.todo[['Id']] |> storage[['RetrieveWhereId']](table, fields)

    updated.todo |> expect.equal.data(retrieved.todo)
  })
})
describe("When id |> operation[['Delete']]()",{
  it("then todo with matching id is deleted from storage",{
    # When
    configuration <- data.frame()
    storage <- configuration |> Storage::Storage('memory')
    
    Todo.Mock.Data |> storage[['SeedTable']]('Todo')

    operation <- storage |> Todo.Broker()

    existing.todo <- table |> storage[['Retrieve']](fields) |> tail(1)

    # When
    existing.todo[['Id']] |> operation[['Delete']]()

    # Then
    retrieved.todo <- existing.todo[['Id']] |> storage[['RetrieveWhereId']](table, fields)
    
    retrieved.todo |> expect.empty()
  })
})
