angular.module 'etimesheetApp'
.controller 'empListCtrl', ($scope, $meteor, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 10
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
    $mdToast.show($mdToast.simple().content('Data removed Sucessfully'))
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage

  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name_sort: parseInt($scope.orderProperty)