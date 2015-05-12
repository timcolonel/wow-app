# Default template for the index of a resource: Render each resource in an array using the  _show partial
json.array! get_resources, partial: 'show', as: resource_name