class ApiFile < ApplicationRecord
  acts_as_taggable
  validates_presence_of :name, :tag_list

  paginates_per 10

  validate :validate_tags

  def validate_tags
    tag_list.each do |tag|
      errors.add(:tag_list, "Please enter the tags in the right format") unless tag =~ %r{\A[^ \+-]+\z}
    end
  end
end