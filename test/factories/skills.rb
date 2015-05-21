FactoryGirl.define do
  factory :skill do
    modifier 1
    master_skill {MasterSkill.find_by(name: "Stealth")}
  end
end
