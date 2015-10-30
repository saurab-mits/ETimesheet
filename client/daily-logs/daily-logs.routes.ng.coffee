'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'addTimesheet',
    url: '/daily-logs'
    templateUrl: 'client/daily-logs/daily-logs-list.view.html'
    controller: 'DailyLogsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
  .state 'dailyLog-detail',
    url: '/dailylogs'
    templateUrl: 'client/daily-logs/daily-log-detail.view.html'
    controller: 'DailyLogDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
