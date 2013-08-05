$(document).ready ->
  doIntro = true


  $intro = $('#intro')
  $main = $('#main')
  
  $panel1 = $('#panel1')
  $panel2 = $('#panel2')
  $firstname = $('#firstname')
  $lastname = $('#lastname')
  $line = $('.line')



  $header = $('#gn-menu')
  $center_col = $('#center_col')
  
  $current = $('.wrapper:first-child')
  $next = $current
  $center_col.css
    width: 0

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
      intiContent()

    ia.to $header, 0.5,
      height: 60
      ease: "Quint.easeOut"

    ia.call ->
      $center_col.css
        width: '100%'

    ia.to $current, 0.2,
      marginLeft: 0
    , '-=.2'


    ia.from $photo, .5,
      scale: 0


  intiContent = ->
    new gnMenu( document.getElementById( 'gn-menu' ) )
    $intro.remove()

    $('#content').show()
    $main.css
      height: 'auto'
    animContent()

    $('.mainWrapper').css
      minHeight: $mainY
    
    #var subcurrent = "#studyCase";
    # var subcurrent2 = "#officeWork";
    size = $(document).width() + "px"
    $("#leftnav a").click (e) ->
      e.preventDefault()
      $("#leftnav a.active").removeClass "active"
      $(this).addClass "active"
      href = $(this).attr("href")
      $next = $(href)
      unless $next is $current
        animContent(href)


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

    $('#pcontainer').isotope
      itemSelector : '.item'


  animContent = (href)->
    ca = new TimelineMax()

    ca.to $center_col, 0.5,
      height:'0'
    ca.call ->
      $current.css
        display: 'none'
      $center_col.css
        height: 'auto'
        width: 0
      $next.css
        display: 'block'
    ca.to $center_col, 0.5,
      width:'100%'
    ca.call ->
      $current = $next
      if(href = "#portfolio")
        $('#pcontainer').isotope( 'reLayout' )
        initCarrou()

      
  if doIntro
    intro()
  else
    $intro.remove()
 

  #photo
  $photo.hover ->
    TweenMax.to $photo, 0.2,
      borderRadius:"0%"
  , ->
    TweenMax.to $photo, 0.2,
      borderRadius:"50%"


  $pcontainer = $('#pcontainer')

  for key, website of app.data
    $item = $('<div>')
              .addClass('item ')
    $itemWrapper = $('<div>')
              .addClass('itemWrapper')
              .attr 'nbItem', website.thumb.length
    for image in website.thumb
      $itemImage = $('<div>')
                .addClass('itemImage ')
                .css
                  background: "url(../images/large/#{image}.jpg) no-repeat center center"
                  float: 'left'
      $itemWrapper.append $itemImage
    
    $item.append $itemWrapper
    $pcontainer.append $item

  itemWrapperh = $('.item').innerWidth()

  #itemTodisplay = -1
  initCarrou = ->
    itemWrapper = $('.itemWrapper')
    requestInterval ->
      ###
      if itemTodisplay < itemWrapper.length
        itemTodisplay+=1
      else
        itemTodisplay = -1
      ###
      itemTodisplay = Math.floor((Math.random()*itemWrapper.length)+1)
      changeItem $(itemWrapper.get(itemTodisplay))
      
    , 5000
      
  changeItem = ($element) ->
    if $element.css('marginLeft') isnt -(($element.attr('nbItem')-1)*itemWrapperh)+'px'
      TweenMax.to $element, 0.2,
        marginLeft: '-='+itemWrapperh
    else
      TweenMax.to $element, 2,
        marginLeft: 0