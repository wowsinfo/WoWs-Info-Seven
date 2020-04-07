import requests
import json

ship_names = {}
# read more ship_names.json
with open('ship_names.json', 'r', encoding='utf-8') as j:
  ship_names = json.load(j, encoding='utf-8')
  j.close()

# get data from global wiki
for key, value in ship_names.items():
  name = value['name']
  link = 'https://wiki.wargaming.net/en/Ship:' + name.replace(' ', '_')
  print(link)

# collapsibleTable0 is recommended commander skill
# b-standart-list[3] is recommended upgrade list, might have more than 1 per row
# b-standart-list[4] is consumable list, this is optional and might have more than 1 per row