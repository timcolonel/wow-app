class Package::Version < ActiveRecord::Base
  validates :major, presence: true
  validates :minor, presence: true
  validates :patch, presence: true
  validates :stage, presence: true

  enum stage: {alpha: 0, beta: 1, release_candidate: 2, release: 3}

  VERSION_REGEX = %r{
    \A
    (\d+)\.(\d+)\.(\d+)       # x.y.z
    (?:(?:\.|\-)([a-z]+))?    # (-|.)stage
    (?:\.(\d+))?              # .identifier
    \Z
  }ix

  def self.stage_initial
    {alpha: 'a', beta: 'b', release_candidate: 'rc', release: 'r'}
  end


  # Parse a version string.
  def self.parse(str)
    result = str.scan(Package::Version::VERSION_REGEX)
    if result.empty?
      fail ArgumentError.new("Version string '#{str}' is in the wrong format check the documentation!")
    end
    matches = result[0]
    stage = if Package::Version.stages.has_key? matches[3]
              matches[3]
            elsif Package::Version.stage_initial.has_value? matches[3]
              Package::Version.stage_initial.key(matches[3])
            else
              :release
            end
    Package::Version.new(major: matches[0],
                         minor: matches[1],
                         patch: matches[2],
                         stage: stage,
                         identifier: matches[4])

  end

  # Return the version
  def to_s(short: true, hide_release: true)
    str = [major, minor, patch].join('.')
    unless hide_release and stage.to_sym == :release
      str << "-#{short ? Package::Version.stage_initial[stage.to_sym] : stage}"
    end
    str << ".#{identifier}" unless identifier.nil?
    str
  end
end
