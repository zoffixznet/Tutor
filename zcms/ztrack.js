window.onload = function() {
    setup_track( $('main'), 'http://zcms/index.pl' );
    
    $$('button')[0].onclick = function() {
        show_track( $('main'), 'http://zcms/index.pl' );
    }
}

function show_track (el, tracker_url) {
    el.set({'styles': {'position': 'relative'}});
    
    var req = new Request({url: tracker_url});
    req.ztel = el;
    req.onSuccess = function (responseText) {
        var clicks = responseText.split(';');
        for ( var i = 0, l = clicks.length; i < l; i++ ) {
            var point = clicks[i].split('x');
            var el = new Element('div', {
                'styles': {
                    'position': 'absolute',
                    'width': '4px',
                    'height': '4px',
                    'background': '#f00',
                    'left': point[0]-2,
                    'top': point[1]-2,
                }
            });
            el.inject(this.ztel,'top')
        }
    }

    req.send('page=ztrack-tracker&getztrack=1');
    
}

function setup_track (el, tracker_url) {
    el.onclick = function(e) {
        var posx = 0;
        var posy = 0;
        if (!e) var e = window.event;
        if (e.pageX || e.pageY) 	{
            posx = e.pageX;
            posy = e.pageY;
        }
        else if (e.clientX || e.clientY) 	{
            posx = e.clientX + document.body.scrollLeft
                + document.documentElement.scrollLeft;
            posy = e.clientY + document.body.scrollTop
                + document.documentElement.scrollTop;
        }
        
        var track_el_pos = this.getPosition();
        posx -= track_el_pos.x;
        posy -= track_el_pos.y;
        
        new Request({url: tracker_url}).send('page=ztrack-tracker&ztrack=' + posx + 'x' + posy);
    }
}



function doSomething(e) {
	var posx = 0;
	var posy = 0;
	if (!e) var e = window.event;
	if (e.pageX || e.pageY) 	{
		posx = e.pageX;
		posy = e.pageY;
	}
	else if (e.clientX || e.clientY) 	{
		posx = e.clientX + document.body.scrollLeft
			+ document.documentElement.scrollLeft;
		posy = e.clientY + document.body.scrollTop
			+ document.documentElement.scrollTop;
	}
}
