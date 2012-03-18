require 'spec_helper'

describe Eloquent::Article do
  it "can be initialized" do
    article = Eloquent::Article.new("title", {})
    article.should be
  end

  it "can be saved" do
    article = Eloquent::Article.new("test_title", {})
    article.save
  end

  it "can be generated from template" do
    article = Eloquent::Article.new("test_title", {:template => "foo"})
  end
end
