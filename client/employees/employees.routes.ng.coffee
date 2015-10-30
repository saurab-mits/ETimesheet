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
  .state 'udashboard',
    url: '/udashboard'
    templateUrl: 'client/udashboard/udashboard.view.html'
    controller: 'udashboardctrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
  .state 'adashboard',
    url: '/adashboard'
    templateUrl: 'client/adashboard/adashboard.view.html'
    controller: 'adashboardctrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
      ]
  .state 'emplst',
    url: '/userlist'
    templateUrl: 'client/userlist/employees.view.html'
    controller: 'empListCtrl'
    resolve:
      currentUser: ['$meteor', ($meteor) ->
        $meteor.requireUser()
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

   