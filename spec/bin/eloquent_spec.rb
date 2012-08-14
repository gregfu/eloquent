require 'spec_helper'
describe "Feature: install workspace" do
  describe "As an author" do
    after do
      puts @err if @err and !@err.empty?
    end

    it "I can create a new blog" do
      in_tmp do
        @out, @err = eloquent_command "new", "new_blog"
        %w{ 
          new_blog
          new_blog/pages
          new_blog/articles
          new_blog/design
          new_blog/design/includes
          new_blog/design/layouts
          new_blog/design/scripts
          new_blog/design/styles
          new_blog/_site
        }.each do |dir|
          File.directory?(dir).must_equal true
        end

        %w{
          new_blog/_config.yml
          new_blog/design/styles/default.sass
        }.each do |file|
          File.file?(file).must_equal true
        end
      end
    end

    it "I am required to provide blog name" do
      in_tmp do
        @out, @err = eloquent_command("new")
        @out.must_match /Please provide name for your blog/
      end
    end

    it "I can display help screen" do
      in_tmp do
        @out, @err = eloquent_command("-h")
        @out.must_match /Show this message/
        @out.must_match /eloquent article/
        @out.must_match /eloquent open/
      end
    end

    describe "Article" do
      it "I can generate empty article" do
        in_tmp do
          eloquent_command "new", "foo_bar"
          Dir.chdir("foo_bar") do
            @out, @err = eloquent_command("article", "foo_bar")
            @out.must_match /Article/
            @out.must_match /has been created/
            File.file?("articles/foo_bar/foo_bar.md").must_equal true
          end
        end
      end

      it "I can't genreate article without a name"

      it "I can't generate with name that matches existing article"
    end

    describe "Layouts" do

    end

    describe "Generating site" do
      it "I can generate site" do
        in_tmp do
          eloquent_command "new" "gen"

          Dir.chdir("gen") do
            eloquent_command "layout", "default"
            eloquent_command "article", "foo"

            File.open(File.join("articles", "foo", "foo.md"), 'a+') do |f|
              f.puts("# Test")
            end

            File.open(File.join("design", "styles", "foo.css"), 'w') do |f|
              f.puts("a { color : '#ccc' }")
            end

            @out, @err = eloquent_command "generate"
            @out.must_match /Site generated/

            %w{
              _site/styles
              _site/scripts
            }.each{|dir| File.directory?(dir).must_equal true }

            %w{
              _site/styles/foo.css
              _site/styles/default.css
              _site/articles/foo.html
            }.each{|file| File.file?(file).must_equal true }

            page_content = IO.read("_site/articles/foo.html")
            page_content.must_match /Test/
            page_content.must_match /<html/

          end
        end
      end
    end

    describe "Deployment" do
      it "I can initialize a server"
      it "I can publish to a server"

      it "I can't intialize misconfigured server"
      it "I can't deploy to a  misconfigured server"
    end

    describe "Watcher" do
      it "generates html article when file has changed"
      it "notifies browser to reload when file has changed"
      it "regenerates site when layout has changed"
      it "regenerates site when layout's css has changed"
    end
  end
end
