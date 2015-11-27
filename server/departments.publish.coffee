'use strict'

Meteor.publish 'departments', (options, searchString) ->
  if !searchString
    searchString = ''
  Counts.publish this, 'numberOfDepartments', Departments.find(
    'name':
      '$regex': '.*' + searchString or '' + '.*'
      '$options':'i'
  ), noReady: true
  Departments.find {
    'name':
      '$regex': '.*' + searchString or '' + '.*'
      '$options':'i'  
  }, options