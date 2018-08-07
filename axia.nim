import net, strutils, tables, fab

var server = newSocket()
server.bindAddr(Port(1234))
server.listen()

var client = new Socket
server.accept(client)

var cmd: seq[string]
while true:
  var r = client.recvLine()
  cmd = r.split()
  echo(cmd)
  case cmd[0]:
    of "get":
      blue("this is the `get` command, and you're passing $#" % $cmd[1])
    of "set":
      green("this is the `set` command, and you're passing $#" % $cmd[1])
    else:
      echo("invalid command $#" % $cmd[0])

client.close()
server.close()
