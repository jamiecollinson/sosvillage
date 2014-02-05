# create canvas element on page
# TODO - should we just have it in the html?
canvas = document.createElement 'canvas'
document.body.appendChild canvas

canvas.width = 1366/1.5
canvas.height = 768/1.5

renderer = PIXI.autoDetectRenderer canvas.width, canvas.height, canvas

stage = new PIXI.Stage

mapTexture = PIXI.Texture.fromImage 'assets/img/map.jpg'
map = new PIXI.Sprite mapTexture
map.width = canvas.width
map.height = canvas.height
stage.addChild map

cloudsTexture = PIXI.Texture.fromImage 'assets/img/tileable-cloud-patterns-2.png'
clouds = new PIXI.TilingSprite cloudsTexture, canvas.width, canvas.height
clouds.alpha = 1
stage.addChild clouds

update = ->
  clouds.tilePosition.x -= 0.32
  renderer.render stage
  requestAnimFrame update
  
do update