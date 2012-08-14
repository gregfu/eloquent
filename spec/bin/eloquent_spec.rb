require 'spec_helper'
describe "Feature: install workspace" do
  describe "As an author" do
    after do
      puts @err if @err
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
  end
end
