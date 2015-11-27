'use strict'

Meteor.publish 'users',()  ->
   return Meteor.users.find {},fields:
    emails:1
    _id:1
    
  #   profile: 1
  #   isActive: 1
    
 