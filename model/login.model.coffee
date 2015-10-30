@Login = new Mongo.Collection('login')

Login.allow
  insert: (userId, login) ->
    true
  update: (userId, login, fields, modifier) ->
    true
  remove: (userId, login) ->
    true
