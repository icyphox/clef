type KeyboardInterrupt* = object of Exception

proc sigintHandler*() {.noconv.} =
  raise newException(KeyboardInterrupt, "Keyboard Interrupt")
