# require 'httparty'
require './lib/requestor'
class Customer
  include Requestor
  extend Requestor
  include HTTParty
  include ActiveModel::Validations
  include StaticError
  include ActiveModel::Model

  attr_accessor :id,
  :email,
  :user_name,
  :date_of_birth,
  :gender,
  :phone_number

  def set_parameters
    {user: as_json}
  end

  def self.find(id)
    request("get", "#{url(path)}" + id.to_s)
  end

  def self.all(attributes = {})
    @parameters = attributes
    request("get", "#{url(path)}")
  end

  def self.create(attributes = {})
    new(attributes).save
  end

  def update(attributes = {})
    self.attributes = attributes
    self.save
  end

  def save
    @parameters = set_parameters
    if persisted?
      request("patch", "#{url(path)}" + id.to_s)
    else
      request("post", "#{url(path)}")
    end
  end

  def destroy
    request("delete", "#{url(path)}" + id.to_s)
  end

  def persisted?
    self.id.present?
  end
end
