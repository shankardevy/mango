alias NimbleCSV.RFC4180, as: CSV
alias Mango.Catalog.Product
alias Mango.Repo

"priv/seed_data/product_list.csv"
|> File.read!
|> CSV.parse_string
|> Enum.each(fn [_, name, price, sku, is_seasonal, image, pack_size, category] ->
     is_seasonal = String.to_existing_atom(is_seasonal)
     price = Decimal.new(price)
     %Product{name: name, price: price, sku: sku, is_seasonal: is_seasonal, image: image, pack_size: pack_size, category: category}
     |> Repo.insert
end)
