FactoryBot.define do
  factory :job do
    job_id { "MyString" }
    user { nil }
    started_at { "2019-03-24 13:21:54" }
    finished_at { "2019-03-24 13:21:54" }
    kind { 1 }
  end
end
