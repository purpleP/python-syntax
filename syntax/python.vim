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
syn match pythonIdentifier "\v[a-zA-Z_][a-zA-Z0-9_]*" nextgroup=FunctionParameters
syn match pythonRaiseFromStatement      "from\>"
syn match pythonImport          "^\s*\zsfrom\>"
syn keyword pythonStatement   as nonlocal
syn match   pythonStatement   "\v(\.)@<!<await>"
syn match   pythonFunction    "[a-zA-Z_][a-zA-Z0-9_]*" nextgroup=FunctionParameters display contained
syn match   pythonStatement   "\<async\s\+def\>" nextgroup=pythonFunction skipwhite
syn match   pythonStatement   "\<async\s\+with\>"
syn match   pythonStatement   "\<async\s\+for\>"

syn region FunctionParameters start='(' end=')' display contains=
            \ FunctionParameters,
            \ OptionalParameters,
            \ pythonRepeat,
            \ pythonInstanceVariable,
            \ pythonClassVaraible,
            \ pythonConditional,
            \ pythonComment,
            \ pythonOperator,
            \ pythonNumber,
            \ pythonNumberError,
            \ pythonFloat,
            \ pythonHexNumber,
            \ pythonStatement,
            \ pythonOctNumber,
            \ pythonString,
            \ pythonRawString,
            \ pythonUniString,
            \ pythonExClass,
            \ pythonUniRawString,
            \ pythonNumber,
            \ pythonRawString,
            \ pythonBytes,
            \ pythonBuiltinObj,
            \ pythonNone,
            \ pythonBuiltinFunc,
            \ pythonBoolean nextgroup=pythonRaiseFromStatement display contained
syn match OptionalParameters /\i*\ze=\(=\)\@!/ display contained
"
" Decorators (new in Python 2.4)
"

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

"
" Strings
"

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

syn region pythonString   start=+[uf]\?'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
syn region pythonString   start=+[uf]\?"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,@Spell
syn region pythonString   start=+[uf]\?"""+ end=+"""+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest2,pythonSpaceError,@Spell
syn region pythonString   start=+[uf]\?'''+ end=+'''+ keepend contains=pythonBytesEscape,pythonBytesEscapeError,pythonUniEscape,pythonUniEscapeError,pythonDocTest,pythonSpaceError,@Spell

syn match  pythonUniRawEscape       "\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  pythonUniRawEscapeError  "\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

syn region pythonRawString  start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString  start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawString  start=+[rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
syn region pythonRawString  start=+[rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn region pythonRawBytes  start=+[bB][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawBytes  start=+[bB][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=pythonRawEscape,@Spell
syn region pythonRawBytes  start=+[bB][rR]"""+ end=+"""+ keepend contains=pythonDocTest2,pythonSpaceError,@Spell
syn region pythonRawBytes  start=+[bB][rR]'''+ end=+'''+ keepend contains=pythonDocTest,pythonSpaceError,@Spell

syn match pythonRawEscape +\\['"]+ display transparent contained



syn region pythonDocTest	start="^\s*>>>" end=+'''+he=s-1 end="^\s*$" contained
syn region pythonDocTest2	start="^\s*>>>" end=+"""+he=s-1 end="^\s*$" contained

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
syn match pythonBuiltinObj	'\v(\.)@<!<(object|bool|int|float|tuple|str|list|dict|set|frozenset|bytearray|bytes)>' nextgroup=FunctionParameters
syn keyword pythonBuiltinObj	__debug__ __doc__ __file__ __name__ __package__
syn keyword pythonBuiltinObj	__loader__ __spec__ __path__ __cached__

"
" Builtin functions
"

syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(ascii|exec|memoryview|print)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(__import__|abs|all|any)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(bin|chr|classmethod|cmp|compile|complex)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(delattr|dir|divmod|enumerate|eval)>\ze\(' nextgroup=FunctionParameters
syn match pythonBuiltinFunc	'\v(\.)@<!\zs<(filter|format|getattr)>\ze\(' nextgroup=FunctionParameters
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

command -nargs=+ HiLink hi def link <args>

HiLink pythonStatement        Statement
HiLink pythonRaiseFromStatement   Statement
HiLink pythonImport           Include
HiLink pythonFunction         Function
HiLink pythonConditional      Conditional
HiLink pythonRepeat           Repeat
HiLink pythonException        Exception
HiLink pythonOperator         Operator

HiLink pythonDecorator        Define
HiLink pythonDottedName       Function
HiLink pythonDot              Normal

HiLink pythonComment          Comment
HiLink pythonCoding           Special
HiLink pythonRun              Special
HiLink pythonTodo             Todo

HiLink pythonError            Error
HiLink pythonIndentError      Error
HiLink pythonSpaceError       Error

HiLink pythonString           String
HiLink pythonRawString        String

HiLink pythonUniEscape        Special
HiLink pythonUniEscapeError   Error

HiLink pythonBytes              String
HiLink pythonRawBytes           String
HiLink pythonBytesContent       String
HiLink pythonBytesError         Error
HiLink pythonBytesEscape        Special
HiLink pythonBytesEscapeError   Error

HiLink pythonStrFormatting    Special
HiLink pythonStrFormat        Special
HiLink pythonStrTemplate      Special

HiLink pythonDocTest          Special
HiLink pythonDocTest2         Special

HiLink pythonNumber           Number
HiLink pythonHexNumber        Number
HiLink pythonOctNumber        Number
HiLink pythonBinNumber        Number
HiLink pythonFloat            Float
HiLink pythonNumberError      Error
HiLink pythonOctError         Error
HiLink pythonHexError         Error
HiLink pythonBinError         Error

HiLink pythonBoolean          Boolean
HiLink pythonNone             Constant

HiLink pythonBuiltinObj       Structure
HiLink pythonBuiltinFunc      Function

HiLink pythonExClass          Structure
HiLink pythonInstanceVariable htmlTagN
HiLink pythonClassVaraible htmlTagN
HiLink OptionalParameters htmlTagN

delcommand HiLink

let b:current_syntax = "python"
