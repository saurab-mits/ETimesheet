'use strict'

angular.module 'etimesheetApp'
.controller 'DepartmentsListCtrl', ($scope, $meteor, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.IsVisible=false
  $scope.sort = name : 1
  $scope.orderProperty = '1'
  
  
  $scope.departments = $scope.$meteorCollection () ->
    Departments.find {'deleted':'0'}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('departments', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.departmentsCount = $scope.$meteorObject Counts, 'numberOfDepartments', false

  $meteor.session 'departmentsCounter'
  .bind $scope, 'page'

  $scope.cancel=()->
    $scope.IsVisible = false
  $scope.ShowHide=()->
    $scope.IsVisible = true
    
  $scope.save =()->
    $scope.newDepartment.deleted='0'
    $scope.newDepartment.isActive='1'
    $scope.departments.save $scope.newDepartment
    $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
    $scope.newDepartment = undefined
    $scope.IsVisible = false
      
  $scope.remove = (dep) ->
    Meteor.call('update2',dep)
    $mdToast.show($mdToast.simple().content('Data removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
