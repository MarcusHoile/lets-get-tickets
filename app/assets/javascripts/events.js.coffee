mapInit = (lat, lng)->
  mapCanvas = document.getElementById("map-canvas")
  latLng = new google.maps.LatLng(lat, lng)
  mapOptions = 
    center: latLng,
    mapTypeControl: false,
    panControl: false,
    zoomControl: false,
    streetViewControl: false,
    zoom: 12

  # create a map
  map = new google.maps.Map(mapCanvas, mapOptions)
  # add a marker
  marker = new google.maps.Marker(
    map: map,
    position: latLng
  )

jQuery.fn.submitOnCheck = ()->
  this.find('input[type=submit]').remove()
  return this

loginPrompt = ->
  $('.rsvp-btn').on('click', ()->
    rsvp = $(this).attr('value')
    $('#user_rsvp').attr('value', rsvp)
    $('#loginPrompt').modal('show')
  )

notificationsFade = ->
  $.each([1,2,3,4,5], (i, num)->
    $(".fade-#{num}").removeClass("fade-#{num}")
  )
  $('.alert-dismissable').each((i)->
    $(this).addClass("fade-#{i}")
  )

ready = ->
  # to copy to clipboard in browser, copy event link for emails
  clip = new ZeroClipboard($('#invite-btn'))
  
  if $('.rsvp .confirm').length == 0
    $('.rsvp-btn.going').on('click', ()->
      rsvp = $(this).attr('value')
      $('#user_rsvp').attr('value', rsvp)
      $('#loginPrompt').modal('show')
    )
  else
    $('.rsvp-btn').on('click', ()->
      rsvp = ($(this).attr('value'))
      $('#invite_rsvp').val(rsvp)
      $(this).parent('form').submit()
    )

  # payment tracking and ticket purhcase confirmation
  $('.edit_invite').submitOnCheck()
  $('.edit_event').submitOnCheck()
  $('.onoffswitch-label').on('click', ()->
    checkBox = $(this).prev('input')
    val = checkBox.is(':checked')
    checkBox.prop('checked', !val)
    $(this).parent('form').submit()
  )
  $('.ticket-confirm').on('click', ()->
    $(this).parent('form').submit()
  )

  $('.view-guest-list').on('click', ()->
    $('.friends-list').toggle()
    $('.accordion').toggleClass('fa-plus-square-o')
    $('.accordion').toggleClass('fa-minus-square-o')
  )

  height = $('.event-notice').outerHeight()

  $('.spacer').css('height', height)
  $('.close-btn').on('click', ()->
    $(this).closest('.event-notice').hide()
    $('.spacer').hide()
  )

  # form for registering guest user
  $('.register-name').on('click', ()->
    $('#loginPrompt').modal('hide')
    $('.friends-list').css('display', 'block')
    $('.guest-register').css('display', 'block')
    $("#guest-name-input").focus()
  )

  # allow user to press enter instead of clicking
  $('#guest-name').keypress( (e)->
    if (e.which == 13)
      $(this).parent('form').submit()
  )

  $('.btn-payment').on('click', ()->
    payment = $(this).attr('value')
    $('#invite_payment_method').attr('value', payment)
    $(this).parent('form').submit()
  )

  $('.event-listing').on('click', ()->
    path = $(this).data('url')
    window.location.href = path
  )


$(document).ready(ready)
$(document).on('page:load', ready)

