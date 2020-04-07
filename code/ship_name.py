import requests
import json
from key import api_key

page_no = 1
more_data = True
# stores all ship names
ship_name = {}

while more_data:
  link = "https://api.worldofwarships.asia/wows/encyclopedia/ships/?application_id={}&fields=name&language=en&page_no={}".format(api_key, page_no)
  res = requests.get(link)
  if res.status_code == 200:
    j = res.json()
    if j['status'] == 'ok':
      ship_name.update(j['data'])
      if j['meta']['page_total'] > page_no:
        page_no += 1
      else:
        more_data = False
    else:
      more_data = False
  
# without correct encoding, it write weird things
with open('ship_names.json', 'w+', encoding='utf-8') as f:
  # encode as utf-8
  f.write(json.dumps(ship_name))
  f.close()