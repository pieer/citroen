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
      barColor: '#D14836'  #ef1e25 The color of the curcular bar. You can pass either a css valid color string like rgb, rgba hex or string colors. But you can also pass a function that accepts the current percentage as a value to return a dynamically generated color.
      #trackColor: '#D14836'  #f2f2f2 The color of the track for the bar, false to disable rendering.
      scaleColor: false
      lineCap:    'round'
      lineWidth:  10
      size: 200
      animate: 500
    )
    #$('.chart').data('easyPieChart').update(40)
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
    setTimeout ->
      $('#infolink').click()
    , 100

  if doIntro
    app.intro()
  else
    $intro.remove()
    app.intiContent()
  