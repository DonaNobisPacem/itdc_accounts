# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change', '#uid', (evt) ->
    $('#accounts_dropdown').css 'display', 'block'
    $.ajax '/reports/accd_get_accounts',
      type: 'GET'
      dataType: 'script'
      data: {
        user_id: $("#uid option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic user select OK!")