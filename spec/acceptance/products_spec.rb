require 'spec_helper'
require 'rspec_api_documentation/dsl'
require 'acceptance_helper'

resource "Products" do
  post "v1/products" do
    example "Creates products" do
      explanation 'This EP receives an array of products. If successful, returns all products and 200 OK. If fails, Unprocessable error'
      admin = User.create(
        first_name: 'Admin',
        last_name: 'User',
        email: 'dummy_user@miemail.com',
        password: '12345678',
        password_confirmation: '12345678',
        is_admin: true
      )
      header "X-API-EMAIL", admin.email
      header "X-API-TOKEN", admin.authentication_token
      do_request({ products: [{ name: 'Dummy Product', brand: 'LG', model: 'Z8', sku: '2323sdfsdf', price: 180, desc: 'Foo Bar Baz'}] })
      expect(status).to eq 200
    end
  end
  post "v1/products" do
    example "Returns meaningful error when creating malformed product" do
      admin = User.create(
        first_name: 'Admin',
        last_name: 'User',
        email: 'dummy_user@miemail.com',
        password: '12345678',
        password_confirmation: '12345678',
        is_admin: true
      )
      header "X-API-EMAIL", admin.email
      header "X-API-TOKEN", admin.authentication_token
      do_request({ products: [{ price: 200, desc: 'Foo Bar Baz'}] })
      expect(status).to eq 422
      response = JSON.parse(response_body)
      expect(response['error']).to include("Transaction failed due to")
      expect(Product.count).to eq(0)
    end
  end
  get "v1/products" do
    example "Returns all products" do
      product1 = Product.create(
        name: 'Dummy Product 1',
        brand: 'LG',
        model: 'z8',
        sku: '123098',
        price_cents: 23450
      )
      product2 = Product.create(
        name: 'Dummy Product 2',
        brand: 'Samsung',
        model: 'Galaxy S8',
        sku: '123099',
        price_cents: 49999
      )
      do_request
      expect(status).to eq 200
      response = JSON.parse(response_body)
      expect(response.first['name']).to eq('Dummy Product 1')
      expect(response.count).to eq(2)
    end
  end
end
