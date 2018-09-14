# Package

version       = "0.1.0"
author        = "Anirudh"
description   = "redis like key-value store, written in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["clef"]
skipDirs      = @["client", "server"]

# Dependencies

requires "nim >= 0.18.0"

# Tasks

task hello, "This is a test task":
  echo("hello world")
