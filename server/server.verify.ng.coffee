'use strict'
Meteor.isServer
Meteor.methods
  chkEmailVerify:(userId,emailToVerify) ->
    Accounts.sendVerificationEmail(userId,emailToVerify)
  update:(userId) ->
    console.log(userId)
    Employees.update(userId,{$set:"deleted":"1"})
  update1:(des) ->
    console.log(des)
    Designations.update(des,{$set:"deleted":"1"})
  update2:(dep) ->
    console.log(dep)
    Departments.update(dep,{$set:"deleted":"1"})
  