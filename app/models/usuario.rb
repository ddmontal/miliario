class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :inicia
  has_many :realiza
  has_many :utiliza
  has_many :caminos, through: :inicia
  has_many :etapas, through: :realiza
  has_many :servicios, through: :utiliza

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :alias,
    exclusion: { in: %w(root admin), message: I18n.t('valor_reservado') },
    uniqueness: true,
    presence: true,
    :unless => :super_user?

  def super_user?
    self.admin && self.alias == 'admin'
  end

  def admin?
    self.admin
  end

end
