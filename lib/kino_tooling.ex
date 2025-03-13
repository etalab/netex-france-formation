defmodule Tooling do
  def file(path) do
    (__DIR__ <> "/../" <> path)
    |> File.read!()
  end

  def xml(content) do
    Kino.Markdown.new("""
    ```xml
    #{content}
    ```
    """)
  end
end
