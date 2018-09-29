import tables

# Initialize empty hashtable
var data* = initTable[string, string]()

# Commands will be stored here
var cmd*: seq[string]

