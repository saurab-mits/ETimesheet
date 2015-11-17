'use strict'

Meteor.publish 'leaveRequests', (options, searchString) ->
  where =
    'user':
      '$regex': '.*' + (searchString or '') + '.*'
      '$options': 'i'
  Counts.publish this, 'numberOfLeaveRequests', LeaveRequests.find(where), noReady: true
  LeaveRequests.find where, options