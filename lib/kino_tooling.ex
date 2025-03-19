defmodule Tooling do
  # TODO: automatically infer `basedir` using `__CALLER__` instead
  def file(path, basedir) do
    basedir
    |> Path.join(path)
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
