defmodule SolrWriter do
  import SweetXml

  def main(_argv) do
    result = retrieve_resources()
    IO.puts "Result is: #{result}"
  end

  def retrieve_resources() do
    {:ok, result} = download_page("https://hyphy.demo.hydrainabox.org/resourcelist")
    {:ok, picture_count} = filter_nodes(result)
    # TODO need to retrieve_doc for each of these resources.
    picture_count
  end

  defp download_page(page) do
    response = HTTPotion.get page
    {:ok, response.body}
  end

  defp filter_nodes(doc) do
    nodes = doc |> xpath(~x"//url/loc/text()"ls)
    {:ok, nodes}
  end

  # Retrieve a turtle doc
  def retrieve_doc(url) do
    response = HTTPotion.get url, headers: ["Accept": "text/turtle"]
    {:ok, response.body}
  end
end
