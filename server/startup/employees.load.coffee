Meteor.startup ->
  if Employees.find().count() == 0
    employees = [
      {
        "name" : "saurab",
        "Mname" : "raj",
        "Lname" : "Bajgain",
        "personalDetails" : {
                "Contact" : {
                        "Mnumber" : 12345678,
                        "Hnumber" : 234567
                },
                "Address" : "jadibuti"
        },
        "emailAddress" : {
                "primary" : "saurab@makeitsimple.info"
        },
        "deleted" : "0",
        "isActive" : "0"
      }
    ]
    employees.forEach (employee) ->
      Employees.insert employee