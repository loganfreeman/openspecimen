
angular.module('os.biospecimen.specimen.overview', ['os.biospecimen.models'])
  .controller('SpecimenOverviewCtrl', function($scope, $rootScope, hasDict, specimen, ExtensionsUtil) {
    function init() {
      var spmnToDisp = null;
      if (hasDict) {
        spmnToDisp = angular.copy(specimen);
        ExtensionsUtil.createExtensionFieldMap(spmnToDisp);
        delete spmnToDisp.children;
      }

      $scope.spmnCtx = {
        obj: {specimen: spmnToDisp},
        inObjs: ['specimen'],
        exObjs: ['specimen.events', 'specimen.collectionEvent', 'specimen.receivedEvent']
      }

      loadActivities();

      $scope.$watch('specimen.activityStatus', function(newVal, oldVal) {
        if (newVal == oldVal) {
          return;
        }

        if (newVal == 'Closed') {
          loadActivities();
        }
      });
    }

    function loadActivities() {
      $scope.activities = [];
      specimen.getEvents(
        function(activities) {
          $scope.activities = activities.map(
            function(activity) {
              return angular.extend({global: $rootScope.global}, activity);
            }
          );
        }
      );
    };

    init();
  });
