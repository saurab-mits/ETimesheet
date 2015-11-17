'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'leaveRequests-list',
    url: '/leave-requests'
    templateUrl: 'client/leave-requests/leave-requests-list.view.html'
    controller: 'LeaveRequestsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
  .state 'leaveRequest-detail',
    url: '/leave-requests/:leaveRequestId'
    templateUrl: 'client/leave-requests/leave-request-detail.view.html'
    controller: 'LeaveRequestDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].address=="admin@etimesheet.com")
             return true
           return 'UNAUTHORIZED'
         )
      ]
