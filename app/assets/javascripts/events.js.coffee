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

manageRsvps = ->
  $('.rsvp-btn').on('click', ()->
    if $('.rsvp .confirm').length == 0
      guestLoginPrompt($(this))
    else
      updateInvite($(this))
  )

guestLoginPrompt = (el)->
  rsvp = el.attr('value')
  $('#user_rsvp').attr('value', rsvp)
  $('#loginPrompt').modal('show')

updateInvite = (el)->
  rsvp = el.attr('value')
  $('#invite_rsvp').val(rsvp)
  el.closest('form').submit()

notificationsFade = ->
  $.each([1,2,3,4,5], (i, num)->
    $(".fade-#{num}").removeClass("fade-#{num}")
  )
  $('.alert-dismissable').each((i)->
    $(this).addClass("fade-#{i}")
  )

hostConfirmsTickets = ->
  $('.ticket-confirm').on('click', ()->
    $(this).parent('form').submit()
    $(this).closest('.alert-dismissable').alert('close')
  )

expandGuestList = ->
  $('#guest-list-collapse').collapse('show')

guestRegistrationForm = ->
  focusInput = ->
    $("#guest-name-input").focus()

  $('.register-name').on('click', ()->
    $('#loginPrompt').modal('hide')
    $("#fullGuestList").focus()
    expandGuestList()
    $('.guest-register').css('display', 'block')
    setTimeout(focusInput, 200)
  )

keyEnterToSubmit = ->
  # allow user to press enter instead of clicking
  $('#guest-name-input').keypress( (e)->
    if (e.which == 13)
      $(this).parent('form').submit()
  )

paymentMethodForm = ->
  $('.btn-payment').on('click', ()->
    payment = $(this).attr('value')
    $('#invite_payment_method').attr('value', payment)
    $(this).parent('form').submit()
  )

paymentTracking = ->
  $('.edit_invite').submitOnCheck()
  $('.edit_event').submitOnCheck()
  $('.onoffswitch-label').on('click', ()->
    checkBox = $(this).prev('input')
    val = checkBox.is(':checked')
    checkBox.prop('checked', !val)
    $(this).parent('form').submit()
  )
eventRow = ->
  $('.event-listing').on('click', ()->
    window.document.location = $(this).data("url")
  )
dismissAlerts = ->
  $('.close').on('click', (e)->
    e.preventDefault()
    $(this).closest('.alert-dismissable').alert('close')
  )
  $('.dismiss-alert').on('click', (e)->
    e.preventDefault()
    $(this).closest('.alert-dismissable').alert('close')
  )
displayGuestList = ->
  if $('.inline.guest').length < 4
    $('#guest-list-collapse').collapse('show')
smoothScroll = ->
  $('a[href^="#"]').on('click', (e)->
    e.preventDefault()

    target = this.hash
    $target = $(target)

    $('html, body').stop().animate({
      'scrollTop': $target.offset().top
      }, 900, 'swing', ()->
      window.location.hash = target
    )
  )
addMedia = ->
  $('.media-icons .col-xs-4').on('click', ()->
    media_type = $(this).data('media-type')
    $('.media-icons .col-xs-4').removeClass('selected')
    $(this).addClass('selected')
    $('.form').addClass('hidden')
    $('.' + media_type + '-form').removeClass('hidden')
  )
setTimezone = ->
  tz = jstz.determine()
  $('#event_timezone').attr('value', tz.name())

DateFormatting = ->
  # Loop over and write in the date formatted using the local 
  $('.convertDatetime').each ->
    utcDate = new Date($(this).html())
    timeDisplay = moment(utcDate).format('h:mma ddd Do MMM')
    $(this).html timeDisplay


ready = ->
  # to copy to clipboard in browser, copy event link for emails
  clip = new ZeroClipboard($('#invite-btn'))
  
  manageRsvps()
  paymentTracking()
  hostConfirmsTickets()
  guestRegistrationForm()
  keyEnterToSubmit()
  paymentMethodForm()
  eventRow()
  dismissAlerts()
  displayGuestList()
  smoothScroll()
  addMedia()
  setTimezone()
  DateFormatting()

  

$(document).ready(ready)
$(document).on('page:load', ready)

