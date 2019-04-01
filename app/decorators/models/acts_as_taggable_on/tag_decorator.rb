ActsAsTaggableOn::Tag.class_eval do 
  validates :name, presence: true, format: { with: %r{\A[^ \+-]+\z}, message: "Please enter tags in correct format"} 
end