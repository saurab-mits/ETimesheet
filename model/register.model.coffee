@Register = new Mongo.Collection('register')

Register.allow
  insert: (userId, register) ->
    true
  update: (userId, register, fields, modifier) ->
    true
  remove: (userId, register) ->
    true
