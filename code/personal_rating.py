import requests
import os
import datetime

link = 'https://wows-numbers.com/personal/rating/expected/json/'
res = requests.get(link)
if res.status_code == 200:
  # override
  with open('../json/personal_rating.json', 'w+', encoding='utf-8') as f:
    f.write(res.text + '\n')
    f.close()

  print("Write to personal_rating.json")
  os.system("git commit -am 'update personal rating - {}'".format(datetime.datetime.now()))
else:
  exit("Status Code wasn't 200 OK")