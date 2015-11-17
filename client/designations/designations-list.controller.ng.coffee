'use strict'

angular.module 'etimesheetApp'
.controller 'DesignationsListCtrl', ($scope, $meteor, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 7
  $scope.IsVisible=true
  $scope.sort = name : 1
  $scope.orderProperty = '1'
  
  
  $scope.designations = $scope.$meteorCollection () ->
    Designations.find {'deleted':'0'}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('designations', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.designationsCount = $scope.$meteorObject Counts, 'numberOfDesignations', false

  $meteor.session 'designationsCounter'
  .bind $scope, 'page'

  $scope.cancel=()->
    $scope.IsVisible = true
  $scope.ShowHide=()->
    $scope.IsVisible = false
    
  $scope.save = () ->
    console.log($scope.newDesignation.name)
    $scope.newDesignation.isActive="1"
    $scope.newDesignation.deleted="0"
    
    if $scope.form.$valid
      $scope.designations.save $scope.newDesignation
      $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
      $scope.newDesignation = undefined
    $scope.IsVisible = true
      
  $scope.remove = (des) ->
    Meteor.call('update1',des)
    $mdToast.show($mdToast.simple().content('Data removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
