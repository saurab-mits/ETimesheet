'use strict'

Meteor.publish 'register', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfRegister', Register.find(where), noReady: true
  Register.find where, options