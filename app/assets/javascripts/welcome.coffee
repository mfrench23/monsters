# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

make_series = (nameval, dataval) ->
  {
    point: events: click: ->
      location.href = @url
      e.preventDefault()
      return
    type: 'line'
    name: nameval
    data: dataval
  }




ready = ->
  if $('#countbyclass-container').length > 0
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

  if $('#countbydate-container').length > 0
    seriesdata = []
    for single_series in raw_series
      sdata = make_series( single_series['key'], single_series['val'] )
      seriesdata.push( sdata )

    $('#countbydate-container').highcharts
      chart:
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false
      title: text: 'Entities over time'
      tooltip: pointFormat: '{series.name}: <b>{point.y}</b>'
      xAxis:
        title: text: 'Date'
        type: 'datetime'
        startOnTick: true
        endOnTick: true
        tickInterval: 24 * 3600 * 1000 * 30 # 30 days
      yAxis:
        title: text: 'Count'
        min: 1
        max: 1000
        type: 'logarithmic'
        minorTickInterval: 1
      series: seriesdata
  return

$(document).ready(ready)
