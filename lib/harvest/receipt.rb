module Harvest
  # The model that contains information about a task
  #
  # == Fields
  # [+url+] URL file
  # [+file_name+] file name
  # [+file_size+] size of the image
  # [+content_type+] image/gif
  class Receipt < Hashie::Mash
    include Harvest::Model
  end
end
