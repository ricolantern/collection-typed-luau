# collection-typed-luau
Strict-typed collection implementation for Luau.

Based on either Symfony's or Laravel's implementation of collections (forgor, it been a while since I made this).

**Currently untested**

## Example usage
### Internal counter
Without using the `Collection` module, you need to keep track of the array size yourself.
`Collection` takes care of this for you.
#### Without `Collection`
```Lua
local levelsCount: number = 3
local levels: {[number]: string} = {
    ["goodegggalaxy"] = "path/to/goodegggalaxy",
    ["cloudycourtgalaxy"] = "path/to/cloudycourtgalaxy",
    ["buoybasegalaxy"] = "path/to/buoybasegalaxy",
}

levels["slimeyspringgalaxy"] = "path/to/slimeyspringgalaxy"
levelsCount += 1

print(#levels) -- "0"
print(levelsCount) -- "4"
```
#### With `Collection`
```Lua
local Collection = require("path/to/collection")

local levels: Collection.Type<string, string> = Collection.new({
    ["goodegggalaxy"] = "path/to/goodegggalaxy",
    ["cloudycourtgalaxy"] = "path/to/cloudycourtgalaxy",
    ["buoybasegalaxy"] = "path/to/buoybasegalaxy",
})

levels:Add("slimeyspringgalaxy", "path/to/slimeyspringgalaxy")

print(#levels) -- "4"
```
### Non-assoc array
```Lua
local Collection = require("path/to/collection")

local items: Collection.Type<number, string> = Collection.new({
    "Wrench",
    "Screw driver",
    "Hammer",
})

assert(items:Search("Screw driver") == "Screw driver") -- true
```
### Assoc array
```Lua
local Collection = require("path/to/collection")

local levels: Collection.Type<string, string> = Collection.new({
    ["goodegggalaxy"] = "path/to/goodegggalaxy",
    ["cloudycourtgalaxy"] = "path/to/cloudycourtgalaxy",
    ["buoybasegalaxy"] = "path/to/buoybasegalaxy",
})

assert(items:Get("buoybasegalaxy") == "path/to/buoybasegalaxy") -- true
```
## Contributing
Contributions are welcome, just make a PR and if need be, send me a message on discord @ricolantern for the review.