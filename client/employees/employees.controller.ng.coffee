angular.module 'etimesheet'
.controller 'empListCtrl', ($scope, $meteor) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name : 1
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

 
    
  $scope.remove = (user) ->
    Meteor.call('remove',user)
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage

  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)