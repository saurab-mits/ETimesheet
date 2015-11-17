'use strict'

angular.module 'etimesheetApp'
.controller 'OrganizationsListCtrl', ($scope, $meteor, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.IsVisible=false
  $scope.sort = name : 1
  $scope.orderProperty = '1'
  
  $scope.organizations = $scope.$meteorCollection () ->
    Organizations.find {}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('organizations', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.organizationsCount = $scope.$meteorObject Counts, 'numberOfOrganizations', false

  $meteor.session 'organizationsCounter'
  .bind $scope, 'page'
  
  $scope.cancel=()->
    $scope.IsVisible = false

  $scope.ShowHide=()->
    $scope.IsVisible = true
    
  $scope.save = ()->
    $scope.organizations.save $scope.newOrganization
    $scope.newOrganization = undefined
    $mdToast.show($mdToast.simple().content('Data Saved Sucessfully'))
    $scope.IsVisible = false
      
  $scope.remove = (organization) ->
    $scope.organizations.remove organization
    $mdToast.show($mdToast.simple().content('Data Removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)
