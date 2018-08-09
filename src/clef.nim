import net, strutils, tables

var server = newSocket()
server.bindAddr(Port(1234))
server.listen()
var localAddr = server.getLocalAddr()

echo("clef server listening on ", localAddr[0], ":", localAddr[1])

var client = new Socket
server.accept(client)

var data = initTable[string, string]()
var cmd: seq[string]

proc setVal(key, value: string): bool =
  data[key] = value
  result = true

proc getVal(key: string): string =
  if(data.hasKey(key)):
    result = data[key]
  else:
    result = "error: specified key doesn't exist"

proc flush(): bool =
  data = initTable[string, string]()
  result = true

proc list(): Table[string, string] =
  result = data

while true:
  var r = client.recvLine()
  cmd = r.split()
  try:
    case cmd[0]:
      of "set":
        if(setVal(cmd[1], cmd[2])):
          echo("OK")
      of "get":
        echo(getVal(cmd[1]))
      of "flush":
        if(flush()):
          echo("OK")
      of "list":
        echo(list())
      of "quit":
        quit(1)
      else:
        echo("error: invalid command $#" % $cmd[0])
  except IndexError:
    echo("error: $# expects an argument" % cmd[0])

client.close()
server.close()
