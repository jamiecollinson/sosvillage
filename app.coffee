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

# MARKERS
markers = [
  {name: 'Gate', x: 500, y: 600}
  {name: 'Sports field', x: 700, y: 275}
  {name: 'Administration', x: 575, y: 525}
  {name: 'Bornehave', x: 450, y: 500}
  {name: 'FSP Office', x: 525, y: 400}
  {name: 'SOS Hjem', x: 625, y: 475}
  {name: 'Ungdomshus', x: 700, y: 400}
]
markerTexture = PIXI.Texture.fromImage 'assets/img/sos-marker-large.png'
for marker in markers
  marker.marker = new PIXI.Sprite markerTexture
  marker.marker.anchor.x = 0.5
  marker.marker.anchor.y = 1
  marker.marker.position.x = marker.x * scale
  marker.marker.position.y = marker.y * scale
  map.addChild marker.marker
  marker.marker.interactive = true
  marker.marker.mouseover = (e) ->
    e.target.alpha = 0.2
  marker.marker.mouseout = (e) ->
    e.target.alpha = 1
  marker.marker.click = (e) ->
    alert 'marker clicked'

# CLOUDS
cloudsTexture = PIXI.Texture.fromImage 'assets/img/tileable-cloud-patterns-2.png'
clouds = new PIXI.TilingSprite cloudsTexture, canvas.width, canvas.height
clouds.alpha = 1
stage.addChild clouds

###
graphics = new PIXI.Graphics
graphics.interactive = true
graphics.beginFill(0x00FF00)
graphics.drawRect(0, 0, 300, 200)
graphics.hitArea = new PIXI.Rectangle(0, 0, 300, 200);
graphics.mouseover = (mouseData) ->
  console.log 'mouseover'
stage.addChild graphics
###

update = ->
  clouds.tilePosition.x -= 0.32
  renderer.render stage
  requestAnimFrame update
  
do update