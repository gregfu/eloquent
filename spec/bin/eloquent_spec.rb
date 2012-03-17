require "spec_helper"

describe "Feature: install workspace." do
  describe "As a system user" do
    after(:each) do
      puts @err if @err
    end

    it "I can isntall basic workspace" do
      in_tmp do
        @out, @err = eloquent_bin
        @out.should =~ /Eloquent/
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

