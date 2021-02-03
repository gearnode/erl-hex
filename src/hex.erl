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

-module(hex).

-export([encode/1, encode/2,
         decode/1]).

-spec encode(binary()) -> binary().
encode(Bin) when is_binary(Bin) ->
  encode(Bin, [lowercase]).

-spec encode(binary(), Options) -> binary() when
    Options :: [Option],
    Option :: lowercase | uppercase.
encode(Bin, Options) when is_binary(Bin), is_list(Options) ->
  case proplists:get_bool(uppercase, Options) of
    false ->
      encode(Bin, fun enc_hex_digit_lower/1, <<>>);
    true ->
      encode(Bin, fun enc_hex_digit_upper/1, <<>>)
  end.

-spec encode(binary(), Enc16, binary()) -> binary() when
    Enc16 :: fun((0..15) -> byte()).
encode(<<>>, _Enc16, Acc) ->
  Acc;
encode(<<A0:4, B0:4, Rest/binary>>, Enc16, Acc) ->
  A = Enc16(A0),
  B = Enc16(B0),
  encode(Rest, Enc16, <<Acc/binary, A, B>>).

-spec enc_hex_digit_upper(0..15) ->
        $A..$F | $0..$9.
enc_hex_digit_upper(Char) when Char =< 9 ->
  Char + $0;
enc_hex_digit_upper(Char) when Char =< 15 ->
  Char + $A - 10.

-spec enc_hex_digit_lower(0..15) ->
        $a..$f | $0..$9.
enc_hex_digit_lower(Char) when Char =< 9 ->
  Char + $0;
enc_hex_digit_lower(Char) when Char =< 15 ->
  Char + $a - 10.

-spec decode(binary()) ->
        {ok, binary()} | {error, term()}.
decode(Bin) when is_binary(Bin) ->
  try
    {ok, decode(Bin, <<>>)}
  catch
    throw:{error, Reason} ->
      {error, Reason}
  end.

-spec decode(binary(), binary()) -> binary().
decode(<<>>, Acc) ->
  Acc;
decode(<<A0:8, B0:8, Rest/binary>>, Acc) ->
  A = dec_hex_char(A0),
  B = dec_hex_char(B0),
  decode(Rest, <<Acc/binary, A:4, B:4>>).

-spec dec_hex_char($A..$F | $a..$f | $0..$9) ->
        0..15.
dec_hex_char(Char) when Char >= $a, Char =< $f ->
  Char - $a + 10;
dec_hex_char(Char) when Char >= $A, Char =< $F ->
  Char - $A + 10;
dec_hex_char(Char) when Char >= $0, Char =< $9 ->
  Char - $0;
dec_hex_char(Char) ->
  throw({error, {invalid_hex_char, Char}}).

