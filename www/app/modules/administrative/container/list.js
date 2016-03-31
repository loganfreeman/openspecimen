angular.module('os.administrative.container.list', ['os.administrative.models'])
  .controller('ContainerListCtrl', function($scope, $stateParams, $state, Container, Site, Util) {

    function init() {
      $scope.containerFilterOpts = {};
      $scope.mode = !!$stateParams.typeName;
      loadContainers();
      loadSites();
      Util.filter($scope, 'containerFilterOpts', loadContainers);
    }

    function loadContainers(filterOpts) {
      var filterOpts = filterOpts ? filterOpts : {};
      if ($stateParams.typeName) {
        var typeName, topLevelContainers;
        filterOpts.typeName = $stateParams.typeName;
        filterOpts.topLevelContainers = false;
      }

      Container.list(filterOpts).then(
        function(containers) {
          $scope.containerList = containers;
        }
      );
    }

    function loadSites() {
      $scope.sites = [];
      Site.listForContainers().then(function(sites) {
        $scope.sites = sites;
      });
    }

    $scope.showContainerOverview = function(container) {
      $state.go('container-detail.overview', {containerId: container.id});
    };

    init();
  });
