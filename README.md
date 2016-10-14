rails generate model products name
rails generate model orders
rails generate model purchases product:references order:references
rails generate model shipments purchases:references
