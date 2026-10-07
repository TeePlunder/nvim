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

		-- See Pulls Configuration below.
		pulls = {
			---@type AtlasBitbucketPullsConfig
			bitbucket = {
				---@type AtlasBitbucketViewConfig[]
				views = {
					{
						name = "Me",
						key = "M",
						layout = "compact", -- "compact", "grouped", or "plain"
						-- https://developer.atlassian.com/cloud/bitbucket/rest/#filter-and-sort-api-objects
						search = 'repo:your-workspace/standalone-repo project:your-workspace/CORE author.nickname = "your-name"',
					},
					{
						name = "Team",
						key = "1",
						layout = "grouped",
						search = 'project:your-workspace/TEAM destination.branch.name = "main"',
					},
				},

				bookmarks = {
					key = "S", -- default
					label = "Search", -- default
					items = {
						["Atlas"] = {
							layout = "grouped",
							search = 'repo:your-workspace/atlas project:your-workspace/ATLAS title ~ "atlas"',
						},
					},
				},
			},
		},

		-- See Issue Configuration below.
		issues = {
			---@type AtlasJiraIssuesConfig
			jira = {
				---@type AtlasJiraViewConfig[]
				views = {
					{
						name = "My Board",
						key = "M",
						layout = "plain",
						jql = "project = KAN AND assignee = currentUser() ORDER BY updated DESC",
					},
					{
						name = "Team Board",
						key = "T",
						layout = "compact",
						jql = "project = KAN ORDER BY updated DESC",
					},
				},

				bookmarks = {
					key = "J", -- default
					label = "JQL", -- default
					items = {
						["Backlog"] = "project = KAN AND statusCategory != Done AND (sprint IS EMPTY OR sprint NOT IN openSprints()) ORDER BY Rank ASC",
						["Next sprint"] = "project = KAN AND sprint in futureSprints() ORDER BY Rank ASC",
						["My open"] = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
					},
				},

				project_config = {
					-- The Jira custom field ID used for story points. Defaults to "customfield_10016".
					story_points_field = "customfield_10016",
					issue_types = {
						["Maintenance"] = { icon = "", hl_group = "AtlasTextWarning" },
						["Infrastructure"] = { icon = "󰒋", hl_group = "AtlasLogInfo" },
					},

					KAN = {
						customfield_10003 = {
							name = "Approvers",
							format = function(value)
								if type(value) ~= "table" or #value == 0 then
									return nil -- nil hides the field
								end
								return table.concat(value, ", ")
							end,
							hl_group = "AtlasChipActive",
							display = "chip", -- "chip" or "table"
						},
					},
				},
			},
		},
	},
}
