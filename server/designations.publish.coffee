'use strict'

Meteor.publish 'designations', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfDesignations', Designations.find(where), noReady: true
  Designations.find where, options