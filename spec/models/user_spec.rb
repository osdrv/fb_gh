#encoding: utf-8

require 'spec_helper'

describe User do
  context "destroy" do
    let!(:user) { User.create!(:email => "user@example.com", :uid => "100001256148752", :provider => "facebook") }
    it "successfuly removes the record" do
      User.count.should eq 1
      user.remove.should be_true
      User.count.should eq 0
    end
  end
  
  context "save" do
    let!(:fb_user) { 
      {"identifier"=>"100001256148752", "endpoint"=>"https://graph.facebook.com/100001256148752", "access_token"=>"AAAB2glFqLZCYBAFAZAsDkjDEGf2OnWH2pbrVDylq3m0rNaGZAuBdBJNo76bnl8nWUx5fZCmH6qdgK3mlBjSY5dk2Nz7dfyOGFsmRdcyp2isEGZCkx1AL7", "name"=>"Джон Смитт", "first_name"=>"Джон", "middle_name"=>nil, "last_name"=>"Смитт", "gender"=>"male", "locale"=>"ru_RU", "languages"=>[], "link"=>"http://www.facebook.com/profile.php?id=100001256148752", "username"=>nil, "third_party_id"=>nil, "timezone"=>4, "verified"=>true, "about"=>nil, "bio"=>nil, "education"=>[], "email"=>nil, "interested_in"=>[], "political"=>nil, "favorite_teams"=>[], "quotes"=>nil, "relationship_status"=>nil, "religion"=>nil, "website"=>nil, "work"=>[], "sports"=>[], "favorite_athletes"=>[], "inspirational_people"=>[], "mobile_phone"=>nil, "updated_time"=>"2011-10-26 11:57:40 UTC"}
    }
    let!("provider") { "facebook" }
    
    it "find no user by fb_uid and provider" do
      User.where(:uid => fb_user["identifier"], :provider => provider).count.should eq 0
    end
    
    it "initializes a new User instance with fb_uid && provider" do
      u = User.find_or_initialize_by(:provider => provider, :uid => fb_user["identifier"])
      u.new?.should be_true
      u.provider.should eq provider
      u.uid.should eq fb_user["identifier"]
    end
  end
end
