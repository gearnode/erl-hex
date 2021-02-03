%% Copyright (c) 2021 Bryan Frimin <bryan@frimin.fr>.
%%
%% Permission to use, copy, modify, and/or distribute this software for any
%% purpose with or without fee is hereby granted, provided that the above
%% copyright notice and this permission notice appear in all copies.
%%
%% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
%% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
%% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
%% SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
%% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
%% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
%% IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

-module(hex_tests).

-include_lib("eunit/include/eunit.hrl").

encode_test_() ->
[?_assertEqual(<<>>,
               hex:encode(<<>>)),
 ?_assertEqual(<<"66">>,
               hex:encode(<<"f">>)),
 ?_assertEqual(<<"666f">>,
               hex:encode(<<"fo">>)),
 ?_assertEqual(<<"666f6f">>,
               hex:encode(<<"foo">>)),
 ?_assertEqual(<<"666f6f62">>,
               hex:encode(<<"foob">>)),
 ?_assertEqual(<<"666f6f6261">>,
               hex:encode(<<"fooba">>)),
 ?_assertEqual(<<"666f6f626172">>,
               hex:encode(<<"foobar">>)),
 ?_assertEqual(<<>>,
               hex:encode(<<>>, [uppercase])),
 ?_assertEqual(<<"66">>,
               hex:encode(<<"f">>, [uppercase])),
 ?_assertEqual(<<"666F">>,
               hex:encode(<<"fo">>, [uppercase])),
 ?_assertEqual(<<"666F6F">>,
               hex:encode(<<"foo">>, [uppercase])),
 ?_assertEqual(<<"666F6F62">>,
               hex:encode(<<"foob">>, [uppercase])),
 ?_assertEqual(<<"666F6F6261">>,
               hex:encode(<<"fooba">>, [uppercase])),
 ?_assertEqual(<<"666F6F626172">>,
               hex:encode(<<"foobar">>, [uppercase]))].

decode_test_() ->
  [?_assertEqual({ok, <<>>},
                 hex:decode(<<>>)),
   ?_assertEqual({ok, <<"f">>},
                 hex:decode(<<"66">>)),
   ?_assertEqual({ok, <<"fo">>},
                 hex:decode(<<"666F">>)),
   ?_assertEqual({ok, <<"foo">>},
                 hex:decode(<<"666F6F">>)),
   ?_assertEqual({ok, <<"foob">>},
                 hex:decode(<<"666F6F62">>)),
   ?_assertEqual({ok, <<"fooba">>},
                 hex:decode(<<"666F6F6261">>)),
   ?_assertEqual({ok, <<"foobar">>},
                 hex:decode(<<"666F6F626172">>)),
   ?_assertEqual({ok, <<"fo">>},
                 hex:decode(<<"666f">>)),
   ?_assertEqual({ok, <<"foo">>},
                 hex:decode(<<"666f6f">>)),
   ?_assertEqual({ok, <<"foob">>},
                 hex:decode(<<"666f6f62">>)),
   ?_assertEqual({ok, <<"fooba">>},
                 hex:decode(<<"666f6f6261">>)),
   ?_assertEqual({ok, <<"foobar">>},
                 hex:decode(<<"666f6f626172">>)),
   ?_assertEqual({ok, <<"foobar">>},
                 hex:decode(<<"666f6F626172">>)),
   ?_assertEqual({error, {invalid_hex_char, 71}},
                 hex:decode(<<"fG">>))].


