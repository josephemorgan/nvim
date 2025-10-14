return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	opts = {},
	config = function(_, opts)
		require("roslyn").setup(opts)

		vim.lsp.config("roslyn", {
			cmd = {
				"roslyn",
				"--logLevel",
				"Information",
				"--extensionLogDirectory",
				vim.fn.stdpath("data"),
				"--stdio",
			},
			handlers = {
				["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
					return result
				end,
			},
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					csharp_enable_inlay_hints_for_types = true,
					dotnet_enable_inlay_hints_for_indexer_parameters = true,
					dotnet_enable_inlay_hints_for_literal_parameters = true,
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,
					dotnet_enable_inlay_hints_for_other_parameters = true,
					dotnet_enable_inlay_hints_for_parameters = true,
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
					dotnet_enable_tests_code_lens = true,
				},
				["csharp|completion"] = {
					dotnet_show_completion_items_from_unimported_namespaces = true,
					dotnet_show_name_completion_suggestions = true,
				},
				["csharp|background_analysis"] = {
					background_analysis_dotnet_compiler_diagnostics_scope = "fullSolution",
				},
				["csharp|symbol_search"] = {
					dotnet_search_reference_assemblies = true,
				},
				["csharp|projects"] = {
					dotnet_enable_file_based_programs = false,
				},
			},
		})
	end,
}
