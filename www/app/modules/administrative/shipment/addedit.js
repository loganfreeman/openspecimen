
angular.module('os.administrative.shipment.addedit', ['os.administrative.models', 'os.biospecimen.models'])
  .controller('ShipmentAddEditCtrl', function(
    $scope, $state, shipment, spmnRequest, cp, Shipment,
    Institute, Site, Specimen, SpecimensHolder, Alerts) {

    function init() {
      $scope.shipment = shipment;

      shipment.request = spmnRequest;
      if (!!spmnRequest) {
        shipment.receivingInstitute = spmnRequest.requestorInstitute;
      }

      $scope.shipment.shipmentItems = shipment.shipmentItems || [];
      $scope.input = {labelText: '', allSelected: false, allItemStatus: false};

      if (!!spmnRequest) {
        shipment.shipmentItems = getShipmentItemsFromReq(spmnRequest.items, shipment.shipmentItems);
      } else if (!shipment.id && angular.isArray(SpecimensHolder.getSpecimens())) {
        shipment.shipmentItems = getShipmentItems(SpecimensHolder.getSpecimens());
        SpecimensHolder.setSpecimens(null);
      }
      
      if (!shipment.shippedDate) {
        shipment.shippedDate = new Date();
      }

      loadInstitutes();
      loadSendingSites();
      setUserAndSiteList(shipment);
    }
    
    function loadInstitutes () {
      if (!!spmnRequest) {
        return;
      }

      Institute.query().then(
        function (institutes) {
          $scope.instituteNames = Institute.getNames(institutes);
        }
      );
    }

    function loadSites(instituteName) {
      Site.listForInstitute(instituteName, true).then(
        function(sites) {
          $scope.sites = sites;
          if (!spmnRequest) {
            return;
          }

          $scope.sites = cp.cpSites.map(
            function(cpSite) {
              return cpSite.siteName;
            }
          ).filter(
            function(site) {
              return sites.indexOf(site) != -1;
            }
          );
        }
      );
    }
    
    function loadSendingSites() {
      if (!spmnRequest) {
        Site.list().then(
          function(sites) {
            $scope.sendingSites = sites;
          }
        );
      } else {
        $scope.sendingSites = cp.cpSites.map(
          function(cpSite) {
            return cpSite.siteName;
          }
        );
      }
    }

    function setUserFilterOpts(institute) {
      $scope.userFilterOpts = {institute: institute};
    }

    function setUserAndSiteList(shipment) {
      var instituteName = shipment.receivingInstitute;
      if (instituteName) {
        setUserFilterOpts(instituteName);
        loadSites(instituteName);
      }
    }

    function getShipmentItems(specimens) {
      return specimens.filter(
        function(specimen) {
          return specimen.available && specimen.availableQty > 0 && specimen.activityStatus == 'Active';
        }).map(
        function(specimen) {
          return {
            specimen: specimen
          };
        });
    }

    function getShipmentItemsFromReq(reqItems, shipmentItems) {
      var shipmentItemsMap = {};
      angular.forEach(shipmentItems,
        function(shipmentItem) {
          shipmentItemsMap[shipmentItem.specimen.id] = shipmentItem;
        }
      );

      var items = [];
      angular.forEach(reqItems,
        function(reqItem) {
          var shipmentItem = shipmentItemsMap[reqItem.specimen.id];
          if (shipmentItem) {
            shipmentItem.specimen.selected = true;
          } else if (reqItem.status == 'PENDING') {
            shipmentItem = {
              specimen: reqItem.specimen,
            }

            reqItem.specimen.selected = reqItem.selected;
          }

          if (shipmentItem) {
            items.push(shipmentItem);
          }
        }
      );

      return items;
    }

    function saveOrUpdate(status) {
      var shipmentClone = angular.copy($scope.shipment);
      shipmentClone.status = status;

      if (!!spmnRequest) {
        var items = [];
        angular.forEach(shipmentClone.shipmentItems,
          function(item) {
            if (!item.specimen.selected) {
              return;
            }

            delete item.specimen.selected;
            items.push(item);
          }
        );

        shipmentClone.shipmentItems = items;
      }

      shipmentClone.$saveOrUpdate().then(
        function(savedShipment) {
          $state.go('shipment-detail.overview', {shipmentId: savedShipment.id});
        }
      );
    };

    $scope.onInstituteSelect = function(instituteName) {
      $scope.shipment.receivingSite = undefined;
      $scope.shipment.notifyUsers = [];

      loadSites(instituteName);
      setUserFilterOpts(instituteName);
    }

    $scope.onSiteSelect = function(siteName) {
      Site.getByName(siteName).then(
        function(site) {
          $scope.shipment.notifyUsers = site.coordinators;
        }
      );
    }

    $scope.addSpecimens = function() {
      var labels = 
        $scope.input.labelText.split(/,|\t|\n/)
          .map(function(label) { return label.trim(); })
          .filter(function(label) { return label.length != 0; });

      if (labels.length == 0) {
        return; 
      }

      angular.forEach($scope.shipment.shipmentItems, function(item) {
        var idx = labels.indexOf(item.specimen.label);
        if (idx != -1) {
          labels.splice(idx, 1);
        }
      });

      if (labels.length == 0) {
        return;
      }

      var param = {
        label: labels,
        sendSiteName: $scope.shipment.sendingSite,
        recvSiteName: $scope.shipment.receivingSite
      }

      Specimen.listForShipment(param).then(
        function (specimens) {
          angular.forEach(getShipmentItems(specimens), function(item) {
            $scope.shipment.shipmentItems.push(item);
          });
          $scope.input.labelText = '';
        }
      );
    }

    $scope.removeShipmentItem = function(shipmentItem) {
      var idx = shipment.shipmentItems.indexOf(shipmentItem);
      if (idx != -1) {
        shipment.shipmentItems.splice(idx, 1);
      }
    }

    $scope.ship = function() {
      saveOrUpdate('Shipped');
    }

    $scope.saveDraft = function() {
      saveOrUpdate('Pending');
    }

    $scope.toggleAllSpecimensSelect = function() {
      angular.forEach($scope.shipment.shipmentItems,
        function(item) {
          item.specimen.selected = $scope.input.allSelected;
        }
      );
    }

    $scope.toggleSpecimenSelect = function() {
      var allNotSelected = $scope.shipment.shipmentItems.some(
        function(item) {
          return !item.specimen.selected;
        }
      );

      $scope.input.allSelected = !allNotSelected;
    }

    init();
  });
