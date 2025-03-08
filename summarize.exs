Mix.install([
  {:unzip, "~> 0.12.0"}
])

ExUnit.start()

Code.require_file("lib/zip_support.ex")
Code.require_file("lib/xml_support.ex")
Code.require_file("lib/helpers.ex")

defmodule TestCase do
  use ExUnit.Case

  @input __DIR__ <> "/data/ca_rochefort_ocean-aggregated-netex-2025-03-03.zip"

  import Helpers
  import ZipSupport
  import XmlSupport

  test "it dumps all" do
    zip = open_zip!(@input)
    entries = zip |> list_zip_entries()

    entries
    |> Enum.reject(&String.ends_with?(&1, "/"))
    |> Enum.each(fn entry ->
      IO.puts("== #{entry} ==")

      content = read_entry!(zip, entry)
      xmerl = string_to_xmerl!(content)

      general_frames = xpath!(xmerl, "//GeneralFrame")

      general_frames
      |> Enum.each(fn general_frame ->
        count_xmerl_elements!(general_frame, "members/*")
        |> IO.inspect(IEx.inspect_opts())
      end)
    end)
  end
end
