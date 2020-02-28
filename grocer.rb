def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  search_index = 0
  while search_index < collection.count do

    if name == collection[search_index][:item]
      return collection[search_index]
    else
      match = false
    end
      
    search_index += 1
  end
  
  if match == false
    return nil
  end
  
end

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
def consolidate_cart(array_of_item_hashes)
        
    cons_cart = {}
    index = 0

    while index < array_of_item_hashes.count do

      cart_item = find_item_by_name_in_collection(array_of_item_hashes[index][:item], array_of_item_hashes)
             
      cons_cart[index] = cart_item
            
      cons_cart[index][:count] = 0

      search_index = 0

      while search_index < array_of_item_hashes.count do

        if cons_cart[index][:item] == array_of_item_hashes[search_index][:item]
          cons_cart[index][:count] += 1
          #array_of_item_hashes.delete_at(search_index) --don't need this apparently?
        end
        search_index += 1
      end

      index += 1
    end
    return cons_cart
end


def apply_coupons(cart, coupons)
  
  #consolidating the passed item array
  #cart = consolidate_cart(cart)
  
  #initializing the new array that will hold items and items w/ coupons
  clearance_cart = cart
  
  coup_index = 0
  while coup_index < coupons.count do
    
    item_w_coupon = {}
    cart_index = 0
    
    while cart_index < cart.count do
      
      if coupons[coup_index][:item] == cart[cart_index][:item]
        
        #create a new hash
        clearance_cart[clearance_cart.count] = {
          :item => "#{coupons[coup_index][:item]} W/COUPON",
          :price => coupons[coup_index][:cost] / coupons[coup_index][:num],
          :clearance => cart[cart_index][:clearance],
          :count => coupons[coup_index][:num]
        }
        
      # item_w_coupon[:item] = "#{coupons[coup_index][:item]} W/COUPON"
      # item_w_coupon[:price] = coupons[coup_index][:cost] / coupons[coup_index][:num]
      # item_w_coupon[:clearance] = true
      # item_w_coupon[:count] = coupons[coup_index][:num]
        
        #update the cart array's num attribute
        if cart[cart_index][:count] >= coupons[coup_index][:num]
          cart[cart_index][:count] -= coupons[coup_index][:num]
          #if cart[cart_index][:count] == 0
            #clearance_cart.delete_at(cart_index)
          #end
        end
        
        #add the new item w/ coupon hash to the cleaerance_cart
        #clearance_cart.push(item_w_coupon)
        
      end #end of if
      
      cart_index += 1
      
    end #end of cart loop
    
    coup_index += 1
    
  end #end of coupons loop
  
  return clearance_cart
  
  
  
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  
  index = 0
  
  while index < cart.count do
    
    if cart[index][:clearance] == true
      cart[index][:price] = (cart[index][:price]*0.80).round(2)
    end
    
    index += 1
  end
  
  return cart
  
  
  
  
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  
  consolidated_cart = consolidate_cart(cart)
  coupon_applied_cart = apply_coupons(consolidated_cart, coupons)
  clearance_applied_cart = apply_clearance(coupon_applied_cart)
  
  #Find the total by iterating through the final cart - 
	# --multiply each item hash's price by its count
	# ---accumulate in a total variable
	# ----return total
	
	index = 0
	total = 0
	
	while index < clearance_applied_cart.count do
	  
	  total += clearance_applied_cart[index][:price] * clearance_applied_cart[index][:count]
	  
	  index += 1
	 end
	 
	#If total is over $100, take additional 10% off the total
	if total > 100
	  total *= 0.90
	end
  
  return total
  
  
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
