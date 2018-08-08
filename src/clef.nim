import net, strutils, tables, fab

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
  echo(data)
  result = true

proc getVal(key: string): string =
  if(data.hasKey(key)):
    result = data[key]
  else:
    result = "error: specified key doesn't exist"

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
      else:
        echo("invalid command $#" % $cmd[0])
  except IndexError:
    echo("error: $# expects an argument" % cmd[0])


client.close()
server.close()
