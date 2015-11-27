'user strict'

Accounts.onCreateUser (options, user) ->
  if options.stopActivationLink
    user.emails[0].verified=true
    user.emails[0].isActive=0
  else
    user.emails[0].isActive=0

    #console.log(user.emails[0].address)
    #Meteor.call('verification',user._id,user.emails[0].address)
  return user
