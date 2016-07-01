$(window).load ->
  @loadInitialEquipmentPieceModifiers(fnd) for fnd in $( "div[name='ajax-modifiers-for-equipment-piece']" )
  return
