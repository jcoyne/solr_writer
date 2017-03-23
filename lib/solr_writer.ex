defmodule SolrWriter do
  alias SolrWriter.ResourceSync

  def main(argv) do
    result = ResourceSync.retrieve_resources(argv, &retrieve_doc/1)
    IO.inspect result
  end

  # Retrieve a turtle doc
  def retrieve_doc(url) do
    response = HTTPotion.get url, headers: ["Accept": "text/turtle"], follow_redirects: true
    IO.inspect response.body
    {:ok, response.body}
  end
end
