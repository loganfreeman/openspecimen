
angular.module('os.biospecimen.extensions.addedit-record', [])
  .controller('FormRecordAddEditCtrl', function($scope, $state, $stateParams, formDef, Alerts) {
    var recId = $stateParams.recordId;
    if (!!recId) {
      recId = parseInt(recId);
    }

    $scope.formOpts = {
      formId: $stateParams.formId,
      formDef: formDef,
      recordId: recId,
      formCtxtId: parseInt($stateParams.formCtxId),
      objectId: $scope.object.id,

      onSave: function() {
        $state.go($scope.extnState + 'records', 
          {formId: $stateParams.formId, formCtxId: $stateParams.formCtxId});
        Alerts.success("extensions.record_saved");
      },

      onError: function() {
        alert("Error");
      },

      onCancel: function() {
        $scope.back();
      },

      onPrint: function(html) {
        alert(html);
      },

      onDelete: function() {
        alert("delete invoked");
      }
    };
  });