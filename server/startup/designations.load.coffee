Meteor.startup ->
  if Designations.find().count() == 0
    designations = [
      {
        'name': 'designation 1'
        'description':'jpt1'
        'deleted' :'0'
        'isActive': '1'
      }
      {
        'name': 'designation 2'
        'description':'jpt2'
        'deleted' :'0'
        'isActive': '1'
      }
    ]
    designations.forEach (designation) ->
      Designations.insert designation