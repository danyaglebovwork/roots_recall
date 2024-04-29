class Flashback < ApplicationRecord
  include Flashbacks::Uploader::Attachment(:file)
end
