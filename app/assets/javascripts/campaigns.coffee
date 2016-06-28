# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@setSelectedCampaign = (source) ->
  req = $.ajax({url: "/set_selected_campaign", type: "GET", data: { campaign_id: source.options[source.selectedIndex].value }, cache: false })
      .done((html)->
        window.location.reload false
        return
      )
  return
