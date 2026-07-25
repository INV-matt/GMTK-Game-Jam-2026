extends Reward

const POT = preload("uid://bcxdguaoswcyf")

func give_reward():
  var pot: Pot = POT.instantiate()
  
  Qol.add_to_tree(pot) # TODO: Prevent pots from spawing one on top of the other
