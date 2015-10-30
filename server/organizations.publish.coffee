'use strict'

Meteor.publish 'organizations', (options, searchString) ->
  where =
    'name':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfOrganizations', Organizations.find(where), noReady: true
  Organizations.find where, options