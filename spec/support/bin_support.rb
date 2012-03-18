module BinSupport
  def create_tmp_if_needed
    FileUtils.mkdir_p(TMP_DIR) unless File.exists?(TMP_DIR)
  end

  def in_tmp
    create_tmp_if_needed
    Dir.chdir(TMP_DIR) do
      yield if block_given?
    end
  end

  def bin_file
    File.join(BIN_DIR, "eloquent")
  end

  def file(name)
    File.file?(name)
  end

  def dir(name)
    File.directory?(name)
  end

  def eloquent_bin(*args)
    options = *args
    cmd = ([bin_file] + options).join(" ")
    Open3.capture3(cmd)
  end

  def cleanup(dir)
    FileUtils.rm_rf(dir)
  end
end
