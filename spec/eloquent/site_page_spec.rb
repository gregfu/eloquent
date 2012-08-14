require 'spec_helper'

describe Eloquent::SitePage do
  before do
    in_tmp do
      copy_fixture_articles
    end
  end

  after do
    in_tmp do
      clean_fixture_articles
    end
  end
  
  it "should init with page directory" do
    skip
    in_tmp do
      pg = Eloquent::SitePage.new "articles/test"
      pg.result.must_match /<h1>Test<\/h1>/
    end
  end

  it "detects file" do
    in_tmp do
      pg = Eloquent::SitePage.new "articles/test"
      pg.article_file.must_equal "articles/test/test.md"
    end
  end

  it "has file alternatives" do
    pg = Eloquent::SitePage.new "articles/test"
    pg.file_alternatives.must_include "test.md"
    pg.file_alternatives.must_include "test.haml"
  end

  it "has supported formats" do
    pg = Eloquent::SitePage.new "articles/test"
    pg.supported_formats.must_include "md"
    pg.supported_formats.must_include "haml"
  end

  it "should read contents" do
    in_tmp do
      pg = Eloquent::SitePage.new "articles/test"
      pg.contents.must_match /title/ 
    end
  end

  it "should have header" do
    in_tmp do
      pg = Eloquent::SitePage.new "articles/test"
      pg.header["title"].must_equal "foo_bar"
    end
  end

  it "has body" do
    in_tmp do
      pg = Eloquent::SitePage.new "articles/test"
      pg.body.must_match /Test/
    end
  end

  it "writes to the destination directory" do
    in_tmp do
      pg = Eloquent::SitePage.new "articles/test"
      pg.result.must_match /<h1>Test<\/h1>/
    end
  end

end
