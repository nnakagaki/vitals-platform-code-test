require 'award'

def update_quality(awards)
  blues = ['Blue First', 'Blue Compare']

  awards.each do |award|
    next if award.name == 'Blue Distinction Plus'

    if !blues.include?(award.name)
      remove_quality(award)
      blue_star_reduction(award)
      if award.expires_in <= 0
        remove_quality(award)
        blue_star_reduction(award)
      end
    else
      add_quality(award)
      if award.name == 'Blue First' && award.expires_in <= 0
        add_quality(award)
      elsif award.name == 'Blue Compare'
        if award.expires_in <= 0
          award.quality = 0
        elsif award.expires_in < 6
          2.times { add_quality(award) }
        elsif award.expires_in < 11
          add_quality(award)
        end
      end
    end

    award.expires_in -= 1
  end
end

def add_quality(award)
  if award.quality < 50
    award.quality += 1
  end
end

def remove_quality(award)
  if award.quality > 0
    award.quality -= 1
  end
end

def blue_star_reduction(award)
  if award.name == 'Blue Star'
    remove_quality(award)
  end
end
