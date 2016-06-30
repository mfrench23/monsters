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

# for links that implicitly change the selected campaign
$(document).on 'click', 'a[data-reset_campaign_id]', (e) ->
  campaign_id = $(e.currentTarget).data().reset_campaign_id
  document.cookie = "selected_campaign=" + campaign_id + "; path=/"
  return
