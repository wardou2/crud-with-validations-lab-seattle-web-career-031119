class Song < ApplicationRecord
  validates :title, presence: :true
  validates :release_year, presence: :true, if: :released
  validate :release_year_not_in_future
  validate :same_song_same_year

  def release_year_not_in_future
    if self.release_year.to_i > Time.now.year.to_i
      errors.add(:release_year, 'Cannot be in the future')
    end
  end

  def same_song_same_year
    song_w_title = Song.find_by(title: title)
    if !song_w_title.nil? && (song_w_title.release_year == self.release_year)
      errors.add(:title, "Cannot release same song in same year")
    end
  end
end
