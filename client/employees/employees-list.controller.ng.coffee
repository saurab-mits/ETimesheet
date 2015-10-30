'use strict'

angular.module ('etimesheetApp')
.controller 'EmployeesListCtrl', ($scope, $meteor, $state) ->
  $scope.page = 1
  $scope.perPage = 3
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'

    
  $scope.employees = $scope.$meteorCollection () ->
    Employees.find {}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('employees', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.employeesCount = $scope.$meteorObject Counts, 'numberOfEmployees', false

  $meteor.session 'employeesCounter'
  .bind $scope, 'page'
  $scope.user = $scope.$meteorCollection () ->
    Meteor.users.find {}

    
  $scope.save = () ->
    $scope.newEmployee.deleted='0'
    $scope.newEmployee.isActive='1'
    $scope.newEmployee.emailAddress = {
      primary : $scope.email
    }
    $scope.employees.save $scope.newEmployee
    console.log($scope.newEmployee.emailAddress.secondary)
    console.log($scope.newEmployee.emailAddress.primary)
    console.log($scope.newEmployee.Lname)
    console.log("Home number="+ $scope.newEmployee.personalDetails.Contact.Hnumber)
    $scope.newEmployee = undefined
    console.log("record saved")
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
    
      
  $scope.remove = (employee) ->
    $scope.employees.remove employee
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
