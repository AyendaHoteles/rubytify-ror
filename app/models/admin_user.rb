class AdminUser < User
  default_scope { with_role(:admin) }
  has_secure_password
  after_create :set_role

  def set_role
    add_role(:admin)
  end
end