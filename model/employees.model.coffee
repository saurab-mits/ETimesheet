@Employees = new Mongo.Collection('employees')

Employees.allow
  insert: (userId, employee) ->
    true
  update: (userId, employee, fields, modifier) ->
    true
  remove: (userId, employee) ->
    true
