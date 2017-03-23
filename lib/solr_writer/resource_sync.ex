defmodule SolrWriter.ResourceSync do
  import SweetXml

  # extracts the uris from the given resource_list_uri and runs the function f
  # on each of them
  def retrieve_resources(resource_list_uri, f) do
    {:ok, result} = download_page(resource_list_uri)
    {:ok, picture_count} = filter_nodes(result)
    Enum.map(picture_count, f)
  end

  defp download_page(page) do
    response = HTTPotion.get page
    {:ok, response.body}
  end

  defp filter_nodes(doc) do
    nodes = doc |> xpath(~x"//url/loc/text()"ls)
    {:ok, nodes}
  end
end
