if exists("b:current_syntax")
    finish
endif

syn keyword pythonInstanceVariable self
syn keyword pythonClassVaraible cls
syn keyword pythonStatement     break continue del
syn keyword pythonStatement     exec return
syn keyword pythonStatement     pass yield
syn keyword pythonStatement     raise nextgroup=pythonIdentifier,pythonExClass skipwhite
syn keyword pythonStatement     global assert
syn keyword pythonStatement     lambda
syn keyword pythonStatement     with
syn keyword pythonStatement     def class nextgroup=pythonFunction skipwhite
syn keyword pythonRepeat        for while
syn keyword pythonConditional   if elif else
" The standard pyrex.vim unconditionally removes the pythonInclude group, so
" we provide a dummy group here to avoid crashing pyrex.vim.
syn keyword pythonException     try except finally
syn keyword pythonOperator      and in is not or
syn match pythonStatement       "\s*\([.,]\)\@<!\<yield\>"
syn keyword pythonInclude       import
syn keyword pythonImport        import
syn match pythonIdentifier "\v[a-zA-Z_][a-zA-Z0-9_]*"
syn match pythonRaiseFromStatement      "from\>"
syn match pythonImport          "^\s*\zsfrom\>"
syn keyword pythonStatement   as nonlocal
syn match   pythonStatement   "\v(\.)@<!<await>"
syn match   pythonFunction    "[a-zA-Z_][a-zA-Z0-9_]*" display contained
syn match   pythonStatement   "\<async\s\+def\>" nextgroup=pythonFunction skipwhite
syn match   pythonStatement   "\<async\s\+with\>"
syn match   pythonStatement   "\<async\s\+for\>"

syn match   pythonDecorator	"@" display nextgroup=pythonDottedName skipwhite
syn match   pythonDottedName "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\%(\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*\)*" display contained nextgroup=FunctionParameters
syn match   pythonDot        "\." display containedin=pythonDottedName

syn match   pythonComment	"#.*$" display contains=pythonTodo,@Spell
syn match   pythonRun		"\%^#!.*$"
syn match   pythonCoding	"\%^.*\%(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword pythonTodo		TODO FIXME XXX contained

syn match pythonError		"\<\d\+\D\+\>" display
syn match pythonError		"[$?]" display
syn match pythonError		"[&|]\{2,}" display
syn match pythonError		"[=]\{3,}" display
syn match pythonIndentError	"^\s*\%( \t\|\t \)\s*\S"me=e-1 display
syn match pythonSpaceError	"\s\+$" display


syn region pythonBytes		start=+[bB]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes		start=+[bB]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesError,pythonBytesContent,@Spell
syn region pythonBytes		start=+[bB]"""+ end=+"""+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonBytes		start=+[bB]'''+ end=+'''+ keepend contains=pythonBytesError,pythonBytesContent,pythonDocTest,pythonSpaceError,@Spell

syn match pythonBytesError    ".\+" display contained
syn match pythonBytesContent  "[\u0000-\u00ff]\+" display contained contains=pythonBytesEscape,pythonBytesEscapeError

