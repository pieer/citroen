$(document).ready ->
  doIntro = false

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

    # dropdown and isotope
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
      false

    
    $(window).resize ->
      $pcontainer.isotope 'reLayout'
      $center_col.css
        height: $('.pt-page-current .wrapper').height()
      false
    false

  # Helper function
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
  
  # init easyPieChart
  setTimeout ->
    $('.chart').easyPieChart(
      animate: 2000
      barColor: '#F2F26F'
      scaleColor: false
      lineCap:    'round'
      lineWidth:  10
      size: 200
      animate: 500
    )
  , 5000


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

  if doIntro
    app.intro()
  else
    $intro.remove()
    app.intiContent()
  