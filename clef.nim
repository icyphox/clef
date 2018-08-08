import net, strutils, tables, fab

var server = newSocket()
server.bindAddr(Port(1234))
server.listen()

var client = new Socket
server.accept(client)

var data = initTable[string, string]()
var cmd: seq[string]
while true:
  var r = client.recvLine()
  cmd = r.split()
  case cmd[0]:
    of "set":
      data.add(cmd[1], cmd[2])
      echo("you set ", data)
    of "get":
      echo("get comes here")
    else:
      #echo("invalid command $#" % $cmd[0])
      quit(1)

echo(data)
client.close()
server.close()
