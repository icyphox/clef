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
  try:
    case cmd[0]:
      of "set":
        if(cmd[2] == ""):
          echo("can't set nothing")
          break
        data.add(cmd[1], cmd[2])
        echo("you set ", data)
      of "get":
        try:
          echo(data[cmd[1]])
        except KeyError:
          echo("error: no such key '$#'" % cmd[1])
      else:
        echo("invalid command $#" % $cmd[0])
  except IndexError:
    echo("error: $# expects an argument" % cmd[0])


client.close()
server.close()
