class GoodSituation < ApplicationRecord
  def self.t(situation)
    I18n.t "activerecord.attributes.good/situations.#{situation}"
  end
end
