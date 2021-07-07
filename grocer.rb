require 'pry' 
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  index = 0
  while index < collection.length do
    if name == collection[index][:item]
      return collection[index]
    end 
    index += 1
  end
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
#   new_array = []
#   index = 0 
#   while index < cart.length do
#     binding.pry
#     (cart[index][:count] = 1)
#     if car[index][:item] != 
#     else
#       cart[index][:count] += 1
#     new_array << cart[index]
#     end 
#   index += 1
#   end
# new_array
  new_array = []
  counter = 0 
  while counter < cart.length do 
    new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_array)
    if new_cart_item != nil
      new_cart_item[:count] += 1
    else
      new_cart_item = {
        :item => cart[counter][:item],
        :price => cart[counter][:price],
        :clearance => cart[counter][:clearance],
        :count => 1
      }
      new_array << new_cart_item
    end
    counter += 1
  end
  new_array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
 counter = 0 
 while counter < coupons.length 
 cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
 couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
 cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
 if cart_item && cart_item[:count] >= coupons[counter][:num]
   if cart_item_with_coupon
     cart_with_coupon[:count] += coupons[counter][:num]
     cart_with_coupon[:count] -= coupons[counter][:num]
   else 
     cart_item_with_coupon = {:item => couponed_item_name, :price => coupons[counter][:cost] / coupons[counter][:num], :count => coupons[counter][:num], :clearance => cart_item[:clearance]}
     
     cart << cart_item_with_coupon
     cart_item[:count] -= coupons[counter][:num]
   end
 end
 counter += 1
 end
  # REMEMBER: This method **should** update cart
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  index = 0 
  while index < cart.length do 
    if cart[index][:clearance] == true 
      cart[index][:price] = (cart[index][:price] * 0.8).round(2)
    end
    index += 1 
  end
  # REMEMBER: This method **should** update cart
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0
  index = 0 
  while index < final_cart.length 
    total += final_cart[index][:price] * final_cart[index][:count]
    index += 1
  end
  if total > 100 
    total -= (total * 0.10) 
  end
  total
end
