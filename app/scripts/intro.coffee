$(document).ready ->

  $intro = $('#intro')
  $main = $('#main')

  $center_col = $('#center_col')
  $photo = $('#photo')
  
  $panel1 = $('#panel1')
  $panel2 = $('#panel2')
  $firstname = $('#firstname')
  $lastname = $('#lastname')
  $line = $('.line')

  $header = $('#gn-menu')
  $header.css
    height: 0


  $mainX = $(window).width()
  $mainY = $(window).height()
  $main.css
    height: $mainY

  $intro.css
    width: $mainX
    height: $mainY

  $centerx = $mainX/2
  $centery = $mainY/2

  $panel1.css
    height: $centery
    width: '200%'
    marginLeft: '-50%'
    paddingLeft: '50%'
    marginTop: -$centery
    paddingTop: $centery

  $panel2.css
    height: $mainY
    width: '200%'
    marginLeft: '-50%'
    paddingLeft: '50%'
    top: $centery

  $firstname.css
    marginTop: $centery + 20
    marginLeft: $centerx - 120
  $lastname.css
    marginLeft: $centerx - 150

  app.intro = ->

    ia = new TimelineMax(delay:0.5)
    ia.to $line, 1,
      delay: 0.5
      width: '100%'
      ease: "Quint.easeOut"

    ia.to $firstname, 0.5,
      marginTop: '-=50'
      opacity: 1
      ease: "Quint.easeOut"

    ia.to $lastname, 0.5,
      marginTop: '+=20'
      opacity: 1
      ease: "Quint.easeOut"

    ia.to $intro, 0.5,
      rotation: -45
      transformOrigin: '50% 50%'
      ease: "Quint.easeOut"

    ia.to $lastname, 1,
      marginLeft:'-=1000'
      ease: "Quint.easeIn"

    ia.to $firstname, 1,
      marginLeft:'+=1000'
      ease: "Quint.easeIn"
    ,'-=1'


    ia.call ->
      $line.css
        display: 'none'

    ia.to $panel1, 0.5,
      height:0
      paddingTop:0
      ease: "Quint.easeOut"

    ia.to $panel2, 0.5,
      top: $mainY*2
      ease: "Quint.easeOut"
    , '-=0.5'


    ia.call ->
      app.intiContent()
      $center_col.css
        height: $('#profile').height()

    ia.to $header, 0.5,
      height: 60
      ease: "Quint.easeOut"

    ia.from $center_col, 0.5,
      width: '0%'
      ease: "Quint.easeOut"


    ia.from $photo, .5,
      scale: 0

    ia.from $('.ipad'), .3,
      marginLeft:'-400px'
      opacity:0
      delay:0.5

    ia.from $('.notebook'), .3,
      marginLeft:'-400px'
      opacity:0

    ia.from $('.iphone'), .3,
      marginLeft:'-400px'
      opacity:0


    ia.staggerFrom($('.paper h2, .paper p'), 1,
      marginLeft:"-2000"
      alpha:0
      ease: "Quint.easeOut"
    , 0.2)

