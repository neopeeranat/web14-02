# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $('#txtDestination').tokenInput $('#txtDestination').data('url'), crossDomain: false, tokenLimit: 1;
  if $('#txtDestination').data('name')
    $('#txtDestination').tokenInput "add", id: $('#txtDestination')[0].defaultValue, name: $('#txtDestination').data('name') ;
