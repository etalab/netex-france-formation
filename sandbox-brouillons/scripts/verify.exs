# basic squeletton to parse a `.livemd` and detect dead links
# TODO: verify links
Mix.install([
  {:earmark_parser, "~> 1.4"}
])

file = __DIR__ <> "/../livebooks/3_reseau/reseau_rochefort.livemd"

markdown = File.read!(file)
{:ok, _ast, []} = EarmarkParser.as_ast(markdown)
