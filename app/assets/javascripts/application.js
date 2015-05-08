// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets//sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap

var content = $('#content');
$.ajax({
    type: "POST",
    url: 'http://localhost:3000/api/v1/packages',
    dataType: 'json',
    contentType: 'application/json',
    data: JSON.stringify({
        'name': 'somevalue10',
        'homepage': 'htpp://example.com',
        'short_description': 'Short desc',
        'description': 'somevalue2',
        'authors': [
            {name: 'name', email: 'Some email'},
            {name: 'name2', email: 'Some email2'}],
        'tags': ['tag1', 'tag2']

    })
}).done(function (data) {
    content.text(data);
    console.log(data);
}).fail(function (error, status, errorCode) {
    console.log('Error:');
    console.error(errorCode);
    console.error(error.responseJSON);
});