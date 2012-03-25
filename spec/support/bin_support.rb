module BinSupport
  FIXTURES = File.expand_path("../../fixtures", __FILE__)
  def create_tmp_if_needed
    FileUtils.mkdir_p(TMP_DIR) unless File.exists?(TMP_DIR)
  end

  def in_tmp
    create_tmp_if_needed
    Dir.chdir(TMP_DIR) do
      yield if block_given?
    end
  end

  def in_blog(name)
    Dir.chdir(name) do
      yield if block_given?
    end
  end

  def bin_file
    File.join(BIN_DIR, "eloquent")
  end

  def file(*elems)
    File.file?(File.join(*elems))
  end

  def dir(*elems)
    File.directory?(File.join(*elems))
  end

  def eloquent_bin(*args)
    options = *args
    cmd = ([bin_file] + options).join(" ")
    Open3.capture3(cmd)
  end

  def cleanup(dir)
    to_remove = File.join(TMP_DIR, dir)
    FileUtils.rm_rf(to_remove)
  end

  def article(title)
    IO.read("articles/#{title}/#{title}.md")
  end

  def site_article(title)
    IO.read("_site/#{title}.html")
  end

  def next_blog_name
    @counter ||= 0
    @counter += 1
    "new_blog_#{@counter}"
  end

  def copy_fixture_articles
    FileUtils.cp_r(File.join(FIXTURES, 'articles'), '.')
  end

  def clean_fixture_articles
    FileUtils.rm_rf('articles')
  end
end
