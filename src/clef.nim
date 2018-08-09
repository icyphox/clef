import net, strutils, tables

# Create server socket
var server = newSocket()

# TODO: Pass port as command line arg
server.bindAddr(Port(1234))
server.listen()
var localAddr = server.getLocalAddr()

echo("clef server listening on ", localAddr[0], ":", localAddr[1])

# Create client socket
var client = new Socket
server.accept(client)

# Initialize empty hashtable
var data = initTable[string, string]()

# Commands will be stored here
var cmd: seq[string]

# Puts the given key-value pair into the `data` table
proc setVal*(key, value: string): bool =
  data[key] = value
  result = true

# Fetches the value corresponding to the given key
proc getVal*(key: string): string =
  if(data.hasKey(key)):
    result = data[key]
  else:
    result = "error: specified key doesn't exist"

# Flushes all entries
proc flush*(): bool =
  data = initTable[string, string]()
  result = true

# Returns the current hashtable
proc list*(): Table[string, string] =
  result = data

while true:
  # Recieves a single line from the client
  var r = client.recvLine()

  # Splits the string into a seq
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
        # FIXME: Goes into an infinite loop if user closes the session
        echo("error: invalid command $#" % $cmd[0])
  except IndexError:
    echo("error: $# expects an argument" % cmd[0])

# Closing all sockets
client.close()
server.close()
