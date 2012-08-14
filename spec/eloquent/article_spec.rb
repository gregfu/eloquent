require 'spec_helper'

describe Eloquent::Article do
  let(:article_class) { Eloquent::Article }

  it "can be initialized" do
    article = article_class.new("title", {})
    assert article
  end

  it "can be saved" do
    article = article_class.new("test_title", {})
    assert article.save
  end

  it "can be generated from template" do
    article = article_class.new("test_title", {:template => "foo"}).save
    assert File.exist?(article.output_file)
  end
end
