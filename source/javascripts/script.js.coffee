#= require jquery/dist/jquery.min.js
#= require trianglify/trianglify.min.js

$ ->
  option =
    cellsize: 120
  t = new Trianglify option
  $blogHead = $('.blog-head')
  pattern = t.generate $blogHead.width(), $blogHead.height()
  $blogHead.css
    'background-image': pattern.dataUrl
