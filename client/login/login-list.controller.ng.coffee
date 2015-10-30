'use strict'

angular.module 'etimesheetApp'
.controller 'LoginListCtrl', ($scope, $meteor) ->
  $scope.page = 1
  $scope.perPage = 3
  $scope.sort = name_sort : 1
  $scope.orderProperty = '1'
  
  $scope.login = $scope.$meteorCollection () ->
    Login.find {}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('login', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.loginCount = $scope.$meteorObject Counts, 'numberOfLogin', false

  $meteor.session 'loginCounter'
  .bind $scope, 'page'
    
  $scope.save = () ->
    if $scope.form.$valid
      $scope.login.save $scope.newLogin
      $scope.newLogin = undefined
      
  $scope.remove = (login) ->
    $scope.login.remove login
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage
    
  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)
