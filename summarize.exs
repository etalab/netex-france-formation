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

    zip
    |> list_zip_entries()
    |> Enum.reject(&String.ends_with?(&1, "/"))
    |> Enum.each(fn entry ->
      IO.puts("== #{entry} ==")

      zip
      |> read_entry!(entry)
      |> string_to_xmerl!()
      |> xpath!("//GeneralFrame")
      |> Enum.each(fn general_frame ->
        general_frame
        |> xpath!("members/*")
        |> count_xmerl_elements!()
        |> IO.inspect(IEx.inspect_opts())
      end)
    end)
  end
end
