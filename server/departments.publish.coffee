'use strict'

Meteor.publish 'departments', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfDepartments', Departments.find(where), noReady: true
  Departments.find where, options