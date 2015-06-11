# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#countbyclass-container').highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title: text: 'Count of monsters by class'
    tooltip: pointFormat: '{series.name}: <b>{point.y}</b> monsters'
    plotOptions: pie:
      allowPointSelect: true
      cursor: 'pointer'
      dataLabels:
        enabled: true
        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
        style: color: Highcharts.theme and Highcharts.theme.contrastTextColor or 'black'
    series: [ {
      point: events: click: ->
        location.href = @url
        e.preventDefault()
        return
      type: 'pie'
      name: 'Number of monsters'
      data: countbyclassdata
    } ]

  $('#countbydate-container').highcharts
    chart:
      plotBackgroundColor: null
      plotBorderWidth: null
      plotShadow: false
    title: text: 'Monsters over time'
    tooltip: pointFormat: '{series.name}: <b>{point.y}</b> monsters'
    xAxis:
      title: text: 'Date'
      type: 'datetime'
      startOnTick: true
      endOnTick: true
    yAxis:
      title: text: 'Count'
      min: 0
    series: [ {
      point: events: click: ->
        location.href = @url
        e.preventDefault()
        return
      type: 'spline'
      name: 'Created'
      data: countbycreateddate
    },
    {
      point: events: click: ->
        location.href = @url
        e.preventDefault()
        return
      type: 'spline'
      name: 'Modified'
      data: countbyupdateddate
    }]
  return

$(document).ready(ready)
