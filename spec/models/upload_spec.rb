# == Schema Information
#
# Table name: uploads
#
#  id         :integer         not null, primary key
#  type       :string(255)
#  url        :string(255)
#  title      :string(255)
#  about      :string(255)
#  user_id    :integer
#  embedid    :string(255)
#  view       :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Upload do
  pending "add some examples to (or delete) #{__FILE__}"
end
