return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style={"
        .. "BasedOnStyle: LLVM, "
        .. "AccessModifierOffset: -4, "
        .. "AlignConsecutiveAssignments: false, "
        .. "AlignConsecutiveDeclarations: false, "
        .. "AlignOperands: true, "
        .. "AlignTrailingComments: false, "
        .. "AlwaysBreakTemplateDeclarations: Yes, "
        .. "BreakBeforeBraces: Custom, "
        .. "BraceWrapping: {"
        .. "AfterCaseLabel: false, "
        .. "AfterClass: false, "
        .. "AfterControlStatement: false, "
        .. "AfterEnum: false, "
        .. "AfterFunction: false, "
        .. "AfterNamespace: false, "
        .. "AfterStruct: false, "
        .. "AfterUnion: false, "
        .. "AfterExternBlock: false, "
        .. "BeforeCatch: false, "
        .. "BeforeElse: false, "
        .. "BeforeLambdaBody: false, "
        .. "BeforeWhile: false, "
        .. "SplitEmptyFunction: true, "
        .. "SplitEmptyRecord: true, "
        .. "SplitEmptyNamespace: true"
        .. "}, "
        .. "BreakConstructorInitializers: AfterColon, "
        .. "BreakConstructorInitializersBeforeComma: false, "
        .. "ColumnLimit: 100, "
        .. "ConstructorInitializerAllOnOneLineOrOnePerLine: false, "
        .. "ContinuationIndentWidth: 4, "
        .. "IndentCaseLabels: true, "
        .. "IndentWidth: 4, "
        .. "InsertNewlineAtEOF: true, "
        .. "MaxEmptyLinesToKeep: 2, "
        .. "NamespaceIndentation: All, "
        .. "PointerAlignment: Left, "
        .. "SpaceAfterCStyleCast: true, "
        .. "SpaceAfterTemplateKeyword: false, "
        .. "SpaceBeforeRangeBasedForLoopColon: false, "
        .. "SpaceInEmptyParentheses: false, "
        .. "SpacesInAngles: false, "
        .. "SpacesInConditionalStatement: false, "
        .. "SpacesInCStyleCastParentheses: false, "
        .. "SpacesInParentheses: false, "
        .. "TabWidth: 4"
        .. "}"
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_markers = {
        ".clangd",
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true
    }
}
