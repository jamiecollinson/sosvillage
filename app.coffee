# create canvas element on page
# TODO - should we just have it in the html?
canvas = document.createElement 'canvas'
document.body.appendChild canvas

canvas.width = window.innerWidth
canvas.height = window.innerHeight

renderer = PIXI.autoDetectRenderer canvas.width, canvas.height, canvas

stage = new PIXI.Stage

mapTexture = PIXI.Texture.fromImage 'assets/img/map.jpg'
map = new PIXI.Sprite mapTexture
stage.addChild map

cloudsTexture = PIXI.Texture.fromImage 'assets/img/clouds.png'
clouds = new PIXI.TilingSprite cloudsTexture, canvas.width, canvas.height
stage.addChild clouds

update = ->
  clouds.tilePosition.x -= 0.64
  renderer.render stage
  requestAnimFrame update
  
do update