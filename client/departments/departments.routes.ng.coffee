'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'departments-list',
    url: '/departments'
    templateUrl: 'client/departments/departments-list.view.html'
    controller: 'DepartmentsListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].address=="admin@etimesheet.com")
             return true
           return 'UNAUTHORIZED'
         )
      ]
  .state 'department-detail',
    url: '/departments/:departmentId'
    templateUrl: 'client/departments/department-detail.view.html'
    controller: 'DepartmentDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].address=="admin@etimesheet.com")
             return true
           return 'UNAUTHORIZED'
         )
      ]