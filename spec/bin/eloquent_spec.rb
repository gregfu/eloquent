require "spec_helper"

describe "Feature: install workspace." do
  describe "As a system user" do
    after(:each) do
      puts @err if @err
    end

    it "I can isntall basic workspace" do
      in_tmp do
        @out, @err = eloquent_bin("new", "new_blog")
        @out.should =~ /Eloquent/
        dir("new_blog").should be
        dir("new_blog/pages").should be
        dir("new_blog/articles").should be
        dir("new_blog/design").should be
        dir("new_blog/design/includes").should be
        dir("new_blog/design/layouts").should be

        dir("new_blog/_site").should be
        file("new_blog/_config.yml").should be

        cleanup("new_blog")
      end
    end

    it "I can run in verbose mode" do
      in_tmp do
        @out, @err = eloquent_bin("-v")
        @out.should =~ /verbose mode/
      end
    end

    it "I can display help screen" do
      in_tmp do
        @out, @err = eloquent_bin("-h")
        @out.should =~ /Show this message/
      end
    end
    it "I can generate site"
    it "I can install on a server"
    it "I can publish to server"
    it "I can generate empty page"
    it "I can generate empty post"
    it "I can generate simple template"

    describe "when server not configured" do
      it "I am notified intallation is not possible"
      it "I am notified publication is not possible"
    end
  end
end

