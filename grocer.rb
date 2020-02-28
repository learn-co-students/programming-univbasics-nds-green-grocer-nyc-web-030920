require 'pry'
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  collection.each do |hash|
    if hash[:item] == name 
      return hash
    end
  end
  return nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  count = 0
  new_array = []
  while count < cart.length
    temp_name = cart[count][:item]
    found_item = find_item_by_name_in_collection(temp_name, new_array)
    if found_item
      found_item[:count] += 1
    else
      cart[count][:count] = 1
      new_array << cart[count]
    end 
    count += 1  
  end
  new_array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  # binding.pry
  new_cart = []
  cart.each do |cart_hash|
    coupons.each do |coupon_hash|
      if coupon_hash[:item] == cart_hash[:item]
        if coupon_hash[:num] == cart_hash[:count]
          # binding.pry
          new_hash = cart_hash.clone
          new_hash[:count] = 0
          new_cart << new_hash
          cart_hash[:item] = cart_hash[:item] + " W/COUPON"
          cart_hash[:price] = coupon_hash[:cost] / coupon_hash[:num] 
        elsif coupon_hash[:num] < cart_hash[:count]
          cart_hash[:count] -= coupon_hash[:num]
          new_hash = cart_hash.clone
          new_hash[:item] = new_hash[:item] + " W/COUPON"
          new_hash[:price] = coupon_hash[:cost] / coupon_hash[:num]
          new_hash[:count] = coupon_hash[:num]
          cart << new_hash
        end
      end
    end
  end
  # binding.pry
  cart << new_cart[0] if new_cart[0]
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |hash|
    if hash[:clearance] == true
      hash[:price] = hash[:price] * 0.8
    end
  end
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
  total = 0
  cons_cart = consolidate_cart(cart)
  # binding.pry
  new_cart = apply_clearance(apply_coupons(cons_cart, coupons))
  # binding.pry
  new_cart.each do |hash|
    total += hash[:price] * hash[:count]
  end
  total > 100 ? total = total * 0.9 : nil
  total = '%.1f' % total
  return total.to_f
end