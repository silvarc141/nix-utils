# When migrating from 25-05, replace this with the nixpkgs' original.
{lib}: str:
lib.throwIfNot (lib.isString str) "toCamelCase does only accepts string values, but got ${builtins.typeOf str}" (
  let
    inherit (lib) splitStringBy match head tail toLower length toSentenceCase elem concatStrings addContextFrom;
    separators =
      splitStringBy (
        prev: curr:
          elem curr [
            "-"
            "_"
            " "
          ]
      )
      false
      str;

    parts = lib.flatten (
      map (splitStringBy (
          prev: curr: match "[a-z]" prev != null && match "[A-Z]" curr != null
        )
        true)
      separators
    );

    first =
      if length parts > 0
      then toLower (head parts)
      else "";
    rest =
      if length parts > 1
      then map toSentenceCase (tail parts)
      else [];
  in
    concatStrings (map (addContextFrom str) ([first] ++ rest))
)
