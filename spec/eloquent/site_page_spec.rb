require 'spec_helper'

describe Eloquent::SitePage do
  around(:each) do |example|
    in_tmp do
      copy_fixture_articles
      example.run
      clean_fixture_articles
    end
  end
  
  it "should init with page directory" do
    pending
    in_tmp do
      pg = Eloquent::SitePage.new("articles/test")
      pg.result.should match(/<h1>Test<\/h1>/)
    end
  end

  it "detects file" do
    in_tmp do
      pg = Eloquent::SitePage.new("articles/test")
      pg.article_file.should == "articles/test/test.md"
    end
  end

  it "has file alternatives" do
    pg = Eloquent::SitePage.new("articles/test")
    pg.file_alternatives.should include("test.md")
    pg.file_alternatives.should include("test.haml")
  end

  it "has supported formats" do
    pg = Eloquent::SitePage.new("articles/test")
    pg.supported_formats.should include("md")
    pg.supported_formats.should include("haml")
  end

  it "should read contents" do
    pg = Eloquent::SitePage.new("articles/test")
    pg.contents.should match(/title/)
  end

  it "should have header" do
    pg = Eloquent::SitePage.new("articles/test")
    pg.header["title"].should == "foo_bar"
  end

  it "has body" do
    pg = Eloquent::SitePage.new("articles/test")
    pg.body.should match(/Test/)
  end

  it "writes to the destination directory" do
    in_tmp do
      pg = Eloquent::SitePage.new("articles/test")
      pg.result.should match(/<h1>Test<\/h1>/)
    end
  end

end
