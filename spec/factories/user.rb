   
FactoryBot.define do 
    factory :user do 
        username { Faker::GreekPhilosophers.name}
        password {'password'}
        factory :socrates do 
            username {'Socrates'}
        end 
    end 
end