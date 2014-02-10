# TODO - create canvas element on page, should we just have it in the html?
canvas = document.createElement 'canvas'
document.body.appendChild canvas

scale = 1

canvas.width = 1366 * scale
canvas.height = 768 * scale

renderer = PIXI.autoDetectRenderer canvas.width, canvas.height, canvas

stage = new PIXI.Stage

# MAP
mapTexture = PIXI.Texture.fromImage 'assets/img/map.jpg'
map = new PIXI.Sprite mapTexture
map.width = canvas.width
map.height = canvas.height
stage.addChild map

# CLOUDS
cloudsTexture = PIXI.Texture.fromImage 'assets/img/tileable-cloud-patterns-2.png'
clouds = new PIXI.TilingSprite cloudsTexture, canvas.width, canvas.height
clouds.alpha = 1
stage.addChild clouds

# MARKERS
markerData = [
  {name: 'Gate', x: 520, y: 600}
  {name: 'Sports field', x: 700, y: 275}
  {name: 'Office', x: 575, y: 535}
  {name: 'Nursery School', x: 450, y: 500}
  {name: 'FSP Office', x: 525, y: 390}
  {name: 'SOS Home', x: 610, y: 450}
  {name: 'Youth Home', x: 710, y: 390}
]
markerTexture = PIXI.Texture.fromImage 'assets/img/sos-marker-large.png'
markers = []
for element in markerData
  marker = new PIXI.Sprite markerTexture
  marker.anchor.x = 0.5
  marker.anchor.y = 1
  marker.position.x = element.x * scale
  marker.position.y = element.y * scale
  marker.name = element.name
  marker.interactive = true
  
  marker.mouseover = (e) ->
    for marker in markers
      marker.alpha = 0.6
    e.target.alpha = 1

  marker.mouseout = (e) ->
    for marker in markers
      marker.alpha = 1
  
  marker.click = (e) ->
    alert e.target.name
  
  text = new PIXI.Text ''
  text.setText element.name
  text.setStyle {fill: 'white', font: '16px Helvetica'}
  text.anchor.x = 0.5
  marker.addChild text
  
  map.addChild marker
  markers.push marker

update = ->
  clouds.tilePosition.x -= 0.32
  renderer.render stage
  requestAnimFrame update
  
do update