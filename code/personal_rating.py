import requests

link = 'https://wows-numbers.com/personal/rating/expected/json/'
res = requests.get(link)
if res.status_code == 200:
  # override
  with open('../json/personal_rating.json', 'w+', encoding='utf-8') as f:
    f.write(res.text + '\n')
    f.close()