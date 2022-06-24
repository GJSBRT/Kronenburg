var visable = false;

$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'toggle':
				if (visable) {
					$('#wrap').fadeOut();
				} else {
					$('#wrap').fadeIn();
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').fadeOut();
				visable = false;
				break;

			case 'updatePlayerCount':
				var playercount = event.data.playercount;
				$('#player_count').html(playercount.players);
				$('#ems').html(playercount.ambulance);
				$('#police').html(playercount.police);
				$('#taxi').html(playercount.taxi);
				$('#mechanic').html(playercount.mechanic);
				$('#brandweer').html(playercount.brandweer);
				$('#casino').html(playercount.casino);
				break;
		}
	}, false);
});