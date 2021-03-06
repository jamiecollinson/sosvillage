TWEEN = require 'tween'
Boids = require 'boids'

renderer = new PIXI.autoDetectRenderer 1366, 768
document.body.appendChild renderer.view

markerData = [
  {name: 'Gate', x: 520, y: 600}
  {name: 'Sports field', x: 700, y: 275}
  {name: 'Office', x: 575, y: 535}
  {name: 'Nursery School', x: 450, y: 500}
  {name: 'FSP Office', x: 525, y: 390}
  {name: 'SOS Home', x: 610, y: 450}
  {name: 'Youth Home', x: 710, y: 390}
]

assets = {
  mapImg: 'assets/img/map.jpg'
  cloudImg: 'assets/img/tileable-cloud-patterns-2.png'
  markerImg: 'assets/img/sos-marker-large.png'
  birdImg: 'http://upload.wikimedia.org/wikipedia/en/1/1c/Up_Arrow_Icon.png'
}
assetArray = (value for key, value of assets)

stage = null
map = null
clouds = null
markers = null
flock = new Boids
  boids: 50                 # The amount of boids to use
  speedLimit: 0.5           # Max steps to take per tick
  accelerationLimit: 0.01   # Max acceleration per tick
  attractors: [ [1366/2, 768/2, Infinity, 0.01] ]

loader = new PIXI.AssetLoader assetArray
loader.addEventListener 'onComplete', () -> do setup
do loader.load
  
setup = () ->
  stage = new PIXI.Stage

  map = PIXI.Sprite.fromImage assets.mapImg
  stage.addChild map
  
  boidsContainer = new PIXI.SpriteBatch
  stage.addChild boidsContainer
  for boid in flock.boids
    # boid is an array with 6 elements
    boid[0] += 1366/2 - 500 + Math.random()*1000
    boid[1] += 768/2 - 500 + Math.random()*1000
    boidSprite = PIXI.Sprite.fromImage assets.birdImg
    [ boidSprite.width, boidSprite.height ] = [ 12, 12 ]
    boid.push boidSprite
    boidsContainer.addChild boidSprite
  
  cloudsTexture = PIXI.Texture.fromImage assets.cloudImg
  clouds = new PIXI.TilingSprite cloudsTexture, 1366, 768
  stage.addChild clouds

  markerTexture = PIXI.Texture.fromImage assets.markerImg
  markers = []
  for element in markerData
    marker = new PIXI.Sprite markerTexture
    marker.anchor.x = 0.5
    marker.anchor.y = 1
    marker.x = element.x
    marker.y = element.y
    markerIntroTween marker
    marker.name = element.name
    marker.interactive = true
    marker.buttonMode = true
    
    text = new PIXI.Text marker.name
    text.setStyle
      font: '24px Helvetica'
      fill: '#FFFFFF'
    text.anchor.x = 0.5
    marker.addChild text
    
    marker.click = (e) ->
      alert e.target.name
      
    markers.push marker
    stage.addChild marker

  do update
  
update = ->
  clouds.tilePosition.x -= 0.32
  do TWEEN.update
  [ flock.attractors[0][0], flock.attractors[0][1] ] = [ stage.getMousePosition().x, stage.getMousePosition().y ]
  do flock.tick
  for boid in flock.boids
    boidSprite = boid[6]
    boidSprite.x = boid[0]
    boidSprite.y = boid[1]
    boidSprite.rotation = Math.PI/2 + Math.atan2( boid[3], boid[2] )
  renderer.render stage
  requestAnimFrame update
  
markerIntroTween = (marker) ->
  marker.position.y -= 200
  new TWEEN.Tween { y: marker.y }
    .to { y: marker.y + 200 }, 1000
    .delay Math.random()*200
    .easing TWEEN.Easing.Bounce.Out
    .onUpdate () ->
      marker.y = @y
    .start()