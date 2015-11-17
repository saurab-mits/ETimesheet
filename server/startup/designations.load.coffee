Meteor.startup ->
  if Designations.find().count() == 0
    designations = [
      {
        'name': 'designation 1'
        'description':'jpt'
        'deleted' :'0'
        'isActive': '1'
      }
      {
        'name': 'designation 2'
      }
    ]
    designations.forEach (designation) ->
      Designations.insert designation