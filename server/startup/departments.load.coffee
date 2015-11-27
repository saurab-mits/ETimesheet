Meteor.startup ->
  if Departments.find().count() == 0
    departments = [
      {
        'name': 'department 1'
        'description':'department 1'
        'deleted' :'0'
        'isActive': '1'
      }
      {
        'name': 'department 2'
        'description':'department 2'
        'deleted' :'0'
        'isActive': '1'
      }
    ]
    departments.forEach (department) ->
      Departments.insert department