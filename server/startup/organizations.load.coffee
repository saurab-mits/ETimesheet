Meteor.startup ->
  if Organizations.find().count() == 0
    organizations = [
      {
        'name': 'MakeItSimple'
        'address':'Pulchowk,kathmandu'
        'Contact':{
          'Phone':'016634669'
        }
        'email':'mis@makeitsimple.info'
      }
      
    ]
    organizations.forEach (organization) ->
      Organizations.insert organization