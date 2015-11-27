'use strict'
Meteor.isServer
Meteor.methods
  setpassword:(userId, newPlaintextPassword) ->
    Accounts.setPassword(userId, newPlaintextPassword)
  remove: (useradd) ->
    Meteor.users.remove('emails.address':useradd)
  update12: (useradd)->
    Meteor.users.update('emails.address':useradd,{$set:{emails:[{"address":useradd,"verified":true,"isActive":1}]}})
  update123: (useradd)->
    Meteor.users.update('emails.address':useradd,{$set:{emails:[{"address":useradd,"verified":true,"isActive":0}]}})
  update33: (leaveId)->
    LeaveRequests.update(leaveId,{$set:"approvedBy":"admin@etimesheet.com","approvedDate":new Date()})
 ### update13:
    Meteor.users.update('emails.address':useradd,{$set:"emails.verified":true})###
  
  


  