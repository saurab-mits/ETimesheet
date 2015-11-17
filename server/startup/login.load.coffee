Meteor.startup ->
  
  if Login.find().count() == 0
    login = [
      {
        'name': 'login 1'
      }
      {
        'name': 'login 2'
      }
    ]
    login.forEach (login) ->
      Login.insert login