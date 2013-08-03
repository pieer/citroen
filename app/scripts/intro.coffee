$(document).ready ->
  doIntro = true


  $intro = $('#intro')
  $main = $('#main')
  
  $panel1 = $('#panel1')
  $panel2 = $('#panel2')
  $firstname = $('#firstname')
  $lastname = $('#lastname')
  $line = $('.line')



  $header = $('#header')
  $center_col = $('#center_col')
  $leftnav = $('#leftnav')
  $current = $('.wrapper:first-child')
  $next = {}
  $current.css
    left:'-800px'

  $photo = $('#photo')


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
    marginLeft: $centerx - 50
  $lastname.css
    marginLeft: $centerx - 80

  intro = ->

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
      marginLeft:'+=1000'
      ease: "Quint.easeIn"

    ia.to $firstname, 1,
      marginLeft:'-=1000'
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
      $intro.css
        display:'none'

      $('#content').css
        display:'block'

    ia.call ->
      intiContent()

    ia.to $header, 0.5,
      height: 80
      ease: "Quint.easeOut"

    ia.to $leftnav, 0.2,
      width: '20%'
      ease: "Quint.easeOut"

    ia.call ->
      $center_col.css
        width: '80%'

    ia.to $current, 0.2,
      left:'20%'
    , '-=.2'


    ia.from $photo, .5,
      scale: 0


  intiContent = ->
    $("body").attr "id", "js"
    current = "#profile"


    
    #var subcurrent = "#studyCase";
    # var subcurrent2 = "#officeWork";
    size = $(document).width() + "px"
    $("#leftnav a").click (e) ->
      e.preventDefault()
      $("#leftnav a.active").removeClass "active"
      $(this).addClass "active"
      $next = $($(this).attr("href"))
      unless $next is $current
        animContent()

    ###
    $(".aw").each (index) ->
      elem = $(this)
      subcurrent = "#" + elem.find(".subwrapper:first").attr("id")
      console.log subcurrent
      elem.find(".linklist a").click (e) ->
        elem.find(".linklist a.active").removeClass "active"
        $(this).addClass "active"
        e.preventDefault()
        ref = $(this).attr("href")
        unless ref is subcurrent
          animContent()
    ###

  animContent = ->
    ca = new TimelineMax()
    ca.to $current, 0.5,
      left: "-100%"
    ca.to $next, 0.5,
      left: "20%"



    $current = $next

      
  if doIntro
    intro()
  else
    $intro.css
      display:'none'
 

  #photo
  
  $photo.hover ->
    TweenMax.to $photo, 0.2,
      borderRadius:"0%"
  , ->
    TweenMax.to $photo, 0.2,
      borderRadius:"50%"