syn match pythonBytesEscape       +\\[abfnrtv'"\\]+ display contained
syn match pythonBytesEscape       "\\\o\o\=\o\=" display contained
syn match pythonBytesEscapeError  "\\\o\{,2}[89]" display contained
syn match pythonBytesEscape       "\\x\x\{2}" display contained
syn match pythonBytesEscapeError  "\\x\x\=\X" display contained
syn match pythonBytesEscape       "\\$"

syn match pythonUniEscape         "\\u\x\{4}" display contained
syn match pythonUniEscapeError    "\\u\x\{,3}\X" display contained
syn match pythonUniEscape         "\\U\x\{8}" display contained
syn match pythonUniEscapeError    "\\U\x\{,7}\X" display contained
syn match pythonUniEscape         "\\N{[A-Z ]\+}" display contained
syn match pythonUniEscapeError    "\\N{[^A-Z ]\+}" display contained


syn region pythonSingleQuoteString start=+'+ skip=+\\'+ excludenl end=+'+ end=+$+ keepend contains=pythonEol
syn region pythonDoubleQuoteString start=+"+ skip=+\\"+ excludenl end=+"+ end=+$+ keepend contains=pythonEol

syn region pythonFString start=+f'+ skip=+\\'+ excludenl end=+'+ end=+$+ keepend contains=pythonEol,pythonSingleQuoteFStringFormat
syn region pythonFString start=+f"+ skip=+\\"+ excludenl end=+"+ end=+$+ keepend contains=pythonEol,pythonDoubleQuoteFStringFormat

syn region pythonTripleSingleQuoteString start=+'''+ skip=+\\'+ excludenl end=+'''+ end=+$+ keepend contains=pythonEol
syn region pythonTripleDoubleQuoteString start=+"""+ skip=+\\"+ excludenl end=+"""+ end=+$+ keepend contains=pythonEol


syn region pythonFString start=+f'''+ skip=+\\'+ excludenl end=+'''+ keepend contains=pythonEol,pythonSingleQuoteFStringFormat
syn region pythonFString start=+f"""+ skip=+\\"+ excludenl end=+"""+ keepend contains=pythonEol,pythonDoubleQuoteFStringFormat

syn match pythonEol "\\n" display contained

syn region pythonSingleQuoteFStringFormat matchgroup=Special start=+{+ end=+}+ keepend contains=pythonStatement,pythonConditional,pythonBoolean,pythonDoubleQuoteString,pythonRepeat,pythonNumber,pythonFloat,pythonOperator contained
syn region pythonDoubleQuoteFStringFormat matchgroup=Special start=+{+ end=+}+ keepend contains=pythonStatement,pythonConditional,pythonBoolean,pythonSingleQuoteString,pythonRepeat,pythonNumber,pythonFloat,pythonOperator contained

syn match   pythonHexError	"\<0[xX]\x*[g-zG-Z]\x*\>" display
syn match   pythonOctError	"\<0[oO]\=\o*\D\+\d*\>" display
syn match   pythonBinError	"\<0[bB][01]*\D\+\d*\>" display

syn match   pythonHexNumber	"\<0[xX]\x\+\>" display
syn match   pythonOctNumber "\<0[oO]\o\+\>" display
syn match   pythonBinNumber "\<0[bB][01]\+\>" display

syn match   pythonNumberError	"\<\d\+\D\>" display
syn match   pythonNumberError	"\<0\d\+\>" display
syn match   pythonNumber	"\<\d\>" display
syn match   pythonNumber	"\<[1-9]\d\+\>" display
syn match   pythonNumber	"\<\d\+[jJ]\>" display

syn match   pythonOctError	"\<0[oO]\=\o*[8-9]\d*\>" display
syn match   pythonBinError	"\<0[bB][01]*[2-9]\d*\>" display

syn match   pythonFloat		"\.\d\+\%([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   pythonFloat		"\<\d\+\.\d*\%([eE][+-]\=\d\+\)\=[jJ]\=" display

syn keyword pythonNone        None
syn keyword pythonBoolean		True False
syn keyword pythonBuiltinObj	Ellipsis NotImplemented
syn match pythonBuiltinObj	'\v(\.)@<!<(object|bool|int|float|tuple|str|list|dict|set|frozenset|bytearray|bytes)>'
syn keyword pythonBuiltinObj	__debug__ __doc__ __file__ __name__ __package__
syn keyword pythonBuiltinObj	__loader__ __spec__ __path__ __cached__

"
" Builtin functions
"

syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(ascii|exec|memoryview|print)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(__import__|abs|all|any)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(bin|chr|classmethod|cmp|compile|complex)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(delattr|dir|divmod|enumerate|eval)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(filter|format|getattr|callable)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(globals|hasattr|hash|hex|id)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(input|isinstance)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(issubclass|iter|len|locals|map|max)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(min|next|oct|open|ord)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(pow|property|range)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(repr|reversed|round|setattr)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(slice|sorted|staticmethod|sum|super)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(type|vars|zip)>\ze\(' nextgroup=FunctionParameters

syn match pythonExClass   '\v(\.)@<!\zs<(BlockingIOError|ChildProcessError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(ConnectionError|BrokenPipeError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(ConnectionAbortedError|ConnectionRefusedError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(ConnectionResetError|FileExistsError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(FileNotFoundError|InterruptedError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(IsADirectoryError|NotADirectoryError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(PermissionError|ProcessLookupError TimeoutError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(StopAsyncIteration|ResourceWarning)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!<(BaseException|Exception|ArithmeticError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(LookupError|EnvironmentError|AssertionError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(AttributeError|BufferError|EOFError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(FloatingPointError|GeneratorExit|IOError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(ImportError|IndexError|KeyError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(KeyboardInterrupt|MemoryError|NameError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(NotImplementedError|OSError|OverflowError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(ReferenceError|RuntimeError|StopIteration)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(SyntaxError|IndentationError|TabError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(SystemError|SystemExit|TypeError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(UnboundLocalError|UnicodeError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(UnicodeEncodeError|UnicodeDecodeError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(UnicodeTranslateError|ValueError|VMSError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(WindowsError|ZeroDivisionError)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(Warning|UserWarning|BytesWarning|DeprecationWarning)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(PendingDepricationWarning|SyntaxWarning)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(RuntimeWarning|FutureWarning)>' nextgroup=FunctionParameters
syn match pythonExClass   '\v(\.)@<!\zs<(ImportWarning|UnicodeWarning)>' nextgroup=FunctionParameters

" This is fast but code inside triple quoted strings screws it up. It
" is impossible to fix because the only way to know if you are inside a
" triple quoted string is to start from the beginning of the file.
syn sync match pythonSync grouphere NONE "):$"
syn sync maxlines=200

hi def link pythonStatement        Statement
hi def link pythonRaiseFromStatement   Statement
hi def link pythonImport           Include
hi def link pythonFunction         Function
hi def link pythonConditional      Conditional
hi def link pythonRepeat           Repeat
hi def link pythonException        Exception
hi def link pythonOperator         Operator

hi def link pythonStarArguments    Keyword

hi def link pythonDecorator        Define
hi def link pythonDottedName       Function
hi def link pythonDot              Normal

hi def link pythonComment          Comment
hi def link pythonCoding           Special
hi def link pythonRun              Special
hi def link pythonTodo             Todo

hi def link pythonError            Error
hi def link pythonIndentError      Error
hi def link pythonSpaceError       Error

hi def link pythonRawString        String

hi def link pythonUniEscape        Special
hi def link pythonUniEscapeError   Error

hi def link pythonBytes              String
hi def link pythonRawBytes           String
hi def link pythonBytesContent       String
hi def link pythonBytesError         Error
hi def link pythonBytesEscape        Special
hi def link pythonBytesEscapeError   Error

hi def link pythonStrFormatting    Special
hi def link pythonStrFormat        Special
hi def link pythonStrTemplate      Special
hi def link pythonEol              Special

hi def link pythonDocTest          Special
hi def link pythonDocTest2         Special

hi def link pythonNumber           Number
hi def link pythonHexNumber        Number
hi def link pythonOctNumber        Number
hi def link pythonBinNumber        Number
hi def link pythonFloat            Float
hi def link pythonNumberError      Error
hi def link pythonOctError         Error
hi def link pythonHexError         Error
hi def link pythonBinError         Error

hi def link pythonBoolean          Boolean
hi def link pythonNone             Constant

hi def link pythonBuiltinObj       Structure
hi def link pythonBuiltinFunc      Function

hi def link pythonExClass          Structure
hi def link pythonInstanceVariable htmlTagN
hi def link pythonClassVaraible htmlTagN
hi def link OptionalParameters htmlTagN

hi def link pythonFstring String
hi def link pythonSingleQuoteString String
hi def link pythonDoubleQuoteString String

let b:current_syntax = "python"
