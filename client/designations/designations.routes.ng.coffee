'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'designations-list',
    url: '/designations'
    templateUrl: 'client/designations/designations-list.view.html'
    controller: 'DesignationsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
  .state 'designation-detail',
    url: '/designations/:designationId'
    templateUrl: 'client/designations/designation-detail.view.html'
    controller: 'DesignationDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
