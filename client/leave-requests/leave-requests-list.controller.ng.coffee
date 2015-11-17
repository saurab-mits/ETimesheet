'use strict'

angular.module 'etimesheetApp'
.controller 'LeaveRequestsListCtrl', ($scope, $meteor, $mdToast,$state) ->
  #$scope.myDate= new Date()
  $scope.page = 1
  $scope.perPage = 10
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  
  $scope.leaveRequests = $scope.$meteorCollection () ->
    LeaveRequests.find {}, {sort:$scope.getReactively('sort')}
   $scope.employee= $scope.$meteorCollection () ->
    Employees.find {'emailAddress.primary':$scope.currentUser.emails[0].address}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('employees')
    $scope.$meteorSubscribe('leaveRequests', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.leaveRequestsCount = $scope.$meteorObject Counts, 'numberOfLeaveRequests', false
    

  $meteor.session 'leaveRequestsCounter'
  .bind $scope, 'page'
  
  console.log($scope.currentUser.emails[0].address)
    
  $scope.save = () ->
      $scope.newLeaveRequest.askDate=new Date()
      $scope.newLeaveRequest.startDate= $scope.startDate
      $scope.newLeaveRequest.endDate= $scope.endDate
      $scope.newLeaveRequest.user= $scope.employee[0].name
      $scope.leaveRequests.save $scope.newLeaveRequest
      $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
      $scope.newLeaveRequest = undefined
      console.log($scope.currentUser.emails[0].address)
      console.log($scope.startDate)
      console.log($scope.endDate)
      $state.go 'udashboard'


      
  $scope.remove = (leaveRequest) ->
    $scope.leaveRequests.remove leaveRequest
    $mdToast.show($mdToast.simple().content('Data removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
