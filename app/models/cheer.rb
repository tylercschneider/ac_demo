class Cheer
  def self.for(name)
    "Go, #{name || "team"}!"
  end

  def self.loud(name)
    self.for(name).upcase
  end
end
