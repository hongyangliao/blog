{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname and not (theme.disqus.enable and theme.disqus.shortname) and not theme.hypercomments_id and not theme.gentie_productKey and not theme.changyan.enable %}
	{% if page.comments and theme.gitment.enable and theme.gitment.username and theme.gitment.client_id and theme.gitment.client_secret %}
		{% set username = theme.gitment.username %}
		{% set client_id = theme.gitment.client_id %}
		{% set client_secret = theme.gitment.client_secret %}
		<link rel="stylesheet" href="https://imsun.github.io/gitment/style/default.css">
		<script src="https://imsun.github.io/gitment/dist/gitment.browser.js"></script>
		<script>
			var gitment = new Gitment({
			  //id: 'Ò³Ãæ ID',
			  owner: '{{username}}',
			  repo: '{{username}}.github.io',
			  oauth: {
				client_id: '{{client_id}}',
				client_secret: '{{client_secret}}'
			  }
			});
			gitment.render('gitment_container');
		</script>
	{% endif %}
{% endif %}