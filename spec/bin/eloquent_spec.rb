require "spec_helper"

describe "Feature: install workspace." do
  describe "As a system user" do
    after(:each) do
      puts @err if @err
    end

    it "I can isntall basic workspace" do
      cleanup("new_blog")

      in_tmp do
        @out, @err = eloquent_bin("new", "new_blog")
        @out.should =~ /Eloquent/
        dir("new_blog").should be
        dir("new_blog/pages").should be
        dir("new_blog/articles").should be
        dir("new_blog/design").should be
        dir("new_blog/design/includes").should be
        dir("new_blog/design/layouts").should be
        dir("new_blog/design/scripts").should be
        dir("new_blog/design/styles").should be

        dir("new_blog/_site").should be
        file("new_blog/_config.yml").should be
        file("new_blog/design/styles/default.sass").should be
      end
    end

    it "I am worned if I haven't provided name for the blog" do
      @out, @err = eloquent_bin("new")
      @out.should =~ /Please provide name for your blog/
    end

    it "I can run in verbose mode" do
      pending "needs command"
      in_tmp do
        @out, @err = eloquent_bin("-v")
        @out.should =~ /verbose mode/
      end
    end

    it "I can display help screen" do
      in_tmp do
        @out, @err = eloquent_bin("-h")
        @out.should =~ /Show this message/
        @out.should =~ /eloquent article/
        @out.should =~ /eloquent open/
      end
    end

    it "I can generate empty post" do
      in_tmp do
        @out, @err = eloquent_bin("article", "foo_bar")
        @out.should match("Article")
        @out.should match("has been created")
      end
    end

    it "I see warning when I don't provide article name" do
      @out, @err = eloquent_bin("article")
      @out.should match(/provide article name/)
    end

    it "I can generate site" do
      in_tmp do
        @out, @err = eloquent_bin("new", "gen")
        Dir.chdir("gen") do
          eloquent_bin("layout", "default")
          eloquent_bin("article", "foo")

          File.open(File.join("articles", "foo", "foo.md"), 'a+') do |f|
            f.puts("# Test")
          end

          @out, @err = eloquent_bin("generate")
          @out.should match(/Site generated/)

          dir("_site/styles").should be
          dir("_site/scripts").should be
          file("_site/styles/default.css").should be

          page_content = IO.read("_site/articles/foo.html")
          page_content.should match(/Test/)
          page_content.should match(/<html/)
        end
      end
    end

    it "I can generate layout" do
      in_tmp do
        @out, @err = eloquent_bin "layout", "default"
        data = IO.read("design/layouts/default.html.haml")
        data.should match(/!!! 5/)
        data.should match(/%html/)
        data.should match(/%head/)
        data.should match(/%title/)
        data.should match(/%body/)
      end
    end

    it "I can install on a server"
    it "I can publish to server"

    describe "when server not configured" do
      it "I am notified intallation is not possible"
      it "I am notified publication is not possible"
    end
  end
end

describe "Feature: create post" do
  around(:each) do |example|
    @blog_name = next_blog_name
    example.run
    cleanup(@blog_name)
  end

  it "I can generate empty page" do
    in_tmp do
      eloquent_bin("new", @blog_name)
      in_blog(@blog_name) do
        eloquent_bin("post", "new-post")

        dir("articles", "new-post").should be 
        dir("articles", "new-post", "assets").should be 
        file("articles", "new-post", "new-post.md").should be
        article("new-post").should =~ /title/
      end
    end
  end
end

describe "Feature: generate site" do
  around(:each) do |example|
    @blog_name = next_blog_name
    example.run
    cleanup(@blog_name)
  end

  it "I can generate html" do
    pending
    in_tmp do
      eloquent_bin("new", @blog_name)
      in_blog(@blog_name) do
        eloquent_bin("post", "new_post")
        pp eloquent_bin("generate")
        site_article("new-post").tap do |a|
          a.should =~ /<title>/
          a.should =~ /<body>/
          a.should =~ /published/
        end
      end
    end
  end
end

