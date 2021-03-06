<div class="fa fa-times close-icon"></div>
<div class="tv-poster">
	<div data-bgr="<%= images.fanart %>" class="tv-poster-background"><div class="tv-poster-overlay"></div></div>
	<div data-bgr="<%= images.poster %>" class="tv-cover"></div>

	<div class="tv-meta-data">
		<div class="tv-title"><%= title %></div>
		<div class="tv-year"><%= year %></div>
		<div class="tv-dot"></div>
		<div class="tv-runtime"><%= duration %></div>
		<div class="tv-dot"></div>
		<div class="tv-status"><%= status !== undefined ? i18n.__(status) : "N/A" %></div>
		<div class="tv-dot"></div>
		<div class="tv-genre"><%= i18n.__(genre[0]) %></div>
		<div class="tv-dot"></div>
		<div data-toggle="tooltip" data-placement="top" title="<%=i18n.__("Open IMDb page") %>" class="show-imdb-link"></div>
		<div class="tv-dot"></div>
		<div class="rating-container-tv">
			<% p_rating = Math.round(rating) / 20; // Roundoff number to nearest 0.5 %>
			<div data-toggle="tooltip" data-placement="right" title="<%= Math.round(rating) / 10 %> /10" class="star-container-tv">

			<% for (var i = 1; i <= Math.floor(p_rating); i++) { %>
					<i class="fa fa-star rating-star"></i>
				<% }; %>
				<% if (p_rating % 1 > 0) { %>
					<span class = "fa-stack rating-star-half-container">
						<i class="fa fa-star fa-stack-1x rating-star-half-empty"></i>
						<i class="fa fa-star-half fa-stack-1x rating-star-half"></i>
					</span>
				<% }; %>
				<% for (var i = Math.ceil(p_rating); i < 5; i++) { %>
					<i class="fa fa-star rating-star-empty"></i>
			<% }; %>
			</div>
			<div class="number-container-tv hidden"><%= Math.round(rating) / 10 %> <em>/10</em></div>
		</div>
		<div class="tv-overview"><%= synopsis %></div>
		<div class="favourites-toggle"><%=i18n.__("Add to bookmarks") %></div>
	</div>
</div>

<div class="episode-base">
	<div class="episode-info">
		<div class="episode-info-title"></div>
		<div class="episode-info-number"></div>
		<div class="episode-info-date"></div>
		<div class="episode-info-description"></div>
		<div class="show-quality-container">
			<div class="quality-selector">
				<div class="q480">480p</div>
				<div class="q720">720p</div>
				<div class="quality switch white">
					<input type="radio" name="switch" id="switch-hd-off" >
					<input type="radio" name="switch" id="switch-hd-on" checked >
					<span class="toggle"></span>
				</div>
			</div>
			<div class="quality-info"></div>
		</div>
		<div class="movie-btn-watch-episode">
			<div class="button dropup" id="player-chooser"></div>
		</div>
	</div>

	<div class="display-base-title">
		<div class="episode-list-seasons"><%= i18n.__("Seasons") %></div>
		<div class="episode-list-episodes"><%= i18n.__("Episodes") %></div>
	</div>

	<div class="season-episode-container">
		<div class="tabs-base">
			<div class="tabs-seasons">
				<ul>
					<% var torrents = {};
					_.each(episodes, function(value, currentEpisode) {
						_.each(value, function(item) {
							if (!torrents[item.season]) torrents[item.season] = {};
							torrents[item.season][item.episode] = item;
						});
					});
					_.each(torrents, function(value, season) { %>
						<li class="tab-season" data-tab="season-<%=season %>">
							<a><%= i18n.__("Season %s", season) %></a>
						</li>
					<% }); %>
				</ul>
			</div>
			<div class="tabs-episodes">
				<% _.each(torrents, function(value, season) { %>
					<div class="tab-episodes season-<%=season %>">
						<ul>
							<% _.each(value, function(episodeData) {
								var first_aired = '',
									q720 = '',
									q480 = '';

								if (episodeData.airsat !== undefined) {
									first_aired = episodeData.airsat;
								}
							%>
								<li class="tab-episode" data-id="<%=episodeData.e_id %>" data-season="<%=episodeData.season %>" data-episode="<%=episodeData.episode %>">
									<a href="#" class="episodeData">
										<span><%=episodeData.episode %></span>
										<div><%=episodeData.e_title %></div>
									</a>
									
									<i id="watched-<%=episodeData.season%>-<%=episodeData.episode%>" class="fa fa-eye watched"></i>


									<!-- hidden template so we can save a DB query -->
									<div class="template-<%=episodeData.e_id %>" style="display:none">
										<span class="title"><%=episodeData.e_title %></span>
										<span class="date"><%=first_aired %></span>
										<span class="season"><%=episodeData.season %></span>
										<span class="episode"><%=episodeData.episode %></span>
										<span class="overview"></span>
										<span class="q480"></span>
										<span class="q720"></span>
									</div>
								</li>
							<% }); %>
						</ul>
					</div><!--End tabs-episode-->
				<% }); %>
			</div><!--End tabs-episode-base-->
		</div><!--End tabs_base-->
	</div><!--End season-episode-container-->
</div>