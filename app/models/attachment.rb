class Attachment < ApplicationRecord
  belongs_to :project

  has_attached_file :image,
                styles: { thumb: ["64x64#", :jpg],
                          original: ['500x500>', :jpg] },
                convert_options: { thumb: "-quality 75 -strip",
                                   original: "-quality 85 -strip" },
                storage: :s3,
                s3_credentials: {access_key_id: ENV["AWS_KEY"], secret_access_key: ENV["AWS_SECRET"]},
                bucket: ENV["YOUR_BUCKET"],
                :url =>':s3_domain_url',
                :path => '/:class/:attachment/:id_partition/:style/:filename'

validates_attachment :image,
                   content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }


end
