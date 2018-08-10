import net, parseopt

var cmds = @["-h", "--help"]
var p = initOptParser(cmds)
for kind, key, val in p.getopt():
  case kind
  of cmdArgument:
    echo("sometheing")
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": echo("switch help")
    of "version", "v": echo("version here")
  of cmdEnd: assert(false) # cannot happen
