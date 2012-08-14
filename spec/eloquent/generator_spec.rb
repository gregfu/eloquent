require 'spec_helper'

describe Eloquent::Generator do
  let(:config) do
    {
      "generator" => {
        "site" => "_site",
        "articles" => "articles",
      }
    }
  end

  let(:gen) { Eloquent::Generator.new(config) }

  before{ in_tmp { copy_fixture_articles } }
  after { in_tmp { clean_fixture_articles } }
  

  it "can init" do
    gen.site.must_equal "_site"
  end

  it "has articles dst" do
    gen.articles_dst.must_equal "_site/articles"
  end

  it "can enumerate articles" do
    in_tmp do
      gen.articles.must_be_kind_of Array
    end
  end

  it "can generate article" do
    skip "verification"
    in_tmp do
      gen.generate!
      # verify things got generated ...
    end
  end
end
