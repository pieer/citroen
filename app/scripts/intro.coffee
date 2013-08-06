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
  $header.css
    height: 0

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

    ia.to $center_col, 0.5,
      width: '100%'
      ease: "Quint.easeOut"

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

    $('.mainWrapper').css
      minHeight: $mainY

    $( '#cd-dropdown' ).dropdown()


    $('#pcontainer').isotope
      itemSelector : '.item'

    $('#dropdown-wrapper input').on 'change', ->
      filterby = $(this).val()

      $('#pcontainer').isotope({ filter: '.'+ filterby}).isotope('shuffle')

      $('.itemWrapper').each (index,element) ->
        ml = 0
        if(filterby is 'mobile')
          ml = -(($(element).attr('nbItem')-1)*itemWrapperW)+'px'
        $(element).css
          marginLeft: ml

    initCarrou()
    

  if doIntro
    intro()
  else
    $intro.remove()
    intiContent()


  $pcontainer = $('#pcontainer')

  thumbsize = 'large'
  if($mainX<=1440)
    thumbsize = 'normal'

  for key, website of app.data
    $item = $('<div>')
              .addClass('item '+thumbsize)
    for typ in website.type
      $item.addClass(typ)
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

  itemWrapperW = $('.item').innerWidth()

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
      
    , 2000
      
  changeItem = ($element) ->
    if $element.css('marginLeft') isnt -(($element.attr('nbItem')-1)*itemWrapperW)+'px'
      TweenMax.to $element, 0.5,
        marginLeft: '-='+itemWrapperW
    else
      TweenMax.to $element, 0.5,
        marginLeft: 0