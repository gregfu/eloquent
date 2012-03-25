require 'spec_helper'

describe Eloquent::Generator do
  around(:each) do |example|
    @config = {
      "generator" => {
        "site" => "_site",
        "articles" => "articles",
      }
    }

    in_tmp do
      copy_fixture_articles
      example.run
      clean_fixture_articles
    end

  end
  
  it "can init" do
    gen = Eloquent::Generator.new(@config)
    gen.site.should == "_site"
  end

  it "has articles dst" do
    gen = Eloquent::Generator.new(@config)
    gen.articles_dst.should == "_site/articles"
  end

  it "can enumerate articles" do
    in_tmp do
      gen = Eloquent::Generator.new(@config)
      gen.articles.should be_a(Array)
    end
  end

  it "can generate article" do
    in_tmp do
      gen = Eloquent::Generator.new(@config)
      gen.generate!
    end
  end
end
