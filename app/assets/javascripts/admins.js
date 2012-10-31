function start () {
	$('.user_box')[0].disabled = true
	$('.movie_box')[0].disabled = true
	$('.user_box')[0].style.background = "salmon"
	$('.movie_box')[0].style.background = "salmon"
}

function activate () {
	console.log ('hello')
	if ( $('.user_select').is(':checked') ) {
		$('.user_box')[0].disabled = false
		$('.movie_box')[0].disabled = true
		$('.movie_box')[0].style.background = "salmon"
		$('.user_box')[0].style.background = "firebrick"
		$('.movie_box').attr('value', 'select movie')
	} else {
		if ( $('.movie_select').is(':checked') ) {
			$('.movie_box')[0].disabled = false
			$('.user_box')[0].disabled = true
			$('.user_box')[0].style.background = "salmon"
			$('.movie_box')[0].style.background = "firebrick"
			$('.user_box').attr('value', 'select user')
		}
	}
}

function create_log () {
	form = $('form')
	form.submit()
}