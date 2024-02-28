class ImportBlogsCsvJob < ApplicationJob
  queue_as :default

  def perform(file, user_id)
    user = User.find_by(id: user_id)
    return unless user

    data = CSV.parse(file.to_io, headers: true, encoding: 'utf8')
    ActiveRecord::Base.transaction do
      data.each do |row|
        current_user.blogs.create!(row.to_h)
      end
    end
  end
end
