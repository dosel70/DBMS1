import urllib.request
import json
from crud_module import *


# # 사용자가 입력한 한국어를 영어로 번역
# # 한국어와 번역된 문장을 DBMS에 저장
# # 번역 내역 전체 조회

if __name__ == '__main__':
    client_id = "Bv9_0vus1XYI_3dFSY0u"
    client_secret = "yog6tEBH4s"
    message = input("번역할 텍스트 입력 : ")
    encoding_text = urllib.parse.quote(f'{message}')
    data = f"source=ko&target=en&text={encoding_text}"
    url = "https://openapi.naver.com/v1/papago/n2mt"
    request = urllib.request.Request(url)



    # -H
    request.add_header("X-Naver-Client-Id", client_id)
    request.add_header("X-Naver-Client-Secret", client_secret)
    response = urllib.request.urlopen(request, data=data.encode("utf-8"))
    rescode = response.getcode()

    if rescode == 200:
        response = json.loads(response.read().decode("utf-8"))
        print(response['message']['result']['translatedText'])
        result1 = response['message']['result']['translatedText']
        find_by_id_query = "insert into tbl_translate(한국어,영어번역) values(%s,%s)"
        find_by_id_params = [message ,response['message']['result']['translatedText']]
        update(find_by_id_query, find_by_id_params)