# INI Parser

A parser for [INI configuration files](https://en.wikipedia.org/wiki/INI_file).

[![Unit Tests](https://github.com/ctSkennerton/INI-Parser/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/ctSkennerton/INI-Parser/actions/workflows/unit-tests.yml/badge.svg)
[![Coverage Status](https://codecov.io/github/ctSkennerton/INI-Parser/coverage.svg?branch=master)](https://codecov.io/gh/ctSkennerton/INI-Parser/branch/master)
[![Group loading check](https://github.com/ctSkennerton/INI-Parser/actions/workflows/loading-groups.yml/badge.svg)](https://github.com/ctSkennerton/INI-Parser/actions/workflows/loading-groups.yml)

[![GitHub release](https://img.shields.io/github/release/ctSkennerton/INI-Parser.svg)](https://github.com/ctSkennerton/INI-Parser/releases/latest)
[![Pharo 8.0](https://img.shields.io/badge/Pharo-8.0-informational)](https://pharo.org)
[![Pharo 9.0](https://img.shields.io/badge/Pharo-9.0-informational)](https://pharo.org)
[![Pharo 10](https://img.shields.io/badge/Pharo-10-informational)](https://pharo.org)
[![Pharo 11](https://img.shields.io/badge/Pharo-11-informational)](https://pharo.org)

This is a simple parser for files with the following format:

```ini
globalKey = value
; This is a comment
# This is also a comment

[Section]
key = value
key2 = value2

[Another Section]
key = value
key2 = value2
```

Only single line values are currently supported.

Parsing returns a two level dictionary.

```smalltalk
parser := IniReader on: iniReadStream.
data := parser parse.
```

---

The parsing code is a derivative work of the [NeoJSON](https://github.com/svenvc/NeoJSON)
parser by [Sven Van Caekenberghe](https://github.com/svenvc) under the MIT license.
