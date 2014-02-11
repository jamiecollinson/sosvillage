game = new Phaser.Game(1366, 768, Phaser.AUTO)

mainState = new Phaser.State
game.state.add 'mainState', mainState, true

mainState.preload = () -> 
  game.load.image('map', 'assets/img/map.jpg')
  game.load.image('clouds', 'assets/img/tileable-cloud-patterns-2.png')
  game.load.image('marker', 'assets/img/sos-marker-large.png')

mainState.create = () ->
  # MAP
  @map = game.add.sprite(0, 0, 'map')
  # CLOUDS
  @clouds = game.add.tileSprite(0, 0, 1366, 768, 'clouds')
  # MARKERS
  @markerData = [
    {name: 'Gate', x: 520, y: 600}
    {name: 'Sports field', x: 700, y: 275}
    {name: 'Office', x: 575, y: 535}
    {name: 'Nursery School', x: 450, y: 500}
    {name: 'FSP Office', x: 525, y: 390}
    {name: 'SOS Home', x: 610, y: 450}
    {name: 'Youth Home', x: 710, y: 390}
  ]
  @markers = []
  for a in @markerData
    marker = game.add.sprite(a.x, a.y-300, 'marker')
    game.add.tween(marker).to( { y: a.y }, 1000, Phaser.Easing.Bounce.Out, true, Math.random()*100 )
    marker.name = a.name
    marker.anchor = x:0.5, y:1
    marker.inputEnabled = true
    marker.input.useHandCursor = true
    marker.events.onInputDown.add(markerClick, @)
    @markers.push(marker)
  
mainState.update = () ->
  @clouds.tilePosition.x -= 0.3
  
markerClick = (marker) ->
  alert marker.name