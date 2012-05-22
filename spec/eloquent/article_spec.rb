require 'spec_helper'

describe Eloquent::Article do
  let(:article_class) { Eloquent::Article }

  it "can be initialized" do
    article = article_class.new("title", {})
    article.should be
  end

  it "can be saved" do
    article = article_class.new("test_title", {})
    article.save.should be
  end

  it "can be generated from template" do
    article = article_class.new("test_title", {:template => "foo"}).save
    File.exist?(article.output_file).should be
  end
end
