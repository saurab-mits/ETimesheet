'use strict'

angular.module 'etimesheetApp'
.controller 'RegisterCtrl', ['$scope', '$meteor', '$state', ($scope, $meteor, $state, $mdToast) ->
  $scope.password = ''
  $scope.role = 'normal'
  $scope.error = ''
  $scope.email=''
  $scope.user = $scope.$meteorCollection () ->
    Meteor.users.find {}
  $scope.employees = $scope.$meteorCollection () ->
    Meteor.Employees.find {}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('employees', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.employeesCount = $scope.$meteorObject Counts, 'numberOfEmployees', false


  $scope.save = ()->
    if $scope.form.$valid
      $scope.newEmployee.emailAddress.primary=$scope.email
      $scope.employees.save $scope.newEmployee
      $mdToast.show($mdToast.simple().content('User registered Sucessfully'))
      console.log("saved")
      $scope.newEmployee = undefined
    Accounts.createUser({email:$scope.email,password:$scope.password,Role:$scope.role}, (error)->
      if(error)
        console.log(error)
      else
        console.log('success')
        $scope.verificationState = $scope.user[0].emails[0].verified
        $scope.emailToVerify = $scope.user[0].emails[0].address
        if($scope.verificationState==false)
          Meteor.call('chkEmailVerify',Meteor.userId(),$scope.emailToVerify)
          $state.go('not-verified',{userId: Meteor.userId()})
        else
          $state.go('udashboard')
    )
   
]



