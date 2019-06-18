# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class AdminUser < User
  default_scope { with_role(:admin) }
  after_create :set_role

  def set_role
    add_role(:admin)
  end
end
