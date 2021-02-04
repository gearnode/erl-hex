# Introduction
This document contains development notes about the `hex` library.

# Versioning
The following `hex` versions are available:
- `0.y.z` unstable versions.
- `x.y.z` stable versions: `hex` will maintain reasonable backward
  compatibility, deprecating features before removing them.
- Experimental untagged versions.

Developers who use unstable or experimental versions are responsible for
updating their application when `hex` is modified. Note that unstable
versions can be modified without backward compatibility at any time.

# Modules
## `hex`
### `encode/1`
Encodes a binary into a hex encoded binary.

Same as `encode(Bin, [lowercase])`.

### `encode/2`
Encodes a binary into a hex encoded binary.

Example:
```erlang
hex:encode(<<"foobar">>, [uppercase]).
```

### `decode/1`
Decodes a hex encoded binary into a binary.

Example:
```erlang
{ok, Bin} = hex:decode(<<"666f6f626172">>).
```
