'use strict'

angular.module ('etimesheetApp')
.controller 'EmployeesListCtrl', ($scope, $meteor, $state, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 10
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
  

    
  $scope.save = () ->
    $scope.newEmployee.deleted='0'
    $scope.newEmployee.isActive='0'
    $scope.newEmployee.emailAddress = {
      primary : $scope.email
    }
    $scope.employees.save $scope.newEmployee
    $mdToast.show($mdToast.simple().content('Employees registered Sucessfully'))
    console.log($scope.newEmployee.emailAddress.secondary)
    console.log($scope.newEmployee.emailAddress.primary)
    console.log($scope.newEmployee.Lname)
    console.log("Home number="+ $scope.newEmployee.personalDetails.Contact.Hnumber)
    $scope.newEmployee = undefined
    console.log("record saved")
    Meteor.call('create',$scope.email,$scope.password)
    $state.go('main')
    ###Accounts.createUser({email:$scope.email,password:$scope.password}, (error)->
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
          $state.go('main')
    )###
    
      
  $scope.remove = (employee) ->
    $scope.employees.remove employee
    $mdToast.show($mdToast.simple().content('Data removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
