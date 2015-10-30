Meteor.startup ->
  if Meteor.users.find().count() == 0
    options =
      email: 'admin@etimesheet.com'
      password: 'admin'
      profile: [
        role:'admin'
      ]
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