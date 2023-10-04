/* 
All columns which is of type uniqueidentifier will return capitalized results.
R is case sensitive, therefore the sql builtin LOWER(<column>) is used to ensure data integrity. 
*/

SELECT 
  LOWER([Id]) as Id, 
  [Task], 
  [Status]
FROM [dbo].[ToDo]
WHERE [Id] = '4a0ec243-78ff-4461-8696-c41e7d64e108'