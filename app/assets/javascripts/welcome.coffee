$(window).scroll ->
  if $(document).scrollTop() > 50
    $('#navbar-conjur').addClass 'shrink'
  else
    $('#navbar-conjur').removeClass 'shrink'

$(document).on 'ready page:load', ->
  $('a.smoothscroll[href^="#"]').on 'click', (e) ->
    e.preventDefault()

    target = @hash
    $target = $(target)

    $('html, body').stop().animate {
      'scrollTop': $target.offset().top
    }, 500, 'swing', ->
      window.location.hash = target
