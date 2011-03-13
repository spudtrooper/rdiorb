def camel2underscores(s)
  while s.match /([A-Z]+)/
    s = s.gsub /#{$1}/,'_'+$1.downcase
  end
  s
end
