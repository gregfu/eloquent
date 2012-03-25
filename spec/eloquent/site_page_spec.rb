require 'spec_helper'

describe Eloquent::SitePage do
  it "should init with page directory" do
    in_tmp do
      pg = Eloquent::SitePage.new("articles/test")
      pg.result.should match(/<h1>Test<\/h1>/)
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

  it "should write to destination direactory"

end
