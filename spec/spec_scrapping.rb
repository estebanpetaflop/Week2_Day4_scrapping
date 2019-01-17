
#spec scrapping currencies
require 'rspec'
require_relative '../lib/scrapping.rb'
include RSpec

describe "the crypto_scrapper method" do
  it "should return an array" do
    expect(crypto_scrapper).to be_an_instance_of(Array)
  end
  it "should return a not empty array" do
    expect(deputee_scrapper).not_to be_empty
  end
  it "should return the usual currencies" do
    A=crypto_scrapper()
    expect(A[0].keys[0]).to eq("Bitcoin")
  end
  it "should return a float for BTC" do
    A=crypto_scrapper()
    expect(A[0].values_at("Bitcoin")[0]).to be_a(Float)
  end
end

#--------------------------------------
#spec cityhalls

describe "the cityhallo_scrapper method" do
  it "should return an array" do
    expect(cityhall_scrapper).to be_an_instance_of(Array)
  end
  it "should return a not empty array" do
    expect(cityhall_scrapper).not_to be_empty
  end

  it "should return the first city" do
    A=cityhall_scrapper()
    expect(A[0].keys[0]).to eq("ABLEIGES")
  end
  it "should return mairie.ableiges95@wanadoo.fr" do
    A=cityhall_scrapper()
    expect(A[0].values_at("ABLEIGES")[0]).to eq("mairie.ableiges95@wanadoo.fr")
  end
end

#--------------------------------------
#spec deputes

describe "the deputee_scrapper method" do
  it "should return an array" do
    expect(deputee_scrapper).to be_an_instance_of(Array)
  end
  it "should return a not empty array" do
    expect(deputee_scrapper).not_to be_empty
  end
  # it "should return the string first name" do
  #   A=deputee_scrapper()
  #   expect(A[0][0].keys[0]).to eq("first_name")
  # end
  # it "should return Damien" do
  #   A=deputee_scrapper()
  #   expect(A[0][0].keys[0].values_at).to eq("Damien")
  # end
end
