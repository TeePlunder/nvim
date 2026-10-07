return {
	"emrearmagan/atlas.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional but recommended
		"MeanderingProgrammer/render-markdown.nvim", -- optional but recommended
		"esmuellert/codediff.nvim", -- optional (PullRequest diff)
		"sindrets/diffview.nvim", -- optional; or "dlyongemallo/diffview-plus.nvim"
	},
	-- See Configuration below
	---@type AtlasConfig
	opts = {
		ui = {
			-- Global statusline for Atlas. See the Statusline section below.
			statusline = true,
			-- "auto", "default", "snacks", or "fzf-lua".
			picker = "auto",
			-- Make the main Atlas dashboard a listed buffer.
			listed_buffer = false,
		},

		providers = {
			---@type AtlasBitbucketConfig
			bitbucket = {
				user = vim.env.BITBUCKET_USER,
				token = vim.env.BITBUCKET_TOKEN,
				cache_ttl = 300, -- Set to 0 to disable caching.
			},

			---@type AtlasJiraConfig
			jira = {
				base_url = vim.env.JIRA_BASE_URL,
				email = vim.env.JIRA_EMAIL, -- Required for basic authentication only.
				--- See: https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/
				token = vim.env.JIRA_TOKEN,
				auth_method = "basic", -- "basic" or "bearer", defaults to "basic". If using bearer, set `token` to your API token.
				api_type = "cloud", -- either "cloud" or "server", defaults to "cloud". Cloud API is v3, server API is v2
				cache_ttl = 300, -- Set to 0 to disable caching.
			},
		},

		pulls = {
			---@type AtlasBitbucketPullsConfig
			bitbucket = {
				---@type AtlasBitbucketViewConfig[]
				views = {
					{
						name = "Repo",
						key = "1",
						layout = "compact",
						current_repo = true,
					},
					{
						name = "Me",
						key = "M",
						layout = "grouped",
						-- https://developer.atlassian.com/cloud/bitbucket/rest/#filter-and-sort-api-objects
						search = 'repo:sweetconnect/sc-platform repo:sweetconnect/sweetconnect-api repo:sweetconnect/sc-ai author.nickname = "Leon Bergmann"',
					},
					{
						name = "Team",
						key = "T",
						layout = "grouped",
						search = "repo:sweetconnect/sc-platform repo:sweetconnect/sweetconnect-api repo:sweetconnect/sc-ai",
					},
				},
			},
		},

		issues = {
			---@type AtlasJiraIssuesConfig
			jira = {
				---@type AtlasJiraViewConfig[]
				views = {
					{
						name = "Mine",
						key = "M",
						layout = "plain",
						jql = "project = SC AND assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
					},
					{
						name = "In Progress",
						key = "T",
						layout = "compact",
						jql = "project = SC AND statusCategory = \"In Progress\" ORDER BY updated DESC",
					},
				},

				bookmarks = {
					items = {
						["Backlog"] = "project = SC AND statusCategory = \"To Do\" ORDER BY Rank ASC",
						["My open (all projects)"] = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
						["My bugs"] = "project = SC AND type = Bug AND assignee = currentUser() AND statusCategory != Done ORDER BY priority DESC",
					},
				},

				project_config = {
					story_points_field = "customfield_10028",
				},
			},
		},
	},
}
