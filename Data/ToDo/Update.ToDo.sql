/* 
Execute this script ONCE after executing the insert script.
After doing so, execute the delete script to ensure the database remains clean
*/

UPDATE [dbo].[ToDo]
SET Id = '4a0ec243-78ff-4461-8696-c41e7d64e108', 
    Task = 'Task.4', 
    Status = 'Done'
WHERE Id = '4a0ec243-78ff-4461-8696-c41e7d64e108'