'use strict'
Meteor.isServer
Meteor.methods
  resetpas:(userId,newPlaintextPassword)->
    console.log(userId)
    Accounts.setPassword(userId,newPlaintextPassword)
  update:(userId) ->
    console.log(userId)
    Employees.update(userId,{$set:"deleted":"1"})
  update1:(des) ->
    console.log(des)
    Designations.update(des,{$set:"deleted":"1"})
  update2:(dep) ->
    console.log(dep)
    Departments.update(dep,{$set:"deleted":"1"})
  update11:(userId) ->
    Employees.update(userId,{$set:"isActive":"1"})
  update112:(userId) ->
    Employees.update(userId,{$set:"isActive":"0"})
  create:(add,pass)->
    userId= Accounts.createUser({email:add,password:pass})
    console.log(userId)
    Accounts.sendVerificationEmail(userId,add)
     
  


        


  