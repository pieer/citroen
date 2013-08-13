$(document).ready ->
  doIntro = true

  $intro = $('#intro')
  $main = $('#main')
  $mainY = $(window).height()

  $center_col = $('#center_col')
  $photo = $('#photo')

  # portfolio container
  $pcontainer = $('#pcontainer')

  app.intiContent = ->
    $intro.remove()

    #initMenu
    new gnMenu( document.getElementById( 'gn-menu' ) )
    
    $('#content').show()
    $main.css
      height: 'auto'

    $('.mainWrapper, .wrapper').css
      minHeight: $mainY

    $center_col.css
      height: $('.pt-page-current .wrapper').height()

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
      $center_col.css
        height: $('.pt-page-current .wrapper').height()

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
  setTimeout ->
    $('.timeline input').first().click()
  ,2000

  # Add skills content
  source   = $("#xp-template").html()
  template = Handlebars.compile(source)
  html    = template(app.experience)
  $('#skillsWrapper').append(html)
  
  setTimeout ->
    $('.chart').easyPieChart(
      animate: 2000
      barColor: '#F2F26F'  #ef1e25 The color of the curcular bar. You can pass either a css valid color string like rgb, rgba hex or string colors. But you can also pass a function that accepts the current percentage as a value to return a dynamically generated color.
      #trackColor: '#D14836'  #f2f2f2 The color of the track for the bar, false to disable rendering.
      scaleColor: false
      lineCap:    'round'
      lineWidth:  10
      size: 200
      animate: 500
    )
  , 5000

  # $('[href="#development"]').on 'click', ->
  #   setTimeout ->
  #     $('.chart').each (el) ->
  #     #$('.chart').data('easyPieChart').update(40)
  #   , 5000

  #init info page
  $('.readmore').on 'click', (e)->
    e.preventDefault()
    source   = $("#info-template").html()
    template = Handlebars.compile(source)
    html    = template(app.portfolio.websites[$(this).data('page')])
    $('#info').html(html)
    $('#infolink').trigger('click')
    setTimeout ->
      $center_col.css
        height: $('.pt-page-current .wrapper').height()
    , 500
    setTimeout ->
      $center_col.css
        height: $('.pt-page-current .wrapper').height()
    , 3000


  $ipad = $('.ipad .device_c')
  ipadpos = 0
  $notebook  = $('.notebook  .device_c')
  notebookpos = 0
  $iphone = $('.iphone .device_c')
  iphonepos = 0
  setInterval ->
    ipadpos -= 126
    notebookpos -= 160
    iphonepos -= 83
    if ipadpos < -378
      iphonepos = notebookpos = ipadpos = 0
    $ipad.css({backgroundPosition:'0 '+ipadpos+'px'})
    $notebook.css({backgroundPosition:'-100px '+notebookpos+'px'})
    $iphone.css({backgroundPosition:'-354px '+iphonepos+'px'})
  ,7000

  if doIntro
    app.intro()
  else
    $intro.remove()
    app.intiContent()
  