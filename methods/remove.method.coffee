'use strict'
Meteor.isServer
Meteor.methods
  setpassword:(userId, newPlaintextPassword) ->
    Accounts.setPassword(userId, newPlaintextPassword)
  remove: (useradd) ->
    Meteor.users.remove('emails.address':useradd)


  