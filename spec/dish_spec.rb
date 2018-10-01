require_relative 'spec_helper'

describe 'Dish' do

  let(:alices_restaurant) {Restaurant.create(:name => "Alice's Restaurant")}

  let(:italian) {Tag.create(:name => "italian")}

  let!(:pizza) {Dish.create(:name => "pizza", :tags => [italian], :restaurant => alices_restaurant)}
  let!(:pasta) {Dish.create(:name => "pasta", :tags => [italian], :restaurant => alices_restaurant)}

  it "has a name" do 
    expect(pizza.name).to eq("pizza")
  end
  
  it "has associated tags in an array" do
    expect(pizza.tags).to include(italian)
    expect(italian.dishes).to include(pizza)
  end
  
  it "validates that name is present" do 
    expect(Dish.new(:name => nil, :restaurant => alices_restaurant).valid?).to be false
    expect(Dish.new(:name => "Pizza", :restaurant => alices_restaurant).valid?).to be true
  end
  
  it "validates that restaurant is present" do 
    expect(Dish.new(:name => "Pizza", :restaurant => nil).valid?).to be false
    expect(Dish.new(:name => "Pizza", :restaurant => alices_restaurant).valid?).to be true
  end
  
  it "invokes the validations associated with DishTag" do 
    # Somehow we need to verify here that the valitations on DishTag are actually
    # checked whenever we add a tag to a dish.
  end

  describe 'Dish.names' do

    it 'returns an array of all dish names' do
      expect(Dish.names).to contain_exactly("pizza", "pasta")
    end

  end

end
