/* 
DO NOT RUN THIS SCRIPT.
This script was used to create the table in azure sql database.
It is meant to be used as an example only. 
*/

CREATE TABLE [dbo].[ToDo] (
  [Id]     UNIQUEIDENTIFIER NOT NULL,
  [Task]   NVARCHAR (100)   NOT NULL,
	[Status] NVARCHAR (100)   NOT NULL
);