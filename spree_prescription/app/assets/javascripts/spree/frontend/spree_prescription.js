// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'
$(document).ready(function() {

  var PrescriptionFieldWidget = {
    elements: {
      lensTypeSelect: $('.lens-type'),
      scriptMethodSelect: $('#prescription-method'),
      scriptUploadInput: $('#prescription_upload'),
      scriptMethodGroup: $('#prescription-method-group'),
      scriptUploadGroup: $('#prescription-upload-group')
    },
    product: gon.product,
    OPTION_TYPE_PRESCRIPTION: 'prescription',
    OPTION_TYPE_NON_PRESCRIPTION: 'non-prescription',
    UPLOAD_NOW: 'I will upload it now',

    init: function() {
      // only continue init if a product has been supplied from the controller
      // or if this product does not accept prescription
      // or if we have the correct elements available
      if (this.product == undefined || !this.product.accepts_prescription) return
      if (this.elements.lensTypeSelect == undefined) return

      this.bindUIActions()
      this.handleLensType(this.elements.lensTypeSelect)
    },

    bindUIActions: function() {
      this.elements.lensTypeSelect.change(function() {
        PrescriptionFieldWidget.handleLensType(this)
      })

      this.elements.scriptMethodSelect.change(function() {
        PrescriptionFieldWidget.handleScriptMethod(this)
      })
    },

    // --------------
    // ui handlers
    // --------------

    handleLensType: function(selectEl) {
      // only continue if we are handling an options dropdown
      var id = $(selectEl).attr('id')
      if (!id.startsWith('options_')) return

      var selectedValueId = $(selectEl).val()
      var optionId = id.replace('options_', '')

      // pull out the optionValue object that corresponds with the option and the value selected from the dropdown
      var value = this.getOptionValue(optionId, selectedValueId)

      switch (value.name) {
        case this.OPTION_TYPE_PRESCRIPTION:
          this.elements.scriptMethodGroup.removeClass('hidden')
          this.elements.scriptMethodSelect.prop('disabled', false)
          this.handleScriptMethod(this.elements.scriptMethodSelect)
          break;
        case this.OPTION_TYPE_NON_PRESCRIPTION:
          this.elements.scriptMethodGroup.addClass('hidden')
          this.elements.scriptUploadGroup.addClass('hidden')
          this.elements.scriptMethodSelect.prop('disabled', true)
          this.elements.scriptUploadInput.prop('disabled', true)
          break;
        default:
          console.log('invalid option type - unable to toggle prescription fields')
      }
    },

    handleScriptMethod: function(selectEl) {
      var method = $(selectEl).find('option:selected').text()

      switch (method) {
        case this.UPLOAD_NOW:
          this.elements.scriptUploadGroup.removeClass('hidden')
          this.elements.scriptUploadInput.prop('disabled', false)
          break;
        default:
          this.elements.scriptUploadGroup.addClass('hidden')
          this.elements.scriptUploadInput.prop('disabled', true)
      }
    },

    // --------------
    // helper handlers
    // --------------

    getOptionValue: function(optionId, valueId) {
      var option = this.product.option_types.find(function(optionType) {
        return optionType.id == optionId
      })

      return option.option_values.find(function(optionValue) {
        return optionValue.id == valueId
      })
    },
  }

  PrescriptionFieldWidget.init()
})
