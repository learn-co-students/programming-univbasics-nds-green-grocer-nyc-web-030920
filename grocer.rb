def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  collection.each do |item|
    if item[:item] == name
      return item
    end
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  consolidated = []
  cart.each do |item|
    if find_item_by_name_in_collection(item[:item], consolidated)
      find_item_by_name_in_collection(item[:item], consolidated)[:count] += 1
    else
      item[:count] = 1
      consolidated << item
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons_hash = {}
  coupons.each do |coupon|
    coupons_hash[coupon[:item]] = coupon
  end

  cart.each do |item|
    if coupons_hash[item[:item]]
      coupon = coupons_hash[item[:item]]
      item[:count] -= coupon[:num]
      cart << {item: "#{item[:item]} W/COUPON", price: coupon[:cost]/coupon[:num], clearance: item[:clearance], count: coupon[:num]}
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance]
      item[:price] = (item[:price]*0.8).round(2)
    end
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  # puts cart
  sum = 0
  cart.each do |item|
    sum += (item[:price] * item[:count])
  end
  if sum > 100
    sum = (sum * 0.9).round(2)
  end
  sum
end
