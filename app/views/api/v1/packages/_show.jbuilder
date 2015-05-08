json.id package.id
json.name package.name
json.homepage package.homepage
json.short_description package.short_description
json.description package.description
json.url api_package_url(package)
# json.html_url package_url(package)
json.authors package.authors, partial: 'api/v1/packages/authors/show', as: :author
json.tags package.tags.map(&:name)