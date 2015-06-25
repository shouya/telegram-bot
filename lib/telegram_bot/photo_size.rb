class PhotoSize < Struct.new(:id, :width, :height)
  attr_accessor :file_size

  def initialize(*args, file_size: nil)
    @file_size = file_size
  end
end
