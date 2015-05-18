'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngAria',
  'ngMaterial',
  'ngRoute',
  'myApp.view1',
  'myApp.view2',
  'myApp.version'
])

.config(function($mdIconProvider) {
  $mdIconProvider
    .iconSet('action', 'assets/iconsets/action-icons.svg', 24)
    .iconSet('alert', 'assets/iconsets/alert-icons.svg', 24)
    .iconSet('av', 'assets/iconsets/av-icons.svg', 24)
    .iconSet('communication', 'assets/iconsets/communication-icons.svg', 24)
    .iconSet('content', 'assets/iconsets/content-icons.svg', 24)
    .iconSet('device', 'assets/iconsets/device-icons.svg', 24)
    .iconSet('editor', 'assets/iconsets/editor-icons.svg', 24)
    .iconSet('file', 'assets/iconsets/file-icons.svg', 24)
    .iconSet('hardware', 'assets/iconsets/hardware-icons.svg', 24)
    .iconSet('icons', 'assets/iconsets/icons-icons.svg', 24)
    .iconSet('image', 'assets/iconsets/image-icons.svg', 24)
    .iconSet('maps', 'assets/iconsets/maps-icons.svg', 24)
    .iconSet('navigation', 'assets/iconsets/navigation-icons.svg', 24)
    .iconSet('notification', 'assets/iconsets/notification-icons.svg', 24)
    .iconSet('social', 'assets/iconsets/social-icons.svg', 24)
    .iconSet('toggle', 'assets/iconsets/toggle-icons.svg', 24)
})

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.otherwise({redirectTo: '/view1'});
}])

.controller('AppCtrl', function ($scope, $timeout, $mdSidenav, $mdUtil, $log) {
  $scope.toggleLeft = buildToggler('left');
  $scope.toggleRight = buildToggler('right');
  /**
   * Build handler to open/close a SideNav; when animation finishes
   * report completion in console
   */
  function buildToggler(navID) {
    var debounceFn =  $mdUtil.debounce(function(){
          $mdSidenav(navID)
            .toggle()
            .then(function () {
              $log.debug("toggle " + navID + " is done");
            });
        },300);
    return debounceFn;
  }
})

.controller('LeftCtrl', function ($scope, $timeout, $mdSidenav, $log) {
  $scope.close = function () {
    $mdSidenav('left').close()
      .then(function () {
        $log.debug("close LEFT is done");
      });
  };
})

.controller('RightCtrl', function ($scope, $timeout, $mdSidenav, $log) {
  $scope.close = function () {
    $mdSidenav('right').close()
      .then(function () {
        $log.debug("close RIGHT is done");
      });
  };
});
