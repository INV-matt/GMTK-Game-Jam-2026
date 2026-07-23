extends Node
class_name SeedMngr

var seeds: Dictionary[PlantResource, int] = {}

func add_seed(plant: PlantResource) -> void:
  if plant in seeds:
    seeds[plant] += 1
  else:
    seeds[plant] = 1
  
  print(seeds)

func remove_seed(plant: PlantResource) -> void:
  if plant in seeds and seeds[plant] > 0:
    seeds[plant] -= 1
  
  print(seeds)
