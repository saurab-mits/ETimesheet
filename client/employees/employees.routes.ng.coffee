'use strict'

angular.module 'etimesheetApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'employees-list',
    url: '/employees'
    templateUrl: 'client/employees/employees-list.view.html'
    controller: 'EmployeesListCtrl'
    
  .state 'employee-detail',
    url: '/employees/:employeeId'
    templateUrl: 'client/employees/employee-detail.view.html'
    controller: 'EmployeeDetailCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].address=="admin@etimesheet.com")
             return true
           return 'UNAUTHORIZED'
         )
      ]
  .state 'udashboard',
    url: '/udashboard'
    templateUrl: 'client/udashboard/udashboard.view.html'
    controller: 'udashboardctrl'
    resolve:
      currentUser: ['$meteor','$state', ($meteor,$state) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].verified==true && user.emails[0].isActive==1)
             return true
          else
            $state.go('not-verified')
          )
      ]

  .state 'adashboard',
    url: '/adashboard'
    templateUrl: 'client/adashboard/adashboard.view.html'
    controller: 'adashboardctrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].address=="admin@etimesheet.com")
             return true
           return 'UNAUTHORIZED'
         )
      ]
  .state 'emplst',
    url: '/userlist'
    templateUrl: 'client/userlist/employees.view.html'
    controller: 'empListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireValidUser((user)->
          if(user.emails[0].address=="admin@etimesheet.com")
             return true
           return 'UNAUTHORIZED'
         )
      ]    
  .state 'not-verified',
    url: '/udashboard/notverified/:userId'
    templateUrl: 'client/udashboard/not-verified.view.html'
    controller: 'NotverifiedCtrl'
  .state 'logout',
    url: '/logout'
    resolve:
      "logout": ['$meteor', '$state', ($meteor, $state) -> 
        return $meteor.logout().then( -> 
          $state.go('main');
        , (err) -> 
          console.log('logout error - ', err);
        )
      ]  

   