# INI Parser

A Parser for [INI configuration files](https://en.wikipedia.org/wiki/INI_file).

This is a simple parser for files with the following format:

```
[Section]
key = value
key2 = value2

[Another Section]
key = value
key2 = value2
```

Only single line values are currently supported.

Paring returns a two level dictionary.

```smalltalk
parser := IniParser on: iniReadStream.
data := parser parse.
```

Much of the Parsing code is copied directly from NeoJson and is copyright 
of Sven Van Caekenberghe under the terms of the MIT license. See the 
license file for more details.
