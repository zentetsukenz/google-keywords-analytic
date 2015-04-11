'use strict';

var app = angular.module('keywordAnalyticApp', ['angularFileUpload']);

app.config(["$httpProvider", function ($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

app.controller('UploadCtrl', ['$scope', '$upload', '$log', function ($scope, $upload, $log) {

  $scope.reports = [];
  $scope.file = null;

  $scope.statusMaster = {
    idle: 'Idle',
    uploading: 'Uploading',
    build: 'Building report',
    done: 'Done',
    error: 'Error'
  };

  $scope.progress = {
    isUploading: false,
    uploadProgress: 0,
    status: $scope.statusMaster.idle
  };

  $scope.fileChange = function (files, event) {
    $scope.progress.isUploading = false;
  };

  $scope.upload = function (file) {
    $scope.progress.isUploading = true;
    $scope.progress.status = $scope.statusMaster.uploading;
    $scope.progress.uploadProgress = 0;

    $upload.upload({
      url: '/keyword_data_collect',
      file: file
    })
    .progress(function (evt) {
      $scope.progress.uploadProgress = parseInt(100.0 * evt.loaded / evt.total);

      if ($scope.progress.uploadProgress >= 100) {
        $scope.progress.status = $scope.statusMaster.build;
      }
    })
    .success(function (resp) {
      var newReport = resp.report
      newReport.isNew = true;

      if ($scope.reports.length > 0) {
        $scope.reports[$scope.reports.length - 1].isNew = false;
      }

      $scope.reports.push(newReport);
      $scope.progress.status = $scope.statusMaster.done;
    })
    .error(function (err) {
      $scope.progress.status = $scope.statusMaster.error;
      $log.error(err);
    });
  };
}]);