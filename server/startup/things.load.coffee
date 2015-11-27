Meteor.startup ->
  if Meteor.users.find().count() == 0
    Accounts.createUser({
      email: 'admin@etimesheet.com'
      password: 'admin123'
      stopActivationLink : true
    })
    Accounts.createUser({
      email: 'saurab@makeitsimple.info'
      password: 'saurab123'
      stopActivationLink : true
    })
    
   ### users =[
      {
        "_id" : "DbLfBj8TBLzhCDjf2",
        "createdAt" : new Date(),
        "services" : {
                "password" : {
                        "bcrypt" : "$2a$10$fNLFjFtkffTWCEG/G5AEquH9d8A/zSqBEpY2AdcCArySLa/QHpKru"
                },
                "resume" : {
                        "loginTokens" : [
                                {
                                        "when" : new Date(),
                                        "hashedToken" : "YZ/Fir65ZsQNyJJgEmfwdnv7+ZcT5opeZx8tkyiddqY="
                                }
                        ]
                },
                "email" : {
                        "verificationTokens" : [
                                {
                                        "token" : "rhK6MXlpFWmX3dqok1wQqBwx5_bKK9dsOP3ShA0FuYt",
                                        "address" : "admin@etimesheet.com",
                                        "when" : new Date()
                                }
                        ]
                }
        },
        "emails" : [
                {
                        "address" : "admin@etimesheet.com",
                        "verified" : true
                }
        ]
      }
    ]
    users.forEach (user) ->
      Meteor.users.insert user###
    
        
      
  