class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true, uniqueness: true

  has_many :bookmarks, dependent: :destroy
  has_many :lists, through: :bookmarks

  before_destroy :ensure_not_referenced_by_any_bookmark

  private

  def ensure_not_referenced_by_any_bookmark
    unless bookmarks.empty?
      errors.add(:base, 'Cannot delete movie with associated bookmarks')
      throw :abort
    end
  end
end
