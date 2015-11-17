angular.module 'etimesheetApp'
.controller 'empListCtrl', ($scope, $stateParams, $meteor, $state, $mdToast) ->
  $scope.page = 1
  $scope.perPage = 5
  $scope.sort = name : 1
  $scope.orderProperty = '1'

  $scope.employees = $scope.$meteorCollection () ->
    Employees.find {'deleted':'0'}, {sort:$scope.getReactively('sort')}
  $meteor.autorun $scope, () ->
    $scope.$meteorSubscribe('employees', {
      limit: parseInt($scope.getReactively('perPage'))
      skip: parseInt(($scope.getReactively('page') - 1) * $scope.getReactively('perPage'))
      sort: $scope.getReactively('sort')
    }, $scope.getReactively('search')).then () ->
      $scope.employeesCount = $scope.$meteorObject Counts, 'numberOfEmployees', false

  $meteor.session 'employeesCounter'
  .bind $scope, 'page'

 
    
  $scope.remove = (userId,useradd) ->
    console.log(userId)
    console.log(useradd)
    Meteor.call('remove', useradd)
    Meteor.call('update',userId)
    $mdToast.show($mdToast.simple().content('user removed Sucessfully'))
    
    
      
    
  $scope.pageChanged = (newPage) ->
    $scope.page = newPage

  $scope.$watch 'orderProperty', () ->
    if $scope.orderProperty
      $scope.sort = name: parseInt($scope.orderProperty)