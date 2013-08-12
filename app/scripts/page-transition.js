var PageTransitions = (function() {

  var $main = $( '#pt-main' ),
    $pages = $main.children( 'div.pt-page' ),
    $iterate = $( '#iterateEffects' ),
    $center_col = $('#center_col'),
    animcursor = 1,
    pagesCount = $pages.length,
    current = 0,
    next = 0,
    isAnimating = false,
    endCurrPage = false,
    endNextPage = false,
    animEndEventNames = {
      'WebkitAnimation' : 'webkitAnimationEnd',
      'OAnimation' : 'oAnimationEnd',
      'msAnimation' : 'MSAnimationEnd',
      'animation' : 'animationend'
    },
    // animation end event name
    animEndEventName = animEndEventNames[ Modernizr.prefixed( 'animation' ) ],
    // support css animations
    support = Modernizr.cssanimations;
  
  function init() {

    $pages.each( function() {
      var $page = $( this );
      $page.data( 'originalClassList', $page.attr( 'class' ) );
    } );

    $pages.eq( current ).addClass( 'pt-page-current' );

    this.eventtype = mobilecheck() ? 'touchstart' : 'click';

    $("#leftnav a, #backto").on(this.eventtype,function( e ) {
        e.preventDefault();
        next = $(this).data( 'page' )
        if(next !== current){
          nextPage( $(this).data( 'animation' ));
        }
      })

  }

  function nextPage( animation ) {

    if( isAnimating ) {
      return false;
    }

    isAnimating = true;
    
    var $currPage = $pages.eq( current );
    current = next;

    var $nextPage = $pages.eq( current ).addClass( 'pt-page-current' ),
      outClass = '', inClass = '';
    minHeight = $nextPage.find('.wrapper').outerHeight();
    winHeight = $(window).outerHeight();

    if(minHeight<= winHeight){
      $nextPage.find('.wrapper').css({'height': winHeight});
    }
    $center_col.css({
      height: minHeight
    });

    switch( animation ) {
      case 13:
        outClass = 'pt-page-moveToLeftEasing pt-page-ontop';
        inClass = 'pt-page-moveFromRight';
        break;
      case 14:
        outClass = 'pt-page-moveToRightEasing pt-page-ontop';
        inClass = 'pt-page-moveFromLeft';
        break;
      case 15:
        outClass = 'pt-page-moveToTopEasing pt-page-ontop';
        inClass = 'pt-page-moveFromBottom';
        break;
     
      case 53:
        outClass = 'pt-page-moveToTopFade';
        inClass = 'pt-page-rotateUnfoldBottom';
        break;

    }

    $currPage.addClass( outClass ).on( animEndEventName, function() {
      $currPage.off( animEndEventName );
      endCurrPage = true;
      if( endNextPage ) {
        onEndAnimation( $currPage, $nextPage );
      }
    } );

    $nextPage.addClass( inClass ).on( animEndEventName, function() {
      $nextPage.off( animEndEventName );
      endNextPage = true;
      if( endCurrPage ) {
        onEndAnimation( $currPage, $nextPage );
      }
    } );

    if( !support ) {
      onEndAnimation( $currPage, $nextPage );
    }

  }

  function onEndAnimation( $outpage, $inpage ) {
    endCurrPage = false;
    endNextPage = false;
    resetPage( $outpage, $inpage );
    isAnimating = false;
  }

  function resetPage( $outpage, $inpage ) {
    $outpage.attr( 'class', $outpage.data( 'originalClassList' ) );
    $inpage.attr( 'class', $inpage.data( 'originalClassList' ) + ' pt-page-current' );
  }

  init();

  return { init : init };

})();