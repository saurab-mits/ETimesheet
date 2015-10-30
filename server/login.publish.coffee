'use strict'

Meteor.publish 'login', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfLogin', Login.find(where), noReady: true
  Login.find where, options