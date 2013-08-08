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
    marginLeft: $centerx - 120
  $lastname.css
    marginLeft: $centerx - 150

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


    ia.from $photo, .5,
      scale: 0


  # portfolio container
  $pcontainer = $('#pcontainer')

  intiContent = ->
    $intro.remove()

    #initMenu
    new gnMenu( document.getElementById( 'gn-menu' ) )
    
    $('#content').show()
    $main.css
      height: 'auto'

    $('.mainWrapper').css
      minHeight: $mainY

    $('#cd-dropdown').dropdown()

    $pcontainer.isotope
      itemSelector : '.item'
      filter: '.website'

    $('#dropdown-wrapper input').on 'change', ->
      filterby = $(this).val()
      $pcontainer.isotope({ filter: '.'+ filterby}).isotope('shuffle')
      if(filterby is 'mobile')
        $pcontainer.addClass('displayMobile')
      else
        $pcontainer.removeClass('displayMobile')

    
    $(window).resize ->
      $pcontainer.isotope 'reLayout'

  Handlebars.registerHelper "displayMobile", (thumb)->
    new Handlebars.SafeString '<img class="mobileImg" src="images/large/'+thumb[thumb.length-1]+'.jpg"/>'


  # Add portfolio content
  source   = $("#portfolio-template").html()
  template = Handlebars.compile(source)
  html    = template(app.portfolio)
  $pcontainer.append(html)

  # Add timeline content
  source   = $("#timeline-template").html()
  template = Handlebars.compile(source)
  html    = template(app.timeline)
  $('#cv').append(html)

  #init info page
  $('.readmore').on 'click', (e)->
    e.preventDefault()
    source   = $("#info-template").html()
    template = Handlebars.compile(source)
    html    = template(app.portfolio.websites[$(this).data('page')])
    $('#info').html(html)
    setTimeout ->
      $('#infolink').click()
    , 100

  if doIntro
    intro()
  else
    $intro.remove()
    intiContent()
  