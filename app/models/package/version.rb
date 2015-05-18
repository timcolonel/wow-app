class Package::Version < ActiveRecord::Base
  validates :major, presence: true
  validates :minor, presence: true
  validates :patch, presence: true
  validates :stage, presence: true

  enum stage: {alpha: 0, beta: 1, release_candidate: 2, release: 3}

  def stage_initial
    {alpha: 'a', beta: 'b', release_candidate: 'rc', release: 'r'}
  end

  def to_s
    str = [major, minor, patch].join('.')
    str << "-#{stage_initial[stage.to_sym]}" if stage.to_sym != :release
    str << ".#{identifier}" unless identifier.nil?
    str
  end
end
