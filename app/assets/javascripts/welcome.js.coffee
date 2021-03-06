swal = require('sweetalert')
scrollreveal = require('scrollreveal')

$(window).scroll ->
  if $(document).scrollTop() > 50
    $('#navbar-conjur').addClass 'shrink'
  else
    $('#navbar-conjur').removeClass 'shrink'

$(document).on 'ready page:load', ->
  window.sr = new scrollreveal()

  $('a.smoothscroll[href^="#"]').on 'click', (e) ->
    e.preventDefault()

    target = @hash
    $target = $(target)

    $('html, body').stop().animate {
      'scrollTop': $target.offset().top
    }, 500, 'swing', ->
      window.location.hash = target

  $("#contact_form").on("ajax:success", (e, data, status, xhr) ->
    swal(
      title: 'Got It!',
      type: 'success'
      text: "We've received your message and will get back to you soon!",
      confirmButtonText: 'OK'
    )
    $('#contact_form').find('input, textarea').val('')
  ).on "ajax:error", (e, xhr, status, error) ->
    error = xhr.responseJSON?.error
    error ||= "Something went wrong! Please try again later."
    swal(
      title: 'Oops...',
      type: 'error'
      text: error,
      confirmButtonText: 'OK'
    )

  if $('#portfolio-page')[0]
    $('#portfolio-slider').owlCarousel
      center: true,
      items: 1,
      loop: true,
      autoWidth: true,
      margin:10